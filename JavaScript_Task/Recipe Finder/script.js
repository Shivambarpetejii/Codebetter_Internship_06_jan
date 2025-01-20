// Sample Recipe Data
const recipes = [
    { name: "Pancakes", ingredients: ["egg", "milk", "flour"], type: "breakfast", image: "https://via.placeholder.com/150" },
    { name: "Caesar Salad", ingredients: ["lettuce", "croutons", "cheese"], type: "lunch", image: "https://via.placeholder.com/150" },
    { name: "Spaghetti", ingredients: ["pasta", "tomato sauce"], type: "dinner", image: "https://via.placeholder.com/150" },
    { name: "Smoothie", ingredients: ["banana", "milk", "yogurt"], type: "snack", image: "https://via.placeholder.com/150" },
  ];
  
  // DOM Elements
  const ingredientInput = document.getElementById("ingredient-input");
  const searchBtn = document.getElementById("search-btn");
  const filterType = document.getElementById("filter-type");
  const recipeResults = document.getElementById("recipe-results");
  
  // Search Button Click Event
  searchBtn.addEventListener("click", () => {
    const query = ingredientInput.value.toLowerCase().split(",").map(ing => ing.trim());
    const type = filterType.value;
  
    // Filter Recipes
    const filteredRecipes = recipes.filter(recipe => {
      const hasIngredients = query.every(ing => recipe.ingredients.includes(ing));
      const matchesType = type === "all" || recipe.type === type;
      return hasIngredients && matchesType;
    });
  
    // Display Recipes
    displayRecipes(filteredRecipes);
  });
  
  // Display Recipes
  function displayRecipes(recipesToDisplay) {
    recipeResults.innerHTML = "";
    if (recipesToDisplay.length === 0) {
      recipeResults.innerHTML = "<p>No recipes found matching your criteria.</p>";
      return;
    }
  
    recipesToDisplay.forEach(recipe => {
      const recipeCard = document.createElement("div");
      recipeCard.className = "recipe-card";
  
      recipeCard.innerHTML = `
        <img src="${recipe.image}" alt="${recipe.name}">
        <h3>${recipe.name}</h3>
        <p>Type: ${recipe.type}</p>
        <p>Ingredients: ${recipe.ingredients.join(", ")}</p>
      `;
  
      recipeResults.appendChild(recipeCard);
    });
  }
  