
#!/bin/bash
 
# KEY="AIzaSyBOti4mM-6x9WDnZIjIeyEU21OpBXqWBgw"
# URL="https://www.google.com/speech-api/v2/recognize?output=json&lang=en&key=$KEY&client=Mozilla/5.0"

index=0
now=$(date +%s)sec
while true
do
  ### echo "Recording...$index"
  fileName="/home/pi/file$index.flac"
  ### echo "$index... " $(TZ=UTC date --date now-$now +%H:%M:%S.%N) 
  arecord -D plughw:1,0 -f cd -t wav -d 5 -c 1 -q -r 44100 | flac - -s -f --best -o "$fileName";
  /home/pi/recognize.sh "$index" &
  # echo "Processing..."
  # fileName2="stt$index.txt"
  # wget -q -U "Mozilla/5.0" --post-file "$fileName" --header "Content-Type: audio/x-flac; rate=44100" -O - "$URL" >"$fileName2"
   
  # echo -n "Google Answer: "
  # OUTPUT=$(cat "$fileName2"  | sed -e 's/[{}]/''/g' | awk -F":" '{print $4}' | awk -F"," '{print $1}' | tr -d '\n')
   
  # echo $OUTPUT
  # echo ""
   
  # rm "$fileName"  > /dev/null 2>&1
   
  # strindex() {
  #   x="${1%%$2*}"
  #   [[ $x = $1 ]] && echo -1 || echo ${#x}
  # }

  # OUTPUT=$(echo $OUTPUT | tr '[:upper:]' '[:lower:]')

  # if (($(strindex "$OUTPUT" "help") != -1));  then
  #   echo "Sending help"
  #   python3 sendMail.py "$OUTPUT"
  # fi

  #index handling
  index=$((index + 1))
  
  if [ "$index" -gt 9 ]
  then
    index=$((index-10))  
  fi

done


  



