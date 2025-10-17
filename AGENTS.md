# Repository Guidelines

## 项目结构与模块组织
- `src/`：核心代码。示例：`src/main.ts`、`src/app.module.ts`、`src/sandbox/*`（模块、控制器、服务、DTO）。
- `test/`：Jest 配置与支持文件；单元测试位于 `src` 同级目录，命名为 `*.spec.ts`。
- `dist/`：编译产物（执行 `build` 后生成）。
- 根目录：`Dockerfile`、`.dockerignore`、`nest-cli.json`、`tsconfig*.json`、`.eslintrc.js`。

## 构建、测试与本地开发命令
- 安装依赖：`npm install`（亦可 `pnpm i`）。
- 开发启动（热重载）：`npm run dev`。
- 构建产物：`npm run build`（输出到 `dist/`）。
- 生产运行：`npm run start:prod`（执行 `dist/main.js`）。
- 普通启动：`npm start`。
- 代码检查：`npm run lint`。
- 测试：`npm test`、`npm run test:watch`、`npm run test:cov`。

## 代码风格与命名约定
- 语言：TypeScript（NestJS + Fastify）。缩进 2 空格、使用单引号，尽量避免 `any`。
- Lint：`@typescript-eslint` 规则已启用；提交前请确保无报错。
- 文件命名：kebab-case + 角色后缀（如 `src/sandbox/sandbox.controller.ts`）。
- 类/枚举：PascalCase（如 `CreateSandboxDto`）。变量/函数：camelCase。

## 测试规范
- 框架：Jest + ts-jest；测试文件命名为 `*.spec.ts`，放在对应 `src` 目录下。
- 覆盖率：自动收集到 `coverage/`，当前未设置强制阈值；新增逻辑需补充单测。
- 运行示例：`npm run test:watch` 持续开发。

## 提交与 Pull Request
- 提交信息：简洁、祈使句、英语为主（示例：`refactor: improve Dockerfile layering`）。
- 推荐前缀（非强制）：`feat`/`fix`/`chore`/`docs`/`refactor`/`test`。
- PR 要求：
  - 清晰描述变更、动机与影响，必要时附运行截图/日志；
  - 关联 Issue；
  - 避免混入无关的格式化与重排。

## 安全与配置提示
- 服务默认从 `3000` 端口启动，被占用时自动递增；OpenAPI 文档位于 `/api`。
- 镜像构建包含原生编译与 Python 依赖，请在具备编译环境的机器/CI 执行。
- 切勿提交密钥与敏感配置。

## Agent 专用说明
- 仅修改与需求相关的最小范围文件，保持变更原子化。
- 变更命令或依赖时，同步更新 `package.json` 与 `README.md`。
- 代码与测试需本地可通过：`npm run lint && npm test`。

