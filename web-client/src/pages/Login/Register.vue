<template>
    <div class="register-container">
        <!--注册面板内容部分-->
        <div class="register-inner">
            <!--面板头部-->
            <div class="register-header">
                <div class="register-logo">
                    新用户注册
                </div>
                <!--面板标题-->
                <div class="register-header-title">
                    <a href="javascript:;" :class="{ current: registerMode }" @click="dealLoginMode(true)">验证码注册</a>
                    <a href="javascript:;" :class="{ current: !registerMode }" @click="dealLoginMode(false)">密码注册</a>
                </div>
            </div>
            <!--面板表单部分-->
            <div class="register-content">
                <form>
                    <!--手机验证码注册部分-->
                    <div :class="{ current: registerMode }">
                        <section class="register-message">
                            <input type="tel" maxlength="11" placeholder="手机号" v-model="phone">
                            <button v-if="!countDown" class="get-verification" :class="{ phone_right: phoneRight }"
                                @click.prevent="getVerifyCode()">
                                获取验证码
                            </button>
                            <button v-else disabled="disabled" class="get-verification">
                                已发送({{ countDown }}s)
                            </button>
                        </section>
                        <section class="register-verification">
                            <input type="tel" maxlength="8" placeholder="验证码" v-model="code">
                        </section>
                        <section class="register-hint">
                            温馨提示：未注册帐号的手机号，注册时将自动注册，且代表已同意
                            <a href="javascript:;">服务协议与隐私政策</a>
                        </section>
                    </div>
                    <!--账号注册部分-->
                    <div :class="{ current: !registerMode }">
                        <section>
                            <section class="register-message">
                                <input type="text" maxlength="11" placeholder="手机号" v-model="user_name">
                            </section>
                            <section class="register-verification">
                                <input type="password" maxlength="18" placeholder="密码" v-if="pwdMode" v-model="pwd">
                                <input type="text" maxlength="18" placeholder="密码" v-else v-model="pwd">
                                <div class="switch-show">
                                    <img @click.prevent="dealPwdMode(false)" :class="{ on: pwdMode }"
                                        src="./images/hide_pwd.png" alt="" width="20">
                                    <img @click.prevent="dealPwdMode(true)" :class="{ on: !pwdMode }"
                                        src="./images/show_pwd.png" alt="" width="20">
                                </div>
                            </section>
                            <section class="register-message">
                                <input type="text" maxlength="11" placeholder="验证码" v-model="captcha">
                                <img ref="captcha" class="get-verification" src="http://localhost:3000/api/captcha"
                                    alt="captcha" @click.prevent="getCaptcha()">
                            </section>
                            <section class="register-hint">
                                温馨提示：未注册帐号的用户账号，注册时将自动注册，且代表已同意
                                <a href="javascript:;">服务协议与隐私政策</a>
                            </section>
                        </section>
                    </div>
                    <button class="register-submit" @click.prevent="register()">注册</button>
                </form>
                <button class="register-back" @click="$router.back()">返回主页</button>
                <button class="go-login" @click="$router.replace('/login')">登录界面</button>
            </div>
        </div>
    </div>
</template>

<script>
import { getPhoneCode, phoneCodeRegister, pwdCodeRegister } from './../../api/index';
import { MessageBox } from 'element-ui';
import { mapActions } from 'vuex'

export default {
    name: "Register",
    data() {
        return {
            registerMode: true, // 注册方式, true 验证码注册 false 账号注册
            phone: '', // 手机号码
            countDown: 0, // 倒计时
            pwdMode: true, // 密码的显示方式 true 密文 false 明文
            pwd: '', // 密码
            code: '', // 验证码
            userInfo: {}, // 用户的信息
            user_name: '', // 用户名
            captcha: '',  // 图形验证码
        }
    },
    computed: {
        // 验证手机号是否合理
        phoneRight() {
            return /^[1][3,4,5,7,8][0-9]{9}$/.test(this.phone)
        }
    },
    methods: {
        ...mapActions(['syncUserInfo']),
        // 1. 注册的模式
        dealLoginMode(flag) {
            this.registerMode = flag;
        },
        // 2. 获取短信验证码
        async getVerifyCode() {
            // 2.1 开启倒计时
            if (this.phoneRight) {
                this.countDown = 60;
                this.intervalId = setInterval(() => {
                    this.countDown--;
                    // 判断
                    if (this.countDown === 0) {
                        clearInterval(this.intervalId);
                    }
                }, 1000);
            }
            // 2.2 获取短信验证码
            let result = await getPhoneCode(this.phone);
            console.log(result);
            // 2.3 获取验证码失败
            if (result.err_code === 0) {
                // 提示信息
                MessageBox({
                    type: 'info',
                    message: result.message,
                    showClose: true,
                });
            } else if (result.success_code === 200) {
                MessageBox({
                    type: 'info',
                    message: `验证码为:${result.message}`,
                    showClose: true,
                });
            }
        },
        // 3. 密码的显示方式
        dealPwdMode(flag) {
            this.pwdMode = flag;
        },
        // 4. 获取图形验证码
        getCaptcha() {
            this.$refs.captcha.src = 'http://localhost:3000/api/captcha?time=' + new Date();
        },
        // 5. 注册
        async register() {
            let registerSuccess = false
            // 5.1 注册模式
            if (this.registerMode) { // 验证码注册
                // 5.2 前台校验
                if (!this.phone) {
                    MessageBox({
                        type: 'info',
                        message: "请输入手机号码!",
                        showClose: true,
                    });
                    return;
                } else if (!this.phoneRight) {
                    MessageBox({
                        type: 'info',
                        message: "请输入正确手机号码!",
                        showClose: true

                    });
                    return;
                }

                if (!this.code) {
                    MessageBox({
                        type: 'info',
                        message: "请输入验证码!",
                        showClose: true,
                    });
                    return;
                } else if (!(/^\d{6}$/gi.test(this.code))) {
                    MessageBox({
                        type: 'info',
                        message: "请输入正确的验证码!",
                        showClose: true
                    });
                    return;
                }
                // 5.3 手机验证码注册
                const result = await phoneCodeRegister(this.phone, this.code);
                if (result.success_code === 200) {
                    console.log('验证码注册成功', result);
                    registerSuccess = true
                    this.userInfo = result.message;
                    this.phone = ''; // 手机号码
                    this.countDown = 0; // 倒计时
                    clearInterval(this.intervalId);
                    this.code = ''; // 验证码
                    this.pwd = ''; // 密码
                    this.user_name = ''; // 用户名
                    this.captcha = '';  // 图形验证码
                } else {
                    MessageBox({
                        type: 'info',
                        message: `${result.message}`,
                        showClose: true,
                        callback: () => {
                            window.location.reload()
                        }
                    });
                    return;
                }
            } else { // 账号和密码注册
                // 5.4 前端校验
                if (!this.user_name) {
                    MessageBox({
                        type: 'info',
                        message: "请输入手机号!",
                        showClose: true,
                    });
                    return;
                } else if (!this.pwd) {
                    MessageBox({
                        type: 'info',
                        message: "请输入密码!",
                        showClose: true,
                    });
                    return;
                } else if (!this.captcha) {
                    MessageBox({
                        type: 'info',
                        message: "请输入验证码!",
                        showClose: true,
                    });
                    return;
                }
                // 5.5 用户名和密码的注册
                console.log(this.user_name, this.pwd, this.captcha);
                const result = await pwdCodeRegister(this.user_name, this.pwd, this.captcha);
                if (result.success_code === 200) {
                    registerSuccess = true
                    this.userInfo = result.message;
                    this.phone = ''; // 手机号码
                    this.countDown = 0; // 倒计时
                    clearInterval(this.intervalId);
                    this.code = ''; // 验证码
                    this.pwd = ''; // 密码
                    this.user_name = ''; // 账号
                    this.captcha = '';  // 图形验证码
                } else {
                    MessageBox({
                        type: 'info',
                        message: `${result.message}`,
                        showClose: true,
                        callback: () => {
                            window.location.reload()
                        }
                    });
                }
            }

            // // 6. 后续处理
            if (registerSuccess) {
                MessageBox({
                    type: 'success',
                    message: `注册成功! 欢迎${this.userInfo.user_name}`,
                    showClose: true,
                    callback: () => {
                        this.$router.replace('/login');
                    }
                });
            }

        }
    }
}
</script>

<style scoped lang="stylus" rel="stylesheet/stylus">
    @import "../../common/stylus/mixins.styl"
    .register-container
      width 100%
      height 100%
      background #fff
      .register-inner
        padding-top 60px
        width 25%
        margin 0 auto
        .register-header
          .register-logo
            font-size 20px
            font-weight bold
            color #40A578
            text-align center
          .register-header-title
            padding-top 40px
            padding-bottom 10px
            text-align center
            > a
              color #333
              font-size 14px
              padding-bottom 4px
              &:first-child
                margin-right 40px
              &.current
                color #d71345
                font-weight 700
                border-bottom 2px solid #d71345
        .register-content
          > form
            > div
              display none
              &.current
                display block
              input
                width 100%
                height 100%
                padding-left 8px
                box-sizing border-box
                border 1px solid #ddd
                border-radius 4px
                outline 0
                font 400 14px #d71345
                &:focus
                  border 1px solid #d71345
              .register-message
                position relative
                margin-top 16px
                height 48px
                font-size 14px
                background #d71345
                .get-verification
                  position absolute
                  top 50%
                  right 10px
                  transform translateY(-50%)
                  border 0
                  color #d71345
                  font-size 14px
                  background transparent
                  &.phone_right
                    color #d71345
              .register-verification
                position relative
                margin-top 16px
                height 48px
                font-size 14px
                background #d71345
                .switch-show
                  position absolute
                  right 10px
                  top 12px
                  img
                    display none
                  img.on
                    display block
              .register-hint
                margin-top 12px
                color #d71345
                font-size 12px
                line-height 20px
                > a
                  color #d71345
            .register-submit
              display block
              width 100%
              height 42px
              margin-top 30px
              border-radius 4px
              background #d71345
              color #fff
              text-align center
              font-size 16px
              line-height 42px
              border 0
          .register-back
            display block
            width 100%
            height 42px
            margin-top 15px
            border-radius 4px
            background transparent
            border: 1px solid #d71345
            color #d71345
            text-align center
            font-size 16px
            line-height 42px
        .go-login
            display block
            width 100%
            height 42px
            margin-top 30px
            border-radius 4px
            background #40a578
            color #fff
            text-align center
            font-size 16px
            line-height 42px
            border 0

  </style>