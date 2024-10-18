# 2024-10-19

```prompt
zsh에서 특정 디렉토리에 있는 모든 폴더, 파일을 지정한 폴더, 파일(ex: node_modules) 등을 제외하고 압축하고 싶어요.
```

zsh에서 특정 디렉토리의 내용을 압축하면서 특정 폴더나 파일을 제외하려면 tar 명령어와 --exclude 옵션을 사용할 수 있습니다. 다음은 이를 수행하는 명령어 예시입니다:

```sh
tar -czvf archive.tar.gz --exclude='node_modules' --exclude='*.log' --exclude='.git' /path/to/directory
```

1. tar: 압축 및 아카이브 생성 유틸리티
2. -czvf: 옵션 조합
  c: 새 아카이브 생성
  z: gzip을 사용하여 압축
  v: 상세 출력 (압축되는 파일 목록 표시)
  f: 아카이브 파일 이름 지정
3. archive.tar.gz: 생성될 압축 파일의 이름
4. --exclude='node_modules': node_modules 폴더 제외
5. --exclude='*.log': .log 확장자를 가진 모든 파일 제외
6. --exclude='.git': .git 폴더 제외
7. /path/to/directory: 압축할 디렉토리 경로

여러 항목을 제외하려면 --exclude 옵션을 여러 번 사용하면 됩니다. 또한 와일드카드(*)를 사용하여 패턴으로 파일이나 폴더를 제외할 수 있습니다.

이 명령어를 실행하면 지정한 디렉토리의 내용이 archive.tar.gz 파일로 압축되며, node_modules 폴더, .log 파일들, 그리고 .git 폴더는 제외됩니다.


```prompt
`zip.sh -e "node_modules,*.log,.git" -d "/path/to/directory"`나 `zip.sh -e node_modules,*.log,.git -d /path/to/directory` 를 실행하면 위의 script과 동일한 효과를 얻을 수 있도록 zip.sh을 만들어주세요
```

네, 요청하신 대로 zip.sh 스크립트를 만들어 드리겠습니다. 이 스크립트는 지정된 디렉토리의 내용을 압축하면서 특정 파일이나 폴더를 제외할 수 있습니다.

```sh
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
```

이 스크립트를 사용하려면 다음 단계를 따르세요:
스크립트를 zip.sh라는 이름으로 저장합니다.
터미널에서 chmod +x zip.sh 명령을 실행하여 스크립트를 실행 가능하게 만듭니다.
다음과 같이 스크립트를 실행합니다:

```sh
./zip.sh -e "node_modules,*.log,.git" -d "/path/to/directory"
```

또는

```sh
./zip.sh -e node_modules,*.log,.git -d /path/to/directory
```

이 스크립트는 다음과 같은 기능을 제공합니다:
-e 옵션으로 제외할 파일이나 폴더를 지정할 수 있습니다. 여러 항목은 쉼표로 구분합니다.
-d 옵션으로 압축할 디렉토리를 지정합니다.
압축 파일은 지정된 디렉토리의 이름을 따서 생성됩니다 (예: directory.tar.gz).
지정된 디렉토리의 내용만 압축되며, 디렉토리 자체는 포함되지 않습니다.
이 스크립트를 사용하면 원하는 대로 특정 파일이나 폴더를 제외하고 디렉토리를 압축할 수 있습니다.


```prompt
zip.sh 실행 옵션에
-i: 압축할 대상 디렉토리
-o: 압축파일을 저장할 디렉토리
-h: 도움말
을 추가해주세요.

그리고, zip.sh를 아무곳에서나 사용할 수 있도록 하려면 어떻게 하나요?
```


zip.sh 스크립트에 요청하신 옵션들을 추가하고, 어디서나 사용할 수 있도록 하는 방법을 설명해드리겠습니다.
먼저, 수정된 zip.sh 스크립트입니다:

```sh
startLine: 1
endLine: 58
```

이 스크립트를 어디서나 사용할 수 있도록 하려면 다음 단계를 따르세요:
1. 스크립트를 적절한 위치에 저장합니다. 일반적으로 /usr/local/bin 디렉토리가 좋은 선택입니다:


```sh
sudo cp zip.sh /usr/local/bin/
```

2. 스크립트에 실행 권한을 부여합니다:

```sh
sudo chmod +x /usr/local/bin/zip.sh
```

이제 zip.sh 스크립트를 어디서나 사용할 수 있습니다. 예를 들어, 현재 디렉토리의 내용을 압축하려면 다음 명령을 실행하세요:

```sh
zip.sh -i . -o /path/to/save/directory
```

이 명령어는 현재 디렉토리의 내용을 압축하고, 압축된 파일을 지정된 디렉토리에 저장합니다.
