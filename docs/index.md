# DataForge

Modern TypeScript utilities and components for developers.

## Quick Start

Install the packages you need:

```bash
# Core utilities and types
npm install @dataforge/core

# Utility functions
npm install @dataforge/utils

# Schema validation
npm install @dataforge/validation
```

## Packages

### @dataforge/core

Core utilities and types including Result, Option, and Either types for functional programming patterns.

```typescript
import { success, failure, some, none } from '@dataforge/core'

const result = success('Hello World')
const option = some('value')
```

### @dataforge/utils

Utility functions for common operations including string manipulation, date handling, validation, array operations, and crypto utilities.

```typescript
import { camelCase, formatDate, isValidEmail, chunk } from '@dataforge/utils'

const camel = camelCase('hello world') // 'helloWorld'
const date = formatDate(new Date(), 'YYYY-MM-DD') // '2024-01-15'
const valid = isValidEmail('test@example.com') // true
const chunks = chunk([1, 2, 3, 4], 2) // [[1, 2], [3, 4]]
```

### @dataforge/validation

Schema validation and form validation utilities with a Zod-like API.

```typescript
import { string, number, object, required, email } from '@dataforge/validation'

const schema = object({
  name: required(string()),
  age: number(),
  email: email()
})

const result = schema.validate({
  name: 'John',
  age: 30,
  email: 'john@example.com'
})
```

## Features

- 🚀 **Modern**: Built with TypeScript 5.3+ and modern JavaScript features
- 📦 **Tree-shakable**: Only import what you need
- 🎯 **Type-safe**: Full TypeScript support with strict mode
- 🧪 **Well-tested**: Comprehensive test coverage
- 📚 **Well-documented**: Complete API documentation
- ⚡ **Fast**: Optimized for performance
- 🔧 **Flexible**: Works in Node.js and browsers

## Contributing

We welcome contributions! Please see our [Contributing Guide](https://github.com/mcabreradev/dataforge/blob/main/CONTRIBUTING.md) for details.

## License

MIT © [Miguelángel Cabrera](https://github.com/mcabreradev)
