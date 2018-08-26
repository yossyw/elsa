{{ template "base.tpl" . }}
{{ define "content" }}
    <div class="section">
        <h4>Calls Log</h4>
        <table class="table table-hover">
            <thead>
            <tr>
                <th>Bot</th>
                <th>Intent</th>
                <th>Phone Number</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Bank Customer Service</td>
                <td>Card Replacement</td>
                <td>+6281932XXXX</td>
                <td>
                    <a href="/call/view" class="btn btn-primary btn-sm" role="button">View</a>                            
                </td>
            </tr>                  
            </tbody>
        </table>
    </div>
{{ end }}