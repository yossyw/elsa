package controllers

type CallLogController struct {
	BaseController
}

func (this *CallLogController) Prepare() {
	this.BaseController.Prepare()
}

func (this *CallLogController) List() {
	this.TplName = "call_log.tpl"
}

func (this *CallLogController) View() {
	this.TplName = "call_view.tpl"
}
