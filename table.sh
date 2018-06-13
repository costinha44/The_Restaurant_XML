echo "Compressing data to be sent to the table side node."
rm -rf table.zip
zip -rq table.zip Table
echo "Transfering data to the table side node."
sshpass -f password ssh cd0102@l040101-ws03.ua.pt 'mkdir -p teste/RestaurantSocketCSFinal'
sshpass -f password ssh cd0102@l040101-ws03.ua.pt 'rm -rf teste/RestaurantSocketCSFinal/*'
sshpass -f password scp table.zip cd0102@l040101-ws03.ua.pt:teste/RestaurantSocketCSFinal/
echo "Decompressing data sent to the table side node."
sshpass -f password ssh cd0102@l040101-ws03.ua.pt 'cd teste/RestaurantSocketCSFinal ; unzip -uq table.zip'
echo "Compiling program files at the table side node."
sshpass -f password ssh cd0102@l040101-ws03.ua.pt 'cd teste/RestaurantSocketCSFinal/Table/src ; find . -name "*.java" -print | xargs javac'
echo "End of compiling at the table side node."
sleep 1
echo "Executing program at the table side node."
sshpass -f password ssh cd0102@l040101-ws03.ua.pt 'cd teste/RestaurantSocketCSFinal/Table/src ; java main.MainTable'
echo "table  shutdown."
