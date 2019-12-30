import Vue from 'vue'
import Vuetify from 'vuetify/lib'
import pt from 'vuetify/es5/locale/pt'

Vue.use(Vuetify)

export default new Vuetify({
  theme: {
    themes: {
      light: {
        primary: '#A587E8',
        secondary: '#0187E8',
        accent: '#82B1FF',
        error: '#FF5252',
        info: '#2196F3',
        success: '#38FF6A',
        warning: '#EBE121'
      }
    }
  },
  lang: {
    locales: { pt },
    current: 'pt'
  }
})
