# Contributing to Xova

English | [简体中文](https://github.com/xova-dev/.github/blob/main/CONTRIBUTING.zh-CN.md)

Contributions in English or Chinese are welcome. These are organization-wide defaults; follow the target repository's contributing guide and development instructions when provided.

## Issues

- Search existing issues before opening a new one.
- Choose a Chinese or English issue form. Bug reports should include expected and actual behavior, the affected version, and reproduction steps or known triggers if reproduction is intermittent.
- Use a feature request to explain the problem, proposed behavior, and alternatives. Discuss substantial changes before implementing them.
- Remove credentials, personal information, and private data from logs and examples.

Forms set the `Bug` or `Feature` issue type and the existing `bug` or `enhancement` label. Maintainers determine priority separately. For questions or documentation feedback that do not fit a form, see the [support guide](https://github.com/xova-dev/.github/blob/main/SUPPORT.md); blank issues remain available.

## Pull requests

1. Read the target repository's README and development instructions for setup, commands, and conventions.
2. Keep changes focused and match the existing style. Avoid unrelated refactoring, formatting, or dependency updates.
3. Add or update tests for meaningful behavior changes and regressions. Prefer observable behavior over implementation details.
4. Run checks appropriate to the change using the repository's existing tooling. Report results and anything not verified, with reasons.
5. Complete the PR template with the purpose, main changes, verification, and risks. Link related issues and document compatibility or migration requirements.

Follow repository-specific commit conventions. If none are defined, use Conventional Commits, such as fix(parser): handle empty input.

## Labels

The shared label set is bug, enhancement, documentation, question, dependencies, duplicate, help wanted, invalid, and wontfix. Maintainers apply labels as appropriate. Use duplicate with a link to the original issue, and help wanted when community assistance is welcome. When closing an issue as invalid or wontfix, briefly explain the reason; an incomplete report alone is not necessarily invalid—ask for clarification when needed.

### Priority

- `priority: high`: blocks key work and should be addressed first.
- `priority: medium`: normal priority, scheduled as planned.
- `priority: low`: non-urgent work to address when capacity allows.

Maintainers assign at most one priority label per issue. No priority label means the issue has not yet been prioritized, not that it is medium priority. Priority describes work order rather than severity; a bug is not automatically high priority. Issue templates do not assign priority labels automatically.

## Security

Do not report vulnerabilities in public issues or pull requests. Follow the target repository's security policy, or the [organization policy](https://github.com/xova-dev/.github/blob/main/SECURITY.md) when it has no override. Use **Security → Advisories → Report a vulnerability** in the affected repository. If unavailable, ask a maintainer for a private channel without disclosing vulnerability details.

## Collaboration

Be respectful, provide actionable feedback, and keep discussions focused on the work. Never include secrets or material you do not have permission to share.
