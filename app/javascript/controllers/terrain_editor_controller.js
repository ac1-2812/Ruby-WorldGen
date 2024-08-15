import { Controller } from "@hotwired/stimulus"
import * as THREE from 'three';
import { OBJLoader } from 'objLoader';
import { OrbitControls } from 'orbitControls';

// Connects to data-controller="terrain-editor"
export default class extends Controller {
  connect() {
  }

  static targets = [ "source" ]

  loadModel() {
    const assetPath = this.sourceTarget.value.replace("<img src=\"", "").replace("\" />", "");
    console.log(assetPath)
    const width = window.innerWidth, height = window.innerHeight;
  
    // init
  
    const camera = new THREE.PerspectiveCamera( 70, width / height, 0.01, 10 );
    camera.position.z = 1;
  
    const scene = new THREE.Scene();

    const renderer = new THREE.WebGLRenderer( { antialias: true } );
    renderer.setSize( width, height );
    renderer.setAnimationLoop(animate)
    document.body.appendChild( renderer.domElement );

    var controls = new OrbitControls( camera, renderer.domElement );

    function animate() {
      requestAnimationFrame( animate );
      controls.update();
      renderer.render( scene, camera );
    }

    const loader = new OBJLoader();
    
  
    // load a resource
    loader.load(
      // resource URL
      assetPath,

      // called when resource is loaded
      function ( object ) {
        object.traverse(function(child) {
          if (child instanceof THREE.Mesh) {
            child.material = new THREE.MeshNormalMaterial()
          }
        });

        console.log(object);

        object.scale.x = 0.1
        object.scale.y = 0.1
        object.scale.z = 0.1

        object.position.z = -3

        scene.add( object );
        camera.lookAt(scene.position);
        renderer.render( scene, camera );
      },

      // called when loading is in progresses
      function ( xhr ) {
        console.log( ( xhr.loaded / xhr.total * 100 ) + '% loaded' );
      },

      // called when loading has errors
      function ( error ) {
        console.log( 'An error happened' );
      }
    );
  }
}
