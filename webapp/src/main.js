import Vue from "vue";
import App from "./App.vue";
import VueMaterial from "vue-material";
import "vue-material/dist/vue-material.min.css";
import "vue-material/dist/theme/default.css";
import VueMoment from "vue-moment";
import store from "./components/store/store";
import router from "./components/services/router";
import Axios from "axios";

Vue.use(VueMoment);
Vue.use(VueMaterial);
Vue.config.productionTip = false;
Vue.prototype.$http = Axios;

const token = localStorage.getItem("token");
if (token) {
  Vue.prototype.$http.defaults.headers.common["Authorization"] = token;
}

new Vue({
  render: (h) => h(App),
  router,
  store,
}).$mount("#app");

