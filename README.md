# Scan Swift

Scan Swift is a Flutter-based mobile application that demonstrates the capabilities of the `edgeidx` Python library — an OCR model specifically optimized for extracting data from Indian Aadhaar cards.

## 📱 App Overview

This app uses a mobile device's camera to capture an Aadhaar card image, processes the image using cropping and enhancement, and sends it to the `edgeidx` backend for information extraction. The app showcases real-time scanning, user guidance overlays, and a clean UI for displaying results.

<p align="center">
  <img src="screenshots/demo.png" alt="Scan Swift UI Preview" width="300"/>
</p>

---

## 🔍 What is `edgeidx`?

`edgeidx` is a Python OCR library designed to extract structured data such as:

- Name
- Date of Birth
- Gender
- Aadhaar Number

It uses a pre-trained OCR model with an embedded Tesseract engine, optimized for speed and accuracy on edge devices. The model is fine-tuned to work well with different Aadhaar formats and conditions (lighting, background noise, etc.).

📦 PyPI: [edgeidx](https://pypi.org/project/edgeidx)

GitHub: [https://github.com/kunalmchandak/edgeidx](https://github.com/yourusername/edgeidx)

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
   git clone https://github.com/kunalmchandak/scan_swift.git
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
├── scan_screen.dart        # Camera preview and image crop
├── result_screen.dart      # Displays extracted Aadhaar data
├── aadhaar_format.dart     # Sample image format guidance
├── progress_indicator.dart # Animated processing screen
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

@app.post("/extract")
async def extract_data(file: UploadFile):
    contents = await file.read()
    result = extractor.extract(contents)
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
OCR model powered by [`edgeidx`](https://pypi.org/project/edgeidx/)

---

## 🧪 Try it out!

Use the "Take Picture" button to scan a real Aadhaar card (blurred or demo version) and check how fast the system extracts accurate details using `edgeidx`.

```
