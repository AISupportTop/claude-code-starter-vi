---
name: "systematic-debugging"
description: "Use when encountering any bug, test failure, build failure or unexpected behavior, before proposing fixes — find the root cause first."
license: MIT
---

> Dựa trên https://github.com/obra/superpowers (MIT). Xem THIRD_PARTY_NOTICES.md. Bản đầy đủ: cài trực tiếp từ repo gốc.

# Systematic Debugging

**Core principle:** ALWAYS find root cause before attempting fixes. Symptom fixes are failure.

## The Iron Law

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

If you haven't completed Phase 1, you cannot propose fixes.

Use for ANY technical issue: test failures, production bugs, unexpected behavior, performance problems, build failures, integration issues. Use it ESPECIALLY under time pressure, when a "quick fix" seems obvious, or when previous fixes didn't work.

## Phase 1: Root Cause Investigation

1. **Read error messages carefully** — full stack traces, line numbers, file paths, error codes. They often contain the answer.
2. **Reproduce consistently** — exact steps; if not reproducible, gather more data, don't guess.
3. **Check recent changes** — git diff, recent commits, new dependencies, config/environment differences.
4. **Gather evidence in multi-component systems** — for each component boundary (CI → build → signing, API → service → DB) log what enters and exits, verify env/config propagation. Run once to see WHERE it breaks, then investigate that component.
5. **Trace data flow backward** — when the error is deep in the call stack: find the immediate cause, ask "what called this, with what value?", keep tracing up until you find the original trigger. Fix at the source, not at the symptom. If manual tracing stalls, add temporary instrumentation (log the value + `new Error().stack`) right before the failing operation.

## Phase 2: Pattern Analysis

1. Find similar working code in the same codebase.
2. If implementing a known pattern, read the reference implementation COMPLETELY.
3. List every difference between working and broken, however small.
4. Understand dependencies: components, settings, environment, assumptions.

## Phase 3: Hypothesis and Testing

1. State one hypothesis: "I think X is the root cause because Y."
2. Make the SMALLEST change to test it — one variable at a time.
3. Worked → Phase 4. Didn't → form a NEW hypothesis; don't stack fixes.
4. If you don't understand something, say so. Don't pretend.

## Phase 4: Implementation

1. **Create a failing test case** reproducing the bug (automated test, or a one-off script if no framework). MUST have before fixing.
2. **Implement a single fix** addressing the root cause. No "while I'm here" improvements.
3. **Verify** — the test passes, no other tests broke, the issue is actually resolved.
4. **If the fix doesn't work:** count attempts. Fewer than 3 → back to Phase 1 with the new information. **3 or more → STOP and question the architecture.**
5. **3+ failed fixes = architectural problem** (each fix reveals new coupling elsewhere, fixes need massive refactoring, new symptoms keep appearing). Discuss with the user before attempting more fixes.

After finding the root cause, consider defense in depth: add validation at the entry point, business logic, and environment guards so the same bad value can't slip through again. Replace arbitrary sleeps/timeouts in tests with polling for the actual condition.

## Red Flags — STOP and return to Phase 1

- "Quick fix for now, investigate later"
- "Just try changing X and see if it works"
- "Add multiple changes, run tests"
- "Skip the test, I'll manually verify"
- "It's probably X, let me fix that"
- "I don't fully understand but this might work"
- Listing fixes before tracing data flow
- "One more fix attempt" after 2+ failures

User signals you're doing it wrong: "Is that not happening?" (you assumed), "Stop guessing", "Will it show us...?" (you should gather evidence), "We're stuck?".

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Issue is simple" | Simple issues have root causes too; the process is fast for them. |
| "Emergency, no time" | Systematic is faster than guess-and-check thrashing. |
| "Multiple fixes at once saves time" | Can't isolate what worked; causes new bugs. |
| "I see the problem" | Seeing symptoms ≠ understanding root cause. |

## When there's truly no root cause

If investigation shows the issue is environmental, timing-dependent or external: document what you investigated, implement appropriate handling (retry, timeout, clear error), add logging for next time. But 95% of "no root cause" cases are incomplete investigation.