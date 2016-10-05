<search>
    <div>
        <h1>Search New &amp; Used Cars for Sale</h1>

        <div class="search_sidebar">
            <form class="search_form" onsubmit={ searchSubmit }>
                <input type="text" name="search-cars" onkeyup={ search }/>
                <button>Search</button>
            </form>
            <h4 class="search_refine">
                Refine your search
            </h4>

            <div class="search_filters">
                <div class="search_filter_show">
                    Show:
                    <ul>
                        <li onclick={ carType } data-type="used" class={ (state.carType.indexOf('used') > -1) ? 'active' : '' }>Used</li>
                        <li onclick={ carType } data-type="new" class={ (state.carType.indexOf('new') > -1) ? 'active' : '' }>New</li>
                        <li onclick={ carType } data-type="lease" class={ (state.carType.indexOf('lease') > -1) ? 'active' : '' }>Lease</li>
                    </ul>
                </div>

                <div class="search_filters_dropdowns">
                    <div class={ (state.filtersOpen.indexOf('make') > -1) ? 'open' : '' }>
                        <h6 data-filter="make" onclick={ filters }>Make</h6>
                        <div class="search_filters_selected">
                            <ul>
                                <li each={ key, value in state.filtersSelected.make } data-filter="make" data-option={ key } onClick={ removeFilter }>
                                    <span>{ value }</span>
                                </li>
                            </ul>
                        </div>
                        <ul class="search_filters_options" onclick={ filterOption }>
                            <li data-option="make-1" class={ selected : state.filtersSelected.make['make-1'] }>Make 1</li>
                            <li data-option="make-2" class={ selected : state.filtersSelected.make['make-2'] }>Make 2</li>
                            <li data-option="make-3" class={ selected : state.filtersSelected.make['make-3'] }>Make 3</li>
                            <li data-option="make-4" class={ selected : state.filtersSelected.make['make-4'] }>Make 4</li>
                            <li data-option="make-5" class={ selected : state.filtersSelected.make['make-5'] }>Make 5</li>
                        </ul>
                    </div>

                    <div class={ (state.filtersOpen.indexOf('model') > -1) ? 'open' : '' }>
                        <h6 data-filter="model" onclick={ filters }>Model</h6>
                        <div class="search_filters_selected">
                            <ul>
                                <li each={ key, value in state.filtersSelected.model } data-filter="model" data-option={ key } onClick={ removeFilter }>
                                    <span>{ value }</span>
                                </li>
                            </ul>
                        </div>
                        <ul class="search_filters_options" onclick={ filterOption }>
                            <li data-option="model-1" class={ selected : state.filtersSelected.model['model-1'] }>Model 1</li>
                            <li data-option="model-2" class={ selected : state.filtersSelected.model['model-2'] }>Model 2</li>
                            <li data-option="model-3" class={ selected : state.filtersSelected.model['model-3'] }>Model 3</li>
                            <li data-option="model-4" class={ selected : state.filtersSelected.model['model-4'] }>Model 4</li>
                            <li data-option="model-5" class={ selected : state.filtersSelected.model['model-5'] }>Model 5</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>


        <div class="search_results {state.loading === true ? 'loading' : ''}">
            <ul>
                <li each={ value, key in state.cars } class="search_result" style="animation-delay: {key * 100 + 150}ms;">
                    <span class="search_result_image">
                        <img src="//images.buyacar.co.uk/img/med/{ value.prodHomeIntImageFileName }" alt={ imgAltString } />
                    </span>
                    <div class="search_result_content">
                        <h2>{ value.fullName }</h2>
                        <p>More info on this car</p>
                    </div>
                    <div class="search_result_price">
                        { currency }{ value.cheapestAdvertPrice }
                        <p>Or from<strong>{ currency }{ parseInt(value.cheapestFinancePaymentAmount, 10) }<sup>*</sup></strong>Per Month</p>
                    </div>
                    <a href={ value.prodHomeUrlPath }></a>
                </li>
            </ul>
        </div>
    </div>


    <script>
        window.tag = this;

        this.currency   = '£';
        this.delay      = 0;

        this.state = {
            loading: true,
            cars: null,
            filtersOpen: [],
            carType: [],
            filtersSelected: {},
            searchTerm: null
        };

        XHR = function(cb, data) {
            var xhr = new XMLHttpRequest();
            xhr.addEventListener('load', function(data) {
                cb(JSON.parse(data.currentTarget.responseText));
            });
            xhr.open('GET', 'http://dev2.buyacar.co.uk/cars/new_cars_json.jhtml', true);
            xhr.send();

            return xhr;
        }

        searchSubmit = function(e) {
            console.log('searchSubmit');
            e.preventDefault();
        }

        displayResults = function(data) {
            this.state.loading  = false;
            this.state.cars     = data;
            this.update();
        }.bind(this);

        filters = function(e) {
            e.preventDefault();

            var filter  = e.currentTarget.dataset.filter;
            var index   = this.state.filtersOpen.indexOf(filter);

            if (index === -1) {
                this.state.filtersOpen.push(filter);
            } else {
                this.state.filtersOpen.splice(index, 1);
            }
        }

        filterOption = function(e) {
            var filter = e.currentTarget.previousElementSibling.previousElementSibling.dataset.filter;
            var option = e.target.dataset.option;

            if (this.state.filtersSelected[filter] && this.state.filtersSelected[filter][option]) {
                delete this.state.filtersSelected[filter][option];
            } else if (this.state.filtersSelected[filter]) {
                this.state.filtersSelected[filter][option] = e.target.innerText;
            } else {
                this.state.filtersSelected[filter] = {};
                this.state.filtersSelected[filter][option] = e.target.innerText;
            }

            shuffleCars();
        }

        removeFilter = function(e) {
            e.preventDefault();
            var data = e.currentTarget.dataset;

            delete this.state.filtersSelected[data.filter][data.option];

            shuffleCars();
        }

        carType = function(e) {
            e.preventDefault();

            var type    = e.currentTarget.dataset.type;
            var index   = this.state.carType.indexOf(type);

            if (index === -1) {
                this.state.carType.push(type);
            } else {
                this.state.carType.splice(index, 1);
            }

            shuffleCars();
        }

        search = function(e) {
            this.state.searchTerm = (e.currentTarget.value.length > 0) ? e.currentTarget.value : null;
        }

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

        shuffleCars = function() {
            this.state.cars = shuffle(this.state.cars);
        }.bind(this);

        this.on('mount', function() {
            XHR(displayResults);
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
                max-width: 1160px;
                overflow: hidden;
                width: 100%;
            }

            .search_sidebar {
                float: left;
                width: 384px;
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

            .search_sidebar .search_refine {
                background-color: #ff8100;
                color: #fff;
                margin: 10px 0;
                padding: 10px;
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
                border:  2px solid #454545;
                border-bottom: 0;
                border-left: 0;
                content: '';
                display: block;
                height: 8px;
                position: absolute;
                right: 10px;
                top: 2px;
                width: 8px;
                transform: rotate(45deg);
                transition: transform 0.05s linear;
            }

            .search_sidebar .search_filters_dropdowns .open h6::after {
                transform: rotate(135deg);
            }

            .search_sidebar .search_filters_dropdowns .search_filters_options {
                overflow: hidden;
                height: 0;
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
                border-radius: 100%;
                border: 1px solid #fe8100;
                color: #fe8100;
                content: '\00D7';
                display: block;
                font-size: 18px;
                height: 16px;
                line-height: 16px;
                position: absolute;
                text-align: center;
                left: 6px;
                text-indent: -1px;
                width: 16px;
                top: 6px;
            }

            .search_sidebar .search_filters_selected li:hover span::before {
                background-color: #fe8100;
                color: #fff;
            }



            .search_results {
                float: right;
                min-height: 600px;
                position: relative;
                width: calc(100% - 384px - 60px);
            }

            .search_results.loading::before {
                background-color: rgba(255,255,255,0.6);
                content: '';
                display: block;
                height: 100%;
                left: 0;
                position: absolute;
                top: 0;
                width: 100%;
            }

            .search_results.loading::after {
                content: 'Processing results...';
                display: block;
                position: fixed;
                text-align: center;
                top: 50%;
                transform: translateY(-50%);
                width: 476px;
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