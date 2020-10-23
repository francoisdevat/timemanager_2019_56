<template>
  <div class="page-container md-layout-column">
    <md-toolbar class="md-primary">
      <md-button class="md-icon-button" @click="showNavigation = true">
        <md-icon>menu</md-icon>
      </md-button>
      <span class="md-title">Gotham City Hall</span>
    </md-toolbar>

    <md-drawer :md-active.sync="showNavigation" md-swipeable>
      <md-toolbar class="md-transparent" md-elevation="0">
        <span class="md-title">User Menu</span>
      </md-toolbar>

      <md-list>
        <md-list-item>
          <md-icon>account_box</md-icon>
          <span class="md-list-item-text">Sign In</span>
        </md-list-item>

        <md-list-item>
          <md-icon>perm_identity</md-icon>
          <span class="md-list-item-text">Sign Up</span>
        </md-list-item>

      </md-list>
    </md-drawer>

  </div>
</template>

<script>
  export default {
    name: 'Menu',
    data: () => ({
      showNavigation: false,
      showSidepanel: false
    })
  }
</script>

<style scoped>
   .page-container {
    min-height: 300px;
    overflow: hidden;
    position: relative;
    border: 1px solid rgba(#000, .12);
    margin-top: -60px;
  }
/*
   // Demo purposes only
  .md-drawer {
    width: 230px;
    max-width: calc(100vw - 125px);
  }

  .md-content {
    padding: 16px;
  } */
</style>