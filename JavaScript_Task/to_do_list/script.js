// Select DOM elements
const taskInput = document.getElementById('task-input');
const addTaskBtn = document.getElementById('add-task-btn');
const taskList = document.getElementById('task-list');

let tasks = JSON.parse(localStorage.getItem('tasks')) || [];

// Render tasks on page load
renderTasks();

// Add a new task
addTaskBtn.addEventListener('click', () => {
  const task = taskInput.value.trim();
  if (task) {
    tasks.push(task);
    updateLocalStorage();
    renderTasks();
    taskInput.value = '';
  }
});

// Render tasks to the DOM
function renderTasks() {
  taskList.innerHTML = '';
  tasks.forEach((task, index) => {
    const li = document.createElement('li');
    li.className = 'task-item';

    li.innerHTML = `
      <span>${task}</span>
      <button class="edit-btn" onclick="editTask(${index})">Edit</button>
      <button class="delete-btn" onclick="deleteTask(${index})">Delete</button>
    `;

    taskList.appendChild(li);
  });
}

// Edit a task
function editTask(index) {
  const newTask = prompt('Edit your task:', tasks[index]);
  if (newTask !== null && newTask.trim() !== '') {
    tasks[index] = newTask.trim();
    updateLocalStorage();
    renderTasks();
  }
}

// Delete a task
function deleteTask(index) {
  tasks.splice(index, 1);
  updateLocalStorage();
  renderTasks();
}

// Update LocalStorage
function updateLocalStorage() {
  localStorage.setItem('tasks', JSON.stringify(tasks));
}
