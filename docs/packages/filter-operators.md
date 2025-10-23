# Filter Operators Reference

Complete reference for all MongoDB-style operators available in `@dataforge/filter`.

## Comparison Operators

### `$gt` - Greater Than

Matches values greater than the specified value.

```typescript
// Find products with price > $100
filter(products, { price: { $gt: 100 } });

// Find users older than 18
filter(users, { age: { $gt: 18 } });

// Find orders after a specific date
filter(orders, { createdAt: { $gt: new Date('2025-01-01') } });
```

### `$gte` - Greater Than or Equal

Matches values greater than or equal to the specified value.

```typescript
// Find products with price >= $50
filter(products, { price: { $gte: 50 } });

// Find users 18 or older
filter(users, { age: { $gte: 18 } });
```

### `$lt` - Less Than

Matches values less than the specified value.

```typescript
// Find products with price < $500
filter(products, { price: { $lt: 500 } });

// Find users younger than 65
filter(users, { age: { $lt: 65 } });
```

### `$lte` - Less Than or Equal

Matches values less than or equal to the specified value.

```typescript
// Find products with price <= $1000
filter(products, { price: { $lte: 1000 } });

// Find users 65 or younger
filter(users, { age: { $lte: 65 } });
```

### `$eq` - Equal

Matches values equal to the specified value (explicit equality).

```typescript
// Find products in stock
filter(products, { inStock: { $eq: true } });

// Find users with specific role
filter(users, { role: { $eq: 'admin' } });
```

### `$ne` - Not Equal

Matches values not equal to the specified value.

```typescript
// Find products not in stock
filter(products, { inStock: { $ne: true } });

// Find users who are not guests
filter(users, { role: { $ne: 'guest' } });
```

## Array Operators

### `$in` - In Array

Matches values that exist in the specified array.

```typescript
// Find products in specific categories
filter(products, { category: { $in: ['Electronics', 'Books'] } });

// Find users with specific roles
filter(users, { role: { $in: ['admin', 'moderator'] } });

// Find orders with specific statuses
filter(orders, { status: { $in: ['completed', 'shipped'] } });
```

### `$nin` - Not In Array

Matches values that do not exist in the specified array.

```typescript
// Find products not in specific categories
filter(products, { category: { $nin: ['Archived', 'Deleted'] } });

// Find users who are not banned or suspended
filter(users, { status: { $nin: ['banned', 'suspended'] } });
```

### `$contains` - Array Contains

Matches arrays that contain the specified value.

```typescript
// Find products with specific tags
filter(products, { tags: { $contains: 'sale' } });

// Find users with specific permissions
filter(users, { permissions: { $contains: 'write' } });

// Find articles with specific topics
filter(articles, { topics: { $contains: 'javascript' } });
```

### `$size` - Array Size

Matches arrays with the specified length.

```typescript
// Find products with exactly 3 images
filter(products, { images: { $size: 3 } });

// Find users with multiple addresses
filter(users, { addresses: { $size: 2 } });

// Find orders with specific number of items
filter(orders, { items: { $size: 1 } });
```

## String Operators

### `$startsWith` - Starts With

Matches strings that start with the specified value.

```typescript
// Find products starting with "Pro"
filter(products, { name: { $startsWith: 'Pro' } });

// Find users with company email
filter(users, { email: { $startsWith: 'user@company.com' } });

// Find files with specific prefix
filter(files, { filename: { $startsWith: 'report-' } });
```

### `$endsWith` - Ends With

Matches strings that end with the specified value.

```typescript
// Find products ending with "Pro"
filter(products, { name: { $endsWith: 'Pro' } });

// Find users with specific email domain
filter(users, { email: { $endsWith: '@company.com' } });

// Find files with specific extension
filter(files, { filename: { $endsWith: '.pdf' } });
```

### `$contains` - Contains Substring

Matches strings that contain the specified substring.

```typescript
// Find products containing "laptop"
filter(products, { name: { $contains: 'laptop' } });

// Find users with specific text in bio
filter(users, { bio: { $contains: 'developer' } });

// Case-sensitive search
filter(products, { name: { $contains: 'Laptop' } }, { caseSensitive: true });
```

## Combining Operators

You can combine multiple operators for complex queries:

```typescript
// Multiple operators on same field
filter(products, {
  price: { $gte: 100, $lte: 500 }
});

// Different operators on different fields
filter(products, {
  price: { $gte: 100, $lte: 500 },
  category: { $in: ['Electronics', 'Accessories'] },
  name: { $startsWith: 'Pro' },
  inStock: { $eq: true }
});

// Complex nested queries
filter(users, {
  age: { $gte: 18, $lte: 65 },
  role: { $nin: ['guest', 'banned'] },
  permissions: { $contains: 'admin' },
  lastLogin: { $gte: new Date('2025-01-01') }
});
```

## Performance Considerations

- **Early Exit**: Operators use early exit strategies for optimal performance
- **Type Checking**: Fast type guards prevent unnecessary operations
- **Caching**: Enable caching for repeated queries on large datasets

```typescript
// ✅ Fast: Simple operators
filter(data, { age: { $gte: 18 } });

// ✅ Fast: Combined operators with early exit
filter(data, { age: { $gte: 18, $lte: 65 } });

// ⚠️ Slower: Complex array operations
filter(data, { tags: { $contains: 'complex-search-term' } });
```

## Type Safety

All operators are fully typed for TypeScript:

```typescript
interface Product {
  id: number;
  name: string;
  price: number;
  category: string;
  tags: string[];
  inStock: boolean;
}

// Type-safe operator usage
const expensiveProducts = filter<Product>(products, {
  price: { $gt: 1000 },
  category: { $in: ['Electronics'] },
  tags: { $contains: 'premium' }
});
```
