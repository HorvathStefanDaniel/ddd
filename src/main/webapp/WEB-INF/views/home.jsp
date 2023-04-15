<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>

<jsp:include page='components/imports.jsp'>
	<jsp:param name="someParam" value="false" />
</jsp:include>

<style>
html {
	overflow: hidden;
}

.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

/* Jelly styles */
.jelly-container {
	position: static;
	display: block;
	left: 150px;
	top: 500px;
}

#lawd {
	margin: auto;
	width: 700px;
	height: auto;
	display: block;
	max-width: 100%;
	position: relative;
}

.jelly-container, .jelly-container2 {
	height: 200px;
	width: 200px;
}

.jelly-canvas, .jelly-canvas2 {
	width: 200px;
	height: 200px;
}

.jelly-container {
	padding-left: 270px;
}

.breast-container {
	max-width: 100%;
	margin: auto;
	height: auto;
	width: 700px;
	position: relative;
	display: flex;
	top: -162px;
	justify-content: space-around;
	align-items: center;
	flex-direction: row;
	left: -202px;
}

/* It's important to position the `.centroid-container` in the top-left corner
   This way the `.centroid-text` will be positioned in the center (with JavaScript) */
.centroid-container {
	position: absolute;
	top: 0;
	transform: translate(-100%, -40%);
	pointer-events: none;
}

.centroid-container2 {
	position: absolute;
	top: 0;
	pointer-events: none;
	transform: translate(0%,-40%);
}

.centroid-text, .centroid-text2 {
	font-size: 50px;
	color: white;
}

#container {
	display: block;
	width: 100%;
	height: auto;
	margin: auto;
}

#svgCont {
	position: absolute;
	left: 0px;
	right: 0px;
	z-index: -99;
}
</style>
<!-- Custom styles for this template -->
</head>
<body class="text-center">
	<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
		<header class="masthead mb-auto">
			<div class="inner">
				<h3 class="masthead-brand">${setting.projectName}</h3>
				<nav class="nav nav-masthead justify-content-center">
					<a class="nav-link active" href="/ddd/">Home</a> <a
						class="nav-link" href="/ddd/demo">DEMO</a>
					<!-- 						<a class="nav-link" href="#">Demo</a>  -->
					<!-- 						<a class="nav-link float-right" href="#">>Login</a> -->
				</nav>
			</div>
		</header>
		<main role="main" class="inner cover">
			<h1 class="cover-heading">Suck-u Hotel.</h1>
			<p class="lead">
				Explore a den of depravity as you fight to preserve your soul and
				your dignity.<br>Cooming to steam soon&#8482;
			</p>
			<p class="lead">
				<a href="#" class="btn btn-lg btn-secondary">WISHLIST NOW</a>
			</p>
		</main>

		<jsp:include page='components/footer.jsp' />
		<div id="svgCont">
			<svg viewBox="0 0 180 180 " width="180" height="180"
				xmlns="http://www.w3.org/2000/svg">
				<ellipse id="svgA"
					style="fill: rgb(216, 216, 216); stroke: rgb(0, 0, 0);" cx="100"
					cy="100" rx="75" ry="69" />
				</svg>
		</div>
	</div>

	<div
		style="aspect-ratio: auto 800/600; background: 0% 0%/contain rgb(20, 21, 31);">
		<div id="interactiveArea"
			style="background: 0% 0%/contain rgb(20, 21, 31);">
			<div id="container">
				<img id="lawd" src="../ddd/sprites/ohLawd.png"></img>
				<div class="breast-container">
					<div class="jelly-container">
						<canvas class="jelly-canvas"></canvas>
						<!-- Text in the centroid of the jelly pentagon -->
						<div class="centroid-container">
							<div class="centroid-text">$</div>
						</div>
					</div>
					<div class="jelly-container2">
						<canvas class="jelly-canvas2"></canvas>
						<!-- Text in the centroid of the jelly pentagon -->
						<div class="centroid-container2">
							<div class="centroid-text2">$</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="../ddd/matter.min.js" type="text/javascript"></script>
	<script src="../ddd/jelly.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		var options = {
			paths : '#svgA', // Shape we want to draw
			pointsNumber : 13, // Number of points
			maxDistance : 3, // Max distance among points
			color : '#FFFF00',
			centroid : '.centroid-text', // Element to move accordingly with the centroid of the shape
			mouseIncidence : 3,
			border : "#C17B75",
			// 			image : "../ddd/sprites/skin.png"
			image : "../ddd/sprites/yellowDollan.png"
		// 			,debug : true
		// Uncomment this to see the points
		};
		var options2 = {
			paths : '#svgA', // Shape we want to draw
			pointsNumber : 15, // Number of points
			maxDistance : 3, // Max distance among points
			color : '#FFFF00',
			centroid : '.centroid-text2', // Element to move accordingly with the centroid of the shape
			mouseIncidence : 3,
			border : "black",
			// 			image : "../ddd/sprites/skin.png"
			image : "../ddd/sprites/yellowDollan.png"
		// 			,debug : true
		// Uncomment this to see the points
		};

		/* Initializing jelly */

		var jelly = new Jelly('.jelly-canvas', options);
		var jelly = new Jelly('.jelly-canvas2', options2);
	</script>
</body>
</html>