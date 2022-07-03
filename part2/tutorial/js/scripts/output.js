const topicContents = [
  {
    title: "JavaScript Display Possibilities",
    description:
      "Writing into an HTML element, using innerHTML.&lt;br/&gt;Writing into the HTML output using document.write().&lt;br/&gt;Writing into an alert box, using window.alert().&lt;br/&gt;Writing into the browser console, using console.log().",
    example: "",
  },
  {
    title: "Using innerHTML",
    description:
      "To access an HTML element, JavaScript can use the document.getElementById(id) method.&lt;br/&gt;The id attribute defines the HTML element. The innerHTML property defines the HTML content:",
    example:
      "&lt;!DOCTYPE html&gt;<br/>&lt;html&gt;<br/>&lt;body&gt;<br/>&lt;h1&gt;My First Web Page&lt;/h1&gt;<br/>&lt;p&gt;My First Paragraph&lt;/p&gt;<br/>&lt;p id='demo'&gt;&lt;/p&gt;<br/>&lt;script&gt;<br/>document.getElementById('demo').innerHTML = 5 + 6;<br/>&lt;/script&gt;<br/>&lt;/body&gt;<br/>&lt;/html&gt;",
  },
];
