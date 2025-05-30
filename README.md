# 🍽️ SwiftUI Recipe App

### Summary

This SwiftUI-based recipe app lets users browse a curated list of global recipes. It includes a responsive grid layout, image caching, recipe detail view, cuisine-based filtering, and search functionality. All asynchronous tasks — including network requests and image loading — use Swift Concurrency (`async/await`). Caching is implemented manually using `FileManager` to optimize bandwidth and loading times. Screenshots and videos are available in the `/screenshots` folder.


---

## 📸 Screenshots

<img width="422" alt="Screenshot 2025-05-30 at 3 29 35 PM" src="https://github.com/user-attachments/assets/b85179ad-c605-486a-81d0-f67c5f742558" />
<img width="422" alt="Screenshot 2025-05-30 at 3 30 01 PM" src="https://github.com/user-attachments/assets/ec39f451-a96f-451f-a65d-78de5e55c340" />
<img width="422" alt="Screenshot 2025-05-30 at 3 30 53 PM" src="https://github.com/user-attachments/assets/2f5f378a-ec50-4494-a908-9a39fd3a667c" />
<img width="422" alt="Screenshot 2025-05-30 at 3 34 44 PM" src="https://github.com/user-attachments/assets/55ea0690-8379-4473-84e6-d631973ce70a" />


---

## ✅ Features

- Swift Concurrency with `async/await`
- Clean MVVM architecture using dependency injection
- Efficient **image disk caching** (no URLCache or 3rd-party libraries)
- SwiftUI-only interface — no UIKit or Storyboards
- Pull to refresh, search, and browse by cuisine
- Fully **testable** core logic: network, caching, and ViewModel
- Graceful handling of malformed and empty JSON
- No external dependencies — 100% native Swift


### Focus Areas

1. **Swift Concurrency with async/await:** Ensured all data fetches and image loading were natively asynchronous.
2. **Manual disk caching of images:** Prioritized efficient bandwidth use by creating a custom caching layer.
3. **Architecture & Testability:** Used MVVM with protocol-based dependency injection to make core components unit-testable.
4. **Modern SwiftUI UI/UX:** Built a clean and accessible UI with pull-to-refresh, grid layouts, and lazy loading.
5. **Error Handling:** Included graceful error messages for malformed or empty data scenarios.

These areas were prioritized to align with the core requirements, maintain performance, and ensure the code is clean, testable, and scalable.

---

## 📂 Project Structure

```
.
├── Models/
│   └── Recipe.swift
├── Network/
│   ├── NetworkManager.swift
│   └── APIEndpoint.swift
├── ImageCache/
│   └── ImageCacheManager.swift
├── ViewModels/
│   └── RecipeViewModel.swift
├── Views/
│   ├── RecipeListView.swift
│   ├── RecipeDetailView.swift
│   ├── CuisineListView.swift
│   ├── RecipesByCuisineView.swift
│   ├── AsyncImageView.swift
│   └── ErrorView / EmptyStateView.swift
├── Mock/
│   ├── MockNetworkService.swift
│   └── MockJSON.swift
├── Tests/
│   ├── ImageCacheManagerTests.swift
│   ├── NetworkManagerTests.swift
│   └── RecipeViewModelTests.swift
└── Assets/
    └── PreviewImage, test_image.jpg
```

---

## 🧪 Testing

We focused on testing all **core logic** components:

- ✅ Image caching logic (save & load from disk)
- ✅ Recipe fetching logic with success, malformed, and empty JSON
- ✅ ViewModel state updates using injected mock services

Tests are written with `XCTest`, no UI or integration tests required.

---

## ⌛ Time Spent

**~5 hours total**, broken down as:

- ✅ 1.5h: UI building with SwiftUI (grid, detail, navigation)
- ✅ 1h: Async/await networking and caching
- ✅ 1.5h: Testing architecture (mocking, custom errors, unit tests)
- ✅ 1h: Debugging image caching, error handling, and preview setup

---

## 🤔 Trade-offs & Decisions

- Chose to manually handle image disk caching (using `FileManager`) instead of relying on `URLCache` or third-party tools.
- Used `.hashValue` of full image URL to generate unique disk filenames.
- Avoided complex filtering logic to keep UI clean and focused.
- Used preview placeholders for SwiftUI previews since remote loading doesn’t work reliably in canvas.

---

## ⚠️ Known Limitations

- Preview thumbnails use static placeholder images since async image loading doesn't work in SwiftUI preview mode.
- Image cache has no eviction strategy; grows with usage over time.

---

## 🧠 Additional Notes

- Fully written in Swift 5.9 and Xcode 15+
- Designed to reflect real-world iOS patterns (MVVM, protocol injection, separation of concerns)
- focused on clarity, performance, and native-first design
- App supports malformed/empty data by ignoring the list and showing user-friendly messages.
- Recipes are browsable via cuisine in a visually appealing circular card format.
- Used mock JSON and injected mock services to ensure test isolation and preview reliability.

---

## 🛠️ Requirements

- iOS 15+
- Xcode 15+
- No external libraries or SPM packages used

---

## 📬 Feedback

If you have any suggestions or want to collaborate, feel free to open an issue or PR! 🙌








