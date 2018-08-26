{{ template "base.tpl" . }}
{{ define "content" }}
    <div class= "section">

        <h4>Edit Intent</h4>
        <form action="/intent/update" method="post" autocomplete="off">
            <div class="form-group">
                <label for="Name">Intent Name</label>
                <input type="text" class="form-control" name="Name" value="{{ .Intent.Name }}" readonly>
            </div> 
            <div class="form-group">
                <label for="SampleUtterances">Sample Utterances</label>
                {{ range .Intent.SampleUtterances }}
                <input type="text" class="form-control" value="{{ . }}">
                {{ end }}
            </div>
            <div class="form-group">
                <label for="Slots">Slots</label>
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Priority</th>
                            <th>Required?</th>
                            <th>Name</th>
                            <th>Slot Type</th>
                            <th>Prompt</th>
                        </tr>
                    </thead>
                    <tbody>
                    {{ range .Intent.Slots}}
                        <tr>
                            <td>{{ .Priority }}</td>
                            <td>{{ .SlotConstraint }}</td>
                            <td>{{ .Name }}</td>
                            <td>{{ .SlotType }}</td>
                            <td>{{ (index .ValueElicitationPrompt.Messages 0).Content }}</td>
                        </tr>
                    {{ end }}
                    </tbody>
                </table>               
            </div>           
            <a href="/intents" class="btn btn-danger btn-sm" role="button">Cancel</a>
            <button type="submit" class="btn btn-success btn-sm">Save</button>
        </form>

    </div>
{{ end }}
