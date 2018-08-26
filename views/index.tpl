{{ template "base.tpl" . }}
{{ define "content" }}
    <div class="section">
        <h4>Bots</h4>
        <p><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#addBot">Create <i class="fas fa-plus"></i></button></p>
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>Bot Name</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            {{ range .Bots}}
            <tr>
                <td>{{ .Name }}</td>
                <td>{{ .Description }}</td>
                <td>
                    {{ .Status }}
                    {{ if compare (html .Status) "FAILED" }}
                        <a id="failure" href="#" data-toggle="popover" data-trigger="focus" onclick="getFailureReason(this, {{ .Name }})">
                            <i class="fas fa-exclamation-circle text-danger"></i>
                        </a>
                    {{ end }}
                </td>
                <td>
                    <button type="button" class="btn btn-primary btn-sm" onclick="document.location.href='/bot/view/{{ .Name }}';"><i class="fas fa-edit"></i> Edit</button>
                    <div class="btn-group">
                        <button type="button" class="btn btn-secondary btn-sm dropdown-toggle dropdown-toggle-split" data-toggle="dropdown"></button>
                        <div class="dropdown-menu dropdown-menu-right">
                            {{ if not (compare (html .Status) "BUILDING") }}
                                <a class="dropdown-item" href="/bot/build/{{ .Name }}"><i class="fas fa-gavel"></i> Build</a>
                            {{ end }}
                            <a class="dropdown-item" href="/bot/delete/{{ .Name }}" data-toggle="confirmation"
                                data-btn-ok-label="OK" data-btn-ok-class="btn-success"
                                data-btn-cancel-label="Cancel" data-btn-cancel-class="btn-danger"
                                data-title="Are you sure?" data-content="This record will be removed">
                                <i class="fas fa-trash-alt"></i> Delete
                            </a>
                        </div>
                    </div>
                </td>
            </tr>
            {{ end }}
            </tbody>
        </table>
    </div>

    <div class="modal" id="addBot">
        <form action="/bot/create" method="post" autocomplete="off">
            <div class="modal-dialog">
                <div class="modal-content">
            
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">Create your bot</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">                        
                        <div class="form-group">
                            <label for="Name">Bot name</label>
                            <input type="text" class="form-control" placeholder="e.g. Reservation" name="Name">
                        </div>
                        <div class="form-group">
                            <label for="Description">Description</label>
                            <input type="text" class="form-control" name="Description">
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
{{ define "script" }}
    <script type="text/javascript">
        function getFailureReason(element, id) {
            $.getJSON("/bot/api/get/" + id, function( data, status ) {
                if (status === "success") {
                    $(element).attr("title", "Failure Reason");
                    $(element).attr("data-content", data.FailureReason);
                    $(element).attr("data-shown", "true");
                    $(element).popover("show");
                }
            });
        }
    </script>
{{ end }}