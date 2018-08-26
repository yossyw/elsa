package controllers

import (
	"elsa/conf"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/service/lexmodelbuildingservice"
)

type IntentsController struct {
	BaseController
}

func (this *IntentsController) Get() {
	this.TplName = "intents.tpl"

	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	input := &lexmodelbuildingservice.GetIntentsInput{
		MaxResults: aws.Int64(10),
		NextToken:  aws.String(""),
	}

	result, err := svc.GetIntents(input)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Data["Intents"] = result.Intents
}

func (this *IntentsController) Create() {
	this.TplName = "index.tpl"

	inputs := this.Input()
	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	intentInput := &lexmodelbuildingservice.PutIntentInput{
		Name:  aws.String(inputs.Get("IntentName")),
	}

	_, err := svc.PutIntent(intentInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Ctx.Redirect(302, "/intents")
}

func (this *IntentsController) View() {
	this.TplName = "intent_edit.tpl"

	id := this.Ctx.Input.Param(":id")
	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	getIntentInput := &lexmodelbuildingservice.GetIntentInput{
		Name:       aws.String(id),
		Version: 	aws.String("$LATEST"),
	}

	getIntentOutput, err := svc.GetIntent(getIntentInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Data["Intent"] = getIntentOutput
}

func (this *IntentsController) Delete() {
	this.TplName = "intents.tpl"

	id := this.Ctx.Input.Param(":id")
	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	deleteIntentInput := &lexmodelbuildingservice.DeleteIntentInput{
		Name: aws.String(id),
	}

	_, err := svc.DeleteIntent(deleteIntentInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Ctx.Redirect(302, "/intents")
}