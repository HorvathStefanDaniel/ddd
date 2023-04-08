<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<jsp:include page='components/imports.jsp'>
	<jsp:param name="someParam" value="false" />
</jsp:include>

<style>
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
			<h1 class="cover-heading">Cover your page.</h1>
			<p class="lead">Cover is a one-page template for building simple
				and beautiful home pages. Download, edit the text, and add your own
				fullscreen background photo to make it your own.</p>
			<p class="lead">
				<a href="#" class="btn btn-lg btn-secondary">Learn more</a>
			</p>
		</main>

		<footer class="mastfoot mt-auto">
			<div class="inner">
				<p>
					Made by <a href="https://twitter.com/mdo">@mdo</a> 2023 ${msg}
				</p>
			</div>
		</footer>
	</div>
	<script src="../ddd/matter.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	//defining a soft body
	/**
* Creates a simple soft body like object.
* @method softBody
* @param {number} xx
* @param {number} yy
* @param {number} columns
* @param {number} rows
* @param {number} columnGap
* @param {number} rowGap
* @param {boolean} crossBrace
* @param {number} particleRadius
* @param {} particleOptions
* @param {} constraintOptions
* @return {composite} A new composite softBody
*/
	isCircle = (i, j, columns, rows, circleEq)=>{
		var calc = Math.pow(i-columns/2,2) + Math.pow(j-rows/2,2);
// 		console.log(i + " " + j + " " + columns + " " + rows + " " + calc + " " + circleEq);
		return false;
		return  calc+1 >= circleEq;
	}
	//jquery on ready
	$(()=>{
		//define a simple soft body. Basically an array of constrained body
		const softBody = function(xx, yy, columns, rows, columnGap, rowGap, crossBrace, particleRadius, particleOptions, toStatic, constraintOptions) {
		    var Common = Matter.Common,
		        Composites = Matter.Composites,
		        Bodies = Matter.Bodies;
		    
		    particleOptions = Common.extend({ inertia: Infinity }, particleOptions);
		    constraintOptions = Common.extend({ 
		    	stiffness: 0.2, 
		    	density: 0.0005,
                frictionAir: 0.06,
                restitution: 0.3,
                friction: 0.01,
                
		    	render: {
		    		anchors: false, 
		    		type:"line",
		    		visible: false
		   	 	} 
		    }, constraintOptions);
		    //added
		    var colMid = Math.floor(columns/2);
		    var rowMid =  Math.floor(rows/2);
		    /*
		    	Circle equation:
		    	To create a circle (boob) using a square array, we need the following ecuation
		    	A square with a side length of 5 can fit a circle with the radius of 5/2
		    	If you have one point per mu ...
		    	The circle equation will be x^2 + y^2 = (5/2)^2
		    	And the square can be described as -5 < x < 5 and -5 < y < 5
		    	So we only want to keep points that can obey all the above rules: x^2 + y^2 = (r/2)^2 and -r < x < r and -r < y < r
		    */
		    //use whichever is smaller between columns and rows
		    var r = columns > rows ? rows : columns;
		    
		    //x^2 + y^2 must equal circleEq to not be removed
		    var circleEq = Math.pow((r / 2),2);
		    
		    //using i and j instead of x and y
		    
		    //an array of 1s and 0s that serves as a mask to create a circle array. 2 means it should be static
		    var andArray = new Array(columns);
		    for(var i = 0; i<columns; i++){
		    	andArray[i] = new Array(rows);
			    for(var j = 0; j<rows; j++){
		    		if(colMid <= i+toStatic && colMid > i-toStatic && rowMid <= j+toStatic && rowMid > j-toStatic){
		    			andArray[i][j] = 2;
		    		}
		    		else if(isCircle(i,j,columns, rows, circleEq)){
		    			andArray[i][j] = 0;
	    			}else{
	    				andArray[i][j] = 1;
	    			}
		    	}
		    }
		    
			var curRow = 0;
			var curCol = 0;
			console.log(andArray);
		    var softBody = Composites.stack(xx, yy, columns, rows, columnGap, rowGap, (x, y)=> {
		    	particleOptions.render = {
				    	sprite: {
		                    texture: '/ddd/sprites/skin.png',
		                    yScale : 1,
		                    xScale : 1
		                }
			   	 	};
		    	if(andArray[curRow][curCol] == 1){
			        //this might need to be the other way arround
		    		if(curCol < columns-1){
		    			curCol++;
			        }else{
			        	curCol = 0;
			        	curRow++;
			        }
		    		return Bodies.circle(x, y, particleRadius, particleOptions);
		    	}else if (andArray[curRow][curCol] == 2){
		    		if(curCol < columns-1){
		    			curCol++;
			        }else{
			        	curCol = 0;
			        	curRow++;
			        }
		    		//make it static
		    		var toRet = Bodies.circle(x, y, particleRadius, particleOptions);
		    		toRet.isStatic = true;
		    		toRet.class="outer-metaballs-container";
		    		return toRet;
		    	}else{
		    		if(curCol < columns-1){
		    			curCol++;
			        }else{
			        	curCol = 0;
			        	curRow++;
			        }
		    		//return with no radius ? or delete it somehow
// 		    		var toRet = Bodies.circle(x, y, 0, particleOptions);
		    		var optionsCopy = particleOptions;
		    		optionsCopy.mass = 0;
		    		optionsCopy.friction = 100;
		    		optionsCopy.opacity = 0;
		    		var toRet = Bodies.circle(x, y, 1, optionsCopy.opacity);
		    		toRet.class="meta";
		    		return toRet;
		    	}
		    });
		    
		    Composites.mesh(softBody, columns, rows, crossBrace, constraintOptions);

		    softBody.label = 'Soft Body';
		    softBody.class = "outer-metaballs-container";

		    return softBody;
		};
		// module aliases
		var Engine = Matter.Engine,
	        Render = Matter.Render,
	        Runner = Matter.Runner,
	        Composites = Matter.Composites,
	        Common = Matter.Common,
	        MouseConstraint = Matter.MouseConstraint,
	        Mouse = Matter.Mouse,
	        Composite = Matter.Composite,
	        Bodies = Matter.Bodies;
		
		// create an engine
		var engine = Engine.create();

		// create a renderer
		var render = Render.create({
	        element: document.body,
	        engine: engine,
	        options: {
	            showAngleIndicator: false,
	            wireframes: false
	        }
	    });

	    // add bodies
	    var offset = 10,
	        options = { 
	            isStatic: true
	        };

	    // these static walls will not be rendered in this sprites example, see options
	    Composite.add(engine.world, [
	        Bodies.rectangle(400, -offset, 800.5 + 2 * offset, 50.5, options),
	        Bodies.rectangle(400, 600 + offset, 800.5 + 2 * offset, 50.5, options),
	        Bodies.rectangle(800 + offset, 300, 50.5, 600.5 + 2 * offset, options),
	        Bodies.rectangle(-offset, 300, 50.5, 600.5 + 2 * offset, options)
	    ]);
	    
	    //soft bodies ;)
	    var particleOptions = {
				mass: 3,
	            friction: 1,
	            frictionStatic: 1,
	            render: { visible: false } 
	        };
	
	    var xx = 200, yy = 200, columns = 5, rows = 5, columnGap = 1, rowGap = 1, crossBrace = true, particleRadius = 15, particleOptions = particleOptions, toStatic = 1;
	    Composite.add(engine.world, [
	        // see softBody function defined later in this file
	        softBody(xx, yy, columns, rows, columnGap, rowGap, crossBrace, particleRadius, particleOptions, toStatic),
// 	       	softBody(400, 300, 8, 3, 0, 0, true, 15, particleOptions),
// 			softBody(250, 400, 4, 4, 0, 0, true, 15, particleOptions),
	    ]);
	    
	    //making sprites
// 	    var stack = Composites.stack(400, 200, 2, 2, 1, 1, function(x, y) {
// 	        if (Common.random() > 0.5) {
// 	            return Bodies.rectangle(x, y, 32, 32, {
// 	                render: {
// 	                    strokeStyle: '#ffffff',
// 	                    sprite: {
// 	                        texture: '/ddd/sprites/box.png',
// 	                        yScale : 0.5,
// 	                        xScale : 0.5
// 	                    }
// 	                }
// 	            });
// 	        } else {
// 	            return Bodies.circle(x, y, 16, {
// 	                density: 0.0005,
// 	                frictionAir: 0.06,
// 	                restitution: 0.3,
// 	                friction: 0.01,
// 	                render: {
// 	                    sprite: {
// 	                        texture: '/ddd/sprites/ball.png',
// 	                        yScale : 0.5,
// 	                        xScale : 0.5
// 	                    }
// 	                }
// 	            });
// 	        }
// 	    });
	    
		//add mouse control
	    var mouse = Mouse.create(render.canvas),
	        mouseConstraint = MouseConstraint.create(engine, {
	            mouse: mouse,
	            constraint: {
	                stiffness: 0.2,
	                render: {
	                    visible: true
	                }
	            }
	        });

	    Composite.add(engine.world, mouseConstraint);

	    // keep the mouse in sync with rendering
	    render.mouse = mouse;

	    // fit the render viewport to the scene
	    Render.lookAt(render, {
	        min: { x: 0, y: 0 },
	        max: { x: 800, y: 600 }
	    });

// 	    Composite.add(engine.world, stack);

		// run the renderer
		Render.run(render);

		// create runner
		var runner = Runner.create();

		// run the engine
		Runner.run(runner, engine);
		
	});

	</script>
</body>
</html>