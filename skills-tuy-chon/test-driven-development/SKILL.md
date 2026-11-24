---
name: "test-driven-development"
description: "Use when implementing any feature, bugfix or behavior change in code, before writing implementation code — red-green-refactor."
license: MIT
---

> Dựa trên https://github.com/obra/superpowers (MIT). Xem THIRD_PARTY_NOTICES.md. Bản đầy đủ: cài trực tiếp từ repo gốc.

# Test-Driven Development (TDD)

Write the test first. Watch it fail. Write minimal code to pass.

**Core principle:** If you didn't watch the test fail, you don't know if it tests the right thing.

**Always** for new features, bug fixes, refactoring, behavior changes. **Exceptions (ask the user):** throwaway prototypes, generated code, configuration files.

## The Iron Law

```
NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST
```

Wrote code before the test? Delete it and start over from the test. Don't keep it as "reference".

## Red-Green-Refactor

### RED — write one failing test
- One behavior, clear name describing it ("and" in the name? split it).
- Real code; mocks only if unavoidable. Assert on real behavior, never on mock behavior.
- Before writing it, name the production change that would make it fail.

### Verify RED — MANDATORY
Run the test. Confirm it **fails** (not errors), with the expected message, because the feature is missing (not a typo). Passes immediately? You're testing existing behavior — fix the test.

### GREEN — minimal code
Simplest code that passes. No extra options, no refactoring other code, no "improvements" beyond the test (YAGNI).

### Verify GREEN — MANDATORY
Run the test, then the **project's full test command** (`pytest`, `npm test`, `cargo test`…), not just your file. Output pristine. Test fails → fix code, not test. Any failure — even one you didn't cause — gets reported by name.

### REFACTOR
Only after green: remove duplication, improve names, extract helpers. Stay green. Don't add behavior.

Repeat with the next failing test.

## Example: bug fix

```typescript
// RED
test('rejects empty email', async () => {
  const result = await submitForm({ email: '' });
  expect(result.error).toBe('Email required');
});
// run → FAIL: expected 'Email required', got undefined

// GREEN
function submitForm(data: FormData) {
  if (!data.email?.trim()) return { error: 'Email required' };
  // ...
}
// run → PASS
```

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Too simple to test" | Simple code breaks. The test takes 30 seconds. |
| "I'll test after" | Tests written after pass immediately — proving nothing. |
| "Already manually tested" | Ad-hoc, unrecorded, not re-runnable. |
| "Deleting hours of work is wasteful" | Sunk cost. Keeping untrusted code is the waste. |
| "Need to explore first" | Fine — throw the exploration away, then start with TDD. |
| "Hard to test" | Hard to test = hard to use. Simplify the design. |
| "Existing code has no tests" | Add tests for the code you touch. |

## Red Flags — delete code, start over

Code before test · test passes immediately · can't explain why the test failed · tests "later" · "just this once" · "spirit not ritual" · "this is different because…"

## When Stuck

| Problem | Solution |
|---------|----------|
| Don't know how to test | Write the wished-for API; write the assertion first. |
| Test too complicated | Design too complicated; simplify the interface. |
| Must mock everything | Code too coupled; use dependency injection. |
| Huge test setup | Extract helpers; still complex → simplify design. |

## Checklist before calling it done

- [ ] Every new function/method has a test
- [ ] Watched each test fail for the expected reason
- [ ] Wrote minimal code to pass
- [ ] Full suite passes, output pristine
- [ ] Edge cases and errors covered

Bug found? Write a failing test reproducing it first. Never fix bugs without a test.