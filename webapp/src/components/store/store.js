import Vue from "vue";
import Vuex from "vuex";
import axios from "axios";
import { API_URL } from "../services/constants";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    status: "",
    token: localStorage.getItem("token") || "",
    user: {},
    teams: [],
    rights: [],
    hours: [],
    userhours: [],
    team_hours: [],
    specifichours: [],
    clocks: [],
    all_users: [],
    last_clock: {},
    last_hour: {},
    specific_hours: [],
    specific_id: "",
    user_hours: [],
  },
  mutations: {
    auth_request(state) {
      state.status = "loading";
    },
    auth_success_token(state, token) {
      state.status = "success";
      state.token = token;
    },
    auth_success_user(state, my_user) {
      state.status = "success";
      state.user = my_user;
    },
    auth_error(state) {
      state.status = "error";
    },
    logout(state) {
      state.status = "";
      state.token = "";
    },
    teams_success(state, teams) {
      state.status = "success";
      state.teams = teams;
    },
    rights_success(state, rights) {
      state.status = "success";
      state.rights = rights;
    },
    user_hours_success(state, userhours) {
      state.status = "success";
      state.user_hours = userhours;
    },
    hours_success(state, hours) {
      state.status = "success";
      state.hours = hours;
    },
    team_hours_success(state, teamhours) {
      state.status = "success";
      state.team_hours = teamhours;
    },
    specific_hours_success(state, specifichours) {
      state.status = "success";
      state.specifichours = specifichours;
    },
    clocks_success(state, clocks) {
      state.status = "success";
      state.clocks = clocks;
    },
    all_users_success(state, all_users) {
      state.status = "success";
      state.all_users = all_users;
    },
    last_clock_success(state, clockage) {
      state.status = "success";
      state.last_clock = clockage;
    },
    last_hour_success(state, lasthour) {
      state.status = "success";
      state.last_hour = lasthour;
    },
    specific_id_success(state, user_id) {
      state.status = "success";
      state.specific_id = user_id;
    },
  },

  actions: {
    login({ commit }, user) {
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios({ url: API_URL + "/login", data: user, method: "POST" })
          .then((resp) => {
            const token = resp.data.jwt;
            localStorage.setItem("token", token);
            commit("auth_success_token", token);
            resolve(resp);
          })
          .catch((err) => {
            commit("auth_error");
            localStorage.removeItem("token");
            reject(err);
          });
      });
    },

    getuser({ commit }) {
      return new Promise((resolve, reject) => {
        const token = localStorage.getItem("token");
        axios
          .get(API_URL + "/my_user", {
            headers: {
              authorization: `Bearer ${token}`,
            },
          })
          .then((response) => {
            const my_user = response.data;
            commit("auth_success_user", my_user);
            resolve(response.data);
          })
          .catch((err) => {
            commit("auth_error");
            localStorage.removeItem("token");
            reject(err);
          });
      });
    },

    register({ commit }, donnees) {
      console.log(donnees);
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios
          .post(API_URL + "/users", {
            user: donnees,
          })
          .then((resp) => {
            const token = resp.data.jwt;
            localStorage.setItem("token", token);
            axios.defaults.headers.common["Authorization"] = token;

            axios
              .get(API_URL + "/my_user", {
                headers: {
                  Authorization: `Bearer ${token}`,
                },
              })
              .then((response) => {
                const user = response.data;
                commit("auth_success", token, user);
                resolve(response);
              });
          })
          .catch((err) => {
            commit("auth_error");
            localStorage.removeItem("token");
            reject(err);
          });
      });
    },

    logout({ commit }) {
      return new Promise((resolve) => {
        commit("logout");
        localStorage.removeItem("token");
        delete axios.defaults.headers.common["Authorization"];
        resolve();
      });
    },

    getallusers({ commit }) {
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios({
          url: API_URL + "/users",
          method: "GET",
        })
          .then((resp) => {
            const all_users = resp.data;
            commit("all_users_success", all_users);
            resolve(resp);
          })
          .catch((err) => {
            commit("auth_error");
            reject(err);
          });
      });
    },

    modifyuser({ commit }, user) {
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios
          .put(API_URL + "/users/" + user.id, {
            user: {
              email: user.email,
              firstname: user.firstname,
              lastname: user.lastname,
              password: user.password,
              status: user.status,
              team_id: user.team_id,
              right_id: user.right_id,
            },
          })
          .then((retour) => {
            commit("auth_success_user", retour.data.data);
            resolve(retour);
          })
          .catch((err) => {
            commit("auth_error");
            reject(err);
          });
      });
    },
    updateuser({ commit }, data) {
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios
          .put(API_URL + "/users/" + data.info.id, {
            user: {
              email: data.info.email,
              firstname: data.info.firstname,
              lastname: data.info.lastname,
              password: data.info.password_hash,
              status: data.info.status,
              team_id: data.teamId,
              right_id: data.info.right_id,
            },
          })
          .then((retour) => {
            commit("auth_success_user", retour.data.data);
            resolve(retour);
          })
          .catch((err) => {
            commit("auth_error");
            reject(err);
          });
      });
    },

    updateuserright({ commit }, data) {
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios
          .put(API_URL + "/users/" + data.info.id, {
            user: {
              email: data.info.email,
              firstname: data.info.firstname,
              lastname: data.info.lastname,
              password: data.info.password_hash,
              status: data.info.status,
              team_id: data.info.team_id,
              right_id: data.rightId,
            },
          })
          .then((retour) => {
            commit("auth_success_user", retour.data.data);
            resolve(retour);
          })
          .catch((err) => {
            commit("auth_error");
            reject(err);
          });
      });
    },

    updateuserstatus({ commit }, user) {
      console.log(user.info.id);
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios
          .put(API_URL + "/users/" + user.info.id, {
            user: {
              email: user.info.email,
              firstname: user.info.firstname,
              lastname: user.info.lastname,
              password: user.info.password_hash,
              status: false,
              team_id: user.info.team_id,
              right_id: user.info.rightId,
            },
          })
          .then((retour) => {
            commit("auth_success_user", retour.data.data);
            resolve(retour);
          })
          .catch((err) => {
            commit("auth_error");
            reject(err);
          });
      });
    },

    getallteams({ commit }) {
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios({
          url: API_URL + "/teams",
          method: "GET",
        })
          .then((resp) => {
            const teams = resp.data;
            commit("teams_success", teams);
            resolve(resp);
          })
          .catch((err) => {
            commit("auth_error");
            reject(err);
          });
      });
    },

    getallrights({ commit }) {
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios({
          url: API_URL + "/rights",
          method: "GET",
        })
          .then((resp) => {
            const rights = resp.data;
            commit("rights_success", rights);
            resolve(resp);
          })
          .catch((err) => {
            commit("auth_error");
            reject(err);
          });
      });
    },

    getallhours({ commit }) {
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios({
          url: API_URL + "/hours",
          method: "GET",
        })
          .then((resp) => {
            const hours = resp.data;
            commit("hours_success", hours);
            resolve(resp);
          })
          .catch((err) => {
            commit("auth_error");
            reject(err);
          });
      });
    },
    getspecifichours({ commit }, time) {
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios({
          url: API_URL + `/hour?start=${time.start}&end=${time.end}`,
          method: "GET",
        })
          .then((resp) => {
            const specifichours = resp.data;
            commit("specific_hours_success", specifichours);
            resolve(resp);
          })
          .catch((err) => {
            commit("auth_error");
            reject(err);
          });
      });
    },
    getuserhours({ commit }, user_id) {
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios({
          url: API_URL + "/myhours/" + user_id.user_id,
          method: "GET",
        })
          .then((resp) => {
            const userhours = resp.data;
            commit("user_hours_success", userhours);
            resolve(resp);
          })
          .catch((err) => {
            commit("auth_error");
            reject(err);
          });
      });
    },
    getteamhours({ commit }, team_id) {
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios({
          url: API_URL + "/teamhours/" + team_id.team_id,
          method: "GET",
        })
          .then((resp) => {
            const teamhours = resp.data;
            commit("team_hours_success", teamhours);
            resolve(resp);
          })
          .catch((err) => {
            commit("auth_error");
            reject(err);
          });
      });
    },
    clockin({ commit }, clock) {
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios
          .post(API_URL + "/clocks", {
            clock: clock,
          })
          .then((resp) => {
            const clockage = resp.data;
            commit("clocks_success", clockage);
            resolve(clockage);
          })
          .catch((err) => {
            commit("auth_error");
            reject(err);
          });
      });
    },
    lastclock({ commit }, user_id) {
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios({
          url: API_URL + "/lastclock/" + user_id,
          method: "GET",
        })
          .then((resp) => {
            const lastclockage = resp.data;
            commit("last_clock_success", lastclockage);
            resolve(resp);
          })
          .catch((err) => {
            commit("auth_error");
            reject(err);
          });
      });
    },
    posthour({ commit }, hour) {
      console.log(hour)
      return new Promise((resolve, reject) => {
        commit("auth_request");
        axios
          .post(API_URL + "/hours", {
            hour: {
              start: hour.start,
              end: hour.time,
              user_id: hour.user_id,
              team_id: hour.team_id,
            },
          })
          .then((resp) => {
            const lasthour = resp.data;
            commit("last_hour_success", lasthour);
            resolve(resp);
          })
          .catch((err) => {
            commit("auth_error");
            reject(err);
          });
      });
    },
  },

  getters: {
    isLoggedIn: (state) => !!state.token,
    authStatus: (state) => state.status,
    isUser: (state) => state.user,
    isClocked: (state) => state.clocks,
    isLastClock: (state) => state.last_clock,
    isSpecificHours: (state) => state.specific_hours,
    isSpecificId: (state) => state.specific_id,
    isUserHours: (state) => state.user_hours,
    isTeamHours: (state) => state.team_hours,
  },
});
