#! /bin/bash
#
echo "[INFO] Update ${bold}setup.properties${normal} with your student number"
( echo 'cat <<EOF' ; cat setup.properties_template ; echo EOF ) | sh > setup.properties