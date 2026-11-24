# Global rules (kept short on purpose: this file loads every session)

## Language
- Reply in Vietnamese. Code, commit messages and identifiers stay in English.
- Be concise: no recap of steps, no restating the question.

## Reading the project cheaply
- If `graphify-out/GRAPH_REPORT.md` exists, read it before grepping or opening many files.
- If the project has CLAUDE.md / AGENTS.md / PLAN.md, read those first.
- For broad searches across many files, delegate to the Explore subagent and keep only its conclusions.
- Read the line ranges you need, not whole large files. Do not re-read a file you just edited.

## Doing the work accurately
- State assumptions before coding; ask only when a wrong guess is costly.
- Make the smallest change that solves the task; do not refactor unrelated code.
- For bugs, find the root cause before proposing a fix.
- Never claim done/fixed/passing without running the relevant test, build or command and reading its output.

## Context hygiene
- For tasks longer than ~1 hour, keep a short `PLAN.md` (goal, decisions, files touched, next step) and update it as you go.
- Before compaction, make sure decisions and open items are in PLAN.md.
- When a task is finished, suggest `/clear` before starting an unrelated one.

## Safety
- Before installing any third-party skill, plugin, MCP server or package, run the `tham-dinh-plugin-skill` skill and ask me.
- Never run `curl | bash`, delete files outside the project, or push to remote without my confirmation.
