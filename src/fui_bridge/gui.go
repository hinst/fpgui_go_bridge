package fui_bridge

import "net"

type TGUI struct {
}

func (this *TGUI) Run() {
	addr, err := net.ResolveTCPAddr("tcp", "localhost:0")
	if err != nil {
		panic(err)
	}
}
