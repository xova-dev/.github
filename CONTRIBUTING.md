# Contributing to Xova

English | [简体中文](https://github.com/xova-dev/.github/blob/main/CONTRIBUTING.zh-CN.md)

Contributions in English or Chinese are welcome. These are organization-wide defaults; follow the target repository's contributing guide and development instructions when provided.

## Issues

- Search existing issues before opening a new one.
- Choose the bilingual Bug or Feature form and answer in English or Chinese. Bug reports should include expected and actual behavior, the affected version, and reproduction steps or known triggers if reproduction is intermittent.
- Use a feature request to explain the problem and desired outcome; approaches and alternatives are optional. Discuss substantial changes before implementing them.
- Remove credentials, personal information, and private data from logs and examples.

Forms set the `Bug` or `Feature` type without labels. Use `Task` for other concrete work. For questions or documentation feedback that do not fit a form, see the [support guide](https://github.com/xova-dev/.github/blob/main/SUPPORT.md); blank issues remain available.

Maintainers use the native `Priority` field: `Urgent` for immediate attention, `High` for work to address next, `Medium` for planned work, and `Low` for work when capacity allows. Unset means not yet prioritized. Priority describes work order, not severity.

Only `Priority` is pinned by default and visible to anyone who can view the issue. `Start date`, `Target date` and `Effort` remain `Organization only`, unpinned and optional for planning. Existing values are preserved and may still appear to viewers with access.

Keep context, evidence and constraints in the body; use sidebar fields for type, priority, ownership and scheduling. When closing an issue, explain the decision and link the original if it is a duplicate.

## Pull requests

1. Read the target repository's README and development instructions for setup, commands, and conventions.
2. Keep changes focused and match the existing style. Avoid unrelated refactoring, formatting, or dependency updates.
3. Add or update tests for meaningful behavior changes and regressions. Prefer observable behavior over implementation details.
4. Run checks appropriate to the change using the repository's existing tooling. Report results and anything not verified, with reasons.
5. Complete the PR template with the purpose, main changes, verification, and risks. Link related issues and document compatibility or migration requirements.

Follow repository-specific commit conventions. If none are defined, use Conventional Commits, such as fix(parser): handle empty input.

## Labels

Issues and PRs do not use labels by default. Add a repository-specific PR label only when filtering or automation needs it. Before removing labels, check workflow, bot and release dependencies and preserve issue type and priority in native fields.

## Security

Do not report vulnerabilities in public issues or pull requests. Follow the target repository's security policy, or the [organization policy](https://github.com/xova-dev/.github/blob/main/SECURITY.md) when it has no override. Use **Security → Advisories → Report a vulnerability** in the affected repository. If unavailable, ask a maintainer for a private channel without disclosing vulnerability details.

## Collaboration

Be respectful, provide actionable feedback, and keep discussions focused on the work. Never include secrets or material you do not have permission to share.
