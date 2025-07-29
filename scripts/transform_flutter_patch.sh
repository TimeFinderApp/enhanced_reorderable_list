#!/bin/bash
# Script to transform Flutter framework patches to work with enhanced_reorderable_list package structure

if [ $# -eq 0 ]; then
    echo "Error: Patch file argument required"
    echo "Usage: $0 <patch-file>"
    echo "Example: $0 ../patches/my-flutter-fix.patch"
    exit 1
fi

PATCH_FILE="$1"

if [ ! -f "$PATCH_FILE" ]; then
    echo "Error: Patch file '$PATCH_FILE' not found"
    exit 1
fi

# Create a temporary file for the transformed patch
TEMP_PATCH=$(mktemp)

# Transform the patch paths from Flutter structure to our package structure
# Flutter: packages/flutter/lib/src/widgets/reorderable_list.dart -> lib/src/widgets/reorderable_list.dart
# Flutter: packages/flutter/lib/src/material/reorderable_list.dart -> lib/src/material/reorderable_list.dart
sed -E \
    -e 's|packages/flutter/lib/src/widgets/reorderable_list\.dart|lib/src/widgets/reorderable_list.dart|g' \
    -e 's|packages/flutter/lib/src/material/reorderable_list\.dart|lib/src/material/reorderable_list.dart|g' \
    -e 's|a/packages/flutter/lib/src/widgets/reorderable_list\.dart|a/lib/src/widgets/reorderable_list.dart|g' \
    -e 's|b/packages/flutter/lib/src/widgets/reorderable_list\.dart|b/lib/src/widgets/reorderable_list.dart|g' \
    -e 's|a/packages/flutter/lib/src/material/reorderable_list\.dart|a/lib/src/material/reorderable_list.dart|g' \
    -e 's|b/packages/flutter/lib/src/material/reorderable_list\.dart|b/lib/src/material/reorderable_list.dart|g' \
    "$PATCH_FILE" > "$TEMP_PATCH"

echo "Transformed patch saved to: $TEMP_PATCH"
echo ""
echo "To apply this patch to the flutter-baseline branch:"
echo "  git checkout flutter-baseline"
echo "  git checkout -b pr/your-feature-name"
echo "  git am $TEMP_PATCH"
echo ""
echo "To apply and merge to main with Enhanced prefixes:"
echo "  git checkout main"
echo "  git merge pr/your-feature-name"
echo "  # Resolve conflicts, keeping Enhanced prefixes"