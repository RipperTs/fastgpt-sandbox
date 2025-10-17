# --------- Python Base（安装依赖） -----------
FROM python:3.11-alpine AS python_base
# 安装构建依赖与 libseccomp 开发包
RUN apk add --no-cache make g++ tar wget gperf automake libtool linux-headers libseccomp-dev

WORKDIR /app
# 复制当前根目录的 requirements.txt（原来的 projects/sandbox/requirements.txt）
COPY requirements.txt /app/requirements.txt

# 先安装 Cython 和其他 Python 依赖
RUN pip install --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple Cython && \
    pip install --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple -r /app/requirements.txt

# 下载并安装 libseccomp 及其 Python 绑定
ENV VERSION_RELEASE=2.5.5
RUN wget https://github.com/seccomp/libseccomp/releases/download/v2.5.5/libseccomp-2.5.5.tar.gz && \
    tar -zxvf libseccomp-2.5.5.tar.gz && \
    cd libseccomp-2.5.5 && \
    ./configure --prefix=/usr && \
    make && \
    make install && \
    cd src/python && \
    python setup.py install && \
    cd /app && \
    rm -rf libseccomp-2.5.5 libseccomp-2.5.5.tar.gz


# --------- Builder（构建 Node 项目） -----------
FROM node:20.14.0-alpine AS builder

WORKDIR /app

ARG proxy
RUN [ -z "$proxy" ] || sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
# 构建原生模块需要
RUN apk add --no-cache make g++ python3

# 提供 python 环境（如需）
COPY --from=python_base /usr/local /usr/local

# 仅复制依赖清单以利用缓存
COPY package.json ./
COPY package-lock.json* ./
RUN npm install

# 复制源码
COPY . .

# 构建（原来的 pnpm --filter=sandbox build）
RUN npm run build


# --------- Runner（运行时） -----------
FROM node:20.14.0-alpine AS runner
WORKDIR /app

RUN apk add --no-cache libffi libffi-dev strace bash
COPY --from=python_base /usr/local /usr/local

# 仅复制生产所需内容
COPY package.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

ENV NODE_ENV=production
ENV PATH="/usr/local/bin:${PATH}"

# 去除开发依赖以减小体积
RUN npm prune --omit=dev

# 原来的 projects/sandbox/dist/main.js 改为根目录 dist/main.js
CMD ["node", "--no-node-snapshot", "dist/main.js"]
