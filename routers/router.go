package routers

import (
	"elsa/controllers"
	"github.com/astaxie/beego"
)

func init() {
	beego.Router("/", &controllers.MainController{})
	beego.Router("/index", &controllers.MainController{})
	beego.Router("/bot/create", &controllers.MainController{}, "post:Create")
	beego.Router("/bot/update", &controllers.MainController{}, "post:Update")
	beego.Router("/bot/delete/:id", &controllers.MainController{}, "get:Delete")
	beego.Router("/bot/view/:id", &controllers.MainController{}, "get:View")
	beego.Router("/bot/api/get/:id", &controllers.MainController{}, "get:GetDetailJSON")
	beego.Router("/bot/build/:id", &controllers.MainController{}, "get:Build")
	beego.Router("/slot/list", &controllers.SlotTypeController{}, "get:List")
	beego.Router("/slot/create", &controllers.SlotTypeController{}, "post:Create")
	beego.Router("/slot/update", &controllers.SlotTypeController{}, "post:Update")
	beego.Router("/slot/delete/:id", &controllers.SlotTypeController{}, "get:Delete")
	beego.Router("/slot/view/:id", &controllers.SlotTypeController{}, "get:View")
	beego.Router("/intents", &controllers.IntentsController{})
	beego.Router("/intent/create", &controllers.IntentsController{}, "post:Create")
	beego.Router("/intent/delete/:id", &controllers.IntentsController{}, "get:Delete")
	beego.Router("/intent/view/:id", &controllers.IntentsController{}, "get:View")
	beego.Router("/call/list", &controllers.CallLogController{}, "get:List")
	beego.Router("/call/view", &controllers.CallLogController{}, "get:View")
}
