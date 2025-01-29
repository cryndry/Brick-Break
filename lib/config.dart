const double gameWidth = 800;
const double gameHeight = 1600;
const initialDifficulty = 1.03;

const double ballRadius = gameWidth * 0.02;
const int ballColor = 0xFF0000FF;

const double batWidth = gameWidth * 0.2;
const double batHeight = ballRadius * 2;
const double batCornerRadius = batHeight * 0.5;
const double batStep = gameWidth * 0.05;
const int batColor = 0xFF0000FF;

const double brickGutter = gameWidth * 0.015;
final double brickWidth = (gameWidth - (brickGutter * (brickColors.length + 1))) / brickColors.length;
const double brickHeight = gameHeight * 0.03;
const List<int> brickColors = [
  0xfff94144,
  0xfff3722c,
  0xfff8961e,
  0xfff9844a,
  0xfff9c74f,
  0xff90be6d,
  0xff43aa8b,
  0xff4d908e,
  0xff277da1,
  0xff577590,
];
