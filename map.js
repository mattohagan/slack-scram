var fs = require('fs');
var string = fs.readFileSync('map1.txt').toString().split('');
var multi = [[0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0]];
var i = 0;
var k = 0;

for (var j = 0; j < string.length; j++)
{


  multi[i][k] = string[j];
  console.log('-------');
  console.log(string[j] + ':' + j);
  console.log(multi[i][k] + ' ' + i + '|' + k);
  console.log('-------');


  if ((k % 9 === 0) && (k !== 0))
  {
    j++;
    i++;
    k = 0;
  } else {
    k++
  }

  console.log(j % 9);

}


console.log(multi[0][1]);
