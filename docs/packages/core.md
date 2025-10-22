# @dataforge/core

Core utilities and types for functional programming patterns.

## Installation

```bash
npm install @dataforge/core
```

## Features

- **Result Type**: Type-safe error handling
- **Option Type**: Nullable value handling
- **Either Type**: Discriminated unions
- **Type Utilities**: Helper functions for type checking

## Result Type

The Result type provides a functional approach to error handling.

```typescript
import { success, failure, isSuccess, isFailure } from '@dataforge/core'

// Creating results
const successResult = success('Hello World')
const failureResult = failure(new Error('Something went wrong'))

// Type checking
if (isSuccess(successResult)) {
  console.log(successResult.data) // 'Hello World'
}

if (isFailure(failureResult)) {
  console.log(failureResult.error.message) // 'Something went wrong'
}
```

### Example: Safe Division

```typescript
import { success, failure, Result } from '@dataforge/core'

function divide(a: number, b: number): Result<number, Error> {
  if (b === 0) {
    return failure(new Error('Division by zero'))
  }
  return success(a / b)
}

const result = divide(10, 2)
if (isSuccess(result)) {
  console.log(result.data) // 5
}
```

## Option Type

The Option type represents a value that may or may not exist.

```typescript
import { some, none, isSome, isNone } from '@dataforge/core'

// Creating options
const someValue = some('Hello')
const noValue = none()

// Type checking
if (isSome(someValue)) {
  console.log(someValue.value) // 'Hello'
}

if (isNone(noValue)) {
  console.log('No value')
}
```

### Example: Safe Array Access

```typescript
import { some, none, Option } from '@dataforge/core'

function getFirstElement<T>(array: T[]): Option<T> {
  return array.length > 0 ? some(array[0]) : none()
}

const numbers = [1, 2, 3]
const first = getFirstElement(numbers)
if (isSome(first)) {
  console.log(first.value) // 1
}
```

## Either Type

The Either type represents a value that can be one of two types.

```typescript
import { left, right, isLeft, isRight } from '@dataforge/core'

// Creating either values
const leftValue = left('error message')
const rightValue = right('success data')

// Type checking
if (isLeft(leftValue)) {
  console.log(leftValue.value) // 'error message'
}

if (isRight(rightValue)) {
  console.log(rightValue.value) // 'success data'
}
```

### Example: Validation

```typescript
import { left, right, Either } from '@dataforge/core'

function validateAge(age: number): Either<string, number> {
  if (age < 0) {
    return left('Age cannot be negative')
  }
  if (age > 150) {
    return left('Age cannot be greater than 150')
  }
  return right(age)
}

const result = validateAge(25)
if (isRight(result)) {
  console.log(`Valid age: ${result.value}`)
}
```

## API Reference

### Result Functions

- `success<T>(data: T): Result<T, never>`
- `failure<E>(error: E): Result<never, E>`
- `isSuccess<T, E>(result: Result<T, E>): result is Success<T>`
- `isFailure<T, E>(result: Result<T, E>): result is Failure<E>`

### Option Functions

- `some<T>(value: T): Option<T>`
- `none(): Option<never>`
- `isSome<T>(option: Option<T>): option is Some<T>`
- `isNone<T>(option: Option<T>): option is None`

### Either Functions

- `left<L>(value: L): Either<L, never>`
- `right<R>(value: R): Either<never, R>`
- `isLeft<L, R>(either: Either<L, R>): either is Left<L>`
- `isRight<L, R>(either: Either<L, R>): either is Right<R>`

## Type Definitions

```typescript
export type Result<T, E = Error> = Success<T> | Failure<E>

export interface Success<T> {
  readonly success: true
  readonly data: T
}

export interface Failure<E> {
  readonly success: false
  readonly error: E
}

export type Option<T> = Some<T> | None

export interface Some<T> {
  readonly some: true
  readonly value: T
}

export interface None {
  readonly some: false
}

export type Either<L, R> = Left<L> | Right<R>

export interface Left<L> {
  readonly left: true
  readonly value: L
}

export interface Right<R> {
  readonly right: true
  readonly value: R
}
```
