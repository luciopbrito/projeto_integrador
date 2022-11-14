<%@page language="java" import="java.sql.*,java.util.*, java.text.*" contentType="text/html" pageEncoding="UTF-8" %>
<%
String select = request.getParameter("type-product");
String id = request.getParameter("id");

response.sendRedirect("./produtos-e-servicos.jsp?id=" + id + "&type=" + select);
%>
