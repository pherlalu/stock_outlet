// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails";
import "controllers"
Turbo.start()

// Ensure Turbo loads the script for dropdown functionality
document.addEventListener('turbo:load', () => {
  const button = document.getElementById('user-menu-button');
  const menu = document.querySelector('[aria-labelledby="user-menu-button"]');

  if (button && menu) {
    const closeMenu = () => {
      menu.classList.add('hidden');
      menu.classList.remove('opacity-100', 'scale-100');
      menu.classList.add('opacity-0', 'scale-95');
    };

    button.addEventListener('click', () => {
      if (menu.classList.contains('hidden')) {
        menu.classList.remove('hidden');
        menu.classList.remove('opacity-0', 'scale-95');
        menu.classList.add('opacity-100', 'scale-100');
      } else {
        closeMenu();
      }
    });

    document.addEventListener('click', (event) => {
      if (!button.contains(event.target) && !menu.contains(event.target)) {
        closeMenu();
      }
    });

    menu.querySelectorAll('[role="menuitem"]').forEach(item => {
      item.addEventListener('click', () => {
        closeMenu();
      });
    });

    // Handle keyboard navigation
    button.addEventListener('keydown', (event) => {
      if (event.key === 'Escape') {
        closeMenu();
      }
    });
  }
});