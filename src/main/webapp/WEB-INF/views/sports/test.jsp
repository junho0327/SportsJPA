<%@ page import="java.util.List" %>
<%@ page import="kopo.poly.dto.PlaceApiResponse" %>
<%@ page import="kopo.poly.dto.ProgramApiResponse" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    List<PlaceApiResponse> placeList = (List<PlaceApiResponse>) request.getAttribute("placeList");
    List<ProgramApiResponse> programList = (List<ProgramApiResponse>) request.getAttribute("programList");

    if (placeList.size() < 0) {
        placeList = new ArrayList<>();
    }

    if (programList.size() < 0) {
        programList = new ArrayList<>();
    }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
</head>
<body>
<%
    for (ProgramApiResponse program : programList) {
%>
<h1><%=program.getProgramName()%></h1>
<h2><%=program.getPrice()%></h2>
<%
    }
%>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<%
    for (PlaceApiResponse place : placeList) {
%>
<h1><%=place.getPlaceName()%></h1>
<h2><%=place.getPlaceTime()%></h2>
<%
    }
%>
</body>
</html>