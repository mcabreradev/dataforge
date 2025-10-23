# @dataforge/filter

A powerful, SQL-like array filtering library for TypeScript and JavaScript with advanced pattern matching, MongoDB-style operators, deep object comparison, and zero dependencies.

## Overview

`@dataforge/filter` goes beyond JavaScript's native `Array.filter()` with a library that understands your data structure. It provides multiple filtering strategies including SQL-like wildcards, MongoDB-style operators, deep object comparison, and custom predicates.

## Key Features

- **🎯 SQL-like Wildcards** - Use `%` and `_` for flexible pattern matching
- **🔍 Deep Object Filtering** - Search through nested objects up to configurable depths
- **⚡ Zero Dependencies** - Lightweight and production-ready
- **🔒 Type-Safe** - Built with strict TypeScript for maximum reliability
- **🎨 Multiple Strategies** - String patterns, objects, predicates, operators, or custom comparators
- **🚀 Performance Optimized** - Optional caching and regex compilation optimization
- **📦 MongoDB-Style Operators** - 13 operators for advanced filtering
- **🧪 Battle-Tested** - 240+ tests ensuring reliability

## Installation

```bash
npm install @dataforge/filter
# or
yarn add @dataforge/filter
# or
pnpm add @dataforge/filter
```

## Quick Start

```typescript
import { filter } from '@dataforge/filter';

const users = [
  { name: 'Alice', email: 'alice@example.com', age: 30, city: 'Berlin' },
  { name: 'Bob', email: 'bob@example.com', age: 25, city: 'London' },
  { name: 'Charlie', email: 'charlie@example.com', age: 35, city: 'Berlin' }
];

// Simple string matching (case-insensitive by default)
filter(users, 'Berlin');
// → Returns Alice and Charlie

// Wildcard patterns (SQL-like)
filter(users, '%alice%');
// → Returns Alice

// Object-based filtering
filter(users, { city: 'Berlin', age: 30 });
// → Returns Alice

// MongoDB-style operators
filter(users, { age: { $gte: 25, $lt: 35 } });
// → Returns Bob and Alice

// Predicate functions
filter(users, (user) => user.age > 28);
// → Returns Alice and Charlie
```

## Filtering Strategies

### 1. String Patterns

Simple string matching with wildcard support:

```typescript
// Basic string search
filter(users, 'Berlin');

// Wildcards
filter(users, '%alice%');     // Contains 'alice'
filter(users, 'Al%');          // Starts with 'Al'
filter(users, '%son');         // Ends with 'son'

// Negation
filter(users, '!London');      // Exclude London
```

### 2. Object-Based Filtering

Match by specific properties with AND logic:

```typescript
// Single property
filter(products, { category: 'Electronics' });

// Multiple properties (all must match)
filter(products, {
  category: 'Electronics',
  price: 1200,
  inStock: true
});

// Nested objects
filter(users, {
  address: { city: 'Berlin' },
  settings: { theme: 'dark' }
});
```

### 3. MongoDB-Style Operators

Powerful operators for advanced filtering:

#### Comparison Operators

```typescript
// Greater than / Less than
filter(products, { price: { $gt: 100 } });
filter(products, { price: { $lte: 500 } });

// Range queries
filter(products, {
  price: { $gte: 100, $lte: 500 }
});

// Not equal
filter(users, { role: { $ne: 'guest' } });
```

**Available:** `$gt`, `$gte`, `$lt`, `$lte`, `$eq`, `$ne`

#### Array Operators

```typescript
// In / Not in array
filter(products, {
  category: { $in: ['Electronics', 'Books'] }
});

// Array contains value
filter(products, {
  tags: { $contains: 'sale' }
});

// Array size
filter(products, {
  images: { $size: 3 }
});
```

**Available:** `$in`, `$nin`, `$contains`, `$size`

#### String Operators

```typescript
// Starts with / Ends with
filter(users, {
  email: { $endsWith: '@company.com' }
});

// Contains substring
filter(articles, {
  title: { $contains: 'typescript' }
});
```

**Available:** `$startsWith`, `$endsWith`, `$contains`

### 4. Predicate Functions

For complex custom logic:

```typescript
// Simple predicate
filter(numbers, (n) => n > 5);

// Complex conditions
filter(products, (product) =>
  product.price < 100 &&
  product.inStock &&
  product.rating >= 4.0
);
```

## Configuration

Customize filter behavior with options:

```typescript
// Case-sensitive matching
filter(users, 'ALICE', { caseSensitive: true });

// Increase max depth for nested objects
filter(data, expression, { maxDepth: 5 });

// Enable caching for repeated queries
filter(largeDataset, expression, { enableCache: true });

// Custom comparison logic
filter(data, expression, {
  customComparator: (actual, expected) => actual === expected
});
```

**Available Options:**

- `caseSensitive` (boolean, default: `false`) - Case-sensitive string matching
- `maxDepth` (number, default: `3`, range: 1-10) - Max depth for nested objects
- `enableCache` (boolean, default: `false`) - Enable result caching
- `customComparator` (function, optional) - Custom comparison function

## TypeScript Support

Full TypeScript support with strict typing:

```typescript
import { filter } from '@dataforge/filter';
import type {
  Expression,
  FilterOptions,
  ComparisonOperators
} from '@dataforge/filter';

interface Product {
  id: number;
  name: string;
  price: number;
  category: string;
}

const products: Product[] = [...];

// Type-safe filtering
const result = filter<Product>(products, {
  price: { $gte: 100 }
});
// result is Product[]
```

## Real-World Examples

### E-commerce Product Filtering

```typescript
interface Product {
  id: number;
  name: string;
  price: number;
  category: string;
  brand: string;
  rating: number;
  inStock: boolean;
  tags: string[];
  createdAt: Date;
}

const products: Product[] = [...];

// Find affordable, highly-rated electronics in stock
const affordableElectronics = filter(products, {
  category: 'Electronics',
  price: { $lte: 1000 },
  rating: { $gte: 4.5 },
  inStock: { $eq: true }
});

// Search products with filters
const searchResults = filter(products, {
  name: { $contains: 'laptop' },
  brand: { $in: ['Apple', 'Dell', 'HP'] },
  price: { $gte: 500, $lte: 2000 }
});
```

### User Management

```typescript
interface User {
  id: number;
  name: string;
  email: string;
  role: string;
  lastLogin: Date;
  isActive: boolean;
}

const users: User[] = [...];

// Find active users who logged in recently
const activeUsers = filter(users, {
  isActive: { $eq: true },
  lastLogin: { $gte: new Date('2025-01-01') },
  role: { $nin: ['guest', 'banned'] }
});

// Search users by name pattern
const searchUsers = filter(users, {
  name: '%john%',
  isActive: true
});
```

## Performance Tips

Filter is optimized for performance:

- **Operators** use early exit strategies for fast evaluation
- **Regex patterns** are compiled and cached
- **Optional caching** for repeated queries on large datasets
- **Type guards** for fast type checking

```typescript
// ✅ Fast: Operators with early exit
filter(data, { age: { $gte: 18 } });

// ✅ Fast with caching for repeated queries
filter(largeData, expression, { enableCache: true });

// ⚠️ Slower: Complex predicates (but more flexible)
filter(data, (item) => complexCalculation(item));
```

## API Reference

### Main Function

```typescript
filter<T>(array: T[], expression: Expression<T>, options?: FilterOptions): T[]
```

### Types

```typescript
type Expression<T> =
  | PrimitiveExpression
  | PredicateFunction<T>
  | ObjectExpression<T>
  | ExtendedObjectExpression<T>;

interface FilterOptions {
  caseSensitive?: boolean;
  maxDepth?: number;
  enableCache?: boolean;
  customComparator?: Comparator;
}

interface ComparisonOperators {
  $gt?: number | Date;
  $gte?: number | Date;
  $lt?: number | Date;
  $lte?: number | Date;
  $eq?: unknown;
  $ne?: unknown;
}

interface ArrayOperators {
  $in?: unknown[];
  $nin?: unknown[];
  $contains?: unknown;
  $size?: number;
}

interface StringOperators {
  $startsWith?: string;
  $endsWith?: string;
  $contains?: string;
}
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
