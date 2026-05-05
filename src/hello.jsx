import React from 'react';
import ReactDOMServer from 'react-dom/server';

const App = () => "hello world!";

console.log(ReactDOMServer.renderToString(<App />));