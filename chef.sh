echo "Compressing data to be sent to the chef side node."
rm -rf chef.zip
zip -rq chef.zip Chef
echo "Transfering data to the chef side node."
sshpass -f password ssh cd0102@l040101-ws05.ua.pt 'mkdir -p teste/RestaurantSocketCSFinal'
sshpass -f password ssh cd0102@l040101-ws05.ua.pt 'rm -rf teste/RestaurantSocketCSFinal/*'
sshpass -f password scp chef.zip cd0102@l040101-ws05.ua.pt:teste/RestaurantSocketCSFinal/
echo "Decompressing data sent to the chef side node."
sshpass -f password ssh cd0102@l040101-ws05.ua.pt 'cd teste/RestaurantSocketCSFinal ; unzip -uq chef.zip'
echo "Compiling program files at the chef side node."
sshpass -f password ssh cd0102@l040101-ws05.ua.pt 'cd teste/RestaurantSocketCSFinal/Chef/src ; find . -name "*.java" -print | xargs javac'
echo "End of compiling at the chef side node."
sleep 1
echo "Executing program at the chef side node."
sshpass -f password ssh cd0102@l040101-ws05.ua.pt 'cd teste/RestaurantSocketCSFinal/Chef/src ; java main.MainChef'
echo "chef  shutdown."
