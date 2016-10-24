package fui_bridge

import (
	"os/exec"
	"strconv"
)

type TGUI struct {
	guiCommand *exec.Cmd
}

func (this *TGUI) Run() {
	this.guiCommand = exec.Command(appDir+"/gui_app.exe", strconv.Itoa(getAvailablePort()))
	this.guiCommand.Start()
}
