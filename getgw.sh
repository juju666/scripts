ipconfig | grep -i gateway|cut -d: -f2|grep -v "^ *$"|sed 's/ //g'
