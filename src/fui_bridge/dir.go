package fui_bridge

import (
	"os"
	"path/filepath"
)

var appDir, _ = filepath.Abs(filepath.Dir(os.Args[0]))
