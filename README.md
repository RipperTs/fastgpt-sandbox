<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="200" alt="Nest Logo" /></a>
</p>

[circleci-image]: https://img.shields.io/circleci/build/github/nestjs/nest/master?token=abc123def456
[circleci-url]: https://circleci.com/gh/nestjs/nest

  <p align="center">A progressive <a href="http://nodejs.org" target="_blank">Node.js</a> framework for building efficient and scalable server-side applications.</p>
    <p align="center">
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/v/@nestjs/core.svg" alt="NPM Version" /></a>
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/l/@nestjs/core.svg" alt="Package License" /></a>
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/dm/@nestjs/common.svg" alt="NPM Downloads" /></a>
<a href="https://circleci.com/gh/nestjs/nest" target="_blank"><img src="https://img.shields.io/circleci/build/github/nestjs/nest/master" alt="CircleCI" /></a>
<a href="https://coveralls.io/github/nestjs/nest?branch=master" target="_blank"><img src="https://coveralls.io/repos/github/nestjs/nest/badge.svg?branch=master#9" alt="Coverage" /></a>
<a href="https://discord.gg/G7Qnnhy" target="_blank"><img src="https://img.shields.io/badge/discord-online-brightgreen.svg" alt="Discord"/></a>
<a href="https://opencollective.com/nest#backer" target="_blank"><img src="https://opencollective.com/nest/backers/badge.svg" alt="Backers on Open Collective" /></a>
<a href="https://opencollective.com/nest#sponsor" target="_blank"><img src="https://opencollective.com/nest/sponsors/badge.svg" alt="Sponsors on Open Collective" /></a>
  <a href="https://paypal.me/kamilmysliwiec" target="_blank"><img src="https://img.shields.io/badge/Donate-PayPal-ff3f59.svg"/></a>
    <a href="https://opencollective.com/nest#sponsor"  target="_blank"><img src="https://img.shields.io/badge/Support%20us-Open%20Collective-41B883.svg" alt="Support us"></a>
  <a href="https://twitter.com/nestframework" target="_blank"><img src="https://img.shields.io/twitter/follow/nestframework.svg?style=social&label=Follow"></a>
</p>
  <!--[![Backers on Open Collective](https://opencollective.com/nest/backers/badge.svg)](https://opencollective.com/nest#backer)
  [![Sponsors on Open Collective](https://opencollective.com/nest/sponsors/badge.svg)](https://opencollective.com/nest#sponsor)-->

## Description

[Nest](https://github.com/nestjs/nest) framework TypeScript starter repository.

## Installation

```bash
$ pnpm install
```

## Docker 镜像

已打包可用的 Docker 镜像（可直接拉取运行）：

```
registry.cn-hangzhou.aliyuncs.com/ripper/fastgpt-sandbox:latest
```

快速使用：

```bash
# 拉取镜像
docker pull registry.cn-hangzhou.aliyuncs.com/ripper/fastgpt-sandbox:latest

# 运行（默认暴露 3000 端口）
docker run -d --name fastgpt-sandbox -p 3000:3000 \
  registry.cn-hangzhou.aliyuncs.com/ripper/fastgpt-sandbox:latest
```

## Docker Compose 使用

项目已提供 `docker-compose.yml`，可一键启动服务。

```bash
# 后台启动
docker compose up -d

# 查看服务状态
docker compose ps

# 查看日志
docker compose logs -f sandbox

# 更新镜像并重启
docker compose pull && docker compose up -d

# 停止并移除容器
docker compose down
```

默认映射端口：`3000->3000`，启动后访问：`http://localhost:3000/api`。

如需调整运行参数，编辑 `docker-compose.yml` 的 `environment` 段，例如：

```yaml
services:
  sandbox:
    environment:
      - PY_SANDBOX_TIMEOUT=60
      - PYTHON_ENABLE_SECCOMP=0
      # 可选：仅放行 stderr 告警
      # - PY_STRICT_STDERR=0
```

## Running the app

```bash
# development
$ pnpm run start

# watch mode
$ pnpm run start:dev

# production mode
$ pnpm run start:prod
```

### Sandbox 环境变量

- `PY_SANDBOX_TIMEOUT`：Python 子进程超时时间（秒），默认 `30`。
- `PYTHON_ENABLE_SECCOMP`：是否启用 Python seccomp 沙箱，`1` 启用（默认），`0` 关闭。
- `PY_STRICT_STDERR`：是否将子进程 `stderr` 视为失败。`0` 忽略告警（默认），`1` 视为失败。

示例（Docker 使用官方镜像，关闭 seccomp 并放宽超时）：

```bash
docker run -e PYTHON_ENABLE_SECCOMP=0 -e PY_SANDBOX_TIMEOUT=60 -p 3000:3000 \
  registry.cn-hangzhou.aliyuncs.com/ripper/fastgpt-sandbox:latest
```

仅放行 `stderr` 告警：

```bash
docker run -e PY_STRICT_STDERR=0 -p 3000:3000 \
  registry.cn-hangzhou.aliyuncs.com/ripper/fastgpt-sandbox:latest
```

### 支持的 Python 依赖
- 查看 [requirements.txt](requirements.txt)   

## Test

```bash
# unit tests
$ pnpm run test

# e2e tests
$ pnpm run test:e2e

# test coverage
$ pnpm run test:cov
```

## Support

Nest is an MIT-licensed open source project. It can grow thanks to the sponsors and support by the amazing backers. If you'd like to join them, please [read more here](https://docs.nestjs.com/support).

## Stay in touch

- Author - [Kamil Myśliwiec](https://kamilmysliwiec.com)
- Website - [https://nestjs.com](https://nestjs.com/)
- Twitter - [@nestframework](https://twitter.com/nestframework)

## License

Nest is [MIT licensed](LICENSE).
