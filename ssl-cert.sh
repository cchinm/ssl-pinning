#! /bin/bash


cert=$2
pem="$2.pem"

c2p(){
    echo "save .cer/crt certificate as .pem format"
    echo openssl x509 -inform der -in $cert -out $pem
    openssl x509 -inform der -in $cert -out $pem
}

rename(){
    echo "calculate .pem file hash-value"
    e=`openssl x509 -inform PEM -subject_hash_old -in $pem |head -1`
    echo "$pem -> $e"
    d="$e.0"
    cp $pem $d
}

if [ $1 == "c2p" ]
then
    c2p
elif [ $1 == "rename" ]
then
    pem=$2
    rename
elif [ $1 == "push" ]
then 
   echo adb push $d /data/local/tmp
   adb push $d /data/local/tmp
elif [ $1 == "all" ]
then 
   c2p
   rename
   echo adb push $d /data/local/tmp
   adb push $d /data/local/tmp
fi
