<p align="center">
  <img src="assets/banner.svg" alt="Voice Recognition System" width="100%"/>
</p>

<p align="center">
  <img alt="MATLAB" src="https://img.shields.io/badge/MATLAB-R20XXa%2B-orange?logo=mathworks&logoColor=white">
  <img alt="Platform" src="https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey">
  <img alt="License" src="https://img.shields.io/badge/license-MIT-green">
  <img alt="Status" src="https://img.shields.io/badge/status-active%20development-blue">
</p>

<p align="center">
  A MATLAB speech-processing project that records voice samples, extracts <b>MFCC</b> features,<br>
  trains a classifier, and recognises voices in <b>real time</b> from a microphone.
</p>

---

## Demo

<p align="center">
  <img src="assets/demo.gif" alt="Real-time voice detector GUI demo" width="720"/>
</p>

> Screen recording of `realtime_voice_detector_gui.m` in action.
> *(Add your own capture at `assets/demo.gif`; see [Adding the demo GIF](#adding-the-demo-gif).)*

## Pipeline

<p align="center">
  <img src="assets/pipeline.svg" alt="Animated processing pipeline" width="100%"/>
</p>

| Stage | What happens |
|---|---|
| **Microphone** | Audio is captured at `[FS]` Hz, mono. |
| **Preprocessing** | Signal is split into `[FRAME_MS]` ms frames with `[OVERLAP]`% overlap, windowed with a `[WINDOW]` window, and normalised. |
| **MFCC** | `[N_MFCC]` coefficients per frame from a `[N_FILTERS]`-band Mel filter bank, summarised into one feature vector per recording. |
| **Classifier** | `[CLASSIFIER, e.g. SVM / k-NN]` trained on the recorded dataset. |
| **Prediction** | Predicted label and confidence are shown live in the GUI. |

## Features

- **Dataset recorder:** GUI for capturing labelled voice samples.
- **MFCC extraction:** compact spectral features, with a standalone script for study and experiments.
- **Classifier training:** trains on your recorded dataset and saves the model to a `.mat` file.
- **Real-time detection:** live microphone input with on-screen prediction.

## Repository Structure

```
voice-recognition-system/
├── assets/                          # README images and animations
├── mfcc_basic.m                     # Standalone MFCC feature extraction
├── record_voice_dataset_gui.m       # GUI: record labelled voice samples
├── train_voice_classifier_gui_old.m # Training script (legacy, see Known Issues)
├── realtime_voice_detector_gui.m    # GUI: live voice detection
├── voice_model_old.mat              # Saved model (legacy)
└── README.md
```

## Requirements

| Item | Version / Note |
|---|---|
| MATLAB | `[R20XXa or newer]` |
| Audio Toolbox | `[required / not required]` |
| Statistics and Machine Learning Toolbox | `[required / not required]` |
| Signal Processing Toolbox | `[required / not required]` |
| Hardware | Working microphone |

## Quick Start

```bash
git clone https://github.com/Mazharul-Islam-Chowdhury/voice-recognition-system.git
cd voice-recognition-system
```

Open MATLAB, set the **Current Folder** to the project directory, then run the steps in order:

```matlab
% 1. Record labelled samples (one class per speaker or word)
record_voice_dataset_gui

% 2. (Optional) Inspect how MFCC features are computed
mfcc_basic

% 3. Train the classifier on the recorded dataset
train_voice_classifier_gui_old

% 4. Start real-time detection
realtime_voice_detector_gui
```

**Tip:** record at least `[N]` samples per class in a quiet room, using the same microphone for recording and detection.

## How MFCC Works

1. Split the signal into short frames.
2. Apply a window function (reduces spectral leakage).
3. Compute the magnitude spectrum with the FFT.
4. Pass it through a Mel-scaled filter bank.
5. Take the logarithm of the filter-bank energies.
6. Apply the DCT to decorrelate and keep the first `[N_MFCC]` coefficients.

## Results

> Replace the placeholders with your measured results on a **held-out test set**.

| Metric | Value |
|---|---|
| Classes | `[N]` |
| Training samples | `[N]` |
| Test samples | `[N]` |
| Accuracy | `[XX.X %]` |
| Precision / Recall | `[XX.X %]` / `[XX.X %]` |

<p align="center">
  <img src="assets/confusion_matrix.png" alt="Confusion matrix" width="420"/>
</p>

## Known Issues

- `train_voice_classifier_gui_old.m` and `voice_model_old.mat` are legacy files. If detection reports a missing variable or a **feature-dimension mismatch**, retrain the model so that training and detection use identical MFCC settings.
- Background noise reduces accuracy; use a quiet environment or add noise reduction.
- Real-time latency depends on the microphone driver and hardware.

## Roadmap

- [ ] Replace legacy training script and model with up-to-date versions
- [ ] Add voice activity detection (VAD)
- [ ] Noise reduction in preprocessing
- [ ] Compare classifiers (SVM, k-NN, small neural network)
- [ ] Report accuracy, precision, recall and confusion matrix automatically
- [ ] Port a lightweight version to a microcontroller / embedded DSP target

## Adding the demo GIF

1. Run `realtime_voice_detector_gui` and record your screen with [ScreenToGif](https://www.screentogif.com/) (Windows) or any screen recorder.
2. Keep it under about 10 seconds and 10 MB.
3. Save it as `assets/demo.gif` and commit it.

## Author

**Mazharul Islam Chowdhury**: Electrical and Electronic Engineering student interested in digital signal processing, embedded systems, and machine learning.

[GitHub](https://github.com/Mazharul-Islam-Chowdhury)

## License

Released under the [MIT License](LICENSE). Add a `LICENSE` file to the repository root to activate this.
