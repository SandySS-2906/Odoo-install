#!/bin/bash

# ------------------------------------------------------------
#  Odoo 19 Automatic Installer for Ubuntu 24.04 (Python 3.12)
#  Author: Sandeep Paulraj
# ------------------------------------------------------------

set -e  # Stop script on first error

echo "====================== GIT INSTALLATION START ============================"
sudo apt install -y git
echo "Git installed successfully!"
echo ""

echo "====================== SYSTEM UPDATE & UPGRADE START ===================="
sudo apt update -y && sudo apt upgrade -y
echo "System updated and upgraded successfully!"
echo ""

echo "====================== INSTALLING PIP & PYTHON 3.12 ======================"
sudo apt install -y python3-pip python3.12 python3.12-venv python3.12-dev libpq-dev
echo "Python 3.12, pip, and system libs installed!"
echo ""

echo "====================== CREATING VIRTUAL ENVIRONMENT ======================"
venv_dir="/opt/venv19"

if [ ! -d "$venv_dir" ]; then
    sudo python3.12 -m venv "$venv_dir"
    sudo chown -R $USER:$USER "$venv_dir"
    echo "Virtual environment created!"
else
    echo "Virtual env already exists."
fi

source "$venv_dir/bin/activate"
echo "Virtual environment activated!"
echo ""

echo "====================== DIRECTORY SETUP START ============================"
odoo_dir="$HOME/workspace"

mkdir -p "$odoo_dir"
echo "Directory ensured: $odoo_dir"
cd "$odoo_dir"
echo ""

echo "====================== GIT CLONE START ================================"
if [ ! -d "odoo_19" ]; then
    git clone https://github.com/odoo/odoo.git --branch=19.0 --depth=1 odoo_19
    echo "Odoo 19 repository cloned!"
else
    echo "Odoo 19 directory already exists."
fi
echo ""

cd odoo_19

echo "====================== INSTALLING PYTHON DEPENDENCIES ======================"
pip install --upgrade pip setuptools wheel

pip install --no-cache-dir \
    asn1crypto==1.5.1 \
    Babel==2.10.3 \
    cbor2==5.6.2 \
    chardet==5.2.0 \
    cryptography==42.0.8 \
    docutils==0.20.1 \
    freezegun==1.2.1 \
    geoip2==2.9.0 \
    gevent==24.2.1 \
    greenlet==3.0.3 \
    idna==3.6 \
    Jinja2==3.1.2 \
    libsass==0.22.0 \
    lxml==5.2.1 \
    lxml-html-clean \
    MarkupSafe==2.1.5 \
    num2words==0.5.13 \
    ofxparse==0.21 \
    openpyxl==3.1.2 \
    passlib==1.7.4 \
    Pillow==10.2.0 \
    polib==1.1.1 \
    psutil==5.9.8 \
    psycopg2==2.9.9 \
    pyopenssl==24.1.0 \
    PyPDF2==2.12.1 \
    pyserial==3.5 \
    python-dateutil==2.8.2 \
    python-magic==0.4.27 \
    python-ldap==3.4.4 \
    python-stdnum==1.19 \
    pytz \
    pyusb==1.2.1 \
    qrcode==7.4.2 \
    reportlab==4.1.0 \
    requests==2.31.0 \
    rjsmin==1.2.0 \
    urllib3==2.0.7 \
    vobject==0.9.6.1 \
    Werkzeug==3.0.1 \
    xlrd==2.0.1 \
    XlsxWriter==3.1.9 \
    xlwt==1.3.0 \
    zeep==4.2.1

echo "Odoo 19 Python dependencies installed!"
echo ""

echo "====================== ADDING ALIASES ================================"
bashrc="$HOME/.bashrc"

if ! grep -q "alias v19=" "$bashrc"; then
    {
        echo "# Odoo 19 environment aliases"
        echo "alias v19=\"source $venv_dir/bin/activate\""
        echo "alias d=\"deactivate\""
        echo "alias 19=\"source $venv_dir/bin/activate && cd $odoo_dir/odoo_19\""
    } >> "$bashrc"
    echo "Aliases added!"
else
    echo "Aliases already exist."
fi

echo ""
echo "====================== SHORTCUTS & USAGE ================================"

echo -e "\nYour Odoo 19 Setup is Complete!"
echo ""
echo "Virtual environment: $venv_dir"
echo "Odoo directory:      $odoo_dir/odoo_19"
echo ""
echo "Shortcuts:"
echo "  Activate venv:         v19"
echo "  Deactivate venv:       d"
echo "  Activate & go to Odoo: 19"
echo ""
echo "Run in your current terminal:"
echo "  source ~/.bashrc"
echo ""

echo "====================== SCRIPT COMPLETED SUCCESSFULLY ====================="

deactivate

echo ""
echo "====================== CONNECT WITH ME ================================"
echo "LinkedIn : https://linkedin.com/in/sandeep-paulraj"
echo "GitHub   : https://github.com/SandySS-2906"
echo "Email    : sandeeppaulraj143@gmail.com"
echo "======================================================================="

