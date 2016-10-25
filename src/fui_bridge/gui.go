package fui_bridge

import (
	"net/http"
	"os/exec"
	"strconv"
)

type TGUI struct {
	// FPGUI app is the server
	GUIServerPort int
	// This app is the client
	GUIClientPort int
	guiCommand    *exec.Cmd
}

func (this *TGUI) Run() {
	this.GUIServerPort = GetAvailablePort()
	this.GUIClientPort = GetAvailablePort()
	this.guiCommand = exec.Command(appDir+"/gui_app.exe", strconv.Itoa(this.GUIServerPort), strconv.Itoa(this.GUIClientPort))
	this.guiCommand.Start()
	http.ListenAndServe(":"+strconv.Itoa(this.GUIClientPort), this)
}

func (this *TGUI) ServeHTTP(response http.ResponseWriter, request *http.Request) {
}
