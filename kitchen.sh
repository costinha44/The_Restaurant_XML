echo "Compressing data to be sent to the kitchen side node."
rm -rf kitchen.zip
zip -rq kitchen.zip Kitchen
echo "Transfering data to the kitchen side node."
sshpass -f password ssh cd0102@l040101-ws02.ua.pt 'mkdir -p teste/RestaurantSocketCSFinal'
sshpass -f password ssh cd0102@l040101-ws02.ua.pt 'rm -rf teste/RestaurantSocketCSFinal/*'
sshpass -f password scp kitchen.zip cd0102@l040101-ws02.ua.pt:teste/RestaurantSocketCSFinal/
echo "Decompressing data sent to the kitchen side node."
sshpass -f password ssh cd0102@l040101-ws02.ua.pt 'cd teste/RestaurantSocketCSFinal ; unzip -uq kitchen.zip'
echo "Compiling program files at the kitchen side node."
sshpass -f password ssh cd0102@l040101-ws02.ua.pt 'cd teste/RestaurantSocketCSFinal/Kitchen/src ; find . -name "*.java" -print | xargs javac'
echo "End of compiling at the kitchen side node."
sleep 1
echo "Executing program at the kitchen side node."
sshpass -f password ssh cd0102@l040101-ws02.ua.pt 'cd teste/RestaurantSocketCSFinal/Kitchen/src ; java main.MainKitchen'
echo "kitchen  shutdown."
