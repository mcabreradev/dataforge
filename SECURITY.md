# Security Policy

## Supported Versions

We release patches for security vulnerabilities in the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability, please report it to us privately:

1. **Email**: Send details to mcabrera.dev@gmail.com
2. **Subject**: Use "SECURITY: [package-name] - [brief description]"
3. **Include**:
   - Package name and version
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

## Response Process

1. **Acknowledgment**: We'll acknowledge receipt within 48 hours
2. **Assessment**: We'll assess the vulnerability within 5 business days
3. **Fix**: We'll work on a fix and coordinate disclosure
4. **Release**: We'll release a patch version as soon as possible
5. **Disclosure**: We'll publicly disclose after the fix is available

## Security Best Practices

When using DataForge packages:

- Always keep packages updated to the latest versions
- Review the code before using in production
- Use TypeScript strict mode for better type safety
- Validate all inputs using the validation package
- Never commit sensitive data to version control

## Security Features

Our packages include several security features:

- **Input Validation**: Comprehensive validation utilities
- **Type Safety**: Full TypeScript support with strict mode
- **No Dependencies**: Minimal external dependencies
- **Audit Trail**: All changes are tracked in git
- **Regular Updates**: Automated dependency updates via Dependabot

## Contact

For security-related questions or concerns:

- **Email**: mcabrera.dev@gmail.com
- **GitHub**: [mcabreradev](https://github.com/mcabreradev)
- **Issues**: Use GitHub Issues for non-security bugs
