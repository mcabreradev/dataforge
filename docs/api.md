# API Reference

Complete API reference for `@dataforge/filter` - a powerful array filtering library with MongoDB-style operators and advanced pattern matching.

## Main Functions

### `filter<T>(array, expression, options?)`

The main filtering function that processes arrays using various expression types.

**Signature:**
```typescript
function filter<T>(
  array: T[],
  expression: Expression<T>,
  options?: FilterOptions
): T[]
```

**Parameters:**
- `array` (`T[]`): The array to filter
- `expression` (`Expression<T>`): Filter expression (string, number, boolean, null, object, or predicate function)
- `options` (`FilterOptions`, optional): Configuration options

**Returns:** `T[]` - Filtered array containing only matching items

**Throws:** Error if expression or options are invalid

**Examples:**

```typescript
import { filter } from '@dataforge/filter';

// String filtering
const users = [
  { name: 'Alice', city: 'Berlin' },
  { name: 'Bob', city: 'London' }
];
filter(users, 'Berlin'); // → [{ name: 'Alice', city: 'Berlin' }]

// Object filtering
filter(users, { city: 'Berlin' }); // → [{ name: 'Alice', city: 'Berlin' }]

// Operator filtering
filter(users, { name: { $startsWith: 'A' } }); // → [{ name: 'Alice', city: 'Berlin' }]

// Predicate filtering
filter(users, (user) => user.name.length > 3); // → [{ name: 'Alice', city: 'Berlin' }]
```

---

## Validation Functions

### `validateExpression(expression)`

Validates a filter expression to ensure it's properly formatted.

**Signature:**
```typescript
function validateExpression<T>(expression: unknown): Expression<T>
```

**Parameters:**
- `expression` (`unknown`): Expression to validate

**Returns:** `Expression<T>` - Validated expression

**Throws:** Error if expression is invalid

**Examples:**

```typescript
import { validateExpression } from '@dataforge/filter';

// Valid expressions
validateExpression('string');          // ✅ Returns 'string'
validateExpression(42);                // ✅ Returns 42
validateExpression({ prop: 'value' }); // ✅ Returns object
validateExpression((x) => true);       // ✅ Returns function

// Invalid expressions
try {
  validateExpression(undefined);       // ❌ Throws error
} catch (error) {
  console.error(error.message);
  // "Invalid filter expression: Expected string | number | boolean | null | function | object"
}
```

### `validateOptions(options)`

Validates filter configuration options.

**Signature:**
```typescript
function validateOptions(options: unknown): FilterOptions
```

**Parameters:**
- `options` (`unknown`): Options to validate

**Returns:** `FilterOptions` - Validated options

**Throws:** Error if options are invalid

**Examples:**

```typescript
import { validateOptions } from '@dataforge/filter';

// Valid options
validateOptions({ caseSensitive: true });  // ✅ Returns options
validateOptions({ maxDepth: 5 });          // ✅ Returns options
validateOptions({});                       // ✅ Returns empty object

// Invalid options
try {
  validateOptions({ maxDepth: 15 });      // ❌ Throws error (max is 10)
} catch (error) {
  console.error(error.message);
  // "Invalid filter options: maxDepth too large"
}
```

---

## Configuration Functions

### `mergeConfig(options?)`

Merges user options with default configuration.

**Signature:**
```typescript
function mergeConfig(options?: FilterOptions): FilterConfig
```

**Parameters:**
- `options` (`FilterOptions`, optional): User-provided options

**Returns:** `FilterConfig` - Complete configuration with defaults applied

**Examples:**

```typescript
import { mergeConfig } from '@dataforge/filter';

// Default configuration
const defaultConfig = mergeConfig();
// → { caseSensitive: false, maxDepth: 3, enableCache: false }

// With custom options
const customConfig = mergeConfig({ caseSensitive: true, maxDepth: 5 });
// → { caseSensitive: true, maxDepth: 5, enableCache: false }
```

### `createFilterConfig(options?)`

Creates a complete filter configuration object.

**Signature:**
```typescript
function createFilterConfig(options?: FilterOptions): FilterConfig
```

**Parameters:**
- `options` (`FilterOptions`, optional): User-provided options

**Returns:** `FilterConfig` - Complete configuration object

**Examples:**

```typescript
import { createFilterConfig } from '@dataforge/filter';

const config = createFilterConfig({
  caseSensitive: true,
  maxDepth: 5,
  enableCache: true
});
// → { caseSensitive: true, maxDepth: 5, enableCache: true, customComparator: undefined }
```

---

## Type Definitions

### Expression Types

```typescript
// Main expression type - can be any of the following
export type Expression<T> =
  | PrimitiveExpression
  | PredicateFunction<T>
  | ObjectExpression<T>
  | ExtendedObjectExpression<T>;

// Primitive values
export type PrimitiveExpression = string | number | boolean | null;

// Predicate function
export type PredicateFunction<T> = (item: T) => boolean;

// Simple object matching
export type ObjectExpression<T> = Partial<{
  [K in keyof T]: T[K] | string;
}>;

// Extended object with operators
export type ExtendedObjectExpression<T> = Partial<{
  [K in keyof T]: T[K] | OperatorExpression;
}>;
```

### Operator Types

#### Comparison Operators

```typescript
export interface ComparisonOperators {
  $gt?: number | Date;      // Greater than
  $gte?: number | Date;     // Greater than or equal
  $lt?: number | Date;      // Less than
  $lte?: number | Date;     // Less than or equal
  $eq?: unknown;            // Equal
  $ne?: unknown;            // Not equal
}
```

**Examples:**
```typescript
// Numeric comparisons
{ price: { $gt: 100 } }        // Price > 100
{ price: { $gte: 100 } }       // Price >= 100
{ price: { $lt: 500 } }        // Price < 500
{ price: { $lte: 500 } }       // Price <= 500
{ price: { $eq: 250 } }        // Price = 250
{ price: { $ne: 0 } }          // Price != 0

// Date comparisons
{ createdAt: { $gte: new Date('2025-01-01') } }
{ updatedAt: { $lt: new Date() } }

// Range queries
{ price: { $gte: 100, $lte: 500 } }  // 100 <= price <= 500
```

#### Array Operators

```typescript
export interface ArrayOperators {
  $in?: unknown[];           // Value in array
  $nin?: unknown[];          // Value not in array
  $contains?: unknown;       // Array contains value
  $size?: number;            // Array length
}
```

**Examples:**
```typescript
// Inclusion/exclusion
{ category: { $in: ['Electronics', 'Books'] } }
{ status: { $nin: ['archived', 'deleted'] } }

// Array operations
{ tags: { $contains: 'sale' } }        // Array contains 'sale'
{ images: { $size: 3 } }              // Array has 3 items
{ permissions: { $size: 0 } }          // Empty array
```

#### String Operators

```typescript
export interface StringOperators {
  $startsWith?: string;      // Starts with substring
  $endsWith?: string;        // Ends with substring
  $contains?: string;        // Contains substring
}
```

**Examples:**
```typescript
// String matching
{ name: { $startsWith: 'Pro' } }       // Name starts with 'Pro'
{ email: { $endsWith: '@company.com' } } // Email ends with domain
{ title: { $contains: 'typescript' } }   // Title contains 'typescript'

// Case-sensitive (with options)
filter(data, { name: { $startsWith: 'pro' } }, { caseSensitive: true });
```

#### Combined Operator Expression

```typescript
export type OperatorExpression =
  | ComparisonOperators
  | ArrayOperators
  | StringOperators;
```

### Configuration Types

#### FilterOptions

User-provided configuration options.

```typescript
export type FilterOptions = Partial<FilterConfig>;
```

**Available Options:**

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `caseSensitive` | `boolean` | `false` | Case-sensitive string matching |
| `maxDepth` | `number` | `3` | Maximum depth for nested objects (1-10) |
| `enableCache` | `boolean` | `false` | Enable result caching for repeated queries |
| `customComparator` | `Comparator` | `undefined` | Custom comparison function |

**Examples:**
```typescript
const options: FilterOptions = {
  caseSensitive: true,
  maxDepth: 5,
  enableCache: true,
  customComparator: (actual, expected) => actual === expected
};
```

#### FilterConfig

Complete configuration with all defaults applied.

```typescript
export interface FilterConfig {
  caseSensitive: boolean;
  maxDepth: number;
  customComparator?: Comparator;
  enableCache: boolean;
}
```

#### Comparator

Custom comparison function type.

```typescript
export type Comparator = (actual: unknown, expected: unknown) => boolean;
```

**Examples:**
```typescript
// Exact match comparator
const exactMatch: Comparator = (actual, expected) => actual === expected;

// Numeric tolerance comparator
const numericTolerance: Comparator = (actual, expected) => {
  if (typeof actual === 'number' && typeof expected === 'number') {
    return Math.abs(actual - expected) < 0.01;
  }
  return actual === expected;
};

// Locale-aware string comparator
const localeCompare: Comparator = (actual, expected) => {
  if (typeof actual === 'string' && typeof expected === 'string') {
    return actual.localeCompare(expected, 'en', { sensitivity: 'base' }) === 0;
  }
  return actual === expected;
};
```

---

## Expression Patterns

### String Patterns

#### Simple String Matching

```typescript
// Case-insensitive substring search across all properties
filter(users, 'Berlin');     // Finds users with 'Berlin' in any property
filter(products, 'Laptop');  // Finds products with 'Laptop' in any property
```

#### Wildcard Patterns

```typescript
// Percent (%) - matches zero or more characters
filter(users, '%alice%');     // Contains 'alice'
filter(users, 'Al%');         // Starts with 'Al'
filter(users, '%son');        // Ends with 'son'

// Underscore (_) - matches exactly one character
filter(codes, 'A_');          // 'A1', 'A2', but not 'AB1'
filter(ids, 'user-10_');      // 'user-101', 'user-102'

// Negation (!) - excludes matches
filter(users, '!London');     // Exclude users with 'London'
filter(files, '!%.pdf');      // Exclude PDF files
```

### Object Patterns

#### Simple Object Matching

```typescript
// Single property
filter(products, { category: 'Electronics' });

// Multiple properties (AND logic)
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

#### Mixed Patterns

```typescript
// Combine simple matching with operators
filter(products, {
  category: 'Electronics',           // Simple equality
  price: { $gte: 100, $lte: 500 },  // Range operator
  name: { $startsWith: 'Pro' },     // String operator
  tags: { $contains: 'premium' }     // Array operator
});
```

### Predicate Patterns

```typescript
// Simple predicates
filter(numbers, (n) => n > 5);
filter(users, (user) => user.age >= 18);

// Complex predicates
filter(products, (product) =>
  product.price < 100 &&
  product.inStock &&
  product.rating >= 4.0
);

// Type-safe predicates
filter<Product>(products, (p: Product): boolean =>
  p.price > 100 && p.name.includes('Pro')
);
```

---

## Error Handling

### Common Errors

#### Invalid Expression Error

```typescript
// ❌ These will throw errors
try {
  filter(data, undefined);
  filter(data, Symbol('test'));
  filter(data, new Map());
} catch (error) {
  console.error(error.message);
  // "Invalid filter expression: Expected string | number | boolean | null | function | object"
}
```

#### Invalid Options Error

```typescript
// ❌ These will throw errors
try {
  filter(data, expression, { maxDepth: 15 });     // Max is 10
  filter(data, expression, { caseSensitive: 'yes' }); // Wrong type
} catch (error) {
  console.error(error.message);
  // "Invalid filter options: maxDepth too large"
}
```

### Error Prevention

```typescript
import { validateExpression, validateOptions } from '@dataforge/filter';

// Safe filtering with validation
function safeFilter<T>(data: T[], expression: unknown, options?: unknown) {
  try {
    const validExpression = validateExpression<T>(expression);
    const validOptions = options ? validateOptions(options) : undefined;
    return filter(data, validExpression, validOptions);
  } catch (error) {
    console.error('Filter error:', error.message);
    return [];
  }
}
```

---

## Performance Considerations

### Optimization Tips

```typescript
// ✅ Fast: Simple string/number matching
filter(data, 'Berlin');
filter(data, 42);

// ✅ Fast: Object-based filtering
filter(data, { city: 'Berlin' });

// ✅ Fast: Operators with early exit
filter(data, { age: { $gte: 18 } });

// ⚠️ Moderate: Wildcards (regex compilation cached)
filter(data, '%berlin%');

// ⚠️ Slower: Complex predicates
filter(data, (item) => complexCalculation(item));
```

### Caching Strategy

```typescript
// Enable caching for repeated queries on large datasets
const largeDataset = [...]; // 10,000+ items

// First query - will be cached
const result1 = filter(largeDataset, { category: 'Electronics' }, { enableCache: true });

// Subsequent identical queries use cache
const result2 = filter(largeDataset, { category: 'Electronics' }, { enableCache: true });
```

### Memory Management

```typescript
// For very large datasets, consider pagination
const pageSize = 100;
const page = 0;
const pagedData = largeDataset.slice(page * pageSize, (page + 1) * pageSize);
const results = filter(pagedData, expression);
```

---

## Browser Support

- **Node.js:** >= 20
- **Browsers:** Chrome, Firefox, Safari, Edge (latest versions)
- **TypeScript:** >= 5.0
- **Module Systems:** ESM, CommonJS

---

## Examples

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
}

const products: Product[] = [...];

// Find affordable electronics in stock
const affordableElectronics = filter(products, {
  category: 'Electronics',
  price: { $lte: 1000 },
  rating: { $gte: 4.5 },
  inStock: { $eq: true }
});

// Search products with multiple filters
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

### Data Analytics

```typescript
interface Transaction {
  id: string;
  amount: number;
  status: 'pending' | 'completed' | 'failed';
  date: Date;
  category: string;
}

const transactions: Transaction[] = [...];

// High-value completed transactions
const highValueTransactions = filter(transactions, {
  amount: { $gte: 10000 },
  status: 'completed'
});

// Failed transactions for investigation
const failedPayments = filter(transactions, {
  status: 'failed',
  date: { $gte: new Date('2025-01-01') }
});
```

---

## Migration from Native Array.filter()

### Direct Replacements

```typescript
// Native filter
const adults = users.filter(u => u.age >= 18);

// @dataforge/filter equivalent
const adults = filter(users, (u) => u.age >= 18);
// OR better with operators:
const adults = filter(users, { age: { $gte: 18 } });

// Native: Multiple conditions
const results = users.filter(u =>
  u.age >= 18 &&
  u.city === 'Berlin' &&
  u.isActive
);

// @dataforge/filter
const results = filter(users, {
  age: { $gte: 18 },
  city: 'Berlin',
  isActive: true
});
```

### Enhanced Capabilities

```typescript
// ❌ Native: No wildcard support
const results = users.filter(u =>
  u.email.includes('gmail.com')
);

// ✅ @dataforge/filter
const results = filter(users, {
  email: { $endsWith: 'gmail.com' }
});
// OR
const results = filter(users, '%gmail.com');
```

---

## Testing

### Unit Testing Examples

```typescript
import { describe, it, expect } from 'vitest';
import { filter } from '@dataforge/filter';

describe('Filter API', () => {
  const users = [
    { id: 1, name: 'Alice', age: 30, role: 'admin' },
    { id: 2, name: 'Bob', age: 25, role: 'user' },
    { id: 3, name: 'Charlie', age: 35, role: 'user' }
  ];

  it('filters by age with operators', () => {
    const result = filter(users, { age: { $gte: 30 } });
    expect(result).toHaveLength(2);
    expect(result[0].name).toBe('Alice');
    expect(result[1].name).toBe('Charlie');
  });

  it('filters by role', () => {
    const result = filter(users, { role: 'admin' });
    expect(result).toHaveLength(1);
    expect(result[0].name).toBe('Alice');
  });

  it('handles empty results', () => {
    const result = filter(users, { age: { $gt: 100 } });
    expect(result).toEqual([]);
  });

  it('filters with predicates', () => {
    const result = filter(users, (u) => u.age > 28);
    expect(result).toHaveLength(2);
  });
});
```

---

## Related Documentation

- **[Main Documentation](./packages/filter.md)** - Complete package overview
- **[Operators Reference](./packages/filter-operators.md)** - Detailed operator guide
- **[Examples](./packages/filter-examples.md)** - Real-world usage examples
- **[WIKI.md](https://github.com/mcabreradev/dataforge/blob/main/packages/filter/WIKI.md)** - Comprehensive documentation with 150+ examples
- **[README.md](https://github.com/mcabreradev/dataforge/blob/main/packages/filter/README.md)** - Package overview and quick start
