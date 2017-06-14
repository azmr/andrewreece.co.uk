function setFilters()
{
	var filterButtons = document.getElementById("filters").getElementsByClassName("filterbutton");
	var filters = [];
	for(i = 0; i < filterButtons.length; ++i)
	{
		var ID = filterButtons[i].id;
		if(document.getElementById(ID).firstElementChild.checked)
		{
			filters.push(ID.slice(7));
		}
		else
		{
			filters.push(0);
		}
	}

	cw = document.getElementsByClassName("cw");
	if(filters.some((el, i, arr) => el !== 0))
	{
		for(i = 0; i < cw.length; ++i)
		{
			cw[i].classList.add("hidden");

			for(j = 0; j < filters.length; ++j)
			{
				if(cw[i].className.split(" ").includes(filters[j]))
				{
					cw[i].classList.remove("hidden");
					continue;
				}
			}
		}
	}

	else
	{
		for(i = 0; i < cw.length; ++i)
		{
			cw[i].classList.remove("hidden");
		}
	}
}


window.onload = function()
{
	// Get Tags
	var cw = document.getElementsByTagName("li");
	var tags = [];
	for(i=0; i < cw.length; ++i)
	{
		tags = tags.concat(cw[i].className.split(" "));
	}
	tags = tags.sort().filter((el, i, arr) => el !== "cw" && el !== "" && arr.indexOf(el) === i);

	// Make buttons from tags
	var header = document.getElementById("university-coursework");
	var filters = document.createElement("div");
	filters.setAttribute("id", "filters");
	filters.innerHTML = 'Filter coursework with the following tags:<br/>';
	header.parentNode.insertBefore(filters, header.nextSibling);
	for(i=0; i < tags.length; ++i)
	{
		var button = document.createElement("label");
		button.setAttribute("class", "filterbutton");
		button.setAttribute("id", "filter-"+tags[i]);
		button.innerHTML = '<input type="checkbox"\\> <p class="switch">'+tags[i]+'</p>';
		button.onclick = setFilters;

		filters.appendChild(button);
	}
}
