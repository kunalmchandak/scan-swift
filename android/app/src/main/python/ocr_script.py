# In android/app/src/main/python/aadhaar_ocr.py
from edgeidx.ocr import extract_aadhaar_details

def run_ocr(image_path):
    return extract_aadhaar_details(image_path)
