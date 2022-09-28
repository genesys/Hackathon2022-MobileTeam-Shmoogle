const GoogleHome = require("google-home-push");
const localtunnel = require('localtunnel');

// Pass the name or IP address of your device
const myHome = new GoogleHome("10.0.0.14");

const express = require('express')
const app = express()
const port = 3000

app.get('/message', (req, res) => {
  myHome.speak(req.query.text);
  res.json({
    message: req.query.text
  })
})

app.listen(port, async () => {
  console.log(`Example app listening on port ${port}`)

  const tunnel = await localtunnel({ port: 3000, subdomain:"shmooogle" });

  // the assigned public url for your tunnel
  // i.e. https://abcdefgjhij.localtunnel.me
  console.log(`tunnelUrl= ${tunnel.url}`);

  tunnel.on('close', () => {
    // tunnels are closed
    console.log(`tunnel is closed`)
  });

  function exitHandler(options, exitCode) {
    tunnel.close();
    if (options.exit) process.exit();
  }

  //do something when app is closing
  process.on('exit', exitHandler.bind(null,{cleanup:true}));

  //catches ctrl+c event
  process.on('SIGINT', exitHandler.bind(null, {exit:true}));

  // catches "kill pid" (for example: nodemon restart)
  process.on('SIGUSR1', exitHandler.bind(null, {exit:true}));
  process.on('SIGUSR2', exitHandler.bind(null, {exit:true}));

  //catches uncaught exceptions
  process.on('uncaughtException', exitHandler.bind(null, {exit:true}));
})





/*const http = require('http');

const hostname = '127.0.0.1';
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World');
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});*/
