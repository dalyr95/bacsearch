<search>

	<header class="header">
		<h1>Search New &amp; Used Cars for Sale</h1>
	</header>
	<div class="search_sidebar">
		<form class="search_form" onsubmit={ searchSubmit }>
			<input type="text" id="search-search" name="search-cars" value={ state.filters.searchTerm } onkeyup={ search } list="search-cars"/>
				<datalist id="search-cars">
					<option each={ name, i in state.datalist } value={ name }>
				</datalist>
			<button class="btn btn_btn_standard" onclick={ search }>Search</button>
		</form>
		<h6 class="search_refine">
			Refine your search<br/>
			<a href="#" onclick={ clearSeach }>Clear search</a>
		</h6>

		<div class="search_filters">

			<div class="search_filter_show">
				Show:
				<ul>
					<li onclick={ carType } data-type="used" class={ (state.filters.carType === 'used') ? 'active' : '' }>Used</li>
					<li onclick={ carType } data-type="new" class={ (state.filters.carType === 'new') ? 'active' : '' }>New</li>
					<li onclick={ carType } data-type="lease" class={ (state.filters.carType === 'lease') ? 'active' : '' }>Lease</li>
				</ul>
			</div>

			<div class="search_filters_dropdowns">
				<div class={ (state.filtersOpen['make']) ? 'open' : '' }>
					<h6 data-filter="make" onclick={ filters }>Make</h6>
					<div class="search_filters_selected">
						<ul>
							<li each={ key, value in state.filters.filtersSelected.make } data-filter="make" data-option={ key } onClick={ removeFilter }>
								<span>{ value }</span>
							</li>
						</ul>
					</div>
					<ul class="search_filters_options" onclick={ filterOption } style="height: { (state.filtersOpen['make']) ? state.filtersOpen['make'] : '0' }px">
						<li data-option="make-1" class={ selected : state.filters.filtersSelected.make['make-1'] }>Make 1</li>
						<li data-option="make-2" class={ selected : state.filters.filtersSelected.make['make-2'] }>Make 2</li>
						<li data-option="make-3" class={ selected : state.filters.filtersSelected.make['make-3'] }>Make 3</li>
						<li data-option="make-4" class={ selected : state.filters.filtersSelected.make['make-4'] }>Make 4</li>
						<li data-option="make-5" class={ selected : state.filters.filtersSelected.make['make-5'] }>Make 5</li>
					</ul>
				</div>

				<div class={ (state.filtersOpen['model']) ? 'open' : '' }>
					<h6 data-filter="model" onclick={ filters }>Model</h6>
					<div class="search_filters_selected">
						<ul>
							<li each={ key, value in state.filters.filtersSelected.model } data-filter="model" data-option={ key } onClick={ removeFilter }>
								<span>{ value }</span>
							</li>
						</ul>
					</div>
					<ul class="search_filters_options" onclick={ filterOption } style="height: { (state.filtersOpen['model']) ? state.filtersOpen['model'] : '0' }px">
						<li data-option="model-1" class={ selected : state.filters.filtersSelected.model['model-1'] }>Model 1</li>
						<li data-option="model-2" class={ selected : state.filters.filtersSelected.model['model-2'] }>Model 2</li>
						<li data-option="model-3" class={ selected : state.filters.filtersSelected.model['model-3'] }>Model 3</li>
						<li data-option="model-4" class={ selected : state.filters.filtersSelected.model['model-4'] }>Model 4</li>
						<li data-option="model-5" class={ selected : state.filters.filtersSelected.model['model-5'] }>Model 5</li>
					</ul>
				</div>

				<div class={ (state.filtersOpen['price']) ? 'open' : '' }>
					<h6 data-filter="price" onclick={ filters }>Price</h6>
					<div class="search_filters_selected">
						<ul>
							<li each={ key, value in state.filters.filtersSelected.price } data-filter="price" data-option={ key } onClick={ removeFilter }>
								<span>{ value }</span>
							</li>
						</ul>
					</div>
					<ul class="search_filters_options" onclick={ filterOption } style="height: { (state.filtersOpen['price']) ? state.filtersOpen['price'] : '0' }px">
						<li data-option="price-1" class={ selected : state.filters.filtersSelected.price['price-1'] }>Price 1</li>
						<li data-option="price-2" class={ selected : state.filters.filtersSelected.price['price-2'] }>Price 2</li>
						<li data-option="price-3" class={ selected : state.filters.filtersSelected.price['price-3'] }>Price 3</li>
					</ul>
				</div>

			</div>

		</div>
	</div>

	<div <div if={ state.cars.length > 0 } class="search_results {state.loading === true ? 'loading' : ''} { state.appending === true ? 'appending' : '' }">
		<ul>
			<li>
				<div class="results_total">1703 Results</div>
			</li>
			<li>
				<div class="results_filter">
					<select onchange={ sortOption }>
						<option value="popular">Most popular</option>
						<option value="ascending">Make A-Z</option>
						<option value="descending">Make Z-A</option>
					</select>
				</div>
			</li>
		</ul>

		<ul>
			<li each={ value, key in state.cars } class="search_result" style="animation-delay: { state.disableAnimations === true ? 0 : key * 100 + 150}ms;">
				<span class="search_result_image">
					<img src="//images.buyacar.co.uk/img/med/{ value.prodHomeIntImageFileName }" alt={ imgAltString } onload="this.style.opacity = 1;" />
				</span>
				<div class="search_result_content">
					<span>Used car - { value.inStockDeals === 0 ? 'in stock' : 'out of stock' }</span>
					<h5>{ value.fullName }</h5>
					<p>More info on this car</p>
				</div>
				<div class="search_result_price" if={ value.cheapestAdvertPrice }>
					{ currency }{ value.cheapestAdvertPrice }
					<p if={ value.cheapestFinancePaymentAmount }>Or from<strong>{ currency }{ parseInt(value.cheapestFinancePaymentAmount, 10) }<sup>*</sup></strong>Per Month</p>
				</div>
				<a href='http://dev2.buyacar.co.uk/{ value.prodHomeUrlPath }deal_{ value.prodAdvertSeoString }.jhtml'></a>
			</li>
		</ul>
		<button class="btn btn_standard btn_load_more" if={ this.state.pagination > 3 } onclick={ scroll }>Load more...</button>
	</div>

	<div if={ state.loading === false && state.cars.length === 0 } class="search_results no_results">
        No cars found
        <button if={ (filtersExist() === true) } onclick={ goBack }>Remove last filter</button>
        <button if={ (filtersExist() === true) } onclick={ clearSeach }>Clear search</button>
	</div>

	<script>
		window.tag = this;
		this.currency   = '£';

		this.state = {
			loading: true,
			appending: false,
			cars: [],
			filtersOpen: {},
			filters: {
				carType: null,
				filtersSelected: {},
				searchTerm: null,
				sort: null
			},
			height: 0,
			pagination: 1,
			disableAnimations: false
		};

		this.originalState = JSON.stringify(this.state);

		XHR = function(cb, query, nopopstate) {
			this.state.loading = true;

			var xhr = new XMLHttpRequest();
			query = (query) ? '?' + query : '';

			xhr.addEventListener('load', function(data) {
				cb(JSON.parse(data.currentTarget.responseText));
			});

			xhr.open('GET', 'http://dev2.buyacar.co.uk/cars/new_cars_json.jhtml' + query, true);
			xhr.send();

			query = (query.length === 0) ? '?' : query;

			if ( nopopstate !== true ) {
				window.history.pushState(this.state.filters, '', query);
			}

			return xhr;
		}.bind(this);

		debounce = function(func, wait, immediate) {
			var timeout;
			return function() {
				var context = this, args = arguments;
				clearTimeout(timeout);
				timeout = setTimeout(function() {
					timeout = null;
					if (!immediate) func.apply(context, args);
				}, wait);
				if (immediate && !timeout) func.apply(context, args);
			};
		};

		searchSubmit = function(e) {
			e.preventDefault();
		};

		displayResults = function(data) {
			this.state.loading = false;
			this.state.cars    = data;
			// Hacky shite to shuffle cars
			this.state.cars    = shuffle(this.state.cars);

			this.update();

			this.one('updated', function() {
				this.state.height = parseInt(this.root.querySelector('.search_results').getBoundingClientRect().height, 10);
			});

		}.bind(this);

		appendResults = function(data) {
			this.state.loading   = false;
			this.state.appending = false;
			this.state.cars      = this.state.cars.concat(data);

			this.update();

			this.state.disableAnimations = false;

			this.one('updated', function() {
				this.state.height = parseInt(this.root.querySelector('.search_results').getBoundingClientRect().height, 10);
			});

		}.bind(this);

		filters = function(e) {
			e.preventDefault();

			var filter  = e.currentTarget.dataset.filter;

			if (this.state.filtersOpen[filter]) {
				delete this.state.filtersOpen[filter];
			} else {
				this.state.filtersOpen[filter] = e.currentTarget.dataset.height;
			}
		}

		filterOption = function(e) {
			var filter = e.currentTarget.previousElementSibling.previousElementSibling.dataset.filter;
			var option = e.target.dataset.option;

			if ( this.state.filters.filtersSelected[filter] && this.state.filters.filtersSelected[filter][option] ) {
				// Delete already selected option
				delete this.state.filters.filtersSelected[filter][option];
				if ( Object.keys( this.state.filters.filtersSelected[filter] ).length === 0 ) {
					delete this.state.filters.filtersSelected[filter];
				}
			} else if ( this.state.filters.filtersSelected[filter] ) {
				// If filter already has one selected, then add new option
				this.state.filters.filtersSelected[filter][option] = e.target.innerText;
			} else {
				// If filter hasn't got anything selected, then create
				this.state.filters.filtersSelected[filter] = {};
				// and add option
				this.state.filters.filtersSelected[filter][option] = e.target.innerText;
			}

			getNewCars();
		}

		resetResults = function() {
			window.scrollTo(0, 0);
			this.state.pagination = 1;
		}.bind(this);

		removeFilter = function(e) {
			e.preventDefault();

			var data = e.currentTarget.dataset;

			delete this.state.filters.filtersSelected[data.filter][data.option];

			if ( Object.keys(this.state.filters.filtersSelected[data.filter]).length === 0 ) {
				delete this.state.filters.filtersSelected[data.filter];
			}
			getNewCars();
		}

		sortOption = function(e) {
			e.preventDefault();
			this.state.filters.sort = e.currentTarget.value;

			getNewCars();
		}

		carType = function(e) {
			e.preventDefault();

			this.state.filters.carType = e.currentTarget.dataset.type;

			getNewCars();
		}

		clearSeach = function(e) {
			e.preventDefault();

			this.state.filters = JSON.parse(this.originalState).filters;
			this.state.filtersOpen = {};

			getNewCars();

			document.addEventListener('scroll', this.scroll);
		}

		search = function(e) {
			if ( e.target.tagName === 'INPUT') {
				this.state.filters.searchTerm = (e.target.value.length > 0) ? e.target.value : null;

				if (e.keyCode === 13) { getNewCars(); }
			} else if ( e.type !== 'keyup') {
				this.state.filters.searchTerm = e.target.parentNode.firstElementChild.value;

				getNewCars();
			}
		};

		// Temp hack to make it look like something is happening
		shuffle = function(array) {
			var currentIndex = array.length, temporaryValue, randomIndex;

			// While there remain elements to shuffle...
			while (0 !== currentIndex) {
				// Pick a remaining element...
				randomIndex = Math.floor(Math.random() * currentIndex);
				currentIndex -= 1;

				// And swap it with the current element.
				temporaryValue = array[currentIndex];
				array[currentIndex] = array[randomIndex];
				array[randomIndex] = temporaryValue;
			}

			return array;
		}

		serialize = function(obj, prefix) {
			var str = [];
			for(var p in obj) {
				if (obj.hasOwnProperty(p)) {
					var k = prefix ? prefix + '[' + p + ']' : p, v = obj[p];
					str.push(typeof v == 'object' ?
					serialize(v, k) :
					encodeURIComponent(k) + '=' + encodeURIComponent(v));
				}
			}
			return str.join("&");
		}

		getNewCars = function(nopopstate) {
			var filters = this.state.filters;
			var query = [];

			Object.keys(filters).forEach(function(key) {
				if (filters[key]) {
					if ( typeof filters[key] === 'string' ) {
						query.push(key + '=' + encodeURIComponent(filters[key]));
					} else {
						Object.keys(filters[key]).forEach(function(k) {
							query.push(k + '=' + Object.keys(filters[key][k]));
						});
					}
				}
			});
			if ( this.state.pagination > 1 ) {
				query.push('page=' + this.state.pagination);
			}
			query = query.join('&');

			resetResults();
			XHR(displayResults, query, nopopstate);

		}.bind(this);

        goBack = function() {
            window.history.back();
        }

        this.filtersExist = function() {
            var hasFilters  = false;
            var filters     = this.state.filters;

            var keys = Object.keys(filters);

            keys.forEach(function(key) {
                if (filters[key]) {
                    if (typeof filters[key] === 'object') {
                        if (Object.keys(filters[key]).length > 0) { hasFilters = true; }
                    } else {
                        hasFilters = true;
                    }
                }
            });


            return hasFilters;
        }

		var parseQueryString = function( queryString ) {
			var params = {}, queries, temp, i, l;
			// Split into key/value pairs
			queries = queryString.split('&');
			// Convert the array of strings into an object
			for ( i = 0, l = queries.length; i < l; i++ ) {
				temp = queries[i].split('=');
				params[temp[0]] = temp[1];
			}
			return params;
		};

		this.on('before-mount', function() {
			var query   = window.location.search.replace(/^\?/, '');
			var filters = this.state.filters;
			query       = parseQueryString(query);

			Object.keys(query).forEach(function( key ) {
				if ( filters.hasOwnProperty(key) ) {
					filters[key] = decodeURIComponent(query[key]);
				} else {
					if (query[key]) {
						var values = query[key].split(',');

						values.forEach(function(v) {
							filters.filtersSelected[key]    = filters.filtersSelected[key] || {};
							filters.filtersSelected[key][v] = decodeURIComponent(true);
						});
					}
				}
			});
		});

		this.on('mount', function() {

			// Get initial results
			// -----------------------------------------------------------

			var query = (window.location.search.length > 1) ? window.location.search.replace(/^\?/, '') : null;

			XHR(displayResults, query);


			// Popstate (back button)
			// -----------------------------------------------------------

			window.onpopstate = function(event) {
				this.state.filters = window.history.state;
				this.update();
				
				getNewCars(true);
			}.bind(this);


			// Infinite load
			// -----------------------------------------------------------

			this.scroll = debounce(function() {
				if ( this.state.appending === false ) {
					// find when we are the bottom of the page
					if ( (window.pageYOffset) > (this.state.height - window.innerHeight) ) {
						this.state.pagination++;
						this.state.loading              = true;
						this.state.appending            = true;
						this.state.disableAnimations    = true;

						this.update();

						XHR(appendResults, window.location.search.replace(/^\?/, ''));

						if ( this.state.pagination > 3 ) {
							document.removeEventListener('scroll', this.scroll);
						}
					}
				}
			},200).bind(this);

			document.addEventListener('scroll', this.scroll);


			// Populate Datalist
			// -----------------------------------------------------------

			var xhr = new XMLHttpRequest();

			xhr.addEventListener('load', function(data) {
				var carsRepsonse = JSON.parse(data.currentTarget.responseText);

					var datalist = [];
					carsRepsonse.makes.forEach(function(make) {
						datalist.push(make.name);
						make.models.forEach(function(model) {
								datalist.push(make.name + ' ' + model.name);
						});
					});

					this.state.datalist = datalist;
			}.bind(this));

			xhr.open('GET', '/cars.json', true);
			xhr.send();
		});

		this.on('updated', function() {
				var filters = [].slice.call(this.root.getElementsByClassName('search_filters_options'));
				var height  = filters[0].children[0].getBoundingClientRect().height;

				filters.forEach(function(f) {
					f.previousElementSibling.previousElementSibling.dataset.height = f.children.length * height;
				});
		});

	</script>

	<style scoped>
		:scope * {
			box-sizing: border-box;
			outline: none;
		}

		:scope {
			display: block;
			margin: 0 auto;
			min-height: calc(100vh + 1px);
			/*max-width: 1160px;*/
			overflow: hidden;
			width: 100%;
		}
		.header {
			width: 100%;
			text-align: center;
			padding: 10px 0;
			/*position: fixed;*/
		}
		.search_sidebar,
		.search_results {
			width: 100%;
		}

		.search_sidebar {
			float: left;
			width: 384px;
			padding: 0 10px;
		}

		.search_results {
			float: right;
			min-height: calc(100vh + 1px);
			position: relative;
			width: calc(100% - 384px - 60px);
			padding: 0 10px 100px 10px;
		}

		.search_filters_dropdowns {
			overflow-y: auto;
			max-height: calc(100vh - 180px);
			width: 100%;
		}

		.search_sidebar .search_form {
			overflow: hidden;
		}

		.search_sidebar .search_form input {
			border-radius: 4px;
			border:  1px solid #d9d9d9;
			box-shadow: inset 0 0 2px 0px #ccc;
			height: 40px;
			margin-right: 10px;
			padding: 0 10px;
			width: calc(100% - 130px);
			-webkit-appearance: none;
		}

		.search_sidebar .search_form input:focus {
			border-color: #ff8100;
		}

		.search_sidebar .search_form button {
			background-color: #fff;
			border: 2px solid #ff8100;
			border-radius: 4px;
			color: #ff8100;
			float: right;
			height: 40px;
			width: 120px;
			-webkit-appearance: none;
		}

		.search_sidebar .search_form button:active {
				background-color: #ff8100;
				color: #fff;
		}

		.search_sidebar .search_refine {
			background-color: #ff8100;
			clear: both;
			color: #fff;
			margin: 10px 0;
			padding: 10px;
			text-transform: uppercase;
		}

		.search_sidebar .search_refine a {
			clear: both;
			color: #fff;
			font-size: 14px;
			font-weight: normal;
		}

		.search_sidebar .search_filters {
			padding: 0 10px;
		}

		.search_sidebar .search_filter_show {
			line-height: 32px;
			margin-bottom: 10px;
		}

		.search_sidebar .search_filter_show ul,
		.search_sidebar .search_filter_show li {
			float: right;
		}

		.search_sidebar .search_filter_show li {
			border: 1px solid #d4d4d4;
			border-radius: 4px;
			cursor: pointer;
			float: right;
			line-height: 30px;
			margin-left: 10px;
			padding: 0 10px 0 26px;
			position: relative;
			transition: background-color 0.05s linear, border-color 0.05s linear;
			-webkit-user-select: none;
			-moz-user-select: none;
			-ms-user-select: none;
		}

		.search_sidebar .search_filter_show li:last-child {
			margin-right: 0;
		}

		.search_sidebar .search_filter_show li::before {
			border: 2px solid #d3d3d3;
			border-left: none;
			border-top: none;
			content: '';
			display: block;
			height: 14px;
			left: 10px;
			position: absolute;
			top: 5px;
			transform: rotate(40deg);
			width: 6px;
		}

		.search_sidebar .search_filter_show li.active {
			background-color: #ff8100;
			border-color: #ff8100;
			color: #fff;
		}

		.search_sidebar .search_filter_show li.active::before {
			border-color: #fff;
		}

		.search_sidebar .search_filters_dropdowns > div {
			border-bottom: 1px solid #d3d3d3;
			-webkit-user-select: none;
			-moz-user-select: none;
			-ms-user-select: none;
		}

		.search_sidebar .search_filters_dropdowns > div:first-child {
			border-top: 1px solid #d3d3d3;
		}

		.search_sidebar .search_filters_dropdowns h6 {
			cursor: pointer;
			padding: 5px;
			position: relative;
		}

		.search_sidebar .search_filters_dropdowns h6:active {
			background-color: #ff8100;
			color: #fff;
		}

		.search_sidebar .search_filters_dropdowns h6::after {
			content: '';
			border: 3px solid #454545;
			border-bottom: 0;
			border-left: 0;
			width: 8px;
			height: 8px;
			position: absolute;
			right: 10px;
			top: 0;
			bottom: 0;
			margin: auto;
			transform: rotate(45deg);
			transition: transform 0.05s linear;
		}
		.btn {
			cursor: pointer;
		}
		.btn_load_more {
			width: 100%;
			background-color: #ff8100;
			padding: 10px;
			border: 0;
			color: #FFF;
			font-size: 1.2em;
		}

		.search_sidebar .search_filters_dropdowns .open h6::after {
			transform: rotate(135deg);
		}

		.search_sidebar .search_filters_dropdowns .search_filters_options {
			overflow: hidden;
			height: 0;
			transition: height 0.1s linear;
		}

		.search_sidebar .search_filters_dropdowns .open .search_filters_options {
			height: auto;
		}

		.search_sidebar .search_filters_dropdowns .search_filters_options li {
			cursor: pointer;
			padding: 2px 5px;
		}

		.search_sidebar .search_filters_dropdowns .search_filters_options li.selected {
			background-color: rgba(254, 129, 0, 0.5);
		}

		.search_sidebar .search_filters_dropdowns .search_filters_options li.selected:hover {
			background-color: rgba(254, 129, 0, 1);
			color: #fff;
		}

		.search_sidebar .search_filters_dropdowns .search_filters_options li:hover {
			background-color: #ebebeb;
		}

		.search_sidebar .search_filters_dropdowns .search_filters_options li:active {
			background-color: #ff8100;
			color: #fff;
		}

		.search_sidebar .search_filters_selected li {
			border-radius: 4px;
			border: 1px solid #fe8100;
			cursor: pointer;
			display: inline-block;
			height: 32px;
			line-height: 30px;
			margin-bottom: 4px;
			margin-right: 4px;
			max-width: 0;
			position: relative;
			overflow: hidden;
			animation-duration: 0.4s;
			animation-fill-mode: forwards;
			animation-name: filterSlide;
		}

		@keyframes filterSlide {
			from {
				max-width: 0;
			}

			to {
				max-width: 500px;
			}
		}

		.search_sidebar .search_filters_selected li span {
			padding: 0 8px 0 28px;
		}

		.search_sidebar .search_filters_selected li span::before {
			content: '\00D7';
			border-radius: 100%;
			color: #FFF;
			display: block;
			font-size: 18px;
			height: 16px;
			line-height: 16px;
			position: absolute;
			text-align: center;
			left: 6px;
			width: 16px;
			top: 6px;
			background-color: #fe8100;
			border: 1px solid #fe8100;
		}

		.search_sidebar .search_filters_selected li:hover span::before {
			color: #fe8100;
			background-color: #FFF;
		}


		.search_results.loading::before {
			content: '';
			background-color: rgba(255,255,255,0.6);
			position: absolute;
			left: 0;
			top: 0;
			width: 100%;
			height: 100%;
			z-index: 1;
		}

		.search_results.loading::after {
			background-color: #fff;
			border-radius: 4px;
			content: 'Processing results...';
			padding: 10px;
			position: fixed;
			top: 50%;
			text-align: center;
			transform: translateY(-50%);
			width: 476px;
			z-index: 2;
		}
		.search_results.appending::after {
			content: '';
			position: absolute;
			bottom: 70px;
			left: 0;
			right: 0;
			margin: auto;
			border-radius: 50%;
			border-top: 3px solid black;
			border-left: 3px solid black;
			width: 40px;
			height: 40px;
			animation-name: appending;
			animation-iteration-count: infinite;
			animation-duration: 0.5s;
		}

		.search_results .search_result {
			border: 1px solid #d9d9d9;
			border-radius: 4px;
			box-shadow: inset 0 0 0 1px #ebebeb;
			margin-bottom: 10px;
			min-height: 148px;
			padding:  10px;
			position: relative;
			overflow: hidden;
			opacity: 0;
			animation-name: slideIn;
			animation-fill-mode: forwards;
			animation-duration: 0.2s;
		}

		@keyframes slideIn {
			from {
				transform: translateX(-50px);
				opacity: 0;
			}
			50% {
				opacity: 1;
			}
			to {
				transform: translateX(0);
				opacity: 1;
			}
		}
		@keyframes appending {
			from {
				transform: rotate(0deg);
			}
			to {
				transform: rotate(360deg);
			}
		}

		.search_results .search_result .search_result_image {
			background-color: #d9d9d9;
			display: block;
			float: left;
			padding-bottom: 28%;
			position: relative;
			width: 40%;
		}

		.search_results .search_result .search_result_image img {
			position: absolute;
			width: 100%;
			opacity: 0;
			transition: opacity 0.4s linear;
		}

		.search_results .search_result .search_result_content {
			float: left;
			margin: 0 10px;
			max-width: calc(100% - 40% - 10px - 110px);
		}

		.search_results .search_result .search_result_price {
			float: right;
			text-align: center;
			width: 100px;
		}

		.search_results .search_result .search_result_price p {
			background-color: #e7e7e7;
			color: #223947;
			padding: 10px 0;
			position: absolute;
			top: 40%;
			width: 100px;
		}

		.search_results .search_result .search_result_price p strong {
			display: block;
			font-size: 150%;
			text-indent: 8px;
		}

		.search_results .search_result a {
			background-color: transparent;
			height: 100%;
			left: 0;
			position: absolute;
			top: 0;
			width: 100%;
			z-index: 10;
		}
	</style>
</search>