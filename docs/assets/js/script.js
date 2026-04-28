
//  zooma in på bilder i läsvy
const img = document.querySelector('.zoom-img');

document.querySelectorAll('.zoom-img').forEach(img => {
  img.addEventListener('mousemove', function(e) {
    const rect = this.getBoundingClientRect();
    const x = (e.clientX - rect.left) / rect.width * 100;
    const y = (e.clientY - rect.top) / rect.height * 100;

    this.style.transformOrigin = `${x}% ${y}%`;
    this.style.transform = "scale(3)";
  });

  img.addEventListener('mouseleave', function() {
    this.style.transform = "scale(1)";
  });
});

// Script för toggla text på authorsida.
function toggleText() {
  let descText = document.getElementById('author_desc_text');

  if(descText.classList.contains('hide_text')) {
    // descText.classList.add('open_author')
    descText.classList.remove('hide_text');
  } else {
    // descText.classList.remove("open_author");
    descText.classList.add('hide_text');
  }
}