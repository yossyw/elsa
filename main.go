package main

import (
	"elsa/conf"
	_ "elsa/routers"
	"github.com/astaxie/beego"
)

func main() {
	config.LoadGlobalConfig()
	beego.Run()
}
