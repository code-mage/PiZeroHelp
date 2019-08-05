
#!/bin/bash

URL="https://www.google.com/speech-api/v2/recognize?output=json&lang=en&key=$KEY&client=Mozilla/5.0"

index=$1
help="help"
###echo "Processing...$1"
fileName="/home/pi/file$index.flac"
fileName2="/home/pi/stt$index.txt"

ampThresh=0.1
ampNormal=0.02
maxAmp=$(sox -t .flac "$fileName" -n stat 2>&1 | sed -n 's#^Maximum amplitude:[^0-9]*\([0-9.]*\)$#\1#p')
echo "$maxAmp"
#if [ 1 -eq "$(echo "${ampThresh} < ${maxAmp}" | bc)" ]
#then  
    #python3 sendMail.py "PiZero1 Alert. \nLoud Voice recognized"
   # wget -q -U "Mozilla/5.0" --post-data '{"message": "Loud noise detected.","sendToAllSubscribers": true}' --header "Content-Type: application/json" --header 'accessToken: '"$KAIZKEY" -O - https://kms.kaiza.la/v1/groups/dd605556-7f15-48f1-8337-8e640350898a/messages
   # echo "Loud sound detected"
    #aplay test.wav
#fi

if [ 1 -eq "$(echo "${ampNormal} < ${maxAmp}" | bc)" ]
then
    wget -q -U "Mozilla/5.0" --post-file "$fileName" --header "Content-Type: audio/x-flac; rate=44100" -O - "$URL" >"$fileName2" 
   # OUTPUT=$(cat "$fileName2"  | sed -e 's/[{}]/''/g' | awk -F":" '{print $4}' | awk -F"," '{print $1}' | tr -d '\n') 
   # echo $OUTPUT
    OUTPUT=$(cat "$fileName2")
 
    OUTPUT=$(echo $OUTPUT | tr '[:upper:]' '[:lower:]')

    if [[ $OUTPUT == *"help"* ]]; then
      wget -q -U "Mozilla/5.0" --post-data '{"message": "Loud noise detected.","sendToAllSubscribers": true}' --header "Content-Type: application/json" --header 'accessToken: '"$KAIZKEY" -O - https://kms.kaiza.la/v1/groups/dd605556-7f15-48f1-8337-8e640350898a/message
      python3 sendMail.py "$OUTPUT"
      bod='{"message": "PiZero1 Alert. \nHelp required. \nRecorded Message -'"${OUTPUT//\"/ }"'","sendToAllSubscribers": true}'
      wget -q -U "Mozilla/5.0" --post-data "$bod" --header "Content-Type: application/json" --header 'accessToken: '"$KAIZKEY" -O - https://kms.kaiza.la/v1/groups/dd605556-7f15-48f1-8337-8e640350898a/messages
      echo "Help is on it's way"
    fi
fi

rm "$fileName"  > /dev/null 2>&1
