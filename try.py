import base64
import json

# Load an image as bytes (you can load it from a file, capture from camera, etc.)
with open(r'valid\0\5006.png', 'rb') as image_file:
    image_data = image_file.read()

# Encode the image data to Base64
base64_encoded_image = base64.b64encode(image_data).decode('utf-8')

# Create a JSON payload with the encoded image
data = {
    'image': base64_encoded_image,
    'other_key': 'other_value'  # You can include other data in your JSON payload
}

# Serialize the JSON data to a string
json_payload = json.dumps(data)
print(json_payload)