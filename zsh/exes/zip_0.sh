#!/bin/zsh

# 기본값 설정
exclude=""
directory=""

# 옵션 파싱
while getopts ":e:d:" opt; do
  case $opt in
    e) exclude=$OPTARG ;;
    d) directory=$OPTARG ;;
    \?) echo "Invalid option -$OPTARG" >&2; exit 1 ;;
  esac
done

# 필수 인자 확인
if [ -z "$directory" ]; then
  echo "Error: Directory (-d) is required."
  exit 1
fi

# 압축 파일 이름 설정
archive_name=$(basename "$directory").tar.gz

# 제외할 항목 처리
exclude_options=""
if [ -n "$exclude" ]; then
  IFS=',' read -rA exclude_array <<< "$exclude"
  for item in "${exclude_array[@]}"; do
    exclude_options="$exclude_options --exclude='$item'"
  done
fi

# 압축 명령 실행
eval "tar -czvf $archive_name $exclude_options -C $directory ."

echo "Archive created: $archive_name"