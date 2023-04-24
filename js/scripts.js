window.addEventListener("scroll", () => {
	const secciones = document.querySelectorAll("section");
	const navLi = document.querySelectorAll("nav ul a li");
	let actual = "";

	secciones.forEach((seccion) => {
		const seccionTop = seccion.offsetTop - seccion.offsetHeight / 3;

		if (scrollY >= 0 && scrollY <= 400) {
			actual = "inicio";
		} else if (scrollY >= seccionTop) {
			actual = seccion.getAttribute("id");
		}
	});

	navLi.forEach((li) => {
		li.classList.remove("activa");

		if (li.classList.contains(actual)) {
			li.classList.add("activa");
		}
	});
});
