<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><tiles:insertAttribute name="title" ignore="true" /></title>

<sj:head jqueryui="true" jquerytheme="le-frog" locale="es"/>
<script type="text/javascript" src="../resources/js/jquery.validate.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.min.css">
<script type="text/javascript" src="../resources/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../resources/css/jquery.ui.all.css">
<script type="text/javascript" src="../resources/js/jquery-ui.js"></script>
<script type="text/javascript" src="../resources/js/bootstrap-modal.js"></script>
<script type="text/javascript" src="../resources/js/bootstrap-modalmanager.js"></script>
<script type="text/javascript" src="../resources/js/main.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap-modal.css">
<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap-modal-bs3patch.css">
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script type="text/javascript" src="../resources/js/bootstrap-datepicker.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/datepicker.css">
</head>
<body>
	<div class="wrapper">
		<div class="row clearfix">
			<tiles:insertAttribute name="header" />
			<tiles:insertAttribute name="subheader" />
		</div>

		<div class="container">
			<div class="row clearfix">
				<!-- Context con menu -->
				<div class="col-md-3 column">
					<tiles:insertAttribute name="menu" />
				</div>
				<!-- 		Cuerpo -->
				<div class="col-md-9 column">
					<tiles:insertAttribute name="body" />
				</div>
			</div>
		</div>
	</div>
	<!-- Pie de pagina-->
		<div class="push"></div>
		<div id="footer" class="container">
			<div class="navbar navbar-default">
				<tiles:insertAttribute name="footer" />
			</div>
		</div>
</body>
</html>