# TOAdvancedSlider & TOEasySlider

## ✨ SwiftUI Custom Sliders for Your Project

This project demonstrates two custom sliders built with **SwiftUI**: `TOAdvancedSlider` and `TOEasySlider`. The sliders are designed for flexibility and style, making them suitable for various use cases in your apps.

---

## ✨ Features

### ⭐ TOAdvancedSlider
- Fully customizable slider with:
  - Gradient fills.
  - Striped overlays.
  - Dynamic styling options.

### ⭐ TOEasySlider
- Lightweight and easy-to-use slider for basic use cases.
- Minimalistic design with essential functionality.

---

## 🔧 Supporting Files

- **`RoundedTriangle.swift`**: Defines the rounded triangle shape used in the slider's handle.
- **`StripedOverlay.swift`**: Provides striped patterns for overlay effects.

---

## 🔄 Future Plans

- Integration with **Swift Package Manager (SPM)** for easier distribution and installation.

---

## 🔗 Usage

1. Add the following files to your project:
   - `TOAdvancedSlider.swift`
   - `TOEasySlider.swift`
   - `RoundedTriangle.swift`
   - `StripedOverlay.swift`

2. Use the sliders in your SwiftUI views:

```swift
import SwiftUI

struct ContentView: View {
    @State var Value: CGFloat = 50
    @State var currentValue: CGFloat = 40
    @State var optimalValue: CGFloat = 75
    let minValue: CGFloat = 0
    let maxValue: CGFloat = 100

    var body: some View {
        VStack(spacing: 20) {
            TOEasySlider(value: $Value)
                .frame(height: 50)

            TOAdvancedSlider(optimalValue: $optimalValue, currentValue: currentValue, minValue: minValue, maxValue: maxValue)
                .frame(height: 50)
        }
        .padding()
    }
}
```

---

## 🌐 Demo

![Demo](https://github.com/user-attachments/assets/460eca01-cbc3-439e-8c5c-32a76d6498ed)


---

## 🎨 Preview

| TOEasySlider                        | TOAdvancedSlider                     |
|-------------------------------------|--------------------------------------|
| ![TOEasySlider](https://github.com/user-attachments/assets/577c2ae9-d32d-49fa-8dba-9c89e6f4f027) | ![TOAdvancedSlider](https://github.com/user-attachments/assets/7876abe9-6855-4c66-bdd2-60a369ec75b0) |

---

## 🛠️ Requirements

- **iOS 17.0+**
- **Swift 5.5+**

---

## ❤️ Contribution
Contributions are welcome! Feel free to open issues or submit pull requests.

---
