Selenum tests for web sites.

sideflow.js - adds looping to selenium scripts
- https://github.com/darrenderidder/sideflow/blob/master/sideflow.js
- http://stackoverflow.com/questions/11033321/how-to-loop-tests-in-selenium-ide

Do this:

Download this js file: https://github.com/darrenderidder/sideflow/blob/master/sideflow.js
Launch Selenium IDE from Firefox and open the options menu.
Upload the .js file to the "Selenium Core extensions (user-extensions.js)" field.
The js file provides goto, gotoIf and while loop functionality in Selenium IDE. The example below shows a simple loop:

<tr>
    <td>getEval</td>
    <td>index = 0;</td>
    <td></td>
</tr>
<tr>
    <td>while</td>
    <td>index &lt; 10;</td>
    <td></td>
</tr>
<tr>
    <td>storeEval</td>
    <td>index</td>
    <td>value</td>
</tr>
<tr>
    <td>echo</td>
    <td>${value}</td>
    <td></td>
</tr>
<tr>
    <td>getEval</td>
    <td>index++;</td>
    <td></td>
</tr>
<tr>
    <td>endWhile</td>
    <td></td>
    <td></td>
</tr>

note:
    index &lt; 10;
  looks like
    index < 10;
  in selenium window
