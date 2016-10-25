package fui_bridge

import (
	"fmt"
	"net"
	"net/http"
	"os/exec"
	"strconv"
	"time"
)

type TGUI struct {
	// FPGUI app is the server
	GUIServerPort int
	// This app is the client
	GUIClientPort int
	guiCommand    *exec.Cmd
	Active        bool
	Server        *http.Server
}

func (this *TGUI) Run() {
	this.GUIServerPort = GetAvailablePort()
	this.GUIClientPort = GetAvailablePort()
	this.StartServer()
	this.guiCommand = exec.Command(appDir+"/gui_app.exe", strconv.Itoa(this.GUIClientPort))
	this.guiCommand.Start()
	this.Active = true
	for {
		time.Sleep(10)
	}
}

func (this *TGUI) ServeHTTP(response http.ResponseWriter, request *http.Request) {
	if request.URL.Path == "/log" {
		fmt.Println("GSL: " + request.URL.Query().Get("text"))
	}
}

func (this *TGUI) StartServer() bool {
	this.Server = &http.Server{}
	var result = false
	var listener, listenerResult = net.Listen("tcp4", "localhost:0")
	if listenerResult == nil {
		this.GUIClientPort = listener.Addr().(*net.TCPAddr).Port
		this.Server.Handler = this
		go this.Server.Serve(listener)
		result = true
	}
	return result
}
