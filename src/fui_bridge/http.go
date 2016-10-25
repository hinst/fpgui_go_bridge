package fui_bridge

import "net"

func GetAvailablePort() int {
	addr, err := net.ResolveTCPAddr("tcp", "localhost:0")
	if err != nil {
		panic(err)
	}
	return addr.Port
}
