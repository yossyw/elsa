{{ template "base.tpl" . }}
{{ define "content" }}
    <div class="section">
        <h4>Intents</h4>
        <p><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#createIntent">Create <i class="fas fa-plus"></i></button></p>
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>Intent</th>
                    <th>Create Date</th>
                    <th>Last Updated</th>
                    <th>Version</th>
                    <th>Action</th>                    
                </tr>
            </thead>
            <tbody>
            {{range .Intents}}
            <tr>
                <td>{{ .Name }}</td>  
                <td>{{ .CreatedDate }}</td>
                <td>{{ .LastUpdatedDate }}</td>
                <td>{{ .Version}}</td>             
                <td>
                    <input type="button" class="btn btn-secondary btn-sm" value="Edit" onclick="document.location.href='/intent/view/{{ .Name }}';">
                    <input type="button" class="btn btn-secondary btn-sm" value="Delete" onclick="document.location.href='/intent/delete/{{ .Name }}';">
                </td>
            </tr>
            {{ end }}
            </tbody>
        </table>
    </div>

    <div class="modal" id="createIntent">
        <form action="/intent/create" method="post" autocomplete="off">
            <div class="modal-dialog">
                <div class="modal-content">
            
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">Add new intent</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">                        
                        <div class="form-group">
                            <label for="Name">Give a unique name for the new intent</label>
                            <input type="text" class="form-control" placeholder="e.g. ReserveRoom" name="IntentName">
                        </div>                        
                    </div>
                
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-success btn-sm">Create</button>
                    </div>
            
                </div>
            </div>
        </form>
    </div> 
{{ end }}