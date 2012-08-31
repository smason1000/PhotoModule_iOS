// Private implementation details for commonJS module

var devGuide = null;
var krollDemo = null;
var	view = null;
var	currentColor = '';


function handleColorSelection(e) {
	view.color = (currentColor == 'green') ? 'red' : 'green';
}

function createColorSelector() {
	var colorBtn = Ti.UI.createButton({
		title: 'Change Color',
		top:10,
		width:150,
		height:40
	});
	
	colorBtn.addEventListener('click', handleColorSelection);

	return colorBtn;
}

function handlePropertyChangeNotification(e) {
	var result = 'Property ' + e.property + ' changed\nOldValue: ' + e.oldValue + '\nNewValue: ' + e.newValue;
	alert(result);
}

function handleColorChange(e) {
	if (Ti.Platform.name == 'android') {
		currentColor = e.color;
	} else {
		currentColor = e.color._name;
	}
	
	//alert('Color changed to ' + currentColor);
}

exports.initialize = function(modDevGuide) {
	// Save the module object -- we'll need it later
	devGuide = modDevGuide;
}

exports.cleanup = function() {
	view = null;
	currentColor = '';
	devGuide = null;
	krollDemo = null;
}

exports.create = function(win) {

	// Create the proxy
	krollDemo = devGuide.createKrollDemo({ arg1: "Hello", arg2: "World" });	
	krollDemo.addEventListener('propertyChange', handlePropertyChangeNotification);	
	krollDemo.watchPropertyChanges = true;


	view = devGuide.createDemoView({
		width:'auto',
		height:'auto',
		top:0,
		left:0,
		color: 'green',
		layout:'vertical'
	});

	view.add(createColorSelector());
	view.addEventListener('colorChange', handleColorChange);
	
	win.add(view);

	

	krollDemo.labels = "Label1,Label2,Label3,Label4";
	krollDemo.reqLabels = "Label1,Label4";

}




	/*
	win.add(Ti.UI.createLabel({
		text:'This demonstrates the view proxy lifecycle. Press the \'Create View\' button to create a new instance of the view. Press the \'Delete View\' button to destroy the view. Lifecycle messages will be output to the console.',
		textAlign:'left',
		font:{ fontsize: 12 },
		top:10,
		right:10,
		left:10,
		color:'black',
		width:Ti.UI.SIZE || 'auto',
		height:Ti.UI.SIZE || 'auto'
	}));

	var toggleBtn = Ti.UI.createButton({
		title: 'Create View',
		top:10,
		width:150,
		height:60
	});
	
	toggleBtn.addEventListener('click', toggleViewCreate);
	
	win.add(toggleBtn);
	*/

/*
function toggleViewCreate(e) {
	if (view == null) {
		view = devGuide.createDemoView({
			width:200,
			height:200,
			top:10,
			color: 'green',
			layout:'vertical'
		});
		
		view.add(createColorSelector());
		
		view.addEventListener('colorChange', handleColorChange);
		
		e.source.parent.add(view);
	} else {
		e.source.parent.remove(view);
		view = null;
	}

	// Toggle the button text
	e.source.title = (view == null) ? 'Create View' : 'Delete View';
}
*/

//########


// Private implementation details for commonJS module


/*
function handlePropertyChangesSwitch(e) {
	krollDemo.watchPropertyChanges = e.value;
}

function handleSetPropertyValue(e) {
	krollDemo.testValue = e.source.value;
}

function handleGetPropertyValue(e) {
	alert('Current property value is ' + krollDemo.testValue);
}

function handleBatchUpdate(e) {
	krollDemo.value1 = (krollDemo.value1 | 0) + 5;
	krollDemo.value2 = { name: 'Hello', value: 'World' };
	krollDemo.value3 = !(krollDemo.value3 | false);
	krollDemo.value4 = 'This is a test';	
}
*/



// Public implementation details for commonJS module

/*
exports.create = function(win) {
	win.add(Ti.UI.createLabel({
		text:'This demonstrates proxy properties and how to get / set their values as well as process property change notifications. Some messages will be output to the console.',
		textAlign:'left',
		font:{ fontsize: 12 },
		top:10,
		right:10,
		left:10,
		color:'black',
		width:Ti.UI.SIZE || 'auto',
		height:Ti.UI.SIZE || 'auto'
	}));
	
	var view1 = Ti.UI.createView({
		layout:'horizontal',
		width:'100%',
		height:'30',
		top:10,
		left:10
	});
	
	view1.add(Ti.UI.createLabel({
		text:'Property Changes:',
		textAlign:'left',
		font:{ fontsize: 12 },
		color:'black',
		width:Ti.UI.SIZE || 'auto',
		height:Ti.UI.SIZE || 'auto',
		top:4
	}));
	
	var switchPropertyChanges = Ti.UI.createSwitch({
		value:krollDemo.watchPropertyChanges,
		left:10,
		top:0
	});
	view1.add(switchPropertyChanges);
	
	var view2= Ti.UI.createView({
		layout:'horizontal',
		width:'100%',
		height:'30',
		top:20,
		left:10
	})
	
	view2.add(Ti.UI.createLabel({
		text:'Test Value:',
		textAlign:'left',
		font:{ fontsize: 12 },
		color:'black',
		width:Ti.UI.SIZE || 'auto',
		height:Ti.UI.SIZE || 'auto',
		top:4
	}));
	
	var valueField = Ti.UI.createTextField({
		hintText:'Enter a value',
		font:{ fontsize: 12 },
		color:'black',
		width:200,
		height:35,
		left:10,
		borderStyle: Ti.UI.INPUT_BORDERSTYLE_ROUNDED
	});
	view2.add(valueField);
	
	var valueBtn = Ti.UI.createButton({
		title:'Get Value',
		width:200,
		height:40,
		top:20
	});
	
	var batchUpdateBtn = Ti.UI.createButton({
		title:'Update Multiple Properties',
		width:200,
		height:40,
		top:20
	});
	
	switchPropertyChanges.addEventListener('change', handlePropertyChangesSwitch);
	valueField.addEventListener('return', handleSetPropertyValue);
	valueBtn.addEventListener('click', handleGetPropertyValue);
	batchUpdateBtn.addEventListener('click', handleBatchUpdate);
	
	win.add(view1);
	win.add(view2);
	win.add(valueBtn);
	win.add(batchUpdateBtn);
}
*/

