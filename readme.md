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

|                 | **Predicted: No** | **Predicted: Yes** |
| --------------- | ----------------- | ------------------ |
| **Actual: No**  | 103               | 14                 |
| **Actual: Yes** | 14                | 92                 |

### Decision Tree

**Confusion Matrix:**

|                 | **Predicted: No** | **Predicted: Yes** |
| --------------- | ----------------- | ------------------ |
| **Actual: No**  | 89                | 11                 |
| **Actual: Yes** | 28                | 95                 |

<img width="1686" height="1678" alt="Decision_Tree_Diagram" src="https://github.com/user-attachments/assets/373cd6ae-a0bc-4184-b1a1-1ff4e2c52d4c" />

### Random Forest

**Confusion Matrix:**

|                 | **Predicted: No** | **Predicted: Yes** |
| --------------- | ----------------- | ------------------ |
| **Actual: No**  | 101               | 16                 |
| **Actual: Yes** | 16                | 90                 |

<img width="1688" height="1686" alt="Random_Forest_Diagram" src="https://github.com/user-attachments/assets/3f5976cc-3137-47d0-82ab-fc9c71155212" />

## Dimensionality Reduction

Based on the **Mean Decrease Accuracy** from the Random Forest model, the following features were excluded:

- `Cholesterol`
- `FastingBS`

**Result:**  
Excluding these features had little to no impact on model performance, so they were safely removed.

### Logistic Regression (After Feature Reduction)

**Confusion Matrix:**

|                 | **Predicted: No** | **Predicted: Yes** |
| --------------- | ----------------- | ------------------ |
| **Actual: No**  | 103               | 15                 |
| **Actual: Yes** | 14                | 91                 |

### Decision Tree (After Feature Reduction)

**Confusion Matrix:**

|                 | **Predicted: No** | **Predicted: Yes** |
| --------------- | ----------------- | ------------------ |
| **Actual: No**  | 89                | 11                 |
| **Actual: Yes** | 28                | 95                 |

### Random Forest (After Feature Reduction)

**Confusion Matrix:**

|                 | **Predicted: No** | **Predicted: Yes** |
| --------------- | ----------------- | ------------------ |
| **Actual: No**  | 100               | 15                 |
| **Actual: Yes** | 17                | 91                 |

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
