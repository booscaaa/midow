import Vue from 'vue'
import App from './App.vue'
import './registerServiceWorker'
import router from './router'
import vuetify from './plugins/vuetify'
import maps from './plugins/maps'

Vue.config.productionTip = false

new Vue({
  router,
  vuetify,
  maps,
  render: h => h(App)
}).$mount('#app')
