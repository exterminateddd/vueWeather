<template>
  <div class="container">
    <div class="input-container">
      <div class="input-box">
        <input class="city-input" v-model="city" v-on:keyup.enter="updateWeather()">
        <button class="search-btn" v-on:click="updateWeather()"><img src="../arrow.svg" class="arrow" alt=""></button>
      </div>
    </div>
    <div class="info-container" v-if="isLoaded">
      <h1 class="city-label">{{this.toTitle(resolvedCityName)}}{{resolvedCountryName}}</h1>
      <h1 class="temp-label large"><span class="temp-value" v-bind:class="{
                                                                          'supercold': checkWeatherRange(-100, 0), 
                                                                          'cold': checkWeatherRange(0, 7), 
                                                                          'medium': checkWeatherRange(7, 18), 
                                                                          'warm': checkWeatherRange(18, 25), 
                                                                          'hot': checkWeatherRange(25, 100)}">{{temperature}}</span>°C</h1>
    </div>
    <error-alert v-if="hasErrored" message="Location not found"></error-alert>
  </div>
</template>

<script>

import ErrorAlert from "./components/ErrorAlert.vue";

export default {
  name: 'App',
  data: () => {return {
    city: '',

    apiKey: '29d3c2120d8bd2eaada50aae60de3963',
    urlBase: 'https://api.openweathermap.org/data/2.5/weather?q=',

    temperature: 0,
    isLoaded: false,
    hasErrored: false,
    resolvedCityName: '',
    resolvedCountryName: ''
  }},
  components: {
    errorAlert: ErrorAlert
  },
  methods: {

     checkWeatherRange(min, max) {
      return this.temperature >= min && this.temperature < max;
    },
    updateWeather() {
      let fetchUrl = this.urlBase + this.city + '&appid=' + this.apiKey + '&units=metric';
      fetch(fetchUrl)
        .then(res => res.json().then(
          json => {
            if (res.ok) {
              this.isLoaded = true;
              this.hasErrored = false;

              this.temperature = Math.round(json.main.temp*10)/10;
              this.resolvedCityName = json.name + ', ';
              this.resolvedCountryName = json.sys.country;
            } else {
              this.isLoaded = false;
              this.hasErrored = true;
            }
          }
        ))
    },
    toTitle(txt) {
      return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
    }
  }
}
</script>

<style>
.info-container {
  background: rgba(0, 0, 0, 0.116);
  margin-top: 24px;
  transition: .2s ease;
}
.info-container:hover {
  box-shadow: 2px 2px 2px 2px rgba(219, 136, 136, 0.301);
}
.arrow {
  max-width: 100%;
  max-height: 100%;
  width: auto;
  height: auto;
  -webkit-user-drag: none;
  cursor: pointer;
  transition: .2s linear;
}
.arrow:hover {
  transform: translateX(6px);
}
.search-btn:hover {
  opacity: 1;
}
.input-box {
  display: flex;
}
.search-btn {
  height: 54px;
  background: transparent;
  border: 1px solid rgba(0, 0, 0, 0.432);
  border-left: none;
  padding: 6px;
  padding-right: 10px;
  background: linear-gradient(to left, rgba(221, 221, 236, 0.616), rgb(255, 255, 255));

  transition: .2s ease;
}
.hot {
  color: rgb(255, 76, 5);
}
.warm {
  color: rgb(255, 115, 0);
}
.medium {
  color: rgb(223, 201, 103);
}
.cold {
  color: rgb(64, 64, 247);
}
.supercold {
  color: rgb(121, 121, 245);
}

input:active, input:focus, input:hover {
  outline: none;
}
.large {
  font-size: 96px;
}
.container {
  width: 100%;
  height: 100%;
  padding: 0;
  margin: 0;

  display: flex;
  justify-content: center;
  flex-direction: column;
}
.city-input {
  width: 200px;
  height: 40px;
  
  border: 1px solid rgba(0, 0, 0, 0.432);
  padding: 6px 12px;
  font-size: 28px;
  color: #2c3e50;
  border-right: none;
}
.city-label {
  height: 40px;
  font-size: 64px;
}
.input-container {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}
@media (max-width: 500px) {
  .city-label {
    font-size: 44px;
  }
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
