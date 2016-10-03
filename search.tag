<search>
    <div>
        <div class="search_sidebar">
            <form class="search_form" onsubmit={ searchSubmit }>
                <input type="text" name="search-cars" />
                <button>Search</button>
            </form>
            <h4 class="search_refine">
                Refine your search
            </h4>

            <div class="search_filters">
                <div class="search_filter_show">
                    Show:
                    <ul>
                        <li>Used</li>
                        <li>New</li>
                        <li>Lease</li>
                    </ul>
                </div>

                <div class="search_filters_dropdowns">
                    <div>
                        <h6>Make</h6>
                        <ul>
                            <li>Make 1</li>
                            <li>Make 2</li>
                            <li>Make 3</li>
                            <li>Make 4</li>
                            <li>Make 5</li>
                        </ul>
                    </div>

                    <div>
                        <h6>Model</h6>
                        <ul>
                            <li>Model 1</li>
                            <li>Model 2</li>
                            <li>Model 3</li>
                            <li>Model 4</li>
                            <li>Model 5</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>


        <div class="search_results {state.loading === true ? 'loading' : ''}">
            <ul>
                <li each={ state.cars } class="search_result">
                    <span class="search_result_image">
                        <img src="//images.buyacar.co.uk/img/med/{ prodHomeIntImageFileName }" alt={ imgAltString } />
                    </span>
                    <div class="search_result_content">
                        <h2>{ fullName }</h2>
                        <p>More info on this car</p>
                    </div>
                    <a href={ prodHomeUrlPath }></a>
                </li>
            </ul>
        </div>
    </div>


    <script>
        window.tag = this;

        this.state = {
            loading: true,
            cars: null
        }

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

        this.on('mount', function() {
            console.log('mount!');
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

            .search_sidebar .search_filters_dropdowns > div {
                border-bottom: 1px solid #d3d3d3;
                padding: 5px;
            }

            .search_sidebar .search_filters_dropdowns > div:first-child {
                border-top: 1px solid #d3d3d3;
            }

            .search_sidebar .search_filters_dropdowns h6 {
                cursor: pointer;
            }

            .search_sidebar .search_filters_dropdowns ul {
                overflow: hidden;
                height: 0;
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
                margin-left: 10px;
                max-width: calc(100% - 40% - 10px);
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