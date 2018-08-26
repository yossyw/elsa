package controllers

import (
	"elsa/conf"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/service/lexmodelbuildingservice"
	"strings"
)

type SlotTypeController struct {
	BaseController
}

func (this *SlotTypeController) Prepare() {
	this.BaseController.Prepare()
}

func (this *SlotTypeController) List() {
	this.TplName = "slot_type.tpl"

	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	input := &lexmodelbuildingservice.GetSlotTypesInput{
		MaxResults: aws.Int64(50),
		NextToken:  aws.String(""),
	}

	result, err := svc.GetSlotTypes(input)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Data["SlotTypes"] = result.SlotTypes
}

func (this *SlotTypeController) Create() {
	this.TplName = "slot_type.tpl"

	inputs := this.Input()
	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	slotInput := &lexmodelbuildingservice.PutSlotTypeInput{
		Name:        aws.String(inputs.Get("Name")),
		Description: aws.String(inputs.Get("Description")),
	}

	slotValues := []*lexmodelbuildingservice.EnumerationValue{}
	for key := range inputs {
		if strings.Contains(key, "value-") {
			slotValue := &lexmodelbuildingservice.EnumerationValue{
				Value: aws.String(inputs.Get(key)),
			}

			slotValues = append(slotValues, slotValue)
		}
	}

	if len(slotValues) > 0 {
		slotInput.EnumerationValues = slotValues
	}

	_, err := svc.PutSlotType(slotInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Ctx.Redirect(302, "/slot/list")
}

func (this *SlotTypeController) Update() {
	this.TplName = "slot_type_edit.tpl"

	inputs := this.Input()
	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	slotInput := &lexmodelbuildingservice.PutSlotTypeInput{
		Name:        aws.String(inputs.Get("Name")),
		Description: aws.String(inputs.Get("Description")),
		Checksum:    aws.String(inputs.Get("Checksum")),
	}

	slotValues := []*lexmodelbuildingservice.EnumerationValue{}
	for key := range inputs {
		if strings.Contains(key, "value-") {
			slotValue := &lexmodelbuildingservice.EnumerationValue{
				Value: aws.String(inputs.Get(key)),
			}

			slotValues = append(slotValues, slotValue)
		}
	}

	if len(slotValues) > 0 {
		slotInput.EnumerationValues = slotValues
	}

	_, err := svc.PutSlotType(slotInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Ctx.Redirect(302, "/slot/list")
}

func (this *SlotTypeController) View() {
	this.TplName = "slot_edit.tpl"

	id := this.Ctx.Input.Param(":id")
	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	getSlotInput := &lexmodelbuildingservice.GetSlotTypeInput{
		Name:    aws.String(id),
		Version: aws.String("$LATEST"),
	}

	getSlotOutput, err := svc.GetSlotType(getSlotInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Data["Slot"] = getSlotOutput
}

func (this *SlotTypeController) Delete() {
	this.TplName = "slot_type.tpl"

	id := this.Ctx.Input.Param(":id")
	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	slotInput := &lexmodelbuildingservice.DeleteSlotTypeInput{
		Name: aws.String(id),
	}

	_, err := svc.DeleteSlotType(slotInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Ctx.Redirect(302, "/slot/list")
}
