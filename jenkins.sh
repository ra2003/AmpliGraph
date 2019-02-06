#Make sure gcc is installed
source /etc/profile 
gcc --version
conda --version
pip --version
# Cleanup old env (if any)
conda env remove --name ampligraph || true

# Create & activate Virtual Environment
conda create --name ampligraph python=3.6
source activate ampligraph

# Install library
pip install .[cpu,hdt] -v

# configure dataset location
export AMPLIGRAPH_DATA_HOME=/var/datasets

# run unit tests
pytest tests

# build documentation
cd docs
make clean autogen html

# mode docs to dubaldeweb001 web server
scp -r _build/html/* jenkinsuser@dubaldeweb001.techlabs.accenture.com:/var/www/html/docs/ampligraph/dev

# cleanup: remove conda env
source deactivate
conda env remove --name ampligraph
