document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll('.navbar a[href$="molligo-cv.pdf"]').forEach(link => {
    link.target = "_blank";
    link.rel = "noopener";
  });
});