// script.js

const articles = [];
const articlesPerPage = 4;
let currentPage = 1;

// DOM Elements
const articleForm = document.getElementById('article-form');
const articlesContainer = document.getElementById('articles-container');
const prevBtn = document.getElementById('prev-btn');
const nextBtn = document.getElementById('next-btn');
const pageNumbers = document.getElementById('page-numbers');

// Add article
articleForm.addEventListener('submit', (e) => {
  e.preventDefault();
  const title = document.getElementById('title').value.trim();
  const description = document.getElementById('description').value.trim();
  const imageUrl = document.getElementById('image-url').value.trim();

  if (title && description) {
    articles.push({ title, description, imageUrl });
    articleForm.reset();
    renderArticles();
    renderPagination();
  }
});

// Render articles
function renderArticles() {
  articlesContainer.innerHTML = '';
  const startIndex = (currentPage - 1) * articlesPerPage;
  const endIndex = startIndex + articlesPerPage;
  const articlesToShow = articles.slice(startIndex, endIndex);

  articlesToShow.forEach((article) => {
    const articleElement = document.createElement('div');
    articleElement.classList.add('article');

    articleElement.innerHTML = `
      <h3>${article.title}</h3>
      <p>${article.description}</p>
      ${article.imageUrl ? `<img src="${article.imageUrl}" alt="${article.title}">` : ''}
    `;
    articlesContainer.appendChild(articleElement);
  });
}

// Render pagination
function renderPagination() {
  pageNumbers.innerHTML = '';
  const totalPages = Math.ceil(articles.length / articlesPerPage);

  for (let i = 1; i <= totalPages; i++) {
    const pageButton = document.createElement('button');
    pageButton.textContent = i;
    pageButton.classList.add('page-btn');
    if (i === currentPage) {
      pageButton.disabled = true;
    }
    pageButton.addEventListener('click', () => {
      currentPage = i;
      renderArticles();
      renderPagination();
    });
    pageNumbers.appendChild(pageButton);
  }

  prevBtn.disabled = currentPage === 1;
  nextBtn.disabled = currentPage === totalPages;
}

// Handle Previous button
prevBtn.addEventListener('click', () => {
  if (currentPage > 1) {
    currentPage--;
    renderArticles();
    renderPagination();
  }
});

// Handle Next button
nextBtn.addEventListener('click', () => {
  if (currentPage < Math.ceil(articles.length / articlesPerPage)) {
    currentPage++;
    renderArticles();
    renderPagination();
  }
});
