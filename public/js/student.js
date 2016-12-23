/* global firebase, Elm, URLSearchParams, registerFirebase, CodeMirror */

const getQueryParam = param => (new URLSearchParams(window.location.search)).get(param);

let token = getQueryParam("token") || "";
let app = Elm.Student.Main.fullscreen(token);
app = registerFirebase(app);
app.ports.initEditor.subscribe(initEditor);


function initEditor(theme) {
	var editor = CodeMirror.fromTextArea(document.getElementById('code'), {
	  mode: "htmlmixed",
		lineNumbers: true,
		matchBrackets: true,
		theme: theme,
		tabMode: 'shift',
		extraKeys: {
			//'Ctrl-Enter': compile,
			//'Tab': function(cm) {
			//	var spaces = Array(cm.getOption("indentUnit") + 1).join(" ");
			//	cm.replaceSelection(spaces, "end", "+input");
			//}
		}
	});

	editor.focus();
	
	editor.on('change', function(instance, obj) {
  	var text = editor.getValue()
		app.ports.code.send(text);
	});
}