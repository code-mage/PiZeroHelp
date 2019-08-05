index=$1
echo "stt$index.txt"
OUTPUT=$(cat "stt$index.txt") 
 
strindex() {
  x="${1%%$2*}"
  [[ $x = $1 ]] && echo -1 || echo ${#x}
}

OUTPUT=$(echo $OUTPUT | tr '[:upper:]' '[:lower:]')

echo $OUTPUT
if [[ $OUTPUT == *$2* ]]; then
  echo "Help is on it's way"
fi
