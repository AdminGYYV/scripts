#!/bin/bash

# Post-install script for "Crésus"

if [ ! -d /Users/Shared/.cresus/ ]; then
  mkdir /Users/Shared/.cresus
fi

if [ ! -d /Users/Shared/.cresus/Comptabilité/ ]; then
  mkdir /Users/Shared/.cresus/Comptabilité
fi

if [ ! -f /Users/Shared/.cresus/Comptabilité/license.gala ]; then
  touch /Users/Shared/.cresus/Comptabilité/license.gala
fi

cat > /Users/Shared/.cresus/Comptabilité/license.gala <<EOL
licensenumber : 72000-960091-4263-122423
title : 0
username : Cédric Delmonico
firstname : Cédric
lastname : Delmonico
enterprisename : Gymnase d'Yverdon
email : activation-gymnase-yverdon@epsitec.ch
key : F5Vc5z65gZs3yo8fCLoaVEYGq7OU0ebQNdV8j4B+PU+U4836MGTeJ8H4TvMnt8fwWg2TlNvJ5tbsSD003LOhOyGoC+enWvn7Tm6XeEN1u4CY6OqtekddRkaRv2nvvmFQ1038zUHY60SiveVyD0vW0otgUOwwwl9FgbxBsdLQG4WXw0Z4JGgLDGHGLAV0ahha9BzRmverCGQ4vz4/xSSavdDMj4BHQpMTnduH5Sp0aQFTTLHcdE7GO+GUGpYNZHq5CCg+tYwpASQOx0dLvQ6vQv538vo/QbJBEZDjSdBqDbEKk9N6dZlk5Pe+4wfEu6hm5OmumdvL7E29C+WmwVOi7Q==
userid : 
build : 1497330759
attributes : 00000000
date_paydue : 
date_payrecv : 
date_signature : lK4Goaf9Pxx1jU8eO7Wm11HpteqhrcD+BbYz581ffJ+toavHb+IBh8l1Zib5w5NHMNvETo3HuAa8miBI1sRLDYRU4jnUIeFKdnpcRLsoqKSy3iYCkckgX7UEeZuHbi+srtU25Ybat+ctMYiK9DSAJ8DCXzs6zWhI30n7kX6XPHVpAxGMA+DZar2QzlTXeq1/PTGyU9UJVRkCFz2kChEwreNylFQX818z0hdvVF/P/2YDEixhiTRWHEB31FK0kpAWzYpmjBEo00OVkIpcMoDmKfSn/NPE30a3RC5uGvYNcxBPQC+N/iVJLhOJC2ujZ7wzaWTzr2046yz9Q7k3p1bk1g==
extension_key : lK4Goaf9Pxx1jU8eO7Wm11HpteqhrcD+BbYz581ffJ+toavHb+IBh8l1Zib5w5NHMNvETo3HuAa8miBI1sRLDYRU4jnUIeFKdnpcRLsoqKSy3iYCkckgX7UEeZuHbi+srtU25Ybat+ctMYiK9DSAJ8DCXzs6zWhI30n7kX6XPHVpAxGMA+DZar2QzlTXeq1/PTGyU9UJVRkCFz2kChEwreNylFQX818z0hdvVF/P/2YDEixhiTRWHEB31FK0kpAWzYpmjBEo00OVkIpcMoDmKfSn/NPE30a3RC5uGvYNcxBPQC+N/iVJLhOJC2ujZ7wzaWTzr2046yz9Q7k3p1bk1g==
EOL