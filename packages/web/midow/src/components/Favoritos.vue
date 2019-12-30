<template>
  <gmap-map :center="mapConf.center" :zoom="mapConf.zoom" style="width: 100%; height: 100vh"></gmap-map>
</template>

<script>
export default {
  data: () => ({
    options: {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0
    },
    mapConf: {
      center: { lat: 0, lng: 0 },
      zoom: 15
    }
  }),
  methods: {
    success (pos) {
      var crd = pos.coords

      this.mapConf.center = {
        lat: crd.latitude,
        lng: crd.longitude
      }
    },
    error (err) {
      console.warn('ERROR(' + err.code + '): ' + err.message)
    }
  },
  mounted () {
    navigator.geolocation.getCurrentPosition(
      this.success,
      this.error,
      this.options
    )
  }
}
</script>

<style>
</style>
