<script setup>
import { ref } from 'vue';
import { Link } from '@inertiajs/vue3';

const props = defineProps({
    isRegister: {
        type: Boolean,
        default: false
    }
});

const registerActive = ref(props.isRegister);
</script>

<template>
    <div id="app">
        <div class="login-page">
            <!-- Login Wallpaper -->
            <transition name="fade">
                <div v-if="!registerActive" class="wallpaper-login"></div>
            </transition>
            
            <!-- Register Wallpaper -->
            <div v-if="registerActive" class="wallpaper-register"></div>

            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-6 col-sm-8 mx-auto">
                        <div class="card-auth" :class="{ 'register-mode': registerActive }">
                            <!-- Brand -->
                            <div class="brand-section">
                                <Link href="/" class="brand-link">
                                    <span class="brand-text">TeamTask</span>
                                </Link>
                            </div>

                            <!-- Content Slot -->
                            <slot />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
/* Base Styles */
#app {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.login-page {
    min-height: 100vh;
    position: relative;
    overflow: hidden;
}

.container {
    position: relative;
    z-index: 10;
    min-height: 100vh;
    display: flex;
    align-items: center;
    padding: 2rem 1rem;
}

.row {
    width: 100%;
    display: flex;
    justify-content: center;
}

.col-lg-4 {
    width: 100%;
    max-width: 400px;
}

/* Wallpapers */
.wallpaper-login,
.wallpaper-register {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 1;
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
}

.wallpaper-login {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    background-image: 
        radial-gradient(circle at 20% 80%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
        radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
        radial-gradient(circle at 40% 40%, rgba(120, 119, 198, 0.2) 0%, transparent 50%);
}

.wallpaper-register {
    background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
    background-image: 
        radial-gradient(circle at 20% 80%, rgba(240, 147, 251, 0.3) 0%, transparent 50%),
        radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
        radial-gradient(circle at 40% 40%, rgba(245, 87, 108, 0.2) 0%, transparent 50%);
}

/* Card Styles */
.card-auth {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    border-radius: 20px;
    padding: 2.5rem;
    box-shadow: 
        0 20px 25px -5px rgba(0, 0, 0, 0.1), 
        0 10px 10px -5px rgba(0, 0, 0, 0.04),
        0 0 0 1px rgba(255, 255, 255, 0.2);
    border: 1px solid rgba(255, 255, 255, 0.2);
    transition: all 0.3s ease;
}

.card-auth.register-mode {
    background: rgba(255, 255, 255, 0.98);
    box-shadow: 
        0 25px 30px -5px rgba(245, 87, 108, 0.2), 
        0 15px 15px -5px rgba(240, 147, 251, 0.1),
        0 0 0 1px rgba(255, 255, 255, 0.3);
}

/* Brand Section */
.brand-section {
    text-align: center;
    margin-bottom: 2rem;
}

.brand-link {
    text-decoration: none;
    display: inline-block;
    transition: transform 0.2s ease;
}

.brand-link:hover {
    transform: scale(1.05);
}

.brand-text {
    font-size: 2.5rem;
    font-weight: 800;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    letter-spacing: -0.02em;
}

.register-mode .brand-text {
    background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

/* Transitions */
.fade-enter-active, .fade-leave-active {
    transition: opacity 0.8s ease;
}

.fade-enter-from, .fade-leave-to {
    opacity: 0;
}

/* Responsive */
@media (max-width: 768px) {
    .container {
        padding: 1rem;
    }
    
    .card-auth {
        padding: 2rem 1.5rem;
        border-radius: 15px;
    }
    
    .brand-text {
        font-size: 2rem;
    }
}

@media (max-width: 480px) {
    .card-auth {
        margin: 1rem;
        padding: 1.5rem;
    }
    
    .brand-text {
        font-size: 1.8rem;
    }
}
</style>
