<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kopo.poly.util.CmmUtil"%>
<%
    // 채팅방 명
    String roomname = CmmUtil.nvl(request.getParameter("roomname"));

    // 채팅방 입장전 입력한 별명
    String nickname = CmmUtil.nvl(request.getParameter("nickname"));
%>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title><%=roomname%> 채팅방 입장 </title>
    <script src="/js/jquery-3.6.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        let data = {} // 전송 데이터(JSON)
        let ws; // 웹소켓 객체
        const roomname = "<%=roomname%>"; // 채팅방 이름
        const nickname = "<%=nickname%>"; // 채팅유저 이름

        $(document).ready(function () {

            let btnSend = document.getElementById("btnSend");
            btnSend.onclick = function () {
                send(); //Send 버튼 누르면, Send함수 호출하기
            }

            //웹소켓 객체를 생성하는중
            console.log("openSocket");
            if (ws !== undefined && ws.readyState !== WebSocket.CLOSED) {
                console.log("WebSocket is already opened.");
                return;

            }

            // 접속 URL 예 : ws://localhost:10000/ws/테스트방/별명
            ws = new WebSocket("ws://" + location.host + "/ws/" + roomname + "/" + nickname);

            // ws = new WebSocket("ws://" + location.host + "/ws/DS/DFGHG");
            // 웹소켓 열기
            ws.onopen = function (event) {
                if (event.data === undefined)
                    return;
                console.log(event.data)
            };


            //웹소캣으로부터 메세지를 받을 때마다 실행됨
            ws.onmessage = function (msg) {

                // 웹소켓으로부터 받은 데이터를 JSON 구조로 변환하기
                let data = JSON.parse(msg.data);

                if (data.name === nickname) { // 내가 발송한 채팅 메시지는 파란색 글씩
                    $("#chat").append("<div>");
                    $("#chat").append("<span style='color: blue'><b>[보낸 사람] : </b></span>");
                    $("#chat").append("<span style='color: blue'> 나 </span>");
                    $("#chat").append("<span style='color: blue'><b>[발송 메시지] : </b></span>");
                    $("#chat").append("<span style='color: blue'>" + data.msg + " </span>");
                    $("#chat").append("<span style='color: blue'><b>[발송시간] : </b></span>");
                    $("#chat").append("<span style='color: blue'>" + data.date + " </span>");
                    $("#chat").append("</div>");

                } else if (data.name === "관리자") { // 관리자가 발송한 채팅 메시지는 빨간색 글씩
                    $("#chat").append("<div>");
                    $("#chat").append("<span style='color: red'><b>[보낸 사람] : </b></span>");
                    $("#chat").append("<span style='color: red'>" + data.name + "</span>");
                    $("#chat").append("<span style='color: red'><b>[발송 메시지] : </b></span>");
                    $("#chat").append("<span style='color: red'>" + data.msg + " </span>");
                    $("#chat").append("<span style='color: red'><b>[발송시간] : </b></span>");
                    $("#chat").append("<span style='color: red'>" + data.date + " </span>");
                    $("#chat").append("</div>");

                } else {
                    $("#chat").append("<div>"); // 그 외 채팅참여자들이 발송한 채팅 메시지는 검정색
                    $("#chat").append("<span><b>[보낸 사람] : </b></span>");
                    $("#chat").append("<span>" + data.name + " </span>");
                    $("#chat").append("<span><b>[수신 메시지] : </b></span>");
                    $("#chat").append("<span>" + data.msg + " </span>");
                    $("#chat").append("<span><b>[발송시간] : </b></span>");
                    $("#chat").append("<span>" + data.date + " </span>");
                    $("#chat").append("</div>");
                }
            }
        });

        // 채팅 메시지 보내기
        function send() {

            let msgObj = $("#msg"); // Object

            if (msgObj.value !== "") {
                data.name = nickname; // 별명
                data.msg = msgObj.val();  // 입력한 메시지

                // 데이터 구조를 JSON 형태로 변경하기
                let temp = JSON.stringify(data);

                // 채팅 메시지 전송하기
                ws.send(temp);
            }

            // 채팅 메시지 전송 후, 입력한 채팅내용 지우기
            msgObj.val("");
        }

    </script>

    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/css/sb-admin-2.min.css" rel="stylesheet">


</head>
<body>
<div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

        <!-- Sidebar - Brand -->
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/sports/main">
            <div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-laugh-wink"></i>
            </div>
            <div class="sidebar-brand-text mx-3">Sports Rev</div>
        </a>

        <!-- Divider -->
        <hr class="sidebar-divider my-0">

        <!-- Nav Item - Dashboard -->
        <li class="nav-item active">
            <a class="nav-link" href="/sports/main">
                <i class="fas fa-fw fa-tachometer-alt"></i>
                <span>MAIN</span></a>
        </li>

        <!-- Divider -->
        <hr class="sidebar-divider">

        <!-- Heading -->
        <div class="sidebar-heading">
            MENU
        </div>

        <!-- Nav Item - Pages Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
               aria-expanded="true" aria-controls="collapseTwo">
                <i class="fas fa-fw fa-cog"></i>
                <span>체육 센터</span>
            </a>
            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">체육 센터</h6>
                    <a class="collapse-item" href="/sports/apimain">센터 목록</a>
                    <a class="collapse-item" href="/sports/program">구민체육센터 프로그램</a>
                </div>
            </div>
        </li>

        <!-- Nav Item - Utilities Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
               aria-expanded="true" aria-controls="collapseUtilities">
                <i class="fas fa-fw fa-wrench"></i>
                <span>커뮤니티</span>
            </a>
            <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
                 data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">커뮤니티</h6>
                    <a class="collapse-item" href="/notice/noticeList">공지사항</a>
                    <a class="collapse-item" href="/chat/intro">채팅방</a>
                </div>
            </div>
        </li>

        <!-- Divider -->
        <hr class="sidebar-divider">

        <!-- Heading -->
        <div class="sidebar-heading">
            환경설정
        </div>

        <!-- Nav Item - Pages Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
               aria-expanded="true" aria-controls="collapsePages">
                <i class="fas fa-fw fa-folder"></i>
                <span>설정</span>
            </a>
            <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">설정</h6>
                    <a class="collapse-item" href="/user/logout">로그아웃</a>
                    <a class="collapse-item" href="/user/UserRegForm">회원가입</a>
                </div>
            </div>
        </li>

        <!-- Divider -->
        <hr class="sidebar-divider d-none d-md-block">

        <!-- Sidebar Toggler (Sidebar) -->
        <div class="text-center d-none d-md-inline">
            <button class="rounded-circle border-0" id="sidebarToggle"></button>
        </div>

    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                <!-- Sidebar Toggle (Topbar) -->
                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>


                <!-- Topbar Navbar -->
                <ul class="navbar-nav ml-auto">

                    <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                    <li class="nav-item dropdown no-arrow d-sm-none">
                        <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-search fa-fw"></i>
                        </a>
                        <!-- Dropdown - Messages -->
                        <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                             aria-labelledby="searchDropdown">
                            <form class="form-inline mr-auto w-100 navbar-search">
                                <div class="input-group">
                                    <input type="text" class="form-control bg-light border-0 small"
                                           placeholder="Search for..." aria-label="Search"
                                           aria-describedby="basic-addon2">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary" type="button">
                                            <i class="fas fa-search fa-sm"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </li>


                    <!-- Nav Item - User Information -->
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=session.getAttribute("SS_USER_ID")%></span>
                            <img class="img-profile rounded-circle"
                                 src="/static/img/undraw_profile.svg">
                        </a>
                        <!-- Dropdown - User Information -->
                        <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                             aria-labelledby="userDropdown">
                            <a class="dropdown-item" href="#">
                                <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                Profile
                            </a>
                            <a class="dropdown-item" href="#">
                                <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                Settings
                            </a>
                            <a class="dropdown-item" href="#">
                                <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                Activity Log
                            </a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                로그아웃
                            </a>
                        </div>
                    </li>

                </ul>

            </nav>
            <!-- End of Topbar -->

            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- Content Row -->
                <div class="row">

                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">채팅방</h6>
                        </div>
                        <div class="card-body">
                            <br/>
                            <br/>
                            <h2><%=nickname%>님! <%=roomname%> 채팅방 입장하셨습니다.</h2><br/><br/>
                                <div><b>채팅 내용</b></div>
                                <br/>
                                <div id="chat"></div>
                                <div>
                                    <label for="msg">전달할 메시지 : </label><input type="text" id="msg">
                                    <button id="btnSend">메시지 전송</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Your Website 2021</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">로그아웃</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">로그아웃하시겠습니까?</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <a class="btn btn-primary" href="/user/logout">로그아웃</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="/vendor/jquery/jquery.min.js"></script>
    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="/js/demo/chart-area-demo.js"></script>
    <script src="/js/demo/chart-pie-demo.js"></script>
</body>
</html>
