// Initialization
const express = require('express');
const app = express();

const mongoose = require('mongoose');
const Note = require('./models/Note');
const cors = require('cors');
app.use(cors());

const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const mongoDbPath = "mongodb+srv://3zuilachinh3:3zuilachinh3@cluster0.kmmmvrq.mongodb.net/data";
mongoose.connect(mongoDbPath).then(function () {
    app.get("/", function (req, res) {
        const response = { statuscode: res.statusCode, message: "API Works!" };
        res.json(response);
    });

    const noteRouter = require('./routers/Note');
    app.use("/notes", noteRouter);
});

// Starting the server on a PORT
const PORT = process.env.PORT || 5005;
app.listen(PORT, function () {
    console.log("Server started at PORT: " + PORT);
});