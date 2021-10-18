<template>
  <div class="container">
    <div class="input-container">
      <div class="input-box">
        <input class="city-input" v-model="city">
        <button class="search-btn" v-on:click="updateWeather()"><img src="../next.png" alt=""></button>
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
  </div>
</template>

<script>

export default {
  name: 'App',
  data: () => {return {
    city: '',

    apiKey: '29d3c2120d8bd2eaada50aae60de3963',
    urlBase: 'https://api.openweathermap.org/data/2.5/weather?q=',

    temperature: 0,
    isLoaded: false,
    resolvedCityName: '',
    resolvedCountryName: ''
  }},
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
              this.temperature = Math.round(json.main.temp*10)/10;
              this.resolvedCityName = json.name + ', ';
              this.resolvedCountryName = json.sys.country
            } else {
              throw new Error("!200");
            }
          }
        )).catch(() => {
          this.isLoaded = false;
        })
    },
    toTitle(txt) {
      return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
    }
  }
}
</script>

<style>
img {
  max-width: 100%;
  max-height: 100%;
  -webkit-user-drag: none;
  cursor: pointer;
}
.input-box {
  display: flex;
}
.search-btn {
  height: 54px;
  background: transparent;
  border: 1px solid black;
  border-left: none;
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
  
  border: 1px solid black;
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
