# Enhanced Reorderable List

Enhanced Flutter ReorderableListView with real-time feedback and programmatic reordering.

## Features

- **Real-time reorder feedback**: Get continuous updates during drag operations via `onReorderUpdate`
- **Programmatic reordering**: Animate items to new positions using the controller API
- **Faster long-press**: 200ms delay instead of Flutter's 500ms for better responsiveness  
- **Enhanced drag listeners**: Custom drag listeners that work correctly with enhanced components
- **Additional APIs**: Extra callbacks and customization options not available in Flutter's version

## ⚠️ Important: Drag Listener Compatibility

When using `buildDefaultDragHandles: false`, you **MUST** use the enhanced drag listeners from this package:

```dart
// ✅ CORRECT - Use enhanced listeners
EnhancedReorderableDelayedDragStartListener(
  index: index,
  child: MyWidget(),
)

// ❌ WRONG - Don't use Flutter's standard listeners
ReorderableDelayedDragStartListener(  // This won't work!
  index: index,
  child: MyWidget(),
)
```

## Getting Started

Add to your `pubspec.yaml`:

```yaml
dependencies:
  enhanced_reorderable_list:
    git:
      url: https://github.com/TimeFinderApp/enhanced_reorderable_list.git
```

## Usage

### Basic Usage

```dart
import 'package:enhanced_reorderable_list/enhanced_reorderable_list.dart';

EnhancedReorderableListView(
  children: [
    for (int index = 0; index < items.length; index++)
      ListTile(
        key: ValueKey(items[index].id),
        title: Text(items[index].title),
      ),
  ],
  onReorder: (oldIndex, newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
  },
);
```

### Custom Drag Handles

```dart
EnhancedReorderableListView.builder(
  buildDefaultDragHandles: false,  // Disable default handles
  itemCount: items.length,
  itemBuilder: (context, index) {
    // IMPORTANT: Use Enhanced drag listener!
    return EnhancedReorderableDelayedDragStartListener(
      key: ValueKey(items[index].id),
      index: index,
      enabled: !isLocked,  // Can disable dragging
      child: ListTile(
        title: Text(items[index].title),
        trailing: Icon(Icons.drag_handle),
      ),
    );
  },
  onReorder: (oldIndex, newIndex) {
    // Handle reorder
  },
  onReorderUpdate: (fromIndex, toIndex) {
    // Get real-time updates during drag
    print('Dragging from $fromIndex to $toIndex');
  },
);
```

### Programmatic Reordering

```dart
final controller = EnhancedReorderableListController();

EnhancedReorderableListView(
  controller: controller,
  // ... other properties
);

// Animate an item to a new position
await controller.animateItemToIndex(
  fromIndex: 0,
  toIndex: 5,
  duration: Duration(milliseconds: 300),
  curve: Curves.easeInOut,
);
```

## Migration from Flutter's ReorderableListView

1. **Update imports**:
   ```dart
   // Before
   import 'package:flutter/material.dart';
   
   // After  
   import 'package:enhanced_reorderable_list/enhanced_reorderable_list.dart';
   ```

2. **Replace widgets**:
   - `ReorderableListView` → `EnhancedReorderableListView`
   - `ReorderableDelayedDragStartListener` → `EnhancedReorderableDelayedDragStartListener`
   - `ReorderableDragStartListener` → `EnhancedReorderableDragStartListener`

3. **Use new features** (optional):
   - Add `onReorderUpdate` for real-time feedback
   - Use `controller` for programmatic reordering

## Additional information

This package contains enhanced versions of Flutter's ReorderableListView framework files.
The enhancements maintain full compatibility while adding useful features for production apps.
