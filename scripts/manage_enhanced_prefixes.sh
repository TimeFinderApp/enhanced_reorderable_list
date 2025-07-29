#!/bin/bash
# Script to apply or remove Enhanced prefixes to/from Flutter reorderable list files

if [ $# -eq 0 ]; then
    echo "Error: Action argument required"
    echo "Usage: $0 [apply|remove]"
    echo "  apply  - Add Enhanced prefixes to Flutter classes"
    echo "  remove - Remove Enhanced prefixes (for Flutter contributions)"
    exit 1
fi

ACTION=$1

if [ "$ACTION" = "apply" ]; then
    echo "Applying Enhanced prefixes..."
    
    # Apply to widgets/reorderable_list.dart
    sed -i '' 's/class ReorderableList /class EnhancedReorderableList /g' lib/src/widgets/reorderable_list.dart
    sed -i '' 's/class SliverReorderableList /class EnhancedSliverReorderableList /g' lib/src/widgets/reorderable_list.dart
    sed -i '' 's/SliverReorderableList\./EnhancedSliverReorderableList./g' lib/src/widgets/reorderable_list.dart
    
    # Apply to material/reorderable_list.dart
    sed -i '' 's/class ReorderableListView /class EnhancedReorderableListView /g' lib/src/material/reorderable_list.dart
    sed -i '' 's/ReorderableListView\./EnhancedReorderableListView./g' lib/src/material/reorderable_list.dart
    sed -i '' 's/SliverReorderableList/EnhancedSliverReorderableList/g' lib/src/material/reorderable_list.dart
    
    echo "Enhanced prefixes applied successfully!"
    
elif [ "$ACTION" = "remove" ]; then
    echo "Removing Enhanced prefixes..."
    
    # Remove from widgets/reorderable_list.dart
    sed -i '' 's/class EnhancedReorderableList /class ReorderableList /g' lib/src/widgets/reorderable_list.dart
    sed -i '' 's/class EnhancedSliverReorderableList /class SliverReorderableList /g' lib/src/widgets/reorderable_list.dart
    sed -i '' 's/EnhancedSliverReorderableList\./SliverReorderableList./g' lib/src/widgets/reorderable_list.dart
    
    # Remove from material/reorderable_list.dart
    sed -i '' 's/class EnhancedReorderableListView /class ReorderableListView /g' lib/src/material/reorderable_list.dart
    sed -i '' 's/EnhancedReorderableListView\./ReorderableListView./g' lib/src/material/reorderable_list.dart
    sed -i '' 's/EnhancedSliverReorderableList/SliverReorderableList/g' lib/src/material/reorderable_list.dart
    
    echo "Enhanced prefixes removed successfully!"
    
else
    echo "Error: Invalid action '$ACTION'"
    echo "Usage: $0 [apply|remove]"
    exit 1
fi