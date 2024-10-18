#!/bin/zsh

# 기본값 설정
exclude=""
input_dir=""
output_dir=""

# 도움말 함수
show_help() {
    echo "Usage: zip.sh [OPTIONS]"
    echo "Options:"
    echo "  -i <directory>   압축할 대상 디렉토리"
    echo "  -o <directory>   압축파일을 저장할 디렉토리"
    echo "  -e <items>       제외할 파일 또는 디렉토리 (쉼표로 구분)"
    echo "  -h               도움말 표시"
}

# 옵션 파싱
while getopts ":i:o:e:h" opt; do
  case $opt in
    i) input_dir=$OPTARG ;;
    o) output_dir=$OPTARG ;;
    e) exclude=$OPTARG ;;
    h) show_help; exit 0 ;;
    \?) echo "Invalid option -$OPTARG" >&2; show_help; exit 1 ;;
  esac
done

# 필수 인자 확인
if [ -z "$input_dir" ]; then
  echo "Error: Input directory (-i) is required."
  show_help
  exit 1
fi

# 출력 디렉토리가 지정되지 않은 경우 현재 디렉토리 사용
if [ -z "$output_dir" ]; then
  output_dir="."
fi

# 압축 파일 이름 설정
archive_name=$(basename "$input_dir").tar.gz
output_path="$output_dir/$archive_name"

# 제외할 항목 처리
exclude_options=""
if [ -n "$exclude" ]; then
  IFS=',' read -rA exclude_array <<< "$exclude"
  for item in "${exclude_array[@]}"; do
    exclude_options="$exclude_options --exclude='$item'"
  done
fi

# 압축 명령 실행
eval "tar -czvf $output_path $exclude_options -C $input_dir ."

echo "Archive created: $output_path"