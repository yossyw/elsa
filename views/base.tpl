<!DOCTYPE html>

<html>
<head>
    <title>Elsa</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="shortcut icon" href="/static/img/favicon.png" />

    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous" />
    <!-- Our Custom CSS -->
    <link rel="stylesheet" href="/static/css/style.css" />

    {{ block "css" . }}{{ end }}

    <!-- jQuery CDN - Slim version (=without AJAX) -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <!-- Popper.JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-confirmation2/dist/bootstrap-confirmation.min.js"></script>

    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>

    <!-- Our JS -->
    <script src="/static/js/base.js"></script>
</head>

<body>
    <div class="wrapper">

        <!-- Sidebar -->
        <nav id="sidebar" class="{{ .SideBarClass }}">
            <div class="sidebar-header">
                <img class="img-fluid logo" src="/static/img/logo-w-s.png" alt="Elsa">
                <img class="img-fluid logo-small" src="/static/img/logoi-w-s.png" alt="Elsa">
            </div>

            <ul class="list-unstyled components">
                <li>
                    <a href="/index">
                        <i class="fas fa-robot"></i>
                        <span>Bots</span>
                    </a>
                </li>
                <li>
                    <a href="/intents">
                        <i class="fas fa-bullseye"></i>
                        <span>Intents</span>
                    </a>
                </li>
                <li>
                    <a href="/slot/list">
                        <i class="fas fa-list-ul"></i>
                        <span>Slot Types</span>
                    </a>
                </li>
                <li>
                    <a href="/call/list">
                        <i class="fas fa-phone"></i>
                        <span>Calls Log</span>
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Page Content -->
        <div id="content">            
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">      
                    <a id="sidebar-toogle" href="#">
                        <i class="fas fa-bars"></i>                        
                    </a>

                    <div class="navbar-right dropdown">
                        <img src="/static/img/profpic.jpg" class="user-profile" />
                        <span>
                        <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                            John Doe
                        </a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Sign Out</a>
                        </div>
                        </span>
                    </div>      
                </div>
            </nav>
            {{ if .Errors }}
            <p id="error-container">
                <span>{{ .Errors }}</span>
            </p>
            {{ end }}

            {{ block "content" . }}{{ end }}
        </div>
    
    </div>

    {{ block "script" . }}{{ end }}
</body>
</html>