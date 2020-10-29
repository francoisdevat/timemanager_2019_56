import Vue from "vue";
import Vuex from "vuex";
import clock from "./modules/clock";
import hour from "./modules/hour";
import team from "./modules/team";
import { user } from "./modules/user";

Vue.use(Vuex);

export const store = new Vuex.Store({
  modules: {
    clock,
    hour,
    team,
    user,
  },
});
