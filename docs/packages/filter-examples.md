# Filter Examples & Use Cases

Practical examples and real-world use cases for `@dataforge/filter`.

## E-commerce Product Catalog

### Product Search & Filtering

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
  specifications: {
    color: string;
    size: string;
    weight: number;
  };
}

const products: Product[] = [
  {
    id: 1,
    name: 'MacBook Pro 16"',
    price: 2499,
    category: 'Electronics',
    brand: 'Apple',
    rating: 4.8,
    inStock: true,
    tags: ['laptop', 'premium', 'professional'],
    createdAt: new Date('2024-01-15'),
    specifications: { color: 'Space Gray', size: '16"', weight: 2.1 }
  },
  {
    id: 2,
    name: 'iPhone 15 Pro',
    price: 999,
    category: 'Electronics',
    brand: 'Apple',
    rating: 4.7,
    inStock: true,
    tags: ['phone', 'premium', 'camera'],
    createdAt: new Date('2024-09-20'),
    specifications: { color: 'Natural Titanium', size: '6.1"', weight: 0.19 }
  },
  {
    id: 3,
    name: 'Samsung Galaxy S24',
    price: 799,
    category: 'Electronics',
    brand: 'Samsung',
    rating: 4.5,
    inStock: false,
    tags: ['phone', 'android', 'camera'],
    createdAt: new Date('2024-01-17'),
    specifications: { color: 'Black', size: '6.2"', weight: 0.17 }
  }
];

// Find affordable electronics in stock
const affordableElectronics = filter(products, {
  category: 'Electronics',
  price: { $lte: 1000 },
  inStock: { $eq: true }
});

// Search for Apple products with high ratings
const premiumAppleProducts = filter(products, {
  brand: 'Apple',
  rating: { $gte: 4.7 },
  inStock: true
});

// Find products with specific tags
const cameraProducts = filter(products, {
  tags: { $contains: 'camera' }
});

// Price range search
const midRangeProducts = filter(products, {
  price: { $gte: 500, $lte: 1500 }
});

// Recent products from specific brands
const recentSamsungProducts = filter(products, {
  brand: 'Samsung',
  createdAt: { $gte: new Date('2024-01-01') }
});
```

### Advanced Product Filtering

```typescript
// Complex multi-criteria search
const searchResults = filter(products, {
  name: { $contains: 'Pro' },
  price: { $gte: 800, $lte: 3000 },
  rating: { $gte: 4.5 },
  inStock: { $eq: true },
  tags: { $contains: 'premium' }
});

// Exclude specific brands
const nonAppleProducts = filter(products, {
  brand: { $ne: 'Apple' },
  inStock: true
});

// Products with specific specifications
const spaceGrayProducts = filter(products, {
  'specifications.color': 'Space Gray'
});

// Products with multiple tags
const professionalProducts = filter(products, {
  tags: { $contains: 'professional' },
  rating: { $gte: 4.5 }
});
```

## User Management System

### User Search & Filtering

```typescript
interface User {
  id: number;
  name: string;
  email: string;
  role: string;
  department: string;
  isActive: boolean;
  lastLogin: Date;
  permissions: string[];
  profile: {
    age: number;
    location: string;
    bio: string;
  };
}

const users: User[] = [
  {
    id: 1,
    name: 'Alice Johnson',
    email: 'alice@company.com',
    role: 'admin',
    department: 'Engineering',
    isActive: true,
    lastLogin: new Date('2025-01-15'),
    permissions: ['read', 'write', 'admin'],
    profile: { age: 30, location: 'San Francisco', bio: 'Senior developer' }
  },
  {
    id: 2,
    name: 'Bob Smith',
    email: 'bob@company.com',
    role: 'user',
    department: 'Marketing',
    isActive: true,
    lastLogin: new Date('2025-01-14'),
    permissions: ['read'],
    profile: { age: 25, location: 'New York', bio: 'Marketing specialist' }
  },
  {
    id: 3,
    name: 'Charlie Brown',
    email: 'charlie@company.com',
    role: 'moderator',
    department: 'Support',
    isActive: false,
    lastLogin: new Date('2024-12-01'),
    permissions: ['read', 'moderate'],
    profile: { age: 35, location: 'Chicago', bio: 'Customer support lead' }
  }
];

// Find active users with admin permissions
const activeAdmins = filter(users, {
  isActive: { $eq: true },
  permissions: { $contains: 'admin' }
});

// Find users from specific departments
const engineeringUsers = filter(users, {
  department: 'Engineering',
  isActive: true
});

// Find users who logged in recently
const recentUsers = filter(users, {
  lastLogin: { $gte: new Date('2025-01-01') },
  isActive: true
});

// Find users with specific roles
const moderatorsAndAdmins = filter(users, {
  role: { $in: ['moderator', 'admin'] }
});

// Search users by name pattern
const johnsons = filter(users, {
  name: '%Johnson%'
});

// Find users with specific age range
const youngUsers = filter(users, {
  'profile.age': { $gte: 18, $lte: 30 }
});
```

### User Access Control

```typescript
// Find users who can write
const writers = filter(users, {
  permissions: { $contains: 'write' },
  isActive: true
});

// Find inactive users
const inactiveUsers = filter(users, {
  isActive: { $eq: false }
});

// Find users from specific locations
const sfUsers = filter(users, {
  'profile.location': 'San Francisco',
  isActive: true
});

// Find users with specific bio content
const developers = filter(users, {
  'profile.bio': { $contains: 'developer' }
});
```

## Content Management System

### Article & Blog Post Filtering

```typescript
interface Article {
  id: number;
  title: string;
  content: string;
  author: string;
  category: string;
  tags: string[];
  publishedAt: Date;
  isPublished: boolean;
  views: number;
  rating: number;
  metadata: {
    wordCount: number;
    readingTime: number;
    language: string;
  };
}

const articles: Article[] = [
  {
    id: 1,
    title: 'Getting Started with TypeScript',
    content: 'TypeScript is a powerful language...',
    author: 'Alice Johnson',
    category: 'Programming',
    tags: ['typescript', 'javascript', 'tutorial'],
    publishedAt: new Date('2025-01-10'),
    isPublished: true,
    views: 1250,
    rating: 4.8,
    metadata: { wordCount: 1200, readingTime: 5, language: 'en' }
  },
  {
    id: 2,
    title: 'Advanced React Patterns',
    content: 'React offers many advanced patterns...',
    author: 'Bob Smith',
    category: 'Programming',
    tags: ['react', 'patterns', 'advanced'],
    publishedAt: new Date('2025-01-12'),
    isPublished: true,
    views: 890,
    rating: 4.6,
    metadata: { wordCount: 2000, readingTime: 8, language: 'en' }
  },
  {
    id: 3,
    title: 'Draft: CSS Grid Layout',
    content: 'CSS Grid is a powerful layout system...',
    author: 'Charlie Brown',
    category: 'Design',
    tags: ['css', 'grid', 'layout'],
    publishedAt: new Date('2025-01-14'),
    isPublished: false,
    views: 0,
    rating: 0,
    metadata: { wordCount: 800, readingTime: 3, language: 'en' }
  }
];

// Find published articles with high ratings
const popularArticles = filter(articles, {
  isPublished: { $eq: true },
  rating: { $gte: 4.5 }
});

// Find articles by specific author
const aliceArticles = filter(articles, {
  author: 'Alice Johnson',
  isPublished: true
});

// Find articles with specific tags
const tutorialArticles = filter(articles, {
  tags: { $contains: 'tutorial' },
  isPublished: true
});

// Find recent articles
const recentArticles = filter(articles, {
  publishedAt: { $gte: new Date('2025-01-01') },
  isPublished: true
});

// Find articles with high engagement
const engagingArticles = filter(articles, {
  views: { $gte: 1000 },
  rating: { $gte: 4.0 },
  isPublished: true
});

// Find articles by category and reading time
const quickReads = filter(articles, {
  category: 'Programming',
  'metadata.readingTime': { $lte: 5 },
  isPublished: true
});
```

## Order Management System

### Order Processing & Analytics

```typescript
interface Order {
  id: number;
  customerId: number;
  items: Array<{
    productId: number;
    quantity: number;
    price: number;
  }>;
  total: number;
  status: string;
  createdAt: Date;
  shippedAt?: Date;
  deliveredAt?: Date;
  customer: {
    name: string;
    email: string;
    location: string;
  };
}

const orders: Order[] = [
  {
    id: 1,
    customerId: 101,
    items: [
      { productId: 1, quantity: 1, price: 2499 },
      { productId: 2, quantity: 2, price: 999 }
    ],
    total: 4497,
    status: 'delivered',
    createdAt: new Date('2025-01-10'),
    shippedAt: new Date('2025-01-12'),
    deliveredAt: new Date('2025-01-15'),
    customer: { name: 'John Doe', email: 'john@example.com', location: 'NYC' }
  },
  {
    id: 2,
    customerId: 102,
    items: [{ productId: 3, quantity: 1, price: 799 }],
    total: 799,
    status: 'shipped',
    createdAt: new Date('2025-01-12'),
    shippedAt: new Date('2025-01-14'),
    customer: { name: 'Jane Smith', email: 'jane@example.com', location: 'LA' }
  },
  {
    id: 3,
    customerId: 103,
    items: [{ productId: 1, quantity: 1, price: 2499 }],
    total: 2499,
    status: 'pending',
    createdAt: new Date('2025-01-15'),
    customer: { name: 'Bob Wilson', email: 'bob@example.com', location: 'Chicago' }
  }
];

// Find high-value orders
const highValueOrders = filter(orders, {
  total: { $gte: 2000 }
});

// Find orders by status
const pendingOrders = filter(orders, {
  status: 'pending'
});

// Find orders from specific location
const nycOrders = filter(orders, {
  'customer.location': 'NYC'
});

// Find orders with multiple items
const multiItemOrders = filter(orders, {
  'items': { $size: { $gt: 1 } }
});

// Find recent orders
const recentOrders = filter(orders, {
  createdAt: { $gte: new Date('2025-01-01') }
});

// Find delivered orders
const deliveredOrders = filter(orders, {
  status: 'delivered',
  deliveredAt: { $gte: new Date('2025-01-01') }
});
```

## Performance Optimization Examples

### Caching for Repeated Queries

```typescript
// Enable caching for large datasets
const largeProductCatalog = [...]; // 10,000+ products

// First query - will be cached
const electronics = filter(largeProductCatalog, {
  category: 'Electronics'
}, { enableCache: true });

// Subsequent queries with same expression will use cache
const electronicsAgain = filter(largeProductCatalog, {
  category: 'Electronics'
}, { enableCache: true });
```

### Efficient Filtering Strategies

```typescript
// ✅ Efficient: Use operators for fast evaluation
const expensiveProducts = filter(products, {
  price: { $gt: 1000 }
});

// ✅ Efficient: Combine operators for early exit
const premiumElectronics = filter(products, {
  category: 'Electronics',
  price: { $gte: 500 },
  rating: { $gte: 4.5 }
});

// ⚠️ Less efficient: Complex predicates (but more flexible)
const complexFilter = filter(products, (product) => {
  return product.price > 1000 &&
         product.category === 'Electronics' &&
         product.rating >= 4.5 &&
         product.tags.includes('premium') &&
         product.specifications.color === 'Space Gray';
});
```

## Testing Examples

### Unit Testing with Filter

```typescript
import { filter } from '@dataforge/filter';

describe('Product Filtering', () => {
  const products = [
    { id: 1, name: 'Laptop', price: 1000, category: 'Electronics' },
    { id: 2, name: 'Book', price: 20, category: 'Books' },
    { id: 3, name: 'Phone', price: 800, category: 'Electronics' }
  ];

  it('should filter by category', () => {
    const electronics = filter(products, { category: 'Electronics' });
    expect(electronics).toHaveLength(2);
    expect(electronics.map(p => p.name)).toEqual(['Laptop', 'Phone']);
  });

  it('should filter by price range', () => {
    const expensiveProducts = filter(products, {
      price: { $gte: 500 }
    });
    expect(expensiveProducts).toHaveLength(2);
  });

  it('should combine multiple criteria', () => {
    const expensiveElectronics = filter(products, {
      category: 'Electronics',
      price: { $gte: 500 }
    });
    expect(expensiveElectronics).toHaveLength(2);
  });
});
```

## Migration from Native Array.filter()

### Before (Native JavaScript)

```typescript
// Complex filtering with native Array.filter()
const expensiveElectronics = products.filter(product =>
  product.category === 'Electronics' &&
  product.price > 1000 &&
  product.inStock === true &&
  product.rating >= 4.5
);

// String matching with native methods
const laptopProducts = products.filter(product =>
  product.name.toLowerCase().includes('laptop')
);
```

### After (With @dataforge/filter)

```typescript
// Clean, readable filtering
const expensiveElectronics = filter(products, {
  category: 'Electronics',
  price: { $gt: 1000 },
  inStock: { $eq: true },
  rating: { $gte: 4.5 }
});

// Simple string matching with wildcards
const laptopProducts = filter(products, '%laptop%');
```

## Best Practices

1. **Use operators for performance**: Operators are optimized for speed
2. **Enable caching for large datasets**: Use `enableCache: true` for repeated queries
3. **Combine operators efficiently**: Use multiple operators on the same field for early exit
4. **Use TypeScript**: Leverage type safety for better development experience
5. **Test your filters**: Write unit tests for complex filtering logic
6. **Consider data structure**: Design your data structure to work well with filtering
7. **Use meaningful field names**: Make your filter expressions readable
8. **Document complex filters**: Add comments for complex filtering logic
