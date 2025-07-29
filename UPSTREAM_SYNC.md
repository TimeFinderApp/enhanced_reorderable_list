# Upstream Synchronization Guide

This package maintains synchronized versions of Flutter's reorderable list implementation with custom enhancements. This document describes the branch structure and synchronization process.

## Branch Structure

This repository uses a two-branch strategy:

- `flutter-baseline`: Contains Flutter's pristine files exactly as they are in the Flutter SDK
- `main`: Contains all enhancements including Enhanced class name prefixes

## Initial Setup

The branch structure was established as follows:
- `flutter-baseline` was created at commit 6ed6a43 (pristine Flutter 3.32.8 files)
- `main` diverged from flutter-baseline with Enhanced prefix renames and custom enhancements

## Synchronizing Upstream Changes

When Flutter releases updates to the reorderable list files:

1. Switch to the flutter-baseline branch:
   ```bash
   git checkout flutter-baseline
   ```

2. Copy the updated files from Flutter SDK:
   ```bash
   cp $FLUTTER_SDK/packages/flutter/lib/src/widgets/reorderable_list.dart lib/src/widgets/
   cp $FLUTTER_SDK/packages/flutter/lib/src/material/reorderable_list.dart lib/src/material/
   ```

3. Commit the pristine Flutter files:
   ```bash
   git add -A
   git commit -m "Update to Flutter 3.x.x baseline"
   ```

4. Merge into main:
   ```bash
   git checkout main
   git merge flutter-baseline
   ```

5. Resolve merge conflicts, ensuring Enhanced prefixes are maintained in main:
   - Keep all custom enhancements
   - Apply Enhanced prefixes to any new Flutter classes/references
   - Test thoroughly

6. Commit the merge:
   ```bash
   git add -A
   git commit -m "Merge Flutter 3.x.x updates"
   ```

## Porting Changes from Flutter Forks

To port changes from a Flutter fork PR:

1. Generate patches from the Flutter fork:
   ```bash
   cd $FLUTTER_FORK
   git format-patch main..pr-branch -- packages/flutter/lib/src/widgets/reorderable_list.dart packages/flutter/lib/src/material/reorderable_list.dart
   ```

2. Apply patches to flutter-baseline branch:
   ```bash
   cd $ENHANCED_REORDERABLE_LIST
   git checkout flutter-baseline
   git am --directory=lib/src/widgets/ --reject widgets-patch.patch
   git am --directory=lib/src/material/ --reject material-patch.patch
   ```

3. Merge into main and apply Enhanced prefixes as part of conflict resolution.

## Contributing Changes Back to Flutter

To create patches suitable for Flutter PRs:

1. Create a feature branch from flutter-baseline:
   ```bash
   git checkout -b flutter-pr-feature flutter-baseline
   ```

2. Cherry-pick specific enhancements and revert renames:
   ```bash
   git cherry-pick <enhancement-commit>
   ./scripts/manage_enhanced_prefixes.sh remove
   git add -A
   git commit --amend -m "Enhancement: <description without Enhanced prefix>"
   ```

3. Generate patches for Flutter:
   ```bash
   git format-patch flutter-baseline..flutter-pr-feature
   ```

## File Structure Preservation

The package maintains Flutter's original file structure:
- `lib/src/widgets/reorderable_list.dart` (from Flutter's widgets library)
- `lib/src/material/reorderable_list.dart` (from Flutter's material library)

This structure ensures git can track changes between versions and perform three-way merges effectively.

## Enhanced Prefix Management

The Enhanced prefixes are managed via a single script:

```bash
./scripts/manage_enhanced_prefixes.sh [apply|remove]
```

- `apply` - Adds Enhanced prefixes to Flutter classes
- `remove` - Removes Enhanced prefixes (for Flutter contributions)