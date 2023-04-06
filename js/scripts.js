window.addEventListener("scroll", () => {
	const secciones = document.querySelectorAll("section");
	const navLi = document.querySelectorAll("nav ul a li");
	let actual = "";

	secciones.forEach((seccion) => {
		const seccionTop = seccion.offsetTop - seccion.clientHeight / 2.5;
		const seccionAltura = seccion.clientHeight;
		const seccionBottom = seccionTop + seccionAltura;

		if (scrollY > seccionTop && scrollY <= seccionBottom) {
			actual = seccion.getAttribute("id");
		}
	});

	navLi.forEach((enlace) => {
		enlace.classList.remove("activa");
		if (enlace.classList.contains(actual)) {
			enlace.classList.add("activa");
		}
	});
});
