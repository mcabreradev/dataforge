# Packages Overview

DataForge is organized into focused packages that can be used independently or together.

## Available Packages

### @dataforge/core

Core utilities and types for functional programming patterns.

**Features:**
- Result type for error handling
- Option type for nullable values
- Either type for discriminated unions
- Type-safe utilities

**Size:** ~2KB gzipped

### @dataforge/utils

Utility functions for common operations.

**Features:**
- String manipulation (camelCase, kebabCase, slugify, etc.)
- Date utilities (format, parse, diff, add/subtract)
- Validation helpers (email, URL, phone, etc.)
- Array operations (chunk, unique, groupBy, etc.)
- Crypto utilities (hash, uuid, base64, etc.)

**Size:** ~8KB gzipped

### @dataforge/validation

Schema validation and form validation utilities.

**Features:**
- Zod-like API for schema validation
- Form validation with state management
- Built-in validators (required, min, max, pattern, etc.)
- Type-safe validation results
- Async validation support

**Size:** ~5KB gzipped

## Installation

Install only the packages you need:

```bash
# Core utilities
npm install @dataforge/core

# Utility functions
npm install @dataforge/utils

# Schema validation
npm install @dataforge/validation

# Or install all packages
npm install @dataforge/core @dataforge/utils @dataforge/validation
```

## Usage Examples

### Using Core Types

```typescript
import { success, failure, some, none, isSuccess } from '@dataforge/core'

// Result type for error handling
const divide = (a: number, b: number) => {
  if (b === 0) return failure(new Error('Division by zero'))
  return success(a / b)
}

const result = divide(10, 2)
if (isSuccess(result)) {
  console.log(result.data) // 5
}

// Option type for nullable values
const findUser = (id: string) => {
  const user = users.find(u => u.id === id)
  return user ? some(user) : none()
}
```

### Using Utils

```typescript
import {
  camelCase,
  formatDate,
  isValidEmail,
  chunk,
  generateUuid
} from '@dataforge/utils'

// String utilities
const className = camelCase('my-component') // 'myComponent'

// Date utilities
const formatted = formatDate(new Date(), 'YYYY-MM-DD HH:mm')

// Validation utilities
const valid = isValidEmail('user@example.com')

// Array utilities
const groups = chunk([1, 2, 3, 4, 5], 2) // [[1, 2], [3, 4], [5]]

// Crypto utilities
const id = generateUuid() // '550e8400-e29b-41d4-a716-446655440000'
```

### Using Validation

```typescript
import {
  string,
  number,
  object,
  required,
  email,
  minLength,
  FormValidator
} from '@dataforge/validation'

// Schema validation
const userSchema = object({
  name: required(string()),
  age: number(),
  email: email(),
  password: required(minLength(8)(string()))
})

const result = userSchema.validate({
  name: 'John Doe',
  age: 30,
  email: 'john@example.com',
  password: 'secret123'
})

// Form validation
const formValidator = new FormValidator({
  email: email(),
  password: required(minLength(8)(string()))
})

formValidator.updateField('email', 'user@example.com')
formValidator.updateField('password', 'password123')

const state = formValidator.getState()
console.log(state.isValid) // true
```

## Bundle Size

All packages are optimized for size and tree-shaking:

| Package | Minified | Gzipped |
|---------|----------|---------|
| @dataforge/core | ~5KB | ~2KB |
| @dataforge/utils | ~20KB | ~8KB |
| @dataforge/validation | ~12KB | ~5KB |

## Browser Support

- Modern browsers with ES2022 support
- Node.js 18+
- TypeScript 5.0+

## TypeScript Support

All packages include full TypeScript definitions and are built with strict mode enabled.
