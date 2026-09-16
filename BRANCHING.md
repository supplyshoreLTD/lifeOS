# LifeOS — Git Branching Strategy

A GitHub Flow style model with a dedicated `nightly` lane for scheduled builds/deployments.

```
                     ┌─────────────┐
   feature/* ──────▶ │    main     │   integration/test/build stage
                     └─────────────┘
                            │  (promotion)
                            ▼
                     ┌─────────────┐
                     │   nightly   │   scheduled builds & deployments
                     └─────────────┘
```

## Branches

### `main` — build / staging stage
- The **only** long-lived integration branch and the single source of truth.
- Code lands here **from a feature branch through a Pull Request**.
- To be merged, the PR must pass:
  1. `flutter analyze`
  2. `flutter test`
  3. the iOS unsigned build
- Everyone can contribute via PRs; only reviewed + green code gets merged.
- `main` may be made `protected` so nobody pushes directly and nothing breaks the stage.

### `nightly` — nightly builds & deployments
- Long-lived branch promoted **from** `main` after `main` is considered stable.
- Only updated by merging `main` into it (fast-forward) — no feature work commits directly.
- Every night (or on `workflow_dispatch`) the scheduled workflow builds and deploys from this branch.
- If a nightly build fails, `main` is untouched: the fix ships through the normal PR → `main` → `nightly` path.

### `feature/*` — development branches
- Everything else. One branch per feature/fix/chore, e.g. `feature/onboarding`, `fix/crash-on-open`.
- Short-lived: created from the latest `main`, opened as a PR back into `main`, deleted when merged.
- Naming: `feature/<slug>`, `fix/<slug>`, `chore/<slug>`, `docs/<slug>`.

## Lifecycle

1. Developer creates `feature/<slug>` from `main`.
2. Opens a PR → CI runs analyze + tests + unsigned build.
3. Review + green checks → squash-merge into `main`.
4. When the stage is healthy, `main` is promoted forward into `nightly`.
5. The nightly job builds and deploys from `nightly`; failures never touch `main`.

## CI touchpoints

| Trigger | Branch | Runs |
|---|---|---|
| Push / PR to `main` | `main` | analyze + test + unsigned iOS build (see `ios-build.yml`) |
| Cron (`nightly`) / manual | `nightly` | unsigned iOS build artifact — TestFlight slotted in when signing secrets are ready (`nightly.yml`) |

## Rules of thumb
- Never commit straight to `main` or `nightly`.
- Keep `feature/*` short-lived and rebase/merge from `main` often.
- Promote `main` → `nightly` only when the stage is green.
