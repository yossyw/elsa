{{ template "base.tpl" . }}
{{ define "content" }}
    <div id="slotSection" class= "section">

        <h4>Slot Type - {{ .Slot.Description }}</h4>
        <form action="/slot/update" method="post" autocomplete="off">
            <div class="form-group">
                <label for="Name">Name</label>
                <input type="text" class="form-control" name="Name" value="{{ .Slot.Name }}" readonly>
            </div>
            <div class="form-group">
                <label for="Description">Description</label>
                <input type="text" class="form-control" name="Description" value="{{ .Slot.Description }}">
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
                {{ range $index, $value := .Slot.EnumerationValues }}
                    <div class="input-group">
                        <input name="value-{{ $index }}" type="text" class="form-control" value="{{ $value.Value }}" />
                        <a href="#" class="remove_field iconlink"><i class="fas fa-fw fa-times-circle"></i></a>
                    </div>
                {{ end }}
            </div>
            <hidden name="Checksum" value="{{ .Slot.Checksum }}" />
            <a href="/slot/list" class="btn btn-danger btn-sm" role="button">Cancel</a>
            <button type="submit" class="btn btn-success btn-sm">Save</button>
        </form>

    </div>
{{ end }}

{{ define "script" }}
    <script type="text/javascript">
        $(document).ready(function () {
            var valueCount = 1;
            var slotWrapper = $("#slotSection"); //fields wrapper
            var addValueButton = $("#addValue"); //add button ID
            var valuePlaceholder = $("#valuePlaceholder");
            
            $(addValueButton).click(function(e){ //on add input button click
                e.preventDefault();
                var slotValue = $(valuePlaceholder).val();
                $(this).closest(".form-group").append('<div class="input-group">' +
                    '<input name="value-' + valueCount + '" type="text" class="form-control" value="' + slotValue + '" />' +
                    '<a href="#" class="remove_field iconlink"><i class="fas fa-fw fa-times-circle"></i></a>' +
                    '</div>');
                valuePlaceholder.val(""); //reset placeholder value
                valueCount++;
            });

        $(slotWrapper).on("click",".remove_field", function(e){ //user click on remove button
            e.preventDefault(); 
            $(this).parent('div').remove();
        })
    });
    </script>
{{ end }}