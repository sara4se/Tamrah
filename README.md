#   Tamrah, Date Classification Model and iOS App

####  Overview

This project aims to support the Saudi Vision 2030 initiative by fostering cultural awareness and eco-friendly practices. The goal is to enable people to distinguish between nine types of dates using a deep learning model. Additionally, there are plans for future development, including an iOS app that supports image classification & recognition.
#### Model Description

The deep learning model is designed for date classification. It has been trained on a dataset containing images of nine different types of dates. The model utilizes transfer learning, adapting a pre-trained architecture to effectively identify features that distinguish each date type.

#### iOS App

Tamrah : the iOS app, currently in development, will provide a user-friendly interface for date recognition. Users can either upload images or capture real-time video to identify and classify date types. The app will serve as a practical tool for cultural education and awareness.

#### Dataset Description

The dataset includes images of nine different types of dates, each representing a distinct variety. These images serve as the training and evaluation data for the deep learning model. The types of dates included in the dataset are:
1. Medjool (135 files)
2. Meneifi (232 files)
3. Ajwa (175 files)
4. Galaxy (190 files)
5. Nabtat Ali (177 files)
6. Rutab (146 files)
7. Shaishe (171 files)
8. Sokari (264 files)
9. Sugaey (168 files)
Getting Started

#### Clone the Repository:
git clone https://github.com/RazanAljuraysi/Tamrah/git

cd Tamrah

#### Install Dependencies:
Install the required dependencies for both the model and the iOS app.
bash

###### Copy code:
pip install -r requirements.txt (will change depends on our requirements09op)
#### Train the Model:

Train the deep learning model using the provided training script:
python train_model.py --dataset_path (......) <<---- when prepare our datasets we will upload it here

#### Run the iOS App:
Open the iOS app project in Xcode and run it on a simulator or a physical device: 
bash open Tamrah.xcodeproj

#### Future Work

##### The project's future work includes:

Refining and optimizing the deep learning model for improved accuracy.
Use deep learning models for other types of dates and there quality and price.
Completing the development of the iOS app for seamless date recognition.
Exploring additional features, such as multi-language support

#### Model and Methodology

The project employs deep learning techniques, specifically transfer learning, to train a model capable of differentiating between the various types of dates. Transfer learning involves utilizing a pre-trained model and adapting it to the specific task at hand. The model is trained on the dataset to learn features that distinguish each date type.

### Usage:

##### Dataset Preparation:
Download the dataset from [link_to_dataset].
Extract the dataset to a directory of your choice.

##### Training the Model:
Use the provided code for training the deep learning model. Ensure that the required dependencies are installed.


#### Evaluation:
After training, evaluate the model's performance on a test set.


#### Future Work

The project aims to extend its impact through the development of an iOS application. This app will not only recognize date types from images but also capture dates in real-time through video input. This expansion aligns with the goal of providing a practical and accessible tool for cultural awareness.

#### Contributors

[Sara Alhumidi]
[Razan Aljeraisy]
[Sarah Alshehri] 
[Abdulmalik Alharbi]


#### Acknowledgments
- Dates Datasets: https://www.kaggle.com/datasets/wadhasnalhamdan/date-fruit-image-dataset-in-controlled-environment
- Hands Datasets: https://www.kaggle.com/datasets/shyambhu/hands-and-palm-images-dataset

