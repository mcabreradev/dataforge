# Packages Overview

DataForge currently offers a powerful array filtering library that can be used independently.

## Available Package

### @dataforge/filter

A powerful, SQL-like array filtering library with MongoDB-style operators and advanced pattern matching.

**Features:**
- SQL-like wildcards (`%`, `_`)
- MongoDB-style operators (`$gt`, `$in`, `$contains`, etc.)
- Deep object filtering
- Zero dependencies
- Type-safe with TypeScript
- Performance optimized

**Size:** ~3KB gzipped

[Learn more about @dataforge/filter →](./filter)

## Installation

Install the filter package:

```bash
# Array filtering
npm install @dataforge/filter
```

## Usage Examples

### Using Filter

```typescript
import { filter } from '@dataforge/filter'

const products = [
  { name: 'Laptop', price: 1000, category: 'Electronics' },
  { name: 'Book', price: 20, category: 'Books' },
  { name: 'Phone', price: 800, category: 'Electronics' }
]

// Simple filtering
const electronics = filter(products, { category: 'Electronics' })

// MongoDB-style operators
const expensiveProducts = filter(products, {
  price: { $gte: 500 },
  category: 'Electronics'
})

// Wildcard patterns
const laptopProducts = filter(products, '%laptop%')

// Complex filtering with multiple criteria
const premiumElectronics = filter(products, {
  category: 'Electronics',
  price: { $gte: 500, $lte: 2000 },
  name: { $contains: 'Pro' }
})
```

### Real-World Examples

#### E-commerce Product Search

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

// Search products with multiple filters
const searchResults = filter(products, {
  name: { $contains: 'laptop' },
  brand: { $in: ['Apple', 'Dell', 'HP'] },
  price: { $gte: 500, $lte: 2000 },
  rating: { $gte: 4.0 }
})
```

#### User Management

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

## Bundle Size

The filter package is optimized for size and tree-shaking:

| Package | Minified | Gzipped |
|---------|----------|---------|
| @dataforge/filter | ~8KB | ~3KB |

## Browser Support

- Modern browsers with ES2022 support
- Node.js 18+
- TypeScript 5.0+

## TypeScript Support

The package includes full TypeScript definitions and is built with strict mode enabled.
