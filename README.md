<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0F2027,50:203A43,100:2C5364&height=200&section=header&text=VOICE%20RECOGNITION%20SYSTEM&fontSize=35&fontColor=FFFFFF&animation=fadeIn&fontAlignY=38&desc=MATLAB%20%7C%20DSP%20%7C%20MACHINE%20LEARNING&descAlignY=60&descSize=16" width="100%" alt="Voice Recognition System banner"/>

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=500&size=22&duration=3000&pause=800&color=00C2FF&center=true&vCenter=true&width=650&lines=Listening+to+the+World;Processing+Speech+Signals;Extracting+MFCC+Features;Exploring+Machine+Learning" alt="Animated typing introduction"/>

<br>

![MATLAB](https://img.shields.io/badge/MATLAB-Engineering-orange?style=for-the-badge&logo=mathworks&logoColor=white)
![DSP](https://img.shields.io/badge/Digital-Signal_Processing-0078D4?style=for-the-badge)
![Machine Learning](https://img.shields.io/badge/Machine-Learning-8A2BE2?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey?style=for-the-badge&logo=windows)

**Turning audio signals into meaningful information through signal processing and machine learning.**

</div>

---

## 🎙️ About the Project

The **Voice Recognition System** is a MATLAB-based engineering project focused on speech signal processing, audio feature extraction, and machine learning.

The idea behind this project is simple: how can a computer analyze a voice recording and use the information contained in the audio signal to recognize or classify a voice?

To explore this question, the project combines digital signal processing (DSP), Mel-Frequency Cepstral Coefficients (MFCC), machine learning, and graphical user interfaces.

From recording voice samples to extracting audio features and experimenting with real-time detection, the project provides a practical way to understand the fundamentals of voice recognition.

## ✨ Key Features

- 🎤 **Voice Recording:** Collect voice samples for training and experimentation.
- 📊 **MFCC Feature Extraction:** Extract useful spectral characteristics from audio signals.
- 🧠 **Machine Learning:** Train a classifier to identify patterns in voice data.
- ⚡ **Real-Time Detection:** Explore voice detection using microphone input.
- 🖥️ **Graphical User Interface:** Interact with the recording and detection workflow.
- 💾 **Model Storage:** Save and load trained model data for further experiments.
- 🔬 **Signal Processing:** Explore how audio signals can be transformed into meaningful features.

*The availability of individual features depends on the implementation and compatibility of the MATLAB scripts in the repository.*

## 🛠️ Technologies Used

<div align="center">

![MATLAB](https://img.shields.io/badge/MATLAB-orange?style=flat-square&logo=mathworks&logoColor=white)
![Signal Processing](https://img.shields.io/badge/Digital%20Signal%20Processing-blue?style=flat-square)
![MFCC](https://img.shields.io/badge/MFCC-Feature%20Extraction-green?style=flat-square)
![Machine Learning](https://img.shields.io/badge/Machine%20Learning-Classification-purple?style=flat-square)
![Audio](https://img.shields.io/badge/Audio-Microphone-red?style=flat-square)

</div>

| Technology | Purpose |
|---|---|
| MATLAB | Main development environment |
| Digital Signal Processing | Audio analysis and preprocessing |
| MFCC | Audio feature extraction |
| Machine Learning | Voice classification |
| MATLAB GUI | User interaction |
| MAT-files | Saving trained model data |

## ⚙️ How It Works

<div align="center">

<p align="center"> <img src="assets/pipeline.svg" alt="Animated processing pipeline" width="100%"/> </p>
Stage	What happens
Microphone	Audio is captured at [FS] Hz, mono.
Preprocessing	Signal is split into [FRAME_MS] ms frames with [OVERLAP]% overlap, windowed with a [WINDOW] window, and normalised.
MFCC	[N_MFCC] coefficients per frame from a [N_FILTERS]-band Mel filter bank, summarised into one feature vector per recording.
Classifier	[CLASSIFIER, e.g. SVM / k-NN] trained on the recorded dataset.
Prediction	Predicted label and confidence are shown live in the GUI.

</div>

### 1. Voice Data Collection

Voice samples are recorded through a microphone and organized into a dataset. These recordings provide examples for training and testing the recognition system.

### 2. Audio Preprocessing

Audio signals may be prepared for analysis through operations such as framing, windowing, filtering, and normalization, depending on the implementation.

### 3. MFCC Feature Extraction

MFCC converts short segments of audio into a compact set of coefficients representing important characteristics of the speech spectrum.

### 4. Machine Learning

A classifier is trained using the extracted features to learn patterns from the available voice data.

### 5. Real-Time Detection

The detection interface provides a way to work with live microphone input and the available trained model.

### 6. Recognition Output

The system produces a classification result based on the implemented model. Its reliability depends on the training dataset, feature consistency, and evaluation process.

## 📂 Project Structure

```text
voice-recognition-system/
│
├── mfcc_basic.m
│   └── Basic MFCC feature extraction
│
├── record_voice_dataset_gui.m
│   └── GUI for recording voice samples
│
├── train_voice_classifier_gui_old.m
│   └── Legacy voice classifier training script
│
├── realtime_voice_detector_gui.m
│   └── Real-time voice detection interface
│
├── voice_model_old.mat
│   └── Saved model data
│
└── README.md
    └── Project documentation
```

**Note:** The training script and saved model contain an `_old` suffix. Their compatibility with the current recording and detection scripts should be verified.

## 🚀 Getting Started

### Prerequisites

Before running the project, make sure you have:

- MATLAB installed on your computer.
- A working microphone for recording and real-time input.
- The project files downloaded locally.
- Any MATLAB toolboxes required by the functions used in the scripts.

### Step 1: Clone the Repository

Open a terminal and run:

```bash
git clone https://github.com/Mazharul-Islam-Chowdhury/voice-recognition-system.git
```

Navigate to the project folder:

```bash
cd voice-recognition-system
```

Alternatively, download the repository as a ZIP file and extract it.

### Step 2: Open MATLAB

Launch MATLAB and set the Current Folder to your project directory.

Ensure the scripts and model files are available in the working directory.

### Step 3: Record Voice Samples

Run the recording interface:

```matlab
record_voice_dataset_gui
```

Follow the instructions displayed by the GUI.

### Step 4: Explore MFCC Extraction

Run:

```matlab
mfcc_basic
```

Review the script to understand how audio is transformed into MFCC features.

### Step 5: Train the Classifier

The repository contains the following legacy training script:

```matlab
train_voice_classifier_gui_old
```

Run it if its dependencies and expected dataset format are available.

### Step 6: Launch Real-Time Detection

Run:

```matlab
realtime_voice_detector_gui
```

Follow the interface instructions and verify that the correct trained model is loaded.

**Troubleshooting tip:** If the system reports a missing model or a feature-dimension mismatch, check that the training and detection scripts use compatible MFCC settings, model variables, and input formats.

## 🧪 Understanding MFCC

Mel-Frequency Cepstral Coefficients are widely used in speech processing because they provide a compact representation of audio spectral characteristics.

A typical MFCC extraction pipeline includes:

1. Dividing the audio signal into short frames.
2. Applying a window function.
3. Computing the frequency spectrum using the Fourier transform.
4. Applying Mel-scaled filter banks.
5. Taking the logarithm of the filter-bank energies.
6. Applying the Discrete Cosine Transform (DCT).

The resulting coefficients can be used as input features for a machine learning classifier.

## 🎯 Project Objectives

- Understand the fundamentals of speech signal processing.
- Explore MFCC-based audio feature extraction in MATLAB.
- Develop a workflow for voice dataset collection.
- Investigate machine learning for voice classification.
- Build a GUI-based audio recording and detection workflow.
- Study the challenges of applying trained models to real-time audio.

## ⚠️ Current Limitations

The following areas should be checked and improved as the project develops:

- **Model compatibility:** The legacy training script and saved model may require updates.
- **Background noise:** Environmental noise can affect audio quality.
- **Feature consistency:** Training and detection must use compatible feature extraction settings.
- **Recognition accuracy:** Performance should be measured using separate test data.
- **Real-time processing:** Microphone handling and processing speed depend on the implementation and hardware.

These limitations also provide opportunities for future experimentation.

## 🔮 Future Improvements

Potential improvements include:

- Updating legacy scripts and model files.
- Improving noise reduction and audio preprocessing.
- Adding voice activity detection.
- Comparing different machine learning classifiers.
- Evaluating accuracy, precision, recall, and confusion matrices.
- Improving the GUI and recognition feedback.
- Exploring embedded voice recognition using microcontrollers and DSP libraries.
- Developing a lightweight version for real-time embedded applications.

## 👨‍💻 About the Author

<div align="center">

### Mazharul Islam Chowdhury

**Electrical and Electronic Engineering (EEE) Student**

Interested in Digital Signal Processing, Embedded Systems, Machine Learning, and Electronics.

[![GitHub](https://img.shields.io/badge/GitHub-Mazharul--Islam--Chowdhury-181717?style=for-the-badge&logo=github)](https://github.com/Mazharul-Islam-Chowdhury)

</div>

## 📄 License

No license is currently specified in this README. If you want others to reuse or distribute your code, consider adding an appropriate open-source license to the repository.

---

<div align="center">

### ⭐ Thanks for Visiting!

If you find this project interesting, consider starring the repository.

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0F2027,50:203A43,100:2C5364&height=120&section=footer" width="100%" alt="Decorative project footer"/>

**Built with curiosity, signal processing, and engineering.**

</div>
