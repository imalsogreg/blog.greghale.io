var bodies;
var world, mass, timeStep=1/60;
var camera, scene, renderer, controls;

var gTransparent = false;

bodies = [];

function new_canal(pos,rotation, color){

    var cannon_torus = new CANNON.Trimesh.createTorus(1,0.2,16,32);
    var body         = new CANNON.Body({mass:0});
    body.addShape(cannon_torus);
    body.position.set(pos.x, pos.y, pos.z);
    body.quaternion.copy(rotation);

    var mat = new THREE.MeshPhongMaterial({color: color, transparent: true, opacity: 0.5});
    var three_torus  = new THREE.Mesh (new THREE.TorusGeometry(1.0,0.2,16,32), mat);

    bodies.push( { cannon: body, three: three_torus } );

    world.addBody(body);
    scene.add(three_torus);
}

function new_goal(){
    var cannon_box = new CANNON.Sphere(0.2);
    var body       = new CANNON.Body( {mass: 0, shape: cannon_box} );
    body.position.set(-3.2, -1.8, -0.4);
    body.addEventListener("collide", function(e){
        console.log("Collision with goal!");
    });

    geometry = new THREE.SphereGeometry(0.2,0.1,0.1);
    material = new THREE.MeshBasicMaterial({color:0x00ff00});
    mesh     = new THREE.Mesh( geometry, material );

    bodies.push({cannon: body, three: mesh});
    world.addBody(body);
    scene.add(mesh);
}

function new_crystal(x,y,z){

    var cannon_sphere = new CANNON.Sphere(0.1);
    var body          = new CANNON.Body({ mass:1, shape: cannon_sphere });
    body.position.set(x,y,z);
    body.angularVelocity.z = 100;
    body.angularVelocity.x = 10;

    group = new THREE.Group();
    geometry = new THREE.SphereGeometry( 0.1,16,16 );
    material = new THREE.MeshPhongMaterial( {color: 0xff0000 } );
    mesh = new THREE.Mesh( geometry, material );
    group.add(mesh);

    for (var p = 0; p < 3; p++) {
        for (var v = -1; v < 2; v += 2) {
            var c = [0,0,0];
            c[p] = v/3;
            var light = new THREE.PointLight( 0xff0040, 2, 50 );
            light.position.set(c[0],c[1],c[2]);
            var geom1 = new THREE.SphereGeometry(0.03,8,8);
            var mesh1 = new THREE.Mesh(geom1, material);
            mesh1.position.set(c[0],c[1],c[2]);
            // mesh1.position.set(-1,0,0);
            group.add(light);
            group.add(mesh1);
        }
    }

    // light1 = new THREE.PointLight( 0xff0040, 2, 50 );
    // light1.position.set(0.3, 0, 0);
    // geom1 = new THREE.SphereGeometry( 0.05, 16,16 );
    // mesh1 = new THREE.Mesh( geom1, material );
    // mesh1.position.set(0.3,0,0);
    // group.add(light1);
    // group.add(mesh1);

    // light2 = new THREE.PointLight( 0xff0040, 2, 50 );
    // light2.position.set(-0.3, 0, 0);
    // geom2 = new THREE.SphereGeometry( 0.05, 16, 16 );
    // mesh2 = new THREE.Mesh(geom2, material);
    // mesh2.position.set(-0.3, 0, 0);
    // group.add(light2);
    // group.add(mesh2);

    // var sphere = new THREE.SphereBufferGeometry( 0.1, 16, 16 );
    // mesh = new THREE.PointLight( 0xff0040, 2, 50 );
    // mesh.add( new THREE.Mesh( sphere, new THREE.MeshBasicMaterial({color: 0xff0040}) ) );

    bodies.push( { cannon: body, three: group } );

    world.addBody(body);
    scene.add(group);
    return body
}

function new_head(){
    var loader = new THREE.BufferGeometryLoader();
    loader.load('/js/WaltHeadLo_buffergeometry.json', bufferGeom => {
        var geom = new THREE.Geometry().fromBufferGeometry(bufferGeom);
        geometry.mergeVertices();
        // var material = new THREE.MeshBasicMaterial({color: 0xcccccc, opacity: 0.1, transparent: gTransparent});
        var material = new THREE.MeshPhongMaterial({color: 0xcccccc, transparent: true, opacity: 0.2});
        var mesh = new THREE.Mesh( geom, material );
        mesh.scale.set(0.3,0.3,0.3);
        mesh.renderOrder = 10;
        scene.add( mesh );
    });
}

function new_organ_right(flip_sign){

    canalQ = new THREE.Quaternion(0,0,0,1);

    // Horizontal canal (red)
    canalQ.setFromAxisAngle( (new THREE.Vector3(1,-0.1 * flip_sign,-0.0)).normalize(), Math.PI/2 );
    new_canal({x: -3 * flip_sign, y: -2, z: 0}, canalQ, 0xff9999);

    // Posterior Canal (green)
    canalQ.setFromAxisAngle( (new THREE.Vector3(1,5,0)).normalize(), flip_sign * (Math.PI/2 + Math.PI/3) );
    new_canal({x:-4 * flip_sign, y: -2, z: -1}, canalQ, 0x44ff44);

    // Anterior canal (blue)
    var canalQHelper = new THREE.Quaternion();
    canalQ.setFromAxisAngle( (new THREE.Vector3(0,1,-0.1)).normalize(), flip_sign * Math.PI/2 );
    new_canal({x: -3 * flip_sign, y: -2, z: 0}, canalQ, 0x4444ff);
}

function init(){
    world = new CANNON.World();
    world.gravity.set(0,0,-10);
    world.broadphase = new CANNON.NaiveBroadphase();
    world.solver.iterations = 10;

    camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 1, 1000);
    camera.position.z = 10;
    camera.position.y = 00;
    // camera.position.x = 10;
    // camera.lookAt(0,0,0);

    scene = new THREE.Scene();

    var light = new THREE.PointLight(0xffffff, 1.5);
    light.position.set(100,1000,1000);
    var light2 = new THREE.PointLight(0xffffff, 0.5);
    light2.position.set(100,-1000,1000);
    scene.add(light);
    scene.add(light2);

    new_organ_right(1);
    new_organ_right(-1);

    // Displaced Crystal
    new_crystal(-4.1, -1, -1.0);
    new_crystal(-4.2, -1.1, -1.1);

    new_goal();

    new_head();

    renderer = new THREE.WebGLRenderer();
    renderer.setSize( 600, 400 );
    renderer.setClearColor( 0xffffff, 1 );
    var myContainer = document.getElementById('epley_container');
    myContainer.appendChild( renderer.domElement );


    controls = new THREE.TrackballControls( camera, renderer.domElement );
    controls.rotateSpeed = 0.5;

    // scene.add( camera );

}

s = -1;
function animate(){
    s = s + 1;
    requestAnimationFrame( animate );
    controls.update();
    // seekGoal(bodies[0].cannon);
    if (s > 0 && s < 120){
        camera.position.z = camera.position.z + 0.1;
    }
    updatePhysics();
    render();
}

function addManyBalls(){
    for (x=0; x< 5; x++){
        for (y=0; y < 5; y++){
            for (z=0; z < 5; z++){
                new_crystal(x-2, y-2, z-2);

            }
        }
    }
}


function multQ(q1,q2){
    return {x: q1}
}

function updateGravity(){
    var cameraVec = new THREE.Vector3(0, 0, -1);

    var rotateQ   = new THREE.Quaternion();
    rotateQ.setFromAxisAngle( new THREE.Vector3(1,0,0), -Math.PI/2 );
    cameraVec.applyQuaternion( rotateQ );
    cameraVec.applyQuaternion( camera.quaternion );

    world.gravity.set(cameraVec.x * 10, cameraVec.y * 10, cameraVec.z * 10);
}

function updatePhysics() {
    updateGravity();
    world.step(timeStep);
    var rotation
    bodies.forEach(
        (b) => {
            b.three.position.copy(b.cannon.position);
            b.three.quaternion.copy(b.cannon.quaternion);
        })
}

function render(){
    renderer.render( scene, camera );
}

init();
window.setTimeout( function() {
    updatePhysics();
    renderer.render( scene, camera );
}, 500)

function go(){
    var clickToStart = document.getElementById("click_to_start");
    var instructions = document.getElementById("instructions");
    clickToStart.innerHTML = "";
    instructions.style = "display:none;"
    animate();
}
