package controllers

import (
	"github.com/astaxie/beego"
)

type BaseController struct {
	beego.Controller
}

func (this *BaseController) Prepare() {
	this.Data["SideBarClass"] = GetSideBarClass(this)
}

func GetSideBarClass(this *BaseController) string {
	// read cookie
	return this.Ctx.GetCookie("sidebar")
}
