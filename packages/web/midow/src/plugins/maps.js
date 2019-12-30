import * as VueGoogleMaps from 'vue2-google-maps'
import Vue from 'vue'

class Maps {
  constructor () {
    Vue.use(VueGoogleMaps, {
      load: {
        key: 'AIzaSyCzGKtGFkSMGaiGpw7bFWvRWIwOM1vDgv0',
        libraries: 'places' // This is required if you use the Autocomplete plugin
        // OR: libraries: 'places,drawing'
        // OR: libraries: 'places,drawing,visualization'
        // (as you require)
      }
    })
  }
}

export default new Maps()
