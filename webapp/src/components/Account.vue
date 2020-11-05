<template>
  <div>
    <form novalidate class="md-layout" @submit.prevent="validateUser">
      <md-card class="md-layout-item md-size-50 md-small-size-100 formulaire">
        <md-card-header>
          <div class="md-title" v-if="user">
            Hello {{ user.firstname + " " + user.lastname }} !
            <md-icon>pan_tool</md-icon>
          </div>
        </md-card-header>

        <md-card-content>
          <div class="md-layout md-gutter">
            <div class="md-layout-item md-small-size-100">
              <md-field :class="getValidationClass('firstname')">
                <label for="first-name">First name</label>
                <md-input
                  name="firstname"
                  id="firstname"
                  v-model="form.firstname"
                  :disabled="editing"
                />
                <span class="md-error" v-if="!$v.form.firstname.required"
                  >The first name is required</span
                >
                <span class="md-error" v-else-if="!$v.form.firstname.minlength"
                  >Invalid firstname</span
                >
              </md-field>
            </div>
          </div>
          <md-field :class="getValidationClass('lastname')">
            <label for="last-name">Last name</label>
            <md-input
              name="lastname"
              id="lastname"
              v-model="form.lastname"
              :disabled="editing"
            />
            <span class="md-error" v-if="!$v.form.lastname.required"
              >The last name is required</span
            >
            <span class="md-error" v-else-if="!$v.form.lastname.minlength"
              >Invalid lastname</span
            >
          </md-field>
          <md-field :class="getValidationClass('email')">
            <label for="email">Email</label>
            <md-input
              type="email"
              name="email"
              id="email"
              autocomplete="email"
              v-model="form.email"
              :disabled="editing"
            />
            <span class="md-error" v-if="!$v.form.email.required"
              >The email is required</span
            >
            <span class="md-error" v-else-if="!$v.form.email.email"
              >Invalid email</span
            >
          </md-field>
          <md-field :class="getValidationClass('password')">
            <label for="password">Password</label>
            <md-input
              type="password"
              name="password"
              id="password"
              v-model="form.password"
              :disabled="editing"
            />
            <span class="md-error" v-if="!$v.form.password.required"
              >The password is required</span
            >
            <span class="md-error" v-else-if="!$v.form.password.password"
              >Invalid password</span
            >
          </md-field>
        </md-card-content>

        <md-progress-bar md-mode="indeterminate" v-if="sending" />

        <md-card-actions>
          <md-button v-if="editing" @click="edit()" class="md-raised md-primary"
            >Edit</md-button
          >
          <md-button @click="showDialog = true" class="md-raised red"
            ><md-icon>delete</md-icon></md-button
          >
          <md-button v-if="!editing" @click="cancel()" class="md-raised red"
            >Cancel</md-button
          >
          <md-button v-if="!editing" class="md-raised md-primary"
            >Update</md-button
          >
        </md-card-actions>
      </md-card> 
    </form>
    <md-snackbar :md-active.sync="userSaved"> {{ message }} </md-snackbar>
    <md-dialog :md-active.sync="showDialog">
      <md-dialog-title>Remove account</md-dialog-title>
          <p>Are you sure you want to remove your account ?</p>
      <md-dialog-actions>
        <md-button class="md-primary" @click="showDialog = false">Cancel</md-button>
        <md-button class="red" @click="remove()">Remove</md-button>
      </md-dialog-actions>
    </md-dialog>
  </div>
</template>

<script>
import { validationMixin } from "vuelidate";
import { required, email } from "vuelidate/lib/validators";

export default {
  name: "Register",
  mixins: [validationMixin],
  data: () => ({
    form: {
      email: null,
      firstname: null,
      lastname: null,
      password: null,
    },
    userSaved: false,
    editing: true,
    sending: false,
    user: null,
    message: null,
    showDialog: false
  }),
  validations: {
    form: {
      email: {
        required,
        email,
      },
      firstname: {
        required,
      },
      lastname: {
        required,
      },
      password: {
        required,
      },
    },
  },
  methods: {
    edit() {
      this.editing = false;
    },
    cancel() {
      this.editing = true;
    },
    gosignin() {
      this.$router.push("login");
    },
    getValidationClass(fieldName) {
      const field = this.$v.form[fieldName];

      if (field) {
        return {
          "md-invalid": field.$invalid && field.$dirty,
        };
      }
    },
    clearForm() {
      this.$v.$reset();
      this.form.firstname = null;
      this.form.lastname = null;
      this.form.password = null;
      this.form.email = null;
    },
    remove() {
      this.showDialog = false
      // handle user remove
    },
    updateUser() {
      this.sending = true;
      this.clearForm();
      this.$store
        .dispatch("modifyuser", {
          email: this.form.email,
          firstname: this.form.firstname,
          lastname: this.form.lastname,
          password: this.form.password,
          status: true,
          right_id: "",
          team_id: "",
        })
        .then((response) => {
          if (response.status === 200) {
            this.message =
              "The user " +
              this.user.firstname +
              " " +
              this.user.lastname +
              " has successfully been updated!";
            this.userSaved = true;
            this.sending = false;
          }
        })
        .catch(() => {
          this.message = "An error occured. Please try again.";
          this.userSaved = true;
          this.sending = false;
        });
    },
    validateUser() {
      this.$v.$touch();

      if (!this.$v.$invalid) {
        this.updateUser();
      }
    },
  },
  async mounted() {
    this.$store.dispatch("getuser").then((response) => {
      this.user = response;
    });
  },
};
</script>

<style lang="scss" scoped>
.md-progress-bar {
  position: absolute;
  top: 0;
  right: 0;
  left: 0;
}
.formulaire {
  margin-left: auto;
  margin-right: auto;
}
.espace {
  margin-right: 20px;
}
.red {
  background-color: red !important;
  color: white !important;
}
</style>
