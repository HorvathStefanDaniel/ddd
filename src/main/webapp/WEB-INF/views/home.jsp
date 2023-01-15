<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<jsp:include page='components/imports.jsp'>
    <jsp:param name="someParam" value="false"/>
</jsp:include>
</head>
<body>
	<div>
		<b>HELLO</b>
		<h1>Hello, world!</h1>

		<i class="bi-alarm"></i> 
		<i class="bi-alarm"
			style="font-size: 2rem; color: cornflowerblue;"></i>


	</div>
</body>
</html>