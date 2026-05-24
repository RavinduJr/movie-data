# movie-data

# Challenges faced while doing the project

### Choosing a scalable architecture

I implemented the project using **Clean Architecture** to ensure clear separation of concerns, maintainability, and testability. Since this assignment was also an opportunity to demonstrate engineering practices, I focused heavily on readability, **SOLID** principles, and modularity rather than only delivering functionality.

The architecture also makes it easier to:
```
- scale features in the future,
- introduce persistence layers such as Core Data,
- add unit tests and mocks,
- and maintain predictable data flow between layers.
```

### Handling AsyncImage caching behavior

One challenge I faced was image refreshing behavior with SwiftUI’s AsyncImage.

When navigating back to the screen or refreshing the list, previously cached images were sometimes reused unexpectedly, resulting in stale renders. Due to the limited timeframe of the assignment, instead of introducing a third party image pipeline such as Kingfisher, I implemented a lightweight cache busting approach by appending a timestamp-based query parameter to image URLs.

This ensured that refreshed content rendered correctly while keeping the implementation simple and dependency free for the scope of the assignment.

In a production-scale application, I would likely replace this with a dedicated image caching solution for more efficient memory and disk cache management.

##### State management and UI synchronization

Another challenge was maintaining consistent UI state across navigation and local persistence updates, especially when handling favorites and restoring previously searched data.

To solve this, I centralized state updates inside the ViewModel layer and avoided tightly coupling UI components directly to persistence logic. This helped keep the SwiftUI views reactive while ensuring updates from Core Data were reflected consistently across the app.