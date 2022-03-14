enum Env { dev, prod }

class Environment {
  final Env environment;
  late String baseURL;
  late String testUserIdentifier;
  late String testUserPass;

  Environment(this.environment) {
    switch (environment) {
      case Env.prod:
        baseURL = 'https://mocki.io/v1/';
        testUserIdentifier = '0560000000';
        testUserPass = 'ab123456';
        break;
      case Env.dev:
        baseURL = 'https://mocki.io/v1/';
        testUserIdentifier = '0560000001';
        testUserPass = 'ab123456';
        break;
    }
  }
}
