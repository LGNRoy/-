var CW = 400, CH = 320;

var diffculty = 1, currentRgb = new Array(0,0,0);
var SQURE_SIZE = 20;
var LINE_SIZE = 2;
var NUMB = 11;

function init() {
  var c = document.getElementById("cuzzle");
  CW = document.body.offsetWidth;
  c.width = CW;
  c.height = CW;
  var ctx = c.getContext("2d");

  run(ctx);
}



function run(ctx){
  var position = calculatePosition();

  var isRight = true;

  while(isRight) {
    initOnce(ctx, position);
    isRight = isSuccess();
    diffculty++;

    if(diffculty > 30) {
      isRight = false;
    }
  }

  if(diffculty > 30) {
    alert("success!");
  } else {
    alert("failed");
  }
}

function isSuccess () {
  var isRight = true;

  console.log("成功：" + isRight);
  return isRight;
}

function initOnce(ctx, position) {
  console.log("第" + diffculty + "次");

  var rgb = new Array(3);
  var difference = calculateDifference();

  rgb[0] = getRandom(0, 256);
  rgb[1] = getRandom(0, 256);
  rgb[2] = getRandom(0, 256);
  console.log("当前颜色：[" + rgb[0] + ", " + rgb[1] + ", " + rgb[2] + "]");

  draw(ctx, position, rgb);
}

function draw(ctx, position, rgb){
  console.log("绘制一次");

  for()

}

function calculatePosition() {
  var paintSize = NUMB * SQURE_SIZE + (NUMB - 1) * LINE_SIZE;

  CW = document.body.offsetWidth;
  CH = CW;
  var StartPoint = {
    x: (CW - paintSize) / 2;
    y: (CH - paintSize) / 2;
  };

  var re = [];
  for(var row = 0; row < NUMB; row ++) {
    for(var col = 0; col < NUMB; col ++) {
      var Point = {
        x: StartPoint.x + col * (SQURE_SIZE + LINE_SIZE);
        y: StartPoint.y + row * (SQURE_SIZE + LINE_SIZE);
      };
      re.push(Point);
    }
  }

  return re;
}

function calculateDifference() {
  var difference = new Array(3);

  var differencePoint = 0;
  if (diffculty > 15) {
    differencePoint = diffculty + 24;
  } else {
    differencePoint = Math.floor(0.8 * diffculty + 27);
  }
  console.log("偏差总值："+differencePoint);

  difference[0] = getRandom(0, differencePoint + 1);
  differencePoint -= R;
  difference[1] = getRandom(0, differencePoint + 1);
  differencePoint -= G;
  difference[2] = differencePoint;
  console.log("随机值：[" + difference[0] + ", " + difference[1] + ", " + difference[2] + "]");

  return difference;
}

function getRandom(start, end) {
  var scale = end - start;
  var random = Math.random();
  var result = Math.floor(random * scale) + start;
  return result;
}
