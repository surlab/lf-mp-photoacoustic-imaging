# Matlab code for Osaki et al. Light: Science & Applications 14, 2264 (2025)

Repository for the code that was used to process and analyze data collected for "Multi-photon, Label-free photoacoustic and optical imaging of NADH in neurons", 
Osaki et al. Light: Science & Applications (2025), https://doi.org/10.1038/s41377-025-01895-x
---

#### Photoacoustic signal processing

*   **Image Analysis**:
    *   **Signal Processing for Photoacoustic Data**: This includes methods for processing acoustic signals, such as performing **Continuous Wavelet Transform (CWT) and inverted CWT** using MATLAB's "Wavelet Toolbox" to decompose signals into distinct frequency bands. It also covers real-time signal conditioning and pixel value calculation for image generation, including averaging multiple photoacoustic pulses for a grey value.
    *   **Image Post-processing**: The page would also likely contain MATLAB codes for **denoising and deconvolution** of photoacoustic NAD(P)H images to improve resolution and identify single cells.
    *   **Calcium Imaging Data Processing**: Although "Suite2p" (a Python package) was used for initial processing of Ca2+ imaging data to identify neurons and regions of interest (ROIs), the subsequent calculation of **correlation matrices** using Pearson's pairwise correlation was performed in MATLAB. This MATLAB code could also be part of the GitHub repository.

*   **K-Wave Simulation**:
    *   The GitHub page would provide **MATLAB codes for K-Wave simulations**, which were used to model various aspects of the photoacoustic system. This includes predicting the **acoustic peak frequency** based on the heated focal volume, simulating the **acoustic pulse pressure field**, and analyzing the **effective field of view** of the acoustic sensor.

---

```
Tatsuya Osaki1, 2†, W. David Lee3†, Xiang Zhang3, 5†, Rebecca E. Zubajlo3†, Mercedes Balcells5, Elazer Edelman5, Brian W. Anthony3, 5*, Peter T. C. So3, 4*, and Mriganka Sur1*
*Multi-photon, Label-free photoacoustic and optical imaging of NADH in neurons*
1. Picower Institute for Learning and Memory, Massachusetts Institute of Technology, Cambridge, MA, 02139, United States
2. Whitehead Institute for Biomedical Research, Massachusetts Institute of Technology, Cambridge, MA, 02142, United States
3. Department of Mechanical Engineering, Massachusetts Institute of Technology, Cambridge, MA, 02139, United States
4. Department of Biological Engineering, Massachusetts Institute of Technology, Cambridge, MA, 02139, United States
5. Institute of Medical Engineering and Science, Massachusetts Institute of Technology, Cambridge, MA, 02139, United States
```


