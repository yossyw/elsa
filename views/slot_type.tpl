{{ template "base.tpl" . }}
{{ define "content" }}
    <div class="section">
        <h4>Slot Types</h4>
        <p><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#addSlotType">Add <i class="fas fa-plus"></i></button></p>
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            {{ range .SlotTypes}}
            <tr>
                <td>{{ .Name }}</td>
                <td>{{ .Description }}</td>                
                <td>
                    <button type="button" class="btn btn-primary btn-sm" onclick="document.location.href='/slot/view/{{ .Name }}';"><i class="fas fa-edit"></i> Edit</button>
                    <a class="btn btn-secondary btn-sm" href="/slot/delete/{{ .Name }}"
                        data-toggle="confirmation" data-btn-ok-label="OK" data-btn-ok-class="btn-success"
                        data-btn-cancel-label="Cancel" data-btn-cancel-class="btn-danger"
                        data-title="Are you sure?" data-content="This record will be removed">
                        <i class="fas fa-trash-alt"></i> Delete
                    </a>
                </td>
            </tr>
            {{ end }}
            </tbody>
        </table>
    </div>

    <div class="modal" id="addSlotType">
        <form action="/slot/create" method="post" autocomplete="off">
            <div class="modal-dialog">
                <div class="modal-content">
            
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">Add slot type</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">                        
                        <div class="form-group">
                            <label for="slotTypeName">Name</label>
                            <input type="text" class="form-control" placeholder="e.g. CarTypes" name="Name">
                        </div>
                        <div class="form-group">
                            <label for="description">Description</label>
                            <input type="text" class="form-control" placeholder="e.g. Available car types" name="Description">
                        </div>
                        <div class="form-group">
                            <label for="slotValue">Value</label>
                            <a href="#" data-toggle="tooltip" title="Values are representative sample. A comprehensive list is not required">
                                <i class="fas fa-info-circle"></i>
                            </a>
                            <div class="input-group placeholder">
                                <input id="valuePlaceholder" type="text" class="form-control" placeholder="e.g. Small" />
                                <div class="input-group-append">
                                    <a id="addValue" href="#" class="input-group-text text-primary iconlink">
                                        <i class="fas fa-fw fa-plus-circle"></i>
                                    </a> 
                                </div>
                            </div>
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
        $(document).ready(function () {
            var valueCount = 1;
            var addValueButton = $("#addValue"); //add button ID
            var valuePlaceholder = $("#valuePlaceholder");
            
            $(addValueButton).click(function(e){ //on add input button click
                e.preventDefault();
                var slotValue = $(valuePlaceholder).val();
                $(this).closest(".form-group").append('<div class="input-group">' +
                    '<input name="value-' + valueCount + '" type="text" class="form-control" value="' + slotValue + '" />' +
                    '<a href="#" class="remove_field iconlink" onclick="removeValue(this);"><i class="fas fa-fw fa-times-circle"></i></a>' +
                    '</div>');
                valuePlaceholder.val(""); //reset placeholder value
                valueCount++;
            });
        });

        function removeValue(e) {
            $(e).closest(".input-group").remove();
        }
    </script>
{{ end }}