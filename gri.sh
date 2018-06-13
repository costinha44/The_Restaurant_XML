echo "Compressing data to be sent to the logger side node."
rm -rf gri.zip
zip -rq gri.zip GRI
echo "Transfering data to the logger side node."
sshpass -f password ssh cd0102@l040101-ws04.ua.pt 'mkdir -p teste/RestaurantSocketCSFinal'
sshpass -f password ssh cd0102@l040101-ws04.ua.pt 'rm -rf teste/RestaurantSocketCSFinal/*'
sshpass -f password scp gri.zip cd0102@l040101-ws04.ua.pt:teste/RestaurantSocketCSFinal/
echo "Decompressing data sent to the logger side node."
sshpass -f password ssh cd0102@l040101-ws04.ua.pt 'cd teste/RestaurantSocketCSFinal ; unzip -uq gri.zip'
echo "Compiling program files at the logger side node."
sshpass -f password ssh cd0102@l040101-ws04.ua.pt 'cd teste/RestaurantSocketCSFinal/GRI/src ; find . -name "*.java" -print | xargs javac'
echo "End of compiling at the logger side node."
sleep 1
echo "Executing program at the logger side node."
sshpass -f password ssh cd0102@l040101-ws04.ua.pt 'cd teste/RestaurantSocketCSFinal/GRI/src ; java main.MainGRI'
echo "Pull log file"
scp -r cd0102@l040101-ws04.ua.pt:teste/RestaurantSocketCSFinal/GRI/src/TheRestaurant-CD.txt .
echo "logger  shutdown."
