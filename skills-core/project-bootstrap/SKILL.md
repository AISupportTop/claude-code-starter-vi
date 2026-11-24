---
name: "project-bootstrap"
description: "Khởi tạo dự án mới theo chủ đề (software, AI agent, research, marketing, data, business, writing, course): tạo cấu trúc thư mục, CLAUDE.md, thư viện prompt và setup tự động. Use for init/scaffold/start a project."
---

# Project Bootstrap (multi-domain)

_Patterns adapted from athola/claude-night-market `attune:project-init` (MIT) and matteotitta/claude-code-marketing-quickstart (MIT): context-first layout, per-folder CLAUDE.md maps, research → strategy → execution lanes, decision journal._

One call turns a topic into a ready workspace: folders, a root `CLAUDE.md` that tells any AI how to work there, per-folder maps, a prompt library for the domain, and state files so later sessions resume without re-explaining.

## Workflow

### 1. Understand the request (ask at most once)
Infer from the user's message; ask only what you can't infer, in ONE short question set:
- **Topic / goal** (one sentence) and **domain preset** (see presets; combine two if needed, e.g. `ai-agent + software`)
- **Project name** (default: kebab-case of topic) and **location** (default: working directory, or the user's connected folder)
- **Language** for generated docs (default: the user's language)
- Domain extras only if they change the scaffold (e.g. code stack: Python / TypeScript)
If the user is away, pick sensible defaults and state them at the top of the result.

### 2. Check the target
List the target folder. If files exist, never overwrite: show what would collide and offer merge (add missing only) or a new subfolder.

### 3. Generate the core (every preset)
```
<project>/
├── CLAUDE.md          # how to work here (rules + map), ≤ 1 page
├── README.md          # goal, scope, how to start, for humans
├── latest.md          # current status + next 3 actions (read first each session)
├── history.md         # one line per meaningful change, newest first
├── decisions.md       # decision journal: date · decision · options · why
├── context/           # facts that stay true: brief, audience, constraints, glossary, sources
│   └── brief.md       # filled from what the user said; gaps marked TODO
├── prompts/           # reusable prompts for this domain (see presets)
├── outputs/           # deliverables, by lane → research/ strategy/ execution/
└── archive/           # superseded material, never deleted
```
Root `CLAUDE.md` template:
```markdown
# How to work in <project>
Goal: <one sentence>. Read this file, then latest.md.
## Before writing anything
1. Read the relevant files in context/. If one you need is empty, say so — don't invent facts.
2. Save work to outputs/<lane>/<research|strategy|execution>/, named YYMMDD-topic.md.
## House rules
- Cite sources; mark guesses as guesses. Never invent numbers, quotes or names.
- Keep each CLAUDE.md to one page — maps, not documents.
- After meaningful work: add a line to history.md, update latest.md, log choices in decisions.md.
## Map
<one line per top-level folder>
```
Every folder gets a 3–6 line `CLAUDE.md`: what goes here, naming, which prompt fills it. Empty leaf folders get `.gitkeep`.

### 4. Add the preset
Add the preset's folders/lanes and write each listed prompt as `prompts/<name>.md` with: purpose, inputs (with `{{placeholders}}`), the prompt text, expected output + save location. Write full, usable prompts — not one-liners.

### 5. Set up
- `git init` + a domain-appropriate `.gitignore` (always ignore `.env`, secrets, large raw data); create `.env.example` if keys are needed, never real keys.
- Software presets: create the minimal runnable skeleton (package manifest, `src/`, `tests/` with one passing smoke test, Makefile or npm scripts: `setup`, `test`, `lint`). Run the smoke test.
- Fill `context/brief.md`, `latest.md` (status: "initialized", next 3 actions), first `history.md` and `decisions.md` entries (preset chosen and why).

### 6. Verify and report
List the tree (depth 2), confirm no file was overwritten, run any tests. Reply with: what was created (tree), the 3 next actions, and which prompt to run first. If the folder is in the workspace, not on the user's computer, deliver it as a zip.

## Presets

**software** — `src/ tests/ docs/{architecture,adr} scripts/ .github/workflows/`
Prompts: `spec-to-plan` (requirements → milestones + tasks), `feature-tdd` (failing test → code → refactor), `debug` (reproduce → hypothesize → bisect → fix + regression test), `code-review` (correctness, security, readability), `adr` (architecture decision record), `release-notes`.

**ai-agent** (LLM / multi-agent / MCP apps) — `src/{agents,tools,prompts,router} evals/{datasets,results} configs/models.yaml docs/`
Prompts: `system-prompt-design`, `tool-schema-design`, `model-routing` (cheap vs strong tier, fallbacks), `eval-set-builder` (golden cases + rubric), `prompt-cache-audit` (stable prefix vs changing suffix), `cost-report` (tokens + $ per task), `failure-triage`. Put model IDs and prices in `configs/`, never in code.

**research** — `context/{question,scope,sources}` lanes `literature/ analysis/ report/`, `notes/`, `data/{raw,processed}`
Prompts: `research-question` (sharpen to answerable sub-questions), `search-plan`, `source-summary` (claim + evidence + reliability), `synthesis` (themes, contradictions, gaps), `report-outline`, `fact-check`.

**marketing / content** — `context/{audience,positioning,messaging,brand-voice,competitors}` lanes `content/ social/ seo/ email/ ads/ website/`, `library/taste/`
Prompts: `icp-profile`, `positioning`, `messaging-house`, `content-calendar`, `brief-to-draft`, `repurpose` (1 piece → N channels), `seo-brief`, `campaign-review`.

**data-analysis** — `data/{raw,interim,processed}` (raw is read-only) `notebooks/ src/ reports/ figures/`
Prompts: `data-audit` (schema, nulls, outliers), `question-to-metrics`, `eda-plan`, `analysis-writeup` (finding → evidence → so-what), `dashboard-spec`, `assumption-check`.

**business / startup** — `context/{problem,customers,market,competitors}` lanes `strategy/ product/ finance/ ops/ fundraising/`, `meetings/`
Prompts: `lean-canvas`, `customer-interview-guide`, `interview-synthesis`, `competitor-teardown`, `pricing-options`, `one-pager`, `okr-draft`, `meeting-notes-to-actions`.

**writing** (book, long-form, thesis) — `context/{premise,outline,characters-or-concepts,style}` `drafts/ chapters/ research/ feedback/`
Prompts: `premise-to-outline`, `chapter-brief`, `draft-section`, `line-edit` (keep the author's voice), `consistency-check`, `feedback-synthesis`.

**course / learning** — `context/{learners,outcomes}` `modules/ lessons/ exercises/ assessments/ resources/`
Prompts: `learning-outcomes`, `curriculum-map`, `lesson-plan`, `exercise-generator`, `quiz-with-answer-key`, `study-plan`.

**custom** — for anything else: derive 3–6 lanes from the user's goal using research → strategy → execution, and write 4–6 prompts covering plan, produce, review, report.

## Rules
- Never overwrite existing files without confirmation; never write secrets.
- Generated docs in the user's language; folder names stay ASCII kebab-case.
- Keep it lean: no empty boilerplate files beyond `.gitkeep` and the one-page maps.
- Don't install hooks or background automation unless the user asks.