package controllers

import (
	"elsa/conf"
	"encoding/json"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/service/lexmodelbuildingservice"
	"net/http"
	"strings"
)

type MainController struct {
	BaseController
}

func (this *MainController) Prepare() {
	this.BaseController.Prepare()
}

func (this *MainController) Get() {
	this.TplName = "index.tpl"

	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	input := &lexmodelbuildingservice.GetBotsInput{
		MaxResults: aws.Int64(10),
		NextToken:  aws.String(""),
	}

	result, err := svc.GetBots(input)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Data["Bots"] = result.Bots
}

func (this *MainController) Create() {
	this.TplName = "index.tpl"

	inputs := this.Input()
	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	botInput := &lexmodelbuildingservice.PutBotInput{
		Name:        aws.String(inputs.Get("Name")),
		Description: aws.String(inputs.Get("Description")),
		AbortStatement: &lexmodelbuildingservice.Statement{
			Messages: []*lexmodelbuildingservice.Message{
				{
					Content:     aws.String("I don't understand. Can you try again?"),
					ContentType: aws.String("PlainText"),
				},
				{
					Content:     aws.String("I'm sorry, I don't understand."),
					ContentType: aws.String("PlainText"),
				},
			},
		},
		ClarificationPrompt: &lexmodelbuildingservice.Prompt{
			MaxAttempts: aws.Int64(5),
			Messages: []*lexmodelbuildingservice.Message{
				{
					Content:     aws.String("I'm sorry, I didn't hear that. Can you repeate what you just said?"),
					ContentType: aws.String("PlainText"),
				},
				{
					Content:     aws.String("Can you say that again?"),
					ContentType: aws.String("PlainText"),
				},
			},
		},
		ChildDirected:   aws.Bool(false),
		Locale:          aws.String("en-US"),
		ProcessBehavior: aws.String("SAVE"),
	}

	_, err := svc.PutBot(botInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Ctx.Redirect(302, "/")
}

func (this *MainController) Update() {
	this.TplName = "bot_edit.tpl"

	inputs := this.Input()
	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	botInput := &lexmodelbuildingservice.PutBotInput{
		Name:        aws.String(inputs.Get("Name")),
		Description: aws.String(inputs.Get("Description")),
		Checksum:    aws.String(inputs.Get("Checksum")),
		AbortStatement: &lexmodelbuildingservice.Statement{
			Messages: []*lexmodelbuildingservice.Message{
				{
					Content:     aws.String("I don't understand. Can you try again?"),
					ContentType: aws.String("PlainText"),
				},
				{
					Content:     aws.String("I'm sorry, I don't understand."),
					ContentType: aws.String("PlainText"),
				},
			},
		},
		ClarificationPrompt: &lexmodelbuildingservice.Prompt{
			MaxAttempts: aws.Int64(5),
			Messages: []*lexmodelbuildingservice.Message{
				{
					Content:     aws.String("I'm sorry, I didn't hear that. Can you repeate what you just said?"),
					ContentType: aws.String("PlainText"),
				},
				{
					Content:     aws.String("Can you say that again?"),
					ContentType: aws.String("PlainText"),
				},
			},
		},
		ChildDirected:   aws.Bool(false),
		Locale:          aws.String("en-US"),
		ProcessBehavior: aws.String("SAVE"),
	}

	intents := []*lexmodelbuildingservice.Intent{}
	for key := range inputs {
		if strings.Contains(key, "intent-") {
			intent := &lexmodelbuildingservice.Intent{
				IntentName:    aws.String(inputs.Get(key)),
				IntentVersion: aws.String("$LATEST"),
			}

			intents = append(intents, intent)
		}
	}

	if len(intents) > 0 {
		botInput.Intents = intents
	}

	_, err := svc.PutBot(botInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Ctx.Redirect(302, "/")
}

func (this *MainController) View() {
	this.TplName = "bot_edit.tpl"

	id := this.Ctx.Input.Param(":id")
	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	getBotInput := &lexmodelbuildingservice.GetBotInput{
		Name:           aws.String(id),
		VersionOrAlias: aws.String("$LATEST"),
	}

	getBotOutput, err := svc.GetBot(getBotInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	getIntentsInput := &lexmodelbuildingservice.GetIntentsInput{
		MaxResults: aws.Int64(10),
		NextToken:  aws.String(""),
	}

	getIntentsOutput, err := svc.GetIntents(getIntentsInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Data["Bot"] = getBotOutput
	this.Data["Intents"] = getIntentsOutput.Intents
}

func (this *MainController) Delete() {
	this.TplName = "index.tpl"

	id := this.Ctx.Input.Param(":id")
	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	botInput := &lexmodelbuildingservice.DeleteBotInput{
		Name: aws.String(id),
	}

	_, err := svc.DeleteBot(botInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Ctx.Redirect(302, "/")
}

func (this *MainController) Build() {
	this.TplName = "index.tpl"

	id := this.Ctx.Input.Param(":id")
	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	getBotInput := &lexmodelbuildingservice.GetBotInput{
		Name:           aws.String(id),
		VersionOrAlias: aws.String("$LATEST"),
	}

	getBotOutput, err := svc.GetBot(getBotInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	putBotInput := &lexmodelbuildingservice.PutBotInput{
		Name:                getBotOutput.Name,
		Description:         getBotOutput.Description,
		Checksum:            getBotOutput.Checksum,
		AbortStatement:      getBotOutput.AbortStatement,
		ClarificationPrompt: getBotOutput.ClarificationPrompt,
		ChildDirected:       getBotOutput.ChildDirected,
		Locale:              getBotOutput.Locale,
		Intents:             getBotOutput.Intents,
		VoiceId:             getBotOutput.VoiceId,
		ProcessBehavior:     aws.String("BUILD"),
	}

	_, err = svc.PutBot(putBotInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	this.Ctx.Redirect(302, "/")
}

func (this *MainController) GetDetailJSON() {
	id := this.Ctx.Input.Param(":id")
	sess := config.NewAwsSession()
	svc := lexmodelbuildingservice.New(sess)
	getBotInput := &lexmodelbuildingservice.GetBotInput{
		Name:           aws.String(id),
		VersionOrAlias: aws.String("$LATEST"),
	}

	getBotOutput, err := svc.GetBot(getBotInput)
	if err != nil {
		this.Data["Errors"] = err.Error()
		return
	}

	getBotOutputJSON, err := json.Marshal(getBotOutput)
	if err != nil {
		this.Data["Errors"] = err.Error()
	}

	this.Ctx.ResponseWriter.Header().Set("Content-Type", "application/json")
	this.Ctx.ResponseWriter.WriteHeader(http.StatusOK)
	this.Ctx.ResponseWriter.Write(getBotOutputJSON)
}
