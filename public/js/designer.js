/* global firebase, Elm, URLSearchParams */
const getQueryParam = param => (new URLSearchParams(window.location.search)).get(param);

let token = getQueryParam("id") || "";
const app = Elm.Designer.Main.fullscreen(token);
registerFirebase(app);

/*
firebase.auth().onAuthStateChanged(user => {
  if (user) {
    const classId = getQueryParam('id')
    clearScreen()
    app = Elm.Student.fullscreen(
        
      //[ user.uid
        //{ id: user.uid
        //, name: user.displayName
        //, name: "samantha"
        //}
      //, classId
      //]
    )
 
    app.ports.fbPost.subscribe(fbPost)
    app.ports.fbRemove.subscribe(fbRemove)
    app.ports.fbSet.subscribe(fbSet)
    app.ports.fbUpdate.subscribe(fbUpdate)
    // 2 way communication
    app.ports.fbGet.subscribe(fbGet(app))
    app.ports.fbOn.subscribe(fbOn(app))
    
    // legacy
    //app.ports.postMessage.subscribe(postMessage)
    //listenForLogout(app)
    //listenForScrollToBottom(app)
    //listenForMessagesFromFb(app, classId)
    //listenForResponsesFromFb(app, classId)
  } else
    firebase.auth().signInWithRedirect(new firebase.auth.GithubAuthProvider())
   
})
 */
