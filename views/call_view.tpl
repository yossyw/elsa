{{ template "base.tpl" . }}
{{ define "content" }}
    <div class="section">
        <h4>Call Log</h4>
        <div class="chat-container">
            <img src="/static/img/favicon.png" alt="Avatar">
            <div class="float-left">
                <strong>Elsa</strong>
                <p>Hello. You are speaking to Elsa. How may I assist you?</p>
            </div>
            <span class="time time-right"><i class="fas fa-clock"></i> 11:00 AM</span>
        </div>

        <div class="chat-container darker">
            <img src="/static/img/wonder-women-50.png" alt="Avatar" class="right">
            <div class="float-right text-right">
                <strong>+62819555222</strong>
                <p>I lost my card.</p>
            </div>
            <span class="time time-left"><i class="fas fa-clock"></i> 11:01 AM</span>
        </div>

        <div class="chat-container">
            <img src="/static/img/favicon.png" alt="Avatar">
            <div class="float-left">
                <strong>Elsa</strong>
                <p>Sorry to hear that. Can I have your name please?</p>
            </div>
            <span class="time time-right"><i class="fas fa-clock"></i> 11:02 AM</span>
        </div>

        <div class="chat-container darker">
            <img src="/static/img/wonder-women-50.png" alt="Avatar" class="right">
            <div class="float-right text-right">
                <strong>+62819555222</strong>
                <p>My name is Diana.</p>
            </div>
            <span class="time time-left"><i class="fas fa-clock"></i> 11:05 AM</span>
        </div>

        <div class="chat-container">
            <img src="/static/img/favicon.png" alt="Avatar">
            <div class="float-left">
                <strong>Elsa</strong>
                <p>Can I have your account number please?</p>
            </div>
            <span class="time time-right"><i class="fas fa-clock"></i> 11:06 AM</span>
        </div>

        <div class="chat-container darker">
            <img src="/static/img/wonder-women-50.png" alt="Avatar" class="right">
            <div class="float-right text-right">
                <strong>+62819555222</strong>
                <p>My account number is 8010193065.</p>
            </div>
            <span class="time time-left"><i class="fas fa-clock"></i> 11:08 AM</span>
        </div>

        <div class="chat-container">
            <img src="/static/img/favicon.png" alt="Avatar">
            <div class="float-left">
                <strong>Elsa</strong>
                <p>Thank you. Do you want a card replacement?</p>
            </div>
            <span class="time time-right"><i class="fas fa-clock"></i> 11:10 AM</span>
        </div>

        <div class="chat-container darker">
            <img src="/static/img/wonder-women-50.png" alt="Avatar" class="right">
            <div class="float-right text-right">
                <strong>+62819555222</strong>
                <p>Yes, please.</p>
            </div>
            <span class="time time-left"><i class="fas fa-clock"></i> 11:11 AM</span>
        </div>

        <div class="chat-container">
            <img src="/static/img/favicon.png" alt="Avatar">
            <div class="float-left">
                <strong>Elsa</strong>
                <p>Do you want your new card to be sent to your house or office?</p>
            </div>
            <span class="time time-right"><i class="fas fa-clock"></i> 11:12 AM</span>
        </div>

        <div class="chat-container darker">
            <img src="/static/img/wonder-women-50.png" alt="Avatar" class="right">
            <div class="float-right text-right">
                <strong>+62819555222</strong>
                <p>To my house, please.</p>
            </div>
            <span class="time time-left"><i class="fas fa-clock"></i> 11:14 AM</span>
        </div>

        <div class="chat-container">
            <img src="/static/img/favicon.png" alt="Avatar">
            <strong>Elsa</strong>
            <span class="time time-right"><i class="fas fa-clock"></i> 11:15 AM</span>
            <p>OK. Your request is confirmed. Your new card will be sent to your home address. Thank you for calling and have a good day.</p>
        </div>

        <button type="button" class="btn btn-secondary btn-sm" onclick="history.go(-1);">Back</button>
    </div>
{{ end }}