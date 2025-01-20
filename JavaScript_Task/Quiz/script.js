// script.js

const questions = [
    {
      question: "What is the capital of France?",
      options: ["Paris", "London", "Berlin", "Madrid"],
      answer: "Paris",
    },
    {
      question: "Which planet is known as the Red Planet?",
      options: ["Earth", "Mars", "Jupiter", "Saturn"],
      answer: "Mars",
    },
    {
      question: "Who wrote 'Hamlet'?",
      options: ["Shakespeare", "Chaucer", "Homer", "Dickens"],
      answer: "Shakespeare",
    },
  ];
  
  let currentQuestionIndex = 0;
  let score = 0;
  
  // DOM Elements
  const homeScreen = document.getElementById("home-screen");
  const quizScreen = document.getElementById("quiz-screen");
  const resultScreen = document.getElementById("result-screen");
  
  const questionEl = document.getElementById("question");
  const optionsContainer = document.getElementById("options-container");
  const nextBtn = document.getElementById("next-btn");
  const scoreEl = document.getElementById("score");
  const resetBtn = document.getElementById("reset-btn");
  const startBtn = document.getElementById("start-btn");
  
  // Start Quiz
  startBtn.addEventListener("click", () => {
    homeScreen.classList.add("d-none");
    quizScreen.classList.remove("d-none");
    loadQuestion();
  });
  
  // Load Question
  function loadQuestion() {
    const currentQuestion = questions[currentQuestionIndex];
    questionEl.textContent = currentQuestion.question;
    optionsContainer.innerHTML = "";
  
    currentQuestion.options.forEach((option) => {
      const button = document.createElement("button");
      button.classList.add("btn", "btn-outline-primary", "btn-block", "mt-2");
      button.textContent = option;
      button.addEventListener("click", () => handleAnswer(option));
      optionsContainer.appendChild(button);
    });
  }
  
  // Handle Answer
  function handleAnswer(selectedOption) {
    const currentQuestion = questions[currentQuestionIndex];
    const buttons = optionsContainer.querySelectorAll("button");
  
    buttons.forEach((button) => {
      button.disabled = true;
      if (button.textContent === currentQuestion.answer) {
        button.classList.add("btn-success");
      } else if (button.textContent === selectedOption) {
        button.classList.add("btn-danger");
      }
    });
  
    if (selectedOption === currentQuestion.answer) {
      score++;
    }
  
    nextBtn.classList.remove("d-none");
  }
  
  // Next Question
  nextBtn.addEventListener("click", () => {
    currentQuestionIndex++;
    if (currentQuestionIndex < questions.length) {
      loadQuestion();
    } else {
      showResult();
    }
    nextBtn.classList.add("d-none");
  });
  
  // Show Result
  function showResult() {
    quizScreen.classList.add("d-none");
    resultScreen.classList.remove("d-none");
    scoreEl.textContent = `${score} / ${questions.length}`;
  }
  
  // Reset Quiz
  resetBtn.addEventListener("click", () => {
    currentQuestionIndex = 0;
    score = 0;
    resultScreen.classList.add("d-none");
    homeScreen.classList.remove("d-none");
  });
  