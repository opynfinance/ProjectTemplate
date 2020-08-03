const shell = require('shelljs')

module.exports = {
  istanbulReporter: ['html'],
  client: require('ganache-cli'),
  providerOptions: {
    mnemonic: "candy maple cake sugar pudding cream honey rich smooth crumble sweet treat"
  },
  mocha: {
    delay: true,
  },
  onCompileComplete: async function (_config) {
    await run('typechain')
  },
  onIstanbulComplete: async function (_config) {
    shell.rm('-rf', './typechain')
  },
  skipFiles: ['mocks', 'test'],
}
