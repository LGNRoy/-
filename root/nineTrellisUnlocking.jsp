<!DOCTYPE html>
<html>
<head lang="en">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"
          name="viewport"/>
    <meta charset="UTF-8">
    <title></title>
    <style type="text/css">
        html, body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
        }
    </style>
    <script type="text/javascript">
        var R = 26, CW = 400, CH = 320, OffsetX = 30, OffsetY = 30;
        function CaculateNinePointLotion(diffX, diffY) {
            var Re = [];
            for (var row = 0; row < 3; row++) {
                for (var col = 0; col < 3; col++) {
                    var Point = {
                        X: (OffsetX + col * diffX + ( col * 2 + 1) * R),
                        Y: (OffsetY + row * diffY + (row * 2 + 1) * R)
                    };
                    Re.push(Point);
                }
            }
            return Re;
        }
        var PointLocationArr = [];
        window.onload = function () {
            var c = document.getElementById("myCanvas");
            CW = document.body.offsetWidth;
            c.width = CW;
            c.height = CH;
            var cxt = c.getContext("2d");
            //两个圆之间的外距离 就是说两个圆心的距离去除两个半径
            var X = (CW - 2 * OffsetX - R * 2 * 3) / 2;
            var Y = (CH - 2 * OffsetY - R * 2 * 3) / 2;
            PointLocationArr = CaculateNinePointLotion(X, Y);
            InitEvent(c, cxt);
            //CW=2*offsetX+R*2*3+2*X
            Draw(cxt, PointLocationArr, [],null);
        }
        function Draw(cxt, _PointLocationArr, _LinePointArr,touchPoint) {
            if (_LinePointArr.length > 0) {
                cxt.beginPath();
                for (var i = 0; i < _LinePointArr.length; i++) {
                    var pointIndex = _LinePointArr[i];
                    cxt.lineTo(_PointLocationArr[pointIndex].X, _PointLocationArr[pointIndex].Y);
                }
                cxt.lineWidth = 10;
                cxt.strokeStyle = "#627eed";
                cxt.stroke();
                cxt.closePath();
                if(touchPoint!=null)
                {
                    var lastPointIndex=_LinePointArr[_LinePointArr.length-1];
                    var lastPoint=_PointLocationArr[lastPointIndex];
                    cxt.beginPath();
                    cxt.moveTo(lastPoint.X,lastPoint.Y);
                    cxt.lineTo(touchPoint.X,touchPoint.Y);
                    cxt.stroke();
                    cxt.closePath();
                }
            }
            for (var i = 0; i < _PointLocationArr.length; i++) {
                var Point = _PointLocationArr[i];
                cxt.fillStyle = "#627eed";
                cxt.beginPath();
                cxt.arc(Point.X, Point.Y, R, 0, Math.PI * 2, true);
                cxt.closePath();
                cxt.fill();
                cxt.fillStyle = "#ffffff";
                cxt.beginPath();
                cxt.arc(Point.X, Point.Y, R - 3, 0, Math.PI * 2, true);
                cxt.closePath();
                cxt.fill();
                if(_LinePointArr.indexOf(i)>=0)
                {
                    cxt.fillStyle = "#627eed";
                    cxt.beginPath();
                    cxt.arc(Point.X, Point.Y, R -16, 0, Math.PI * 2, true);
                    cxt.closePath();
                    cxt.fill();
                }

            }
        }
        function IsPointSelect(touches,LinePoint)
        {
            for (var i = 0; i < PointLocationArr.length; i++) {
                var currentPoint = PointLocationArr[i];
                var xdiff = Math.abs(currentPoint.X - touches.pageX);
                var ydiff = Math.abs(currentPoint.Y - touches.pageY);
                var dir = Math.pow((xdiff * xdiff + ydiff * ydiff), 0.5);
                if (dir < R ) {
                    if(LinePoint.indexOf(i) < 0){ LinePoint.push(i);}
                    break;
                }
            }
        }
        function InitEvent(canvasContainer, cxt) {
            var LinePoint = [];
            canvasContainer.addEventListener("touchstart", function (e) {
                IsPointSelect(e.touches[0],LinePoint);
            }, false);
            canvasContainer.addEventListener("touchmove", function (e) {
                e.preventDefault();
                var touches = e.touches[0];
                IsPointSelect(touches,LinePoint);
                cxt.clearRect(0,0,CW,CH);
                Draw(cxt,PointLocationArr,LinePoint,{X:touches.pageX,Y:touches.pageY});
            }, false);
            canvasContainer.addEventListener("touchend", function (e) {
                cxt.clearRect(0,0,CW,CH);
                Draw(cxt,PointLocationArr,LinePoint,null);
                alert("密码结果是："+LinePoint.join("->"));
                LinePoint=[];
            }, false);
        }
    </script>
</head>
<body>
<canvas id="myCanvas"></canvas>
</body>
</html>
