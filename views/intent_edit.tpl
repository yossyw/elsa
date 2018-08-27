{{ template "base.tpl" . }}
{{ define "content" }}
    <div id="intentSection" class= "section">

        <h4>Edit Intent</h4>
        <form action="/intent/update" method="post" autocomplete="off">
            <div class="form-group">
                <label for="Name">Intent Name</label>
                <input type="text" class="form-control" name="Name" value="{{ .Intent.Name }}" readonly>
            </div> 
            <div id="utteranceSection" class="form-group">
                <label for="SampleUtterances">Sample Utterances</label>
                <div class="input-group placeholder">
                    <input id="utterancePlaceholder" type="text" class="form-control" placeholder="e.g. I would like to book a room" />
                    <div class="input-group-append">
                        <a id="addUtterance" href="#" class="input-group-text text-primary iconlink">
                            <i class="fas fa-fw fa-plus-circle"></i>
                        </a> 
                    </div>
                </div>
                
                {{ range $index, $value := .Intent.SampleUtterances }}
                    <div class="input-group">
                        <input name="value-{{ $index }}" type="text" class="form-control" value="{{ . }}" />
                        <a href="#" class="remove_field iconlink"><i class="fas fa-fw fa-times-circle"></i></a>
                    </div>
                {{ end }}
            </div>
            <div class="form-group">
                <label for="Slots">Slots</label>
                <div class="row">
                    <div class="col-2">Priority</div>
                    <div class="col-2">Required?</div>
                    <div class="col-2">Name</div>
                    <div class="col-2">Slot Type</div>
                    <div class="col-2">Prompt</div>
                </div>
                <div class="row table-row placeholder">
                    <div class="col-2"></div>
                    <div class="col-2">
                        <input id="slotRequiredPlaceholder" type="text" class="form-control" value="Required" readonly/>
                    </div>
                    <div class="col-2">
                        <input id="namePlaceholder" type="text" class="form-control" placeholder="e.g. FirstName"/>
                    </div>
                    <div class="col-2">                        
                        <select id="slotTypePlaceholder" class="form-control sel-placeholder">
                            <option id="placeholder" value="">e.g. AMAZON.US_FIRST_NAME</option>
                            <option id="amazonNumber" value="AMAZON.NUMBER">AMAZON.NUMBER</option>
                            <option id="amazonNumber" value="AMAZON.DATE">AMAZON.DATE</option>
                            <option id="amazonNumber" value="AMAZON.TIME">AMAZON.TIME</option>
                            <option id="amazonFirstName" value="AMAZON.US_FIRST_NAME">AMAZON.US_FIRST_NAME</option>
                            <option id="amazonLastName" value="AMAZON.US_LAST_NAME">AMAZON.US_LAST_NAME</option>
                            <option id="cardLocation" value="CardLocation">CardLocation</option>
                            <option id="carTypes" value="CardTypes">CardTypes</option>
                            <option id="dogBreeds" value="DogBreeds">DogBreeds</option>
                            <option id="flowerTypes" value="FlowerTypes">FlowerTypes</option>
                        </select>
                    </div>
                    <div class="col-2">
                        <input id="promptPlaceholder" type="text" class="form-control" placeholder="e.g. What is your first name?"/>
                    </div>
                    <div class="input-group-append">
                        <a id="addSlot" href="#" class="input-group-text text-primary iconlink">
                            <i class="fas fa-fw fa-plus-circle"></i>
                        </a> 
                    </div>
                </div>
                {{ range $index, $value := .Intent.Slots }}
                <div class="row table-row placeholder">
                    <div class="col-2">
                        <input name="priority-{{ $index }}" type="text" class="form-control" value={{ .Priority }}  readonly/>
                    </div>
                    <div class="col-2">
                        <input name="slotConstraint-{{ $index }}" type="text" class="form-control" value="{{ .SlotConstraint }}" readonly/>
                    </div>
                    <div class="col-2">
                        <input name="name-{{ $index }}" type="text" class="form-control" value="{{ .Name}}"/>
                    </div>
                    <div class="col-2">                          
                        <select name="sloType-{{ $index }}" id="slotTypePlaceholder" class="form-control sel-placeholder">
                            <option id="amazonNumber" value="AMAZON.NUMBER" {{ if compare (html .SlotType) "AMAZON.NUMBER"}}selected="selected"{{ end }}>AMAZON.NUMBER</option>
                            <option id="amazonDate" value="AMAZON.DATE" {{ if compare (html .SlotType) "AMAZON.DATE"}}selected="selected"{{ end }}>AMAZON.DATE</option>
                            <option id="amazonTime" value="AMAZON.TIME" {{ if compare (html .SlotType) "AMAZON.TIME"}}selected="selected"{{ end }}>AMAZON.TIME</option>
                            <option id="amazonFirstName" value="AMAZON.US_FIRST_NAME" {{ if compare (html .SlotType) "AMAZON.US_FIRST_NAME"}}selected="selected"{{ end }}>AMAZON.US_FIRST_NAME</option>
                            <option id="amazonLastName" value="AMAZON.US_LAST_NAME" {{ if compare (html .SlotType) "AMAZON.US_LAST_NAME"}}selected="selected"{{ end }}>AMAZON.US_LAST_NAME</option>
                            <option id="cardLocation" value="CardLocation" {{ if compare (html .SlotType) "CardLocation"}}selected="selected"{{ end }}>CardLocation</option>
                            <option id="carTypes" value="CardTypes" {{ if compare (html .SlotType) "CardTypes"}}selected="selected"{{ end }}>CardTypes</option>
                            <option id="dogBreeds" value="DogBreeds" {{ if compare (html .SlotType) "DogBreeds"}}selected="selected"{{ end }}>DogBreeds</option>
                            <option id="flowerTypes" value="FlowerTypes" {{ if compare (html .SlotType) "FlowerTypes"}}selected="selected"{{ end }}>FlowerTypes</option>                        
                        </select>
                    </div>
                    <div class="col-2">
                        <input name="prompt-{{ $index }}" type="text" class="form-control" value="{{ (index .ValueElicitationPrompt.Messages 0).Content }}"/>
                    </div>                    
                    <a href="#" class="remove_field iconlink"><i class="fas fa-fw fa-times-circle"></i></a>
                </div>
                {{ end }}                                    
            </div> 
            <hidden name="Checksum" value="{{ .Intent.Checksum }}" />          
            <a href="/intents" class="btn btn-danger btn-sm" role="button">Cancel</a>
            <button type="submit" class="btn btn-success btn-sm">Save</button>
        </form>

    </div>
{{ end }}

{{ define "script" }}
    <script type="text/javascript">
        $(document).ready(function () {
            var valueCount = 1;
            var utteranceWrapper = $("#utteranceSection"); //fields wrapper
            var addUtteranceButton = $("#addUtterance"); //add button ID
            var utterancePlaceholder = $("#utterancePlaceholder");
            
            $(addUtteranceButton).click(function(e){ //on add input button click
                e.preventDefault();
                var utterance = $(utterancePlaceholder).val();
                $(this).closest(".form-group").append('<div class="input-group">' +
                    '<input name="utterancevalue-' + valueCount + '" type="text" class="form-control" value="' + utterance + '" />' +
                    '<a href="#" class="remove_field iconlink"><i class="fas fa-fw fa-times-circle"></i></a>' +
                    '</div>');
                utterancePlaceholder.val(""); //reset placeholder value
                valueCount++;
            });

        $(utteranceWrapper).on("click",".remove_field", function(e){ //user click on remove button
            e.preventDefault(); 
            $(this).parent('div').remove();
        })
    });
    </script>
{{ end }}