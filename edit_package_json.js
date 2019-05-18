const jsonfile = require('jsonfile')

const file = './package.json';

const errHnd = (err) => {
	if (err) {
		console.error(err);
	} else {
		console.log("Done.");
	}
};

jsonfile.readFile(file, (err, obj) => {
	errHnd(err);

	console.dir(obj)

	obj.main  = "dist/index.js";
	obj.types = "dist/index.d.ts";
	
	console.dir(obj)

	jsonfile.writeFile(file, obj, errHnd);
});
