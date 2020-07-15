# Wildfire Smoke Detection

Matlab source code for the paper:

	A. Genovese, R. Donida Labati, V. Piuri, and F. Scotti, 
    "Wildfire smoke detection using computational intelligence techniques", 
    in IEEE International Conference on Computational Intelligence for Measurement Systems and Applications (CIMSA 2011), 
    Ottawa, Canada, September, 2011, pp. 1-6. ISSN: 2159-1547. 
    [DOI: 10.1109/CIMSA.2011.6059930]
    https://ieeexplore.ieee.org/document/6059930
    
    R. Donida Labati, A. Genovese, V. Piuri, and F. Scotti, 
    "Wildfire smoke detection using computational intelligence techniques enhanced with synthetic smoke plume generation", 
    in IEEE Transactions on Systems, Man and Cybernetics: Systems, vol. 43, no. 4, July, 2013, pp. 1003-1012. ISSN: 2168-2216. 
    [DOI: 10.1109/TSMCA.2012.2224335]
    https://ieeexplore.ieee.org/document/6425498

Project page:
(with example videos)

https://homes.di.unimi.it/genovese/wild/wildfire.htm

Outline:<br/>
![Outline](https://homes.di.unimi.it/genovese/wild/imgs/Picture1small_2.png "Outline")

Citation:

@InProceedings {CIMSA2011,
    author = {A. Genovese and R. {Donida Labati} and V.
Piuri and F. Scotti},
    booktitle = {Proc. of the 2011 IEEE Int. Conf. on Computational Intelligence for Measurement Systems and Applications (CIMSA 2011)},
    title = {Wildfire smoke detection using computational intelligence techniques},
    address = {Ottawa, ON, Canada},
    pages = {1-6},
    month = {September},
    day = {19-21},
    year = {2011},
    note = {978-1-61284-924-9}
}
	
@Article {tsmca12,
    author = {R. {Donida Labati} and A. Genovese and V.
Piuri and F. Scotti},
    title = {Wildfire smoke detection using computational intelligence techniques enhanced with synthetic smoke plume generation},
    journal = {IEEE Transactions on Systems, Man and Cybernetics: Systems},
    volume = {43},
    number = {4},
    pages = {1003-1012},
    month = {July},
    year = {2013},
    note = {2168-2216}
}

Main files:

    - launch_smokeClassification.m: main file

Required files:

    - ./(VID SEGM) Smoke3: Directory with example video
    
The code implements some of the algorithms described in:
http://signal.ee.bilkent.edu.tr/VisiFire/
