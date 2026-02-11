document.addEventListener("nav", () => {
  for (const toggleButton of document.getElementsByClassName("sidebar-toggle")) {
    const toggle = () => {
      document.body.classList.toggle("show-sidebar")
    }
    toggleButton.addEventListener("click", toggle)
    window.addCleanup(() => toggleButton.removeEventListener("click", toggle))
  }

  // Reset sidebar state on navigation
  document.body.classList.remove("show-sidebar")
})
