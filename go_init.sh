PROJECTS_DIR="$HOME/www"
PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: $0 <project-name>"
    exit 1
fi

PROJECT_PATH="$PROJECTS_DIR/$PROJECT_NAME"

mkdir -p "$PROJECT_PATH"
cd "$PROJECT_PATH" || exit

go mod init "github.com/tegarsubkhan236/$PROJECT_NAME"

cat <<EOF > main.go
package main

import "fmt"

func main() {
    fmt.Println("Hello, $PROJECT_NAME!")
}
EOF

cat <<EOF > .gitignore
/.idea/
/.env
EOF

if command -v goland &> /dev/null; then
    goland "$PROJECT_PATH" &
else
    echo "Goland not found in PATH. Skipping open."
fi

echo "✅ Project $PROJECT_NAME created at $PROJECT_PATH"
