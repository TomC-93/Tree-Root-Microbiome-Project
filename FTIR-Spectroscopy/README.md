# FTIR Spectroscopy

## Folder Contents

This folder contains R scripts related to loading and processing soil spectra data in R, creating PLSR models, and all associated functions for assessing these models. 

## Original Files

These files, folders, and R functions are modified versions of those provided in the following GitHub repositories belonging to Shree Dangal and Charlotte Rivard:

https://github.com/sdangal/Model-Choice-using-MIR

https://github.com/charlotter62/Model-Choice-Using-MIR-Spectroscopy

The original code from which ours was adapated led to the publication of the following manuscript:

Dangal, S.R.S., Sanderman, J., Wills, S., Ramirez-Lopez, L. Accurate and Precise Prediction of Soil Properties from a Large Mid-Infrared Spectral Library. Soil Syst. 2019, 3, 11.

And some user-firendly guidelines for the original code are available here:
https://whrc.github.io/Soil-Predictions-MIR/

## Citing this work

All publications produced using the available code should cite the following works:

Dangal, S.R.S., Sanderman, J., Wills, S., Ramirez-Lopez, L. Accurate and Precise Prediction of Soil Properties from a Large Mid-Infrared Spectral Library. Soil Syst. 2019, 3, 11.

Garrett, L.G., Sanderman, J., Palmer, D.J., Dean, F., Jeram, S., Bridson, J.H., Carlin, T. (2022) _Mid-infrared spectroscopy for planted forest soil and foliage nutrition predictions, New Zealand case study_. Manuscript submitted for publication.

## In the Media

Forest Growers Research Annual Science Report 2021 (Page 6): https://fgr.nz/wp-content/uploads/2021/09/2021-Annual-Research-Report.pdf

## Funding & Acknowledgements
Funding for this research came from the Resilient Forest programme, which is funded by New Zealand Ministry of Business, Innovation & Employment (MBIE) Strategic Science Investment Fund, and in part by the New Zealand Forest Growers Levy Trust (C04X1703). Funding to support soil spectroscopy also came from the Tree-Root-Microbiome programme, which is funded by MBIE’s Endeavour Fund and in part by the New Zealand Forest Growers Levy Trust (C04X2002). The authors thank the New Zealand Ministry for the Environment for permission to use the New Zealand’s National Planted Forest Inventory (NPFI) soil samples and data. We thank the forest companies who have contributed with soil and foliage samples and data, Scion staff for support in the laboratory, analytical laboratories, and the New Zealand Bruker representative. 

### Deviations from Original
Modifications to the original code can be seen throughout by the use of "# TC -" followed by a description of the change, where "TC" are the initials of the individual who made the changes (Thomas Carlin). Modifications are largely superficial in nature in order for the code to work on samples procured by Scion, and data stored by Scion in different formats than those allowed by the original code. Minor optimisations are present, but are in no way substantial or required.

### Disclaimer
These functions are provided by Scion to facilitate analysis of soil spectra data in R, and to produce PLSR models to predict soil properties rapidly and cheaply. While we have made reasonable endeavours to ensure its accuracy, these functions are still under development and have not yet been fully validated. In addition, Scion is not responsible for any changes/updates/maintenance of the R packages on which these functions rely which may lead to unintended consequences or results from these functions. Accordingly, these functions are provided without warranties of any kind including accuracy, timeliness or fitness for any particular purpose. To the fullest extent permitted by law, Scion excludes liability for any loss, damage or expense, direct or indirect resulting from any person or organisation's use of or reliance on these functions.
