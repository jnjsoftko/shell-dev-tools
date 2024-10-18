## zip

```sh
tar -czvf archive.tar.gz --exclude='node_modules' --exclude='*.log' --exclude='.git' /path/to/directory
```

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
```