# Contribution Loop

Projects may reveal better Rizum Glass rules, but the shared system should not absorb product-specific fixes.

## Classify The Lesson

Keep the change local when it depends on product content, business rules, brand identity, or one screen's unusual geometry.

Consider promotion when the lesson:

- repeats across more than one component or project;
- can be stated without product names;
- improves accessibility, text fit, motion continuity, or visual consistency;
- survives an unrelated product-domain transfer test.

## Promote A Reusable Lesson

1. Preserve the product fix and evidence separately.
2. Rewrite the observation as a product-neutral rule.
3. Update the canonical `DESIGN.md` in the Rizum Glass repository.
4. Add or update a cross-domain transfer test.
5. Run `./scripts/export-tokens.sh`, which also regenerates native adapter assets and synchronizes the skill snapshot.
6. Update `CHANGELOG.md`.
7. Run the repository checks, the GPUI gallery compile check, and the WinUI build checks available on Windows.
8. Commit and publish the shared change, then intentionally update consuming projects.

Do not silently edit an installed snapshot. Prefer a symlinked local skill or a repository checkout so shared improvements retain history and review.
