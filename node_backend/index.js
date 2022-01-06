const express = require('express');
const bodyParser = require('body-parser');

var app = express();

var balance = 2500;

app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

app.use(function(req, res, next) {
    res.header("Content-Type", 'application/json');
    res.header("Access-Control-Allow-Origin", "*");
    next();
});

app.post('/users/0/', function(req, res) {

    var login = req.body.login,
        pin = req.body.pin;
		
		console.log(req.body);


    if (!login || !pin) {
        return res
            .status(400)
            .jsonp({               
                error: "Needs a json body with { login: <login>, pin: <pin>}"
            });
    }

    if (login !== 'jkowalski0451' || pin !== '0451') {
        return res
            .status(401)
            .jsonp({
                error: "Authentication failied.",
            });
    }

    return res
        .status(200)
        .jsonp({
			'status': 'OK'
        });
});

app.post('/users/0/transfer', function(req, res) {
	if (!req.body.accountNumber || !req.body.amount) {
        return res
            .status(400)
            .jsonp({               
                error: "Needs a json body with { accountNumber: <accountNumber>, amount: <amount>}"
            });
    }

	var accountNumber = req.body.accountNumber;
	balance = balance - req.body.amount;
	
	return res
        .status(200)
        .jsonp(
	{
		'status': 'OK'
	});
});


app.get('/users/0/', function(req, res) {
    return res
        .status(200)
        .jsonp(
	{
		"login": "jkowalski0451",
		"pin": "0451",
		"fullName": "Jan Kowalski",
		"balance": balance,
		"accountNumber": "00000000"
	});
});


// catch 404 and forward to error handler
app.use(function(req, res, next) {
    /*var err = new Error('Not Found');
    err.status = 404;
    next(err);*/
    return res.status(404).json({
        success: false,
        message: "not found"
    });
});

if (app.get('env') === 'development') {
    app.use(function(err, req, res, next) {
        console.log(err);
        return res.status(err.status || 500).jsonp({
            success: false,
            "data": [{
                message: err.message
            }]
        });
    });
}


var port = process.env.PORT || 9001;

const server = app.listen(port, function() {
    console.log('Server up at http://localhost:' + port);
});

process.on('SIGTERM', () => {
    console.info('SIGTERM signal received.');
    console.log('Closing http server.');
    server.close(() => {
        console.log('Http server closed.');
    });
});

process.on('SIGINT', () => {
    console.info('SIGINT signal received.');
    console.log('Closing http server.');
    server.close(() => {
        console.log('Http server closed.');
    });
});