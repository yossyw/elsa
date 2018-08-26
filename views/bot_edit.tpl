{{ template "base.tpl" . }}
{{ define "content" }}
    <div class= "section">

        <h4>Bot - {{ .Bot.Description }}</h4>
        <form action="/bot/update" method="post" autocomplete="off">
            <div class="form-group">
                <label for="Name">Bot Name</label>
                <input type="text" class="form-control" name="Name" value="{{ .Bot.Name }}" readonly>
            </div>
            <div class="form-group">
                <label for="Description">Description</label>
                <input type="text" class="form-control" name="Description" value="{{ .Bot.Description }}">
            </div>
            <div class="form-group dropdown">
                <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown">
                    Add intent
                </button>
                <div id="addIntent" class="dropdown-menu">
                    {{ range .Intents }}
                        <a class="dropdown-item" href="#">{{ .Name }}</a>
                    {{ end }}
                </div>
            </div>
            <div class="form-group">
                <ul id="intentList" class="list-group">
                    {{ range .Bot.Intents }}
                        <li class="list-group-item">
                            {{ .IntentName }}
                            <input type="hidden" name="intent-{{ .IntentName }}" value="{{ .IntentName }}">
                            <button type="button" class="close">&times;</button>
                        </li>
                    {{ end }}
                </ul>
            </div>
            <hidden name="Checksum" value="{{ .Bot.Checksum }}" />
            <a href="/index" class="btn btn-danger btn-sm" role="button">Cancel</a>
            <button type="submit" class="btn btn-success btn-sm">Save</button>
        </form>

    </div>
{{ end }}

{{ define "script" }}
    <script type="text/javascript">
        $(document).on('click', '.close', function () {
            $(this).parent().remove();
        });

        $('#addIntent > a').click(function(e) {
            var intentName = $(this).text(); // Get the text of the element
            var intentList = $("#intentList"); //fields wrapper

            var listItemControl = $("<li>");
            listItemControl.addClass("list-group-item");
            listItemControl.text(intentName);

            var hiddenControl = $("<input type=\"hidden\">");
            hiddenControl.attr("name", "intent-" + intentName);
            hiddenControl.attr("value", intentName);
            listItemControl.append(hiddenControl);

            var buttonControl = $("<button>&times;</button>");
            buttonControl.addClass("close");
            listItemControl.append(buttonControl);

            $(intentList).append(listItemControl);
        });
    </script>
{{ end }}