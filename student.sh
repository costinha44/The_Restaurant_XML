echo "Compressing data to be sent to the student side node."
rm -rf student.zip
zip -rq student.zip Student
echo "Transfering data to the student side node."
sshpass -f password ssh cd0102@l040101-ws07.ua.pt 'mkdir -p teste/RestaurantSocketCSFinal'
sshpass -f password ssh cd0102@l040101-ws07.ua.pt 'rm -rf teste/RestaurantSocketCSFinal/*'
sshpass -f password scp student.zip cd0102@l040101-ws07.ua.pt:teste/RestaurantSocketCSFinal/
echo "Decompressing data sent to the student side node."
sshpass -f password ssh cd0102@l040101-ws07.ua.pt 'cd teste/RestaurantSocketCSFinal ; unzip -uq student.zip'
echo "Compiling program files at the student side node."
sshpass -f password ssh cd0102@l040101-ws07.ua.pt 'cd teste/RestaurantSocketCSFinal/Student/src ; find . -name "*.java" -print | xargs javac'
echo "End of compiling at the student side node."
sleep 1
echo "Executing program at the student side node."
sshpass -f password ssh cd0102@l040101-ws07.ua.pt 'cd teste/RestaurantSocketCSFinal/Student/src ; java main.MainStudent'
echo "student  shutdown."
