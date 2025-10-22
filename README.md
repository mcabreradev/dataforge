# 📦 DataForge

Modern TypeScript utilities and components monorepo with state-of-the-art tooling.

[![npm version](https://img.shields.io/npm/v/@dataforge/core.svg)](https://www.npmjs.com/package/@dataforge/core)
[![npm downloads](https://img.shields.io/npm/dm/@dataforge/core.svg)](https://www.npmjs.com/package/@dataforge/core)
[![Build Status](https://github.com/mcabreradev/dataforge/workflows/CI/badge.svg)](https://github.com/mcabreradev/dataforge/actions)
[![Coverage](https://codecov.io/gh/mcabreradev/dataforge/branch/main/graph/badge.svg)](https://codecov.io/gh/mcabreradev/dataforge)
[![License](https://img.shields.io/npm/l/@dataforge/core.svg)](https://github.com/mcabreradev/dataforge/blob/main/LICENSE)

## 🚀 Quick Start

```bash
# Install core utilities
npm install @dataforge/core

# Install utility functions
npm install @dataforge/utils

# Install validation utilities
npm install @dataforge/validation
```

## 📚 Packages

| Package | Description | Size |
|---------|-------------|------|
| [@dataforge/core](./packages/core) | Core utilities and types (Result, Option, Either) | ~2KB |
| [@dataforge/utils](./packages/utils) | Utility functions for common operations | ~8KB |
| [@dataforge/validation](./packages/validation) | Schema validation and form validation | ~5KB |

## ✨ Features

- 🚀 **Modern**: Built with TypeScript 5.3+ and modern JavaScript features
- 📦 **Tree-shakable**: Only import what you need
- 🎯 **Type-safe**: Full TypeScript support with strict mode
- 🧪 **Well-tested**: Comprehensive test coverage with Vitest
- 📚 **Well-documented**: Complete API documentation with VitePress
- ⚡ **Fast**: Optimized for performance with tsup
- 🔧 **Flexible**: Works in Node.js and browsers
- 🛡️ **Secure**: Regular security updates with Dependabot

## 🛠️ Development

### Prerequisites

- Node.js 20+
- pnpm 8+

### Setup

```bash
# Clone the repository
git clone https://github.com/mcabreradev/dataforge.git
cd dataforge

# Install dependencies
pnpm install

# Build all packages
pnpm build

# Run tests
pnpm test

# Run linting
pnpm lint

# Format code
pnpm format
```

### Scripts

```bash
# Development
pnpm build:watch    # Build packages in watch mode
pnpm test:ui        # Run tests with UI
pnpm test:coverage  # Run tests with coverage

# Quality
pnpm lint           # Lint code
pnpm format         # Format code
pnpm typecheck      # Type check
pnpm size           # Check bundle sizes

# Release (Automatic)
pnpm semantic-release:dry-run  # Test release without publishing
pnpm semantic-release:beta     # Release beta version
# Full releases happen automatically on main branch
```

## 🏗️ Architecture

```
dataforge/
├── packages/
│   ├── core/           # Core utilities and types
│   ├── utils/          # Utility functions
│   └── validation/     # Schema validation
├── docs/               # VitePress documentation
├── .github/
│   ├── workflows/      # CI/CD workflows
│   └── dependabot.yml  # Dependency updates
├── .releaserc.json     # Semantic release config
└── turbo.json          # Turborepo config
```

## 🔧 Tooling

- **Build**: [Turborepo](https://turbo.build/) + [tsup](https://tsup.egoist.sh/) - Fast monorepo builds
- **Testing**: [Vitest](https://vitest.dev/) - Fast unit test framework
- **Linting**: [Biome](https://biomejs.dev/) - Fast linter and formatter
- **Type Checking**: [TypeScript](https://www.typescriptlang.org/) 5.3+
- **Versioning**: [semantic-release](https://semantic-release.gitbook.io/) - Automatic releases
- **Documentation**: [VitePress](https://vitepress.dev/)
- **CI/CD**: [GitHub Actions](https://github.com/features/actions)

## 📝 Commit Convention

We use [Conventional Commits](https://www.conventionalcommits.org/) for automatic versioning:

```bash
# Features (minor version bump)
git commit -m "feat(core): add Result type for error handling"

# Bug fixes (patch version bump)
git commit -m "fix(utils): correct date formatting edge case"

# Breaking changes (major version bump)
git commit -m "feat(validation)!: change schema API to be more intuitive"

# Documentation
git commit -m "docs: update API documentation for core package"

# Multiple packages
git commit -m "feat(core,utils): add new utility functions and types"
```

**Commit Types:**
- `feat`: New features
- `fix`: Bug fixes
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Test changes
- `build`: Build system changes
- `ci`: CI/CD changes
- `chore`: Maintenance tasks

**Scopes:**
- `core`: @dataforge/core package
- `utils`: @dataforge/utils package
- `validation`: @dataforge/validation package
- `docs`: Documentation
- `ci`: CI/CD
- `release`: Release process

## 📖 Documentation

- [Getting Started](https://mcabreradev.github.io/dataforge/)
- [API Reference](https://mcabreradev.github.io/dataforge/api/)
- [Packages](https://mcabreradev.github.io/dataforge/packages/)

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

MIT © [Miguelángel Cabrera](https://github.com/mcabreradev)

## 🔗 Links

- [GitHub](https://github.com/mcabreradev/dataforge)
- [npm](https://www.npmjs.com/org/dataforge)
- [Documentation](https://mcabreradev.github.io/dataforge/)
- [Changelog](CHANGELOG.md)
