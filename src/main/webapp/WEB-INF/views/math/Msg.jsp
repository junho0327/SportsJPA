<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR" %>
<%@ page import="kopo.poly.dto.UserInfoDTO" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%
  //Controller�κ��� ���޹��� ������
   String msg = CmmUtil.nvl((String) request.getAttribute("msg"));
    String url = CmmUtil.nvl((String) request.getAttribute("url"));

  //Controller�κ��� ���޹��� ��(ȸ������ �Է�ȭ��)���κ��� �Է¹��� ������(ȸ�����̵�, �̸�, �̸���, �ּ� ��)
   UserInfoDTO pDTO = (UserInfoDTO) request.getAttribute("pDTO");
    if (pDTO == null) {
    pDTO = new UserInfoDTO();
    }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="EUC-KR">
  <title>Sign Up Result</title>
  <script type="text/javascript">
    alert("<%=msg%>");
    window.location= '<%=url%>';
  </script>
</head>
<body>
</body>
</html>