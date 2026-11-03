# 参与 Xova 贡献

[English](https://github.com/xova-dev/.github/blob/main/CONTRIBUTING.md) | 简体中文

欢迎使用中文或英文参与贡献。本指南是组织级默认约定；目标仓库提供专属贡献指南或开发说明时，以目标仓库的说明为准。

## Issue

- 提交前先搜索已有 Issue。
- 请选择 Bug 或 Feature 双语表单，用中文或英文填写。Bug 报告应包含预期与实际行为、受影响版本和复现步骤；暂时无法稳定复现时，说明已知触发条件。
- 功能建议应说明问题和期望结果，方案与替代办法选填。较大改动请先讨论，再开始实现。
- 日志和示例中请移除凭据、个人信息及私密数据。

表单设置 `Bug` 或 `Feature` 类型，不添加标签。其他具体工作使用 `Task`。不适合表单的使用问题或文档反馈请参阅[支持指南](https://github.com/xova-dev/.github/blob/main/SUPPORT.md)，仍可新建空白 Issue。

维护者使用原生 `Priority` 字段：`Urgent` 需立即处理，`High` 优先处理，`Medium` 按计划处理，`Low` 有余力再处理。未设置表示尚未定级。优先级表示处理顺序，不等同于严重程度。日期和工作量仅在排期需要时填写。

正文记录背景、证据与约束；类型、优先级、负责人和排期使用侧栏字段。关闭 Issue 时说明原因；重复问题应关联原始 Issue。

## Pull Request

1. 阅读目标仓库的 README 和开发说明，了解环境准备、命令和约定。
2. 保持改动聚焦，遵循现有风格，避免无关重构、格式化或依赖升级。
3. 为重要行为变化和历史回归补充或更新测试，优先验证可观察行为，而非实现细节。
4. 使用仓库已有工具执行与改动范围匹配的检查，说明结果、未验证的部分及原因。
5. 填写 PR 模板中的改动目的、主要变化、验证情况和风险；关联相关 Issue，说明兼容性影响或迁移要求。

遵循仓库自身的提交约定。未规定时，使用 Conventional Commits，例如 fix(parser): handle empty input。

## 标签

Issue 默认不使用标签。PR 仅在筛选或自动化需要时使用 `bug`、`enhancement`、`documentation` 或 `dependencies`，不要求逐个标记。删除仓库已有标签前，先检查工作流、机器人和发布流程的依赖。

## 安全问题

不要通过公开 Issue 或 PR 报告安全漏洞。请遵循目标仓库的安全政策；没有专属政策时，遵循[组织默认政策](https://github.com/xova-dev/.github/blob/main/SECURITY.md)。在受影响仓库中使用 **Security → Advisories → Report a vulnerability** 私密报告。如果入口不可用，请向维护者询问私密渠道，不要披露漏洞细节。

## 协作

尊重他人，提供可操作的反馈，围绕工作本身展开讨论。请勿提交密钥或无权分享的内容。
