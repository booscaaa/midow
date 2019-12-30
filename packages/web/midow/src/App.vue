<template>
  <div id="app">
    <v-app>
      <v-navigation-drawer permanent app>
        <v-layout column align-center justify-center class="py-5">
          <v-avatar color="primary">
            <!-- <v-img src="https://randomuser.me/api/portraits/men/85.jpg"></v-img> -->
            <v-icon color="white">mdi-account-badge</v-icon>
          </v-avatar>
          <v-list-item-title>Não cadastrado</v-list-item-title>
          <v-list-item-subtitle>Clique para cadastrar-se</v-list-item-subtitle>
        </v-layout>
        <v-divider></v-divider>

        <v-list dense nav>
          <v-list-item-group v-model="selected" color="primary" mandatory>
            <v-list-item v-for="item in items" :key="item.title" link>
              <v-list-item-icon>
                <v-icon>{{ item.icon }}</v-icon>
              </v-list-item-icon>

              <v-list-item-content>
                <v-list-item-title>{{ item.title }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list-item-group>
        </v-list>
      </v-navigation-drawer>
      <v-content app>
        <router-view />
      </v-content>
    </v-app>
  </div>
</template>

<script>
export default {
  data: () => ({
    items: [
      { title: 'Home', icon: 'mdi-map-marker' },
      { title: 'Favoritos', icon: 'mdi-shopping' }
    ],
    selected: 0
  })
}
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: left;
  color: #2c3e50;
}
</style>
