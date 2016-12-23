/* global firebase */

"use strict";


// easy entry point
// usage:
// var app = Elm.Main.fullscreen()
// app = registerFirebase(app)
function registerFirebase(elmApp) {
    elmApp.ports.fbRemove.subscribe(fbRemove)
    elmApp.ports.fbSet.subscribe(fbSet)
    elmApp.ports.fbUpdate.subscribe(fbUpdate)
    // 2 way communication
    elmApp.ports.fbGet.subscribe(fbGet(elmApp))
    elmApp.ports.fbOn.subscribe(fbOn(elmApp))
    elmApp.ports.fbPost.subscribe(fbPost(elmApp))
    return elmApp
}

// generalized firebase ports
function fbRemove(ref) {
  console.log("fbRemove", ref)
  firebase.database().ref(ref).remove()
}

function fbSet([ref, data]) {
  delete data.id
  console.log("fbSet", ref, data)
  firebase.database().ref(ref).set(data)
}

function fbUpdate([ref, data]) {
  delete data.id
  console.log("fbUpdate", ref, data)
  firebase.database().ref(ref).update(data)
}


// the following functions facilitate 2 way communication with firebase
// they require a elm app to call back into once the firebase request is
// complete. as such their binding invocation looks like:
// app.ports.fbGet.subscribe(fbGet)
function fbGet(app) {
  console.log("fbGet registered")
  return ([ref, eventType, callbackName]) => {
    console.log("fbGet request", ref, eventType, callbackName)
    firebase.database().ref(ref).once(eventType, result => {
      if (callbackName) {
        let val = result.val()
        val.id = result.key
        console.log("fbGet", ref, eventType, val)
  
        app.ports[callbackName].send(val)
      }
    })
  }
}

function fbOn(app) {
  console.log("fbOn registered")
  return ([ref, eventType, callbackName]) => {
    console.log("fbOn request", ref, eventType, callbackName)
    firebase.database().ref(ref).on(eventType, result => {
      if (callbackName) {
        let val = result.val()
        val.id = result.key
        console.log("fbOn result", ref, eventType, callbackName, val)
        app.ports[callbackName].send(val)
      }
    })
  }
}

function fbPost(app) {
  console.log("fbPost registered")
  return ([ref, data, callbackName]) => {
    console.log("fbPost request", ref, data, callbackName)
    delete data.id
    firebase.database().ref(ref).push(data).then(newRef => {
        if (callbackName) {
          const resultPath = ref + "/" + newRef.key //result.ref().path.o.join("/")
          console.log("fbPost complete", resultPath)
          
          app.ports[callbackName].send(resultPath)
        }
    })
  }
}

