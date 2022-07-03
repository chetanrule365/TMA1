const images = [
  {
    image:
      "https://media.istockphoto.com/photos/taj-mahal-mausoleum-in-agra-picture-id1146517111?k=20&m=1146517111&s=612x612&w=0&h=vHWfu6TE0R5rG6DJkV42Jxr49aEsLN0ML-ihvtim8kk=",
    caption: "Taj Mahal",
  },
  {
    image:
      "https://cdn.theculturetrip.com/wp-content/uploads/2017/11/holi-2416686_1280.jpg",
    caption: "Holi Festival",
  },
  {
    image:
      "https://www.shezoned.com/wp-content/uploads/2021/03/Indian-Dresses.jpg",
    caption: "Indian Dresses",
  },
];

const canvas1 = document.getElementById("canvas1");
const canvas2 = document.getElementById("canvas2");
const ctx1 = canvas1.getContext("2d");
const img1 = new Image();
let slideCounter = 0;
let sequenceSlideShow;
let transitionSlideshow;
let transitionInterval;
let selectedTransition = "sequence";

const changeSlideCounter = (incrementer = 1) => {
  slideCounter += incrementer;
  if (slideCounter === images.length) {
    slideCounter = 0;
  }
  if (slideCounter === -1) {
    slideCounter = images.length - 1;
  }
};

const sequenceSlideShowLogic = (incrementer = 1) => {
  changeSlideCounter(incrementer);
  img1.src = images[slideCounter].image;
  img1.onload = function () {
    ctx1.drawImage(img1, 0, 0, canvas1.width, canvas1.height);
  };
};

const startSequenceSlideShow = () => {
  clearInterval(sequenceSlideShow);
  sequenceSlideShow = setInterval(sequenceSlideShowLogic, 3000);
};

const transitionEffect = () => {
  let length = 0;
  transitionInterval = setInterval(function () {
    ctx1.reset();
    ctx1.beginPath();
    if (selectedTransition === "square") {
      const xOffset = Math.floor((canvas2.width - length) / 2);
      const yOffset = Math.floor((canvas2.height - length) / 2);
      ctx1.drawImage(img1, xOffset, yOffset, length, length);
    } else {
      ctx1.arc(canvas2.width / 2, canvas2.height / 2, length, 0, 2 * Math.PI);
      ctx1.clip();
      ctx1.drawImage(img1, 0, 0, canvas2.width, canvas2.height);
    }
    ctx1.closePath();
    length = length + 2;
    if (length > canvas2.height) {
      clearInterval(transitionInterval);
    }
  }, 40);
};

const transitionSlideShowLogic = (incrementer = 1) => {
  changeSlideCounter(incrementer);
  img1.src = images[slideCounter].image;
  clearInterval(transitionInterval);
  transitionEffect();
};

const startTransitionSlideShow = () => {
  clearInterval(transitionSlideshow);
  transitionSlideshow = setInterval(transitionSlideShowLogic, 5000);
};

const startSlideShow = () => {
  if (selectedTransition === "sequence") startSequenceSlideShow();
  if (selectedTransition === "circle" || selectedTransition === "square")
    startTransitionSlideShow();
  document.getElementById("start-button").style.display = "none";
  document.getElementById("stop-button").style.display = "block";
};

const stopSlideShow = () => {
  clearInterval(sequenceSlideShow);
  clearInterval(transitionSlideshow);
  document.getElementById("start-button").style.display = "block";
  document.getElementById("stop-button").style.display = "none";
};

const nextSlide = () => {
  if (selectedTransition === "sequence") {
    sequenceSlideShowLogic(1);
    startSequenceSlideShow();
  }
  if (selectedTransition === "circle" || selectedTransition === "square") {
    clearInterval(transitionInterval);
    transitionSlideShowLogic(1);
    startTransitionSlideShow();
  }
};

const prevSlide = () => {
  if (selectedTransition === "sequence") {
    sequenceSlideShowLogic(-1);
    startSequenceSlideShow();
  }
  if (selectedTransition === "circle" || selectedTransition === "square") {
    clearInterval(transitionInterval);
    transitionSlideShowLogic(-1);
    startTransitionSlideShow();
  }
};

document.getElementById("transitions").addEventListener("change", (e) => {
  selectedTransition = e.target.value;
  stopSlideShow();
  startSlideShow();
});

img1.src = images[slideCounter].image;
img1.onload = function () {
  ctx1.drawImage(img1, 0, 0, canvas1.width, canvas1.height);
};
startSequenceSlideShow();
document.getElementById("start-button").style.display = "none";
