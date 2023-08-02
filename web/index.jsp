<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/8/2
  Time: 16:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>tomcat启动!</title>
    <style>
        html,
        body {
            height: 100%;
            margin: 0;
            padding: 0
        }

        ul,
        li {
            text-indent: 0;
            text-decoration: none;
            margin: 0;
            padding: 0
        }

        img {
            border: 0
        }

        body {
            background-color: #000;
            color: #999;
            font: 100%/18px helvetica, arial, sans-serif;
        }

        canvas {
            cursor: crosshair;
            display: block;
            left: 0;
            position: absolute;
            top: 0;
            z-index: 20
        }

        #moon {
            margin-top: 30px;
            margin-left: 900px;
        }

        #text {
            color: #ffdf00;
            font-size: 50px;
            position: absolute;
            top: 100px;
            left: 50%;
            transform: translateX(-50%);
            filter: url(#text-filter);
            text-shadow: 0 5px 15px #ff0000ed;
            letter-spacing: 10px;
        }
        .pull-rope{
            position: absolute;
            top: 0;
            left: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .mode{
            width: 100px;
            height: 40px;
            color: #fff;
            text-align: center;
            line-height: 40px;
            background: url(https://img2.baidu.com/it/u=580689249,230811503&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=234);
            background-size: 100% 100%;
            font-weight: bold;
        }
        .rope{
            width: 10px;
            height: 300px;
            border-radius: 0 0 5px 5px;
            background: darkorange;
            z-index: 99;
        }

    </style>

</head>
<body>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
<script type="text/javascript">
    $(function() {
        //烟花
        var Fireworks = function() {
            var self = this;
            var rand = function(rMi, rMa) {
                return ~~((Math.random() * (rMa - rMi + 1)) + rMi);
            }
            var hitTest = function(x1, y1, w1, h1, x2, y2, w2, h2) {
                return !(x1 + w1 < x2 || x2 + w2 < x1 || y1 + h1 < y2 || y2 + h2 < y1);
            };
            /**window.requestAnimationFrame() 告诉浏览器——你希望执行一个动画，并且要求浏览器在下次重绘之前调用指定的回调函数更新动画。
             该方法需要传入一个回调函数作为参数，该回调函数会在浏览器下一次重绘之前执行
             封装一下，可以兼容所有浏览器*/
            window.requestAnimFrame = function() {
                return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window
                    .mozRequestAnimationFrame || window.oRequestAnimationFrame || window
                    .msRequestAnimationFrame || function(a) {
                    window.setTimeout(a, 1E3 / 60)
                }
            }();
            //初始化,创建画布，和初始化需要的参数
            self.init = function() {
                self.mode = "auto"
                self.canvas = document.createElement('canvas');
                self.canvas.width = self.cw = $(window).innerWidth();
                self.canvas.height = self.ch = $(window).innerHeight();
                self.particles = [];
                self.partCount = 150;
                self.fireworks = [];
                self.mx = self.cw / 2;
                self.my = self.ch / 2;
                self.currentHue = 30;
                self.partSpeed = 5;
                self.partSpeedVariance = 10;
                self.partWind = 50;
                self.partFriction = 5;
                self.partGravity = 1;
                self.hueMin = 0;
                self.hueMax = 360;
                self.fworkSpeed = 4;
                self.fworkAccel = 10;
                self.hueVariance = 30;
                self.flickerDensity = 25;
                self.showShockwave = true;
                self.showTarget = false;
                self.clearAlpha = 25;

                $(document.body).append(self.canvas);
                self.ctx = self.canvas.getContext('2d');
                self.ctx.lineCap = 'round';
                self.ctx.lineJoin = 'round';
                self.lineWidth = 1;
                self.bindEvents();
                self.canvasLoop();

                self.canvas.onselectstart = function() {
                    return false;
                };
            };
            //创建烟花粒子
            self.createParticles = function(x, y, hue) {
                var countdown = self.partCount;
                while (countdown--) {
                    var newParticle = {
                        x: x,
                        y: y,
                        coordLast: [{
                            x: x,
                            y: y
                        },
                            {
                                x: x,
                                y: y
                            },
                            {
                                x: x,
                                y: y
                            }
                        ],
                        angle: rand(0, 360),
                        speed: rand(((self.partSpeed - self.partSpeedVariance) <= 0) ? 1 : self
                            .partSpeed - self.partSpeedVariance, (self.partSpeed + self
                            .partSpeedVariance)),
                        friction: 1 - self.partFriction / 100,
                        gravity: self.partGravity / 2,
                        hue: rand(hue - self.hueVariance, hue + self.hueVariance),
                        brightness: rand(50, 80),
                        alpha: rand(40, 100) / 100,
                        decay: rand(10, 50) / 1000,
                        wind: (rand(0, self.partWind) - (self.partWind / 2)) / 25,
                        lineWidth: self.lineWidth
                    };
                    self.particles.push(newParticle);
                }
            };

            //更新烟花粒子
            self.updateParticles = function() {
                var i = self.particles.length;
                while (i--) {
                    var p = self.particles[i];
                    var radians = p.angle * Math.PI / 180;
                    var vx = Math.cos(radians) * p.speed;
                    var vy = Math.sin(radians) * p.speed;
                    p.speed *= p.friction;

                    p.coordLast[2].x = p.coordLast[1].x;
                    p.coordLast[2].y = p.coordLast[1].y;
                    p.coordLast[1].x = p.coordLast[0].x;
                    p.coordLast[1].y = p.coordLast[0].y;
                    p.coordLast[0].x = p.x;
                    p.coordLast[0].y = p.y;

                    p.x += vx;
                    p.y += vy;
                    p.y += p.gravity;

                    p.angle += p.wind;
                    p.alpha -= p.decay;

                    if (!hitTest(0, 0, self.cw, self.ch, p.x - p.radius, p.y - p.radius, p.radius * 2, p
                        .radius * 2) || p.alpha < .05) {
                        self.particles.splice(i, 1);
                    }
                };
            };
            //绘制烟花粒子
            self.drawParticles = function() {
                var i = self.particles.length;
                while (i--) {
                    var p = self.particles[i];

                    var coordRand = (rand(1, 3) - 1);
                    self.ctx.beginPath();
                    self.ctx.moveTo(Math.round(p.coordLast[coordRand].x), Math.round(p.coordLast[
                        coordRand].y));
                    self.ctx.lineTo(Math.round(p.x), Math.round(p.y));
                    self.ctx.closePath();
                    self.ctx.strokeStyle = 'hsla(' + p.hue + ', 100%, ' + p.brightness + '%, ' + p
                        .alpha + ')';
                    self.ctx.stroke();

                    if (self.flickerDensity > 0) {
                        var inverseDensity = 50 - self.flickerDensity;
                        if (rand(0, inverseDensity) === inverseDensity) {
                            self.ctx.beginPath();
                            self.ctx.arc(Math.round(p.x), Math.round(p.y), rand(p.lineWidth, p
                                .lineWidth + 3) / 2, 0, Math.PI * 2, false)
                            self.ctx.closePath();
                            var randAlpha = rand(50, 100) / 100;
                            self.ctx.fillStyle = 'hsla(' + p.hue + ', 100%, ' + p.brightness + '%, ' +
                                randAlpha + ')';
                            self.ctx.fill();
                        }
                    }
                };
            };

            //创建烟花
            self.createFireworks = function(startX, startY, targetX, targetY) {
                var newFirework = {
                    x: startX,
                    y: startY,
                    startX: startX,
                    startY: startY,
                    hitX: false,
                    hitY: false,
                    coordLast: [{
                        x: startX,
                        y: startY
                    },
                        {
                            x: startX,
                            y: startY
                        },
                        {
                            x: startX,
                            y: startY
                        }
                    ],
                    targetX: targetX,
                    targetY: targetY,
                    speed: self.fworkSpeed,
                    angle: Math.atan2(targetY - startY, targetX - startX),
                    shockwaveAngle: Math.atan2(targetY - startY, targetX - startX) + (90 * (Math.PI /
                        180)),
                    acceleration: self.fworkAccel / 100,
                    hue: self.currentHue,
                    brightness: rand(50, 80),
                    alpha: rand(50, 100) / 100,
                    lineWidth: self.lineWidth
                };
                self.fireworks.push(newFirework);

            };

            //更新烟花参数
            self.updateFireworks = function() {
                var i = self.fireworks.length;

                while (i--) {
                    var f = self.fireworks[i];
                    self.ctx.lineWidth = f.lineWidth;

                    vx = Math.cos(f.angle) * f.speed,
                        vy = Math.sin(f.angle) * f.speed;
                    f.speed *= 1 + f.acceleration;
                    f.coordLast[2].x = f.coordLast[1].x;
                    f.coordLast[2].y = f.coordLast[1].y;
                    f.coordLast[1].x = f.coordLast[0].x;
                    f.coordLast[1].y = f.coordLast[0].y;
                    f.coordLast[0].x = f.x;
                    f.coordLast[0].y = f.y;

                    if (f.startX >= f.targetX) {
                        if (f.x + vx <= f.targetX) {
                            f.x = f.targetX;
                            f.hitX = true;
                        } else {
                            f.x += vx;
                        }
                    } else {
                        if (f.x + vx >= f.targetX) {
                            f.x = f.targetX;
                            f.hitX = true;
                        } else {
                            f.x += vx;
                        }
                    }

                    if (f.startY >= f.targetY) {
                        if (f.y + vy <= f.targetY) {
                            f.y = f.targetY;
                            f.hitY = true;
                        } else {
                            f.y += vy;
                        }
                    } else {
                        if (f.y + vy >= f.targetY) {
                            f.y = f.targetY;
                            f.hitY = true;
                        } else {
                            f.y += vy;
                        }
                    }

                    if (f.hitX && f.hitY) {
                        self.createParticles(f.targetX, f.targetY, f.hue);
                        self.fireworks.splice(i, 1);

                    }
                };
            };
            //绘制烟花
            self.drawFireworks = function() {
                var i = self.fireworks.length;
                self.ctx.globalCompositeOperation = 'lighter';
                while (i--) {
                    var f = self.fireworks[i];
                    self.ctx.lineWidth = f.lineWidth;

                    var coordRand = (rand(1, 3) - 1);
                    self.ctx.beginPath();
                    self.ctx.moveTo(Math.round(f.coordLast[coordRand].x), Math.round(f.coordLast[
                        coordRand].y));
                    self.ctx.lineTo(Math.round(f.x), Math.round(f.y));
                    self.ctx.closePath();
                    self.ctx.strokeStyle = 'hsla(' + f.hue + ', 100%, ' + f.brightness + '%, ' + f
                        .alpha + ')';
                    self.ctx.stroke();

                    if (self.showTarget) {
                        self.ctx.save();
                        self.ctx.beginPath();
                        self.ctx.arc(Math.round(f.targetX), Math.round(f.targetY), rand(1, 8), 0, Math
                            .PI * 2, false)
                        self.ctx.closePath();
                        self.ctx.lineWidth = 1;
                        self.ctx.stroke();
                        self.ctx.restore();
                    }

                    if (self.showShockwave) {
                        self.ctx.save();
                        self.ctx.translate(Math.round(f.x), Math.round(f.y));
                        self.ctx.rotate(f.shockwaveAngle);
                        self.ctx.beginPath();
                        self.ctx.arc(0, 0, 1 * (f.speed / 5), 0, Math.PI, true);
                        self.ctx.strokeStyle = 'hsla(' + f.hue + ', 100%, ' + f.brightness + '%, ' +
                            rand(25, 60) / 100 + ')';
                        self.ctx.lineWidth = f.lineWidth;
                        self.ctx.stroke();
                        self.ctx.restore();
                    }
                };
            };
            self.autoPlayTimer = null
            self.autoPlay = function() {
                let maxW = window.screen.width
                let maxH = window.screen.height
                let x = Math.floor(Math.random() * (maxW - 300)) + 150;
                let y = Math.floor(Math.random() * (maxH - 250));
                fworks.mx = x - fworks.canvas.offsetLeft;
                fworks.my = y- fworks.canvas.offsetTop;
                fworks.currentHue = rand(fworks.hueMin, fworks.hueMax);
                fworks.createFireworks(fworks.cw / 2, fworks.ch, fworks.mx, fworks.my);
            }
            //绑定事件
            self.bindEvents = function() {

                $('.rope').on('load', function(e) {
                    e.stopPropagation();
                    $('.rope').animate({height: '400px'},500,function() {
                        $('.rope').animate({height: '300px'},500)
                    })
                    //切换手动
                    self.mode = self.mode === 'auto'?'Manual':'auto'
                    $('.mode').text(self.mode === 'auto'?'自 动':'手 动')
                    clearInterval(self.autoPlayTimer)
                    self.autoPlayTimer = null
                });

                $(window).on('load', function() {
                    if(self.mode == 'Manual')return
                    if(self.autoPlayTimer){
                        clearInterval(self.autoPlayTimer)
                        self.autoPlayTimer = null
                    }else{
                        self.autoPlayTimer = setInterval(function() {
                            self.autoPlay()
                        },100)
                    }
                });

                $(window).on('resize', function() {
                    clearTimeout(self.timeout);
                    self.timeout = setTimeout(function() {
                        self.canvas.width = self.cw = $(window).innerWidth();
                        self.canvas.height = self.ch = $(window).innerHeight();
                        self.ctx.lineCap = 'round';
                        self.ctx.lineJoin = 'round';
                    }, 100);
                });

                $(self.canvas).on('mousedown', function(e) {
                    if(self.mode == 'auto')return
                    self.mx = e.pageX - self.canvas.offsetLeft;
                    self.my = e.pageY - self.canvas.offsetTop;
                    console.log(e.pageY)
                    self.currentHue = rand(self.hueMin, self.hueMax);
                    self.createFireworks(self.cw / 2, self.ch, self.mx, self.my);

                    $(self.canvas).on('mousemove.fireworks', function(e) {
                        if(self.mode == 'auto')return
                        self.mx = e.pageX - self.canvas.offsetLeft;
                        self.my = e.pageY - self.canvas.offsetTop;
                        self.currentHue = rand(self.hueMin, self.hueMax);
                        self.createFireworks(self.cw / 2, self.ch, self.mx, self.my);
                    });
                });

                $(self.canvas).on('mouseup', function(e) {
                    if(self.mode == 'auto')return
                    $(self.canvas).off('mousemove.fireworks');
                });

            }

            self.clear = function() {
                self.particles = [];
                self.fireworks = [];
                self.ctx.clearRect(0, 0, self.cw, self.ch);
            };


            self.canvasLoop = function() {
                //requestAnimationFrame是浏览器用于定时循环操作的一个接口，类似于setTimeout，主要用途是按帧对网页进行重绘。
                requestAnimFrame(self.canvasLoop, self.canvas);
                self.ctx.globalCompositeOperation = 'destination-out';
                self.ctx.fillStyle = 'rgba(0,0,0,' + self.clearAlpha / 100 + ')';
                self.ctx.fillRect(0, 0, self.cw, self.ch);
                self.updateFireworks();
                self.updateParticles();
                self.drawFireworks();
                self.drawParticles();

            };

            self.init();

        }
        var fworks = new Fireworks();

    });
</script>
<img id="moon" src="https://img1.baidu.com/it/u=726891218,2328235929&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500"
     width="400px" ;height="400px" ; />

<span>
    <marquee behavior="alternate" direction="right" ><font style="font-size: 50px; background-image:-webkit-linear-gradient(bottom,red,#fd8403,yellow); -webkit-background-clip:text; -webkit-text-fill-color:transparent;">tomcat 启动!</font></marquee>

</span>




<div class="pull-rope">
    <div class="mode">自 动</div>
    <div class="rope"></div>
</div>

<svg width="0" height="0">
    <filter id="text-filter">

        <!--定义feTurbulence滤镜-->
        <feTurbulence baseFrequency="0.02" seed="0">

            <!--这是svg动画的定义方式，通过动画不断改变seed的值，形成抖动效果-->
            <animate attributeName="seed" dur="1s" keyTimes="0;0.5;1" values="1;2;3" repeatCount="indefinite">
            </animate>
        </feTurbulence>
        <feDisplacementMap in="SourceGraphic" scale="10" />
    </filter>
</svg>
</body>

</html>