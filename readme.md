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

| **Variable**     | **Description**                                                                                                                              |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `Age`            | Age of the patient in years.                                                                                                                 |
| `Sex`            | Sex of the patient: `M` = Male, `F` = Female.                                                                                                |
| `ChestPainType`  | Type of chest pain: <br>• `TA` = Typical Angina <br>• `ATA` = Atypical Angina <br>• `NAP` = Non-Anginal Pain <br>• `ASY` = Asymptomatic      |
| `RestingBP`      | Resting blood pressure (in mmHg). Values >120 mmHg are considered elevated.                                                                  |
| `Cholesterol`    | Serum cholesterol in mg/dL. High values may indicate increased risk of heart disease.                                                        |
| `FastingBS`      | Fasting blood sugar > 120 mg/dL: `1` = True, `0` = False. High levels may suggest diabetes.                                                  |
| `RestingECG`     | Resting electrocardiogram results: <br>• `Normal` = Normal ECG <br>• `ST` = ST-T wave abnormality <br>• `LVH` = Left Ventricular Hypertrophy |
| `MaxHR`          | Maximum heart rate achieved during exercise stress test (in bpm).                                                                            |
| `ExerciseAngina` | Exercise-induced angina: `Y` = Yes, `N` = No.                                                                                                |
| `Oldpeak`        | ST depression induced by exercise relative to rest. Indicates possible myocardial ischemia.                                                  |
| `ST_Slope`       | Slope of the peak exercise ST segment: <br>• `Up` = Upsloping <br>• `Flat` = Flat <br>• `Down` = Downsloping.                                |
| `HeartDisease`   | Target variable: `1` = Presence of heart disease, `0` = Absence of heart disease.                                                            |

## Feature Plots

### Numeric Variables
<img width="393" height="391" alt="num_1" src="https://github.com/user-attachments/assets/4318d5d5-7866-460a-a95b-e909a7067f97" />
<img width="393" height="394" alt="num_2" src="https://github.com/user-attachments/assets/923a8fca-fd8f-4537-a6e6-f5b0e2d22417" />
<img width="367" height="370" alt="num_3" src="https://github.com/user-attachments/assets/fe8802fd-2718-436f-9593-43eed8d76234" />
<img width="364" height="364" alt="num_4" src="https://github.com/user-attachments/assets/0259c681-2d2f-43f4-94e1-eab01ca67207" />
<img width="192" height="370" alt="num_5" src="https://github.com/user-attachments/assets/21b9d9f1-dc01-45d0-8b38-63e880b586d3" />

### Categorial Variables
<img width="401" height="401" alt="cat_1" src="https://github.com/user-attachments/assets/b779325f-bdee-4c13-ae2d-023174a64afe" />
<img width="401" height="401" alt="cat_2" src="https://github.com/user-attachments/assets/b5a6f4a2-20c1-45a2-91a3-85fb86eb0e70" />
<img width="250" height="508" alt="cat_3" src="https://github.com/user-attachments/assets/befa8853-5929-4312-919d-54be1800d8c1" />
<img width="260" height="508" alt="cat_4" src="https://github.com/user-attachments/assets/84d59534-8cb2-46e8-96d1-85f5fd490daf" />

## Data Cleaning

- **Feature exclusion:**  
  The `Sex` feature was removed because its distribution was skewed and not representative.

- **Missing / invalid values:**  
  About 20% of cholesterol values are recorded as `0`, which is biologically impossible.  
  → Solution: rows with `cholesterol = 0` were removed since these cases were mostly labeled as “diseased” and would bias the model.

---

## Models

**Applied models:**

1. Logistic Regression
2. Decision Tree
3. Random Forest

**Validation method:**  
10-fold cross-validation was performed to ensure model robustness.

---

## Results

### Logistic Regression

**Confusion Matrix:**

|                    | **Actual: No** | **Actual: Yes** |
| ------------------ | ---------------| ----------------|
| **Predicted: No**  | 103            | 14              |
| **Predicted: Yes** | 14             | 92              |

### Decision Tree

**Confusion Matrix:**

|                    | **Actual: No** | **Actual: Yes** |
| ------------------ | -------------- | --------------- |
| **Predicted: No**  | 89             | 11              |
| **Predicted: Yes** | 28             | 95              |

<img width="1686" height="1678" alt="Decision_Tree_Diagram" src="https://github.com/user-attachments/assets/373cd6ae-a0bc-4184-b1a1-1ff4e2c52d4c" />

### Random Forest

**Confusion Matrix:**

|                    | **Actual: No** | **Actual: Yes** |
| ------------------ | -------------- | --------------- |
| **Predicted: No**  | 101            | 16              |
| **Predicted: Yes** | 16             | 90              |

<img width="1688" height="1686" alt="Random_Forest_Diagram" src="https://github.com/user-attachments/assets/3f5976cc-3137-47d0-82ab-fc9c71155212" />

## Dimensionality Reduction

Based on the **Mean Decrease Accuracy** from the Random Forest model, the following features were excluded:

- `Cholesterol`
- `FastingBS`

**Result:**  
Excluding these features had little to no impact on model performance, so they were safely removed.

### Logistic Regression (After Feature Reduction)

**Confusion Matrix:**

|                    | **Actual: No** | **Actual: Yes** |
| ------------------ | -------------- | --------------- |
| **Predicted: No**  | 103            | 15              |
| **Predicted: Yes** | 14             | 91              |

### Decision Tree (After Feature Reduction)

**Confusion Matrix:**

|                    | **Actual: No** | **Actual: Yes** |
| ------------------ | -------------- | --------------- |
| **Predicted: No**  | 89             | 11              |
| **Predicted: Yes** | 28             | 95              |

### Random Forest (After Feature Reduction)

**Confusion Matrix:**

|                    | **Actual: No** | **Actual: Yes** |
| ------------------ | -------------- | --------------- |
| **Predicted: No**  | 100            | 15              |
| **Predicted: Yes** | 17             | 91              |

---

## Interpretation of Results

### Most influential features:

- **ST_Slope**
- **Oldpeak**
- **ExerciseAngina**
- **ChestPainType**

These are medically meaningful:

- Changes in **ST_Slope** and **Oldpeak** indicate **ischemic changes** in the heart.
- **ExerciseAngina** and **ChestPainType** are direct indicators of coronary insufficiency.

**Cholesterol**, although generally relevant to heart disease, lost its predictive power here due to faulty data (values = 0).

---

## Model Selection

Since **false negatives** (predicting a sick patient as healthy) are more critical than false positives, the best model was chosen based on **minimizing false negatives**.

➡️ **Best model:** **Decision Tree**

---

## Improvement Suggestions

- Collect **more laboratory data** (e.g., lipid profiles, inflammation markers) to improve prediction quality.
- Improve **data quality control** to prevent biologically impossible entries.
- Consider testing **advanced models** such as Gradient Boosting or Neural Networks for further optimization.

---
