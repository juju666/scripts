netsh wlan show profiles|grep -i all|while read a b c d e; 
do  
echo $e; 
done > lista.txt 
cat lista.txt|while read a
do
#netsh wlan show profile name="$a" key=clear|grep -i "SSID name"
pass=`netsh wlan show profile name="$a" key=clear|grep -i "Key content"|cut -d: -f2`
echo - $a - $pass
done
