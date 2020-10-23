import axios from 'axios';

class AuthService {
  async login(user) {
    return await axios
      .post("http://localhost:8080/api/login/", {
        username: user.username,
        password: user.password
      })
      .then(response => {
        if (response.data.accessToken) {
          localStorage.setItem('user', JSON.stringify(response.data));
        }
        return response.data;
      });
  }

  logout() {
    localStorage.removeItem('user');
  }

  register(user) {
    return axios.post("http://localhost:8080/api/users/", {
      username: user.username,
      email: user.email,
      password: user.password
    });
  }
}

export default new AuthService();