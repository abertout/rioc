Inria Paris/Rocquencourt cluster user documentation
===================================================

Requirements
------------

Install the package manager miniconda3, from:

    http://conda.pydata.org/miniconda.html

Create a conda environment, for example named 'cluster-pro-inria-doc',
containing required packages:

    conda create -n cluster-pro-inria-doc python=3 sphinx

Activate the conda environment:

    source activate cluster-pro-inria-doc 

Build documentation
-------------------

Build the documentation:

    cd doc
    make html

Open the generated files:
 
    firefox doc/_build/html/index.html
