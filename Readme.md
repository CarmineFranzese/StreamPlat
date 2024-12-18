# Plat Manage

## Table of Contents
- [Project Overview](#project-overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Code Structure](#code-structure)
- [Customization](#customization)
- [Accessibility](#accessibility)
- [Contributing](#contributing)
- [License](#license)

---

## Project Overview
This project is a SwiftUI-based app that allows users to create, manage, and track platform items. The app includes search, sorting, and accessibility features to ensure usability for all users. Items are displayed in a grid and list format, and users can add, edit, and delete items. It supports light and dark themes, which can be toggled in the app's settings.

---

## Features
- **Grid and List View**: Displays items in a dynamic grid and list layout.
- **CRUD Operations**: Users can Create, Read, Update, and Delete platform items.
- **Dark Mode Support**: Users can toggle between light and dark modes.
- **Search Functionality**: Users can search items by title.
- **Context Menus**: Provides quick actions like Edit and Delete on long press.
- **Accessibility**: Fully supports VoiceOver with descriptive labels for essential elements.

---

## Requirements
- **Xcode 15+**
- **iOS 17+**

---

## Installation

1. **Clone the Repository**
   `bash https://github.com/CarmineFranzese/StreamPlat.git`
   
2. **Open the Project**
   Open the `.xcodeproj` file using Xcode.

3. **Run the Project**
   Select an iOS Simulator or a connected device and press `Cmd + R` to build and run the project.

---

## Usage

1. **Add New Items**:
   - Tap the `+` button in the top-right corner to add a new platform item.

2. **View Items**:
   - Scroll through the grid and list views to see the items.

3. **Edit Items**:
   - Long-press on an item to access the "Edit" option.

4. **Delete Items**:
   - Long-press on an item and tap the "Delete" option. You will be prompted to confirm the deletion.

5. **Search Items**:
   - Use the search bar to filter items by title.

6. **Toggle Dark Mode**:
   - Tap the gear icon in the top-left corner to access the settings, where you can enable or disable Dark Mode.

---

## Code Structure

```
📁 Project Root
|-- 📄 ContentView.swift     // Main view of the app
|-- 📄 PlatformItems.swift  // Model for platform items
|-- 📄 Create1View.swift    // View for creating new items
|-- 📄 UpdateView.swift     // View for updating existing items
|-- 📄 SettingsView.swift   // View for toggling dark mode settings
```

**Key Elements**:
- **Environment and State Variables**: Manages dark mode, edit, and delete confirmation states.
- **Custom Views**: Modular design with separate views for creating and updating items.
- **Query and Context**: Uses `@Query` and `@Environment(\_.modelContext)` to interact with the app's data model.

---

## Customization

1. **Change Color Scheme**:
   - Modify `isDarkMode` to set the preferred color scheme.

2. **Change the Item Model**:
   - Update the `PlatformItems` model to add more properties (e.g., category, priority, etc.).

3. **Update List Design**:
   - Customize the `LazyVGrid` and `ForEach` loops to change how items are displayed.

---

## Accessibility

The app follows best practices for accessibility:
- **VoiceOver Labels**: Items have labels for titles, descriptions, and remaining days.
- **Dynamic Text**: Uses `Text` elements that support dynamic font sizes.
- **High-Contrast Support**: Supports both light and dark themes.

---
