import axios from "axios";
import { API_URL } from "../../../components/services/constants";

const state = () => ({
  status: "",
  token: localStorage.getItem("token") || "",
  user: {},
  all_users: [],
});

// getters
const getters = {
  isLoggedIn:  !!state.token,
  authStatus: state.status,
};

// actions
const actions = {
  login({ commit }, user) {
    return new Promise((resolve, reject) => {
      commit("auth_request");
      axios({ url: API_URL + "/login", data: user, method: "POST" })
        .then((resp) => {
          const token = resp.data.jwt;
          localStorage.setItem("token", token);
          axios.defaults.headers.common["Authorization"] = token;

          axios({ url: API_URL + "/my_user", method: "GET" }).then(
            (response) => {
              const user = response.data;
              commit("auth_success", token, user);
            }
          );
          resolve(resp);
        })
        .catch((err) => {
          commit("auth_error");
          localStorage.removeItem("token");
          reject(err);
        });
    });
  },
  register({ commit }, donnees) {
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
    //   return new Promise((resolve, reject) => {
    return new Promise((resolve) => {
      mutations.commit("logout");
      localStorage.removeItem("token");
      delete axios.defaults.headers.common["Authorization"];
      resolve();
    });
  },
};

// mutations
const mutations = {
  auth_request(state) {
    state.status = "loading";
  },
  auth_success(state, token, user) {
    state.status = "success";
    state.token = token;
    state.user = user;
  },
  auth_error(state) {
    state.status = "error";
  },
  logout(state) {
    state.status = "";
    state.token = "";
  },
  all_users_success(state, all_users) {
    state.all_users = all_users;
  },
};

// export default {
//   namespaced: true,
//   state,
//   getters,
//   actions,
//   mutations,
// };
export default user;