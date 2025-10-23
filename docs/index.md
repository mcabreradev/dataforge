# DataForge Filter

A powerful, SQL-like array filtering library for TypeScript and JavaScript with advanced pattern matching, MongoDB-style operators, deep object comparison, and zero dependencies.

## Quick Start

Install the filter package:

```bash
npm install @dataforge/filter
```

## Features

- **🎯 SQL-like Wildcards** - Use `%` and `_` for flexible pattern matching
- **🔍 Deep Object Filtering** - Search through nested objects up to configurable depths
- **⚡ Zero Dependencies** - Lightweight and production-ready
- **🔒 Type-Safe** - Built with strict TypeScript for maximum reliability
- **🎨 Multiple Strategies** - String patterns, objects, predicates, operators, or custom comparators
- **🚀 Performance Optimized** - Optional caching and regex compilation optimization
- **📦 MongoDB-Style Operators** - 13 operators for advanced filtering
- **🧪 Battle-Tested** - 240+ tests ensuring reliability

## Basic Usage

```typescript
import { filter } from '@dataforge/filter'

const users = [
  { name: 'Alice', email: 'alice@example.com', age: 30, city: 'Berlin' },
  { name: 'Bob', email: 'bob@example.com', age: 25, city: 'London' },
  { name: 'Charlie', email: 'charlie@example.com', age: 35, city: 'Berlin' }
]

// Simple string matching (case-insensitive by default)
filter(users, 'Berlin')
// → Returns Alice and Charlie

// Wildcard patterns (SQL-like)
filter(users, '%alice%')
// → Returns Alice

// Object-based filtering
filter(users, { city: 'Berlin', age: 30 })
// → Returns Alice

// MongoDB-style operators
filter(users, { age: { $gte: 25, $lt: 35 } })
// → Returns Bob and Alice

// Predicate functions
filter(users, (user) => user.age > 28)
// → Returns Alice and Charlie
```

## Filtering Strategies

### String Patterns
Simple string matching with wildcard support:

```typescript
// Basic string search
filter(users, 'Berlin')

// Wildcards
filter(users, '%alice%')     // Contains 'alice'
filter(users, 'Al%')          // Starts with 'Al'
filter(users, '%son')         // Ends with 'son'

// Negation
filter(users, '!London')      // Exclude London
```

### MongoDB-Style Operators
Powerful operators for advanced filtering:

```typescript
// Comparison operators
filter(products, { price: { $gt: 100 } })
filter(products, { price: { $lte: 500 } })

// Array operators
filter(products, { category: { $in: ['Electronics', 'Books'] } })
filter(products, { tags: { $contains: 'sale' } })

// String operators
filter(users, { email: { $endsWith: '@company.com' } })
```

### Object-Based Filtering
Match by specific properties with AND logic:

```typescript
// Single property
filter(products, { category: 'Electronics' })

// Multiple properties (all must match)
filter(products, {
  category: 'Electronics',
  price: 1200,
  inStock: true
})
```

## Real-World Examples

### E-commerce Product Filtering

```typescript
interface Product {
  id: number
  name: string
  price: number
  category: string
  brand: string
  rating: number
  inStock: boolean
  tags: string[]
}

const products: Product[] = [...]

// Find affordable electronics in stock
const affordableElectronics = filter(products, {
  category: 'Electronics',
  price: { $lte: 1000 },
  inStock: { $eq: true }
})

// Search products with filters
const searchResults = filter(products, {
  name: { $contains: 'laptop' },
  brand: { $in: ['Apple', 'Dell', 'HP'] },
  price: { $gte: 500, $lte: 2000 }
})
```

### User Management

```typescript
interface User {
  id: number
  name: string
  email: string
  role: string
  lastLogin: Date
  isActive: boolean
}

const users: User[] = [...]

// Find active users who logged in recently
const activeUsers = filter(users, {
  isActive: { $eq: true },
  lastLogin: { $gte: new Date('2025-01-01') },
  role: { $nin: ['guest', 'banned'] }
})

// Search users by name pattern
const searchUsers = filter(users, {
  name: '%john%',
  isActive: true
})
```

## Performance Tips

Filter is optimized for performance:

- **Operators** use early exit strategies for fast evaluation
- **Regex patterns** are compiled and cached
- **Optional caching** for repeated queries on large datasets
- **Type guards** for fast type checking

```typescript
// ✅ Fast: Operators with early exit
filter(data, { age: { $gte: 18 } })

// ✅ Fast with caching for repeated queries
filter(largeData, expression, { enableCache: true })

// ⚠️ Slower: Complex predicates (but more flexible)
filter(data, (item) => complexCalculation(item))
```

## Browser Support

- **Node.js:** >= 20
- **Browsers:** Chrome, Firefox, Safari, Edge (latest versions)
- **TypeScript:** >= 5.0
- **Module Systems:** ESM, CommonJS

## Contributing

We welcome contributions! Please see the [Contributing Guide](https://github.com/mcabreradev/dataforge/blob/main/CONTRIBUTING.md) for guidelines.

## License

MIT License - see [LICENSE](https://github.com/mcabreradev/dataforge/blob/main/LICENSE.md) for details.
