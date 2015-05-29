Inria Paris/Rocquencourt cluster user documentation
===================================================

Requirements
------------

Install the package manager miniconda3, from:

    http://conda.pydata.org/miniconda.html

Create a conda environment, for example named 'rioc',
containing required packages:

    conda create -n rioc python=3 sphinx sphinx_rtd_theme

Activate the conda environment:

    source activate rioc

Build documentation
-------------------

Build the documentation:

    cd doc
    make html

Open the generated files:
 
    firefox doc/_build/html/index.html
