#!/usr/bin/env bash
#apt-get update
#apt-get install -y debtree
#apt-get install graphviz -y
mkdir -p /vagrant/16


mkdir -p /vagrant/16-package
sudo su
#dpkg --get-selections | grep -v "deinstall" | cut -f1 > /vagrant/16-package/list.txt
#file="/vagrant/16-package/list.txt"
#i=0
#while IFS= read -r line
#do
#	i=$((i+1))
#	$(debtree $line |  tr -d '\n\t' | sed 's/\;/\;\n/g' |  awk '!a[$0]++' > /vagrant/16-package/data$i.dot)
#done <"$file"


#Get dependancies
#debtree apache2  |  tr -d '\n\t' | sed 's/\;/\;\n/g'|  awk '!a[$0]++'  > /vagrant/16/16-apache2.dot
#debtree apache2-dev  |  tr -d '\n\t' | sed 's/\;/\;\n/g' |  awk '!a[$0]++' > /vagrant/16/16-apache2-dev.dot
#debtree apache2-bin  |  tr -d '\n\t' | sed 's/\;/\;\n/g'|  awk '!a[$0]++'  > /vagrant/16/16-apache2-bin.dot

#Get noconflict
#debtree apache2 --no-conflicts |  tr -d '\n\t' | sed 's/\;/\;\n/g'|  awk '!a[$0]++'  > /vagrant/16/16-apache2-noconflict.dot
#debtree apache2-dev --no-conflicts |  tr -d '\n\t' | sed 's/\;/\;\n/g'|  awk '!a[$0]++'  > /vagrant/16/16-apache2-dev-noconflict.dot
#debtree apache2-bin --no-conflicts |  tr -d '\n\t' | sed 's/\;/\;\n/g'|  awk '!a[$0]++'  > /vagrant/16/16-apache2-bin-noconflict.dot

#Get conflicts
#{ head -n +2 /vagrant/16/16-apache2.dot ; diff /vagrant/16/16-apache2.dot /vagrant/16/16-apache2-noconflict.dot |  sed -n 's/^< \(.*\)/\1/p' ; tail -1 /vagrant/16/16-apache2.dot ; } |  awk '!a[$0]++'  > /vagrant/16/16-apache2-diff.dot
#{ head -n +2 /vagrant/16/16-apache2-dev.dot ; diff /vagrant/16/16-apache2-dev.dot /vagrant/16/16-apache2-dev-noconflict.dot |  sed -n 's/^< \(.*\)/\1/p' ; tail -1 /vagrant/16/16-apache2-dev.dot ; } |  awk '!a[$0]++'  > /vagrant/16/16-apache2-dev-diff.dot
#{ head -n +2 /vagrant/16/16-apache2-bin.dot ; diff /vagrant/16/16-apache2-bin.dot /vagrant/16/16-apache2-bin-noconflict.dot |  sed -n 's/^< \(.*\)/\1/p' ; tail -1 /vagrant/16/16-apache2-bin.dot ; } |  awk '!a[$0]++'  > /vagrant/16/16-apache2-bin-diff.dot

#Merge
#gvpack /vagrant/16/16-apache2-noconflict.dot /vagrant/16/16-apache2-bin-noconflict.dot /vagrant/16/16-apache2-dev-noconflict.dot  -u| sed 's/_gv[0-9]\+//g' | tr -d '\n\t' | sed 's/\;/\;\n/g'|  awk '!a[$0]++' >  /vagrant/16/16-Merge.dot

#gvpack /vagrant/16/16-apache2-diff.dot /vagrant/16/16-apache2-bin-diff.dot /vagrant/16/16-apache2-dev-diff.dot -u | sed 's/_gv[0-9]\+//g' | tr -d '\n\t' | sed 's/\;/\;\n/g'| awk '!a[$0]++' > /vagrant/16/16-Merge-diff.dot

#gvpack /vagrant/16/16-apache2.dot /vagrant/16/16-apache2-bin.dot /vagrant/16/16-apache2-dev.dot -u | sed 's/_gv[0-9]\+//g'| tr -d '\n\t' | sed 's/\;/\;\n/g' |  awk '!a[$0]++' > /vagrant/16/16-Merge-Full.dot 

gvpack /vagrant/16-package/*.dot -u | sed 's/_gv[0-9]\+//g'| tr -d '\n\t' | sed 's/\;/\;\n/g' |  awk '!a[$0]++' > /vagrant/16-package/16-Merge.dot 
sed -i '/alt/d' /vagrant/16-package/16-Merge.dot