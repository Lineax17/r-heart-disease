# Heart Failure Prediction

## Source of the Dataset

The Dataset is sourced from Kaggle and can be accessed at the following link:

https://www.kaggle.com/datasets/fedesoriano/heart-failure-prediction

## Description
The dataset contains 13 features and a target variable indicating 
whether a patient has heart failure (1) or not (0). The features 
include demographic information, clinical measurements, and laboratory 
test results. The goal is to compare three different machine learning 
models at predicting heart failure based on these features.

## Features

| **Variable**         | **Description**                                                                                                                                           |
|----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Age`                | Age of the patient in years.                                                                                                                              |
| `Sex`                | Sex of the patient: `M` = Male, `F` = Female.                                                                                                             |
| `ChestPainType`      | Type of chest pain: <br>• `TA` = Typical Angina <br>• `ATA` = Atypical Angina <br>• `NAP` = Non-Anginal Pain <br>• `ASY` = Asymptomatic                   |
| `RestingBP`          | Resting blood pressure (in mmHg). Values >120 mmHg are considered elevated.                                                                              |
| `Cholesterol`        | Serum cholesterol in mg/dL. High values may indicate increased risk of heart disease.                                                                    |
| `FastingBS`          | Fasting blood sugar > 120 mg/dL: `1` = True, `0` = False. High levels may suggest diabetes.                                                              |
| `RestingECG`         | Resting electrocardiogram results: <br>• `Normal` = Normal ECG <br>• `ST` = ST-T wave abnormality <br>• `LVH` = Left Ventricular Hypertrophy              |
| `MaxHR`              | Maximum heart rate achieved during exercise stress test (in bpm).                                                                                        |
| `ExerciseAngina`     | Exercise-induced angina: `Y` = Yes, `N` = No.                                                                                                             |
| `Oldpeak`            | ST depression induced by exercise relative to rest. Indicates possible myocardial ischemia.                                                              |
| `ST_Slope`           | Slope of the peak exercise ST segment: <br>• `Up` = Upsloping <br>• `Flat` = Flat <br>• `Down` = Downsloping.                                             |
| `HeartDisease`       | Target variable: `1` = Presence of heart disease, `0` = Absence of heart disease.                                                                        |
