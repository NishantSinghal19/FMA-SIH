from fastai.vision.all import *
import pathlib
import numpy as np

temp = pathlib.PosixPath
pathlib.PosixPath = pathlib.WindowsPath

learner = load_learner('flood_classifier.pkl')
categories = ["Normal","Flood"]

def infer_image(image_data):
    label, _, probabilities = learner.predict(image_data)
    if label == '0':
        print(f"The area shown in the image is not flooded with probability {probabilities[0]*100:.2f}%.")
        return label,probabilities[0]*100
    elif label == '1':
        print(f"The area shown in the image is flooded with probability {probabilities[1]*100:.2f}%.")
        return label,probabilities[1]*100
    else:
        print("Unknown label assigned to image.")


image = (PILImage(PILImage.create(r"valid\0\5006_0.png")))

a,b = infer_image(image)



pathlib.PosixPath = temp