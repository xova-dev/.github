# 参与 Xova 贡献

[English](https://github.com/xova-dev/.github/blob/main/CONTRIBUTING.md) | 简体中文

欢迎使用中文或英文参与贡献。本指南是组织级默认约定；目标仓库提供专属贡献指南或开发说明时，以目标仓库的说明为准。

## Issue

- 提交前先搜索已有 Issue。
- 请选择中文或英文 Issue 表单。Bug 报告应包含预期与实际行为、受影响版本和复现步骤；暂时无法稳定复现时，说明已知触发条件。
- 功能建议应说明问题、期望行为和替代方案。较大改动请先讨论，再开始实现。
- 日志和示例中请移除凭据、个人信息及私密数据。

表单会设置 `Bug` 或 `Feature` 类型，并保留 `bug` 或 `enhancement` 标签；优先级由维护者另行判断。不适合表单的使用问题或文档反馈请参阅[支持指南](https://github.com/xova-dev/.github/blob/main/SUPPORT.md)，仍可新建空白 Issue。

## Pull Request

1. 阅读目标仓库的 README 和开发说明，了解环境准备、命令和约定。
2. 保持改动聚焦，遵循现有风格，避免无关重构、格式化或依赖升级。
3. 为重要行为变化和历史回归补充或更新测试，优先验证可观察行为，而非实现细节。
4. 使用仓库已有工具执行与改动范围匹配的检查，说明结果、未验证的部分及原因。
5. 填写 PR 模板中的改动目的、主要变化、验证情况和风险；关联相关 Issue，说明兼容性影响或迁移要求。

遵循仓库自身的提交约定。未规定时，使用 Conventional Commits，例如 fix(parser): handle empty input。

## 标签

通用标签为 bug、enhancement、documentation、question、dependencies、duplicate、help wanted、invalid 和 wontfix，由维护者按需添加。duplicate 应关联原始 Issue，help wanted 表示欢迎社区协助。以 invalid 或 wontfix 关闭问题时，请简要说明原因；信息不完整不一定代表问题无效，必要时先请求补充信息。

### 优先级

- `priority: high`：阻塞关键工作，需要优先处理。
- `priority: medium`：常规优先级，按计划处理。
- `priority: low`：非紧迫改进，有余力再处理。

由维护者为每个 Issue 设置最多一个优先级标签。未标记表示尚未定级，不默认视为 medium。优先级表示处理顺序，而非严重程度；bug 不自动意味着高优先级。Issue 模板不自动添加优先级标签。

## 安全问题

不要通过公开 Issue 或 PR 报告安全漏洞。请遵循目标仓库的安全政策；没有专属政策时，遵循[组织默认政策](https://github.com/xova-dev/.github/blob/main/SECURITY.md)。在受影响仓库中使用 **Security → Advisories → Report a vulnerability** 私密报告。如果入口不可用，请向维护者询问私密渠道，不要披露漏洞细节。

## 协作

尊重他人，提供可操作的反馈，围绕工作本身展开讨论。请勿提交密钥或无权分享的内容。
