<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import { Link } from '@inertiajs/vue3';

const showingNavigationDropdown = ref(false);
const showingMobileMenu = ref(false);

// Toggle dropdown
const toggleDropdown = (event) => {
    event.stopPropagation();
    console.log('Toggling dropdown, current value:', showingNavigationDropdown.value);
    showingNavigationDropdown.value = !showingNavigationDropdown.value;
    console.log('New dropdown value:', showingNavigationDropdown.value);
};

// Toggle mobile menu
const toggleMobileMenu = () => {
    showingMobileMenu.value = !showingMobileMenu.value;
};

// Close dropdown when clicking outside
const closeDropdown = (event) => {
    const userDropdown = document.querySelector('.user-dropdown');
    const mobileMenu = document.querySelector('.mobile-menu-button');
    const mobileNav = document.querySelector('.mobile-nav');
    
    if (userDropdown && !userDropdown.contains(event.target)) {
        showingNavigationDropdown.value = false;
    }
    
    if (mobileMenu && mobileNav && !mobileMenu.contains(event.target) && !mobileNav.contains(event.target)) {
        showingMobileMenu.value = false;
    }
};

onMounted(() => {
    document.addEventListener('click', closeDropdown);
});

onUnmounted(() => {
    document.removeEventListener('click', closeDropdown);
});
</script>

<template>
    <div>
        <div class="min-h-screen bg-gray-50">
            <!-- Navigation -->
            <nav class="navbar">
                <div class="navbar-container">
                    <!-- Brand -->
                    <div class="navbar-brand">
                        <Link :href="route('dashboard')" class="brand-link">
                            TeamTask
                        </Link>
                    </div>

                    <!-- Desktop Navigation -->
                    <div class="navbar-nav-desktop">
                        <Link :href="route('dashboard')" 
                              :class="route().current('dashboard') ? 'nav-link active' : 'nav-link'">
                            Dashboard
                        </Link>
                    </div>

                    <!-- User Dropdown -->
                    <div class="user-dropdown">
                        <button @click="toggleDropdown($event)"
                                class="user-button">
                            <span class="user-name">{{ $page.props.auth.user.name.split(' ')[0] }}</span>
                            <svg class="dropdown-icon" :class="{ 'rotate-180': showingNavigationDropdown }" 
                                 fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                            </svg>
                        </button>

                        <!-- Dropdown Menu -->
                        <Transition
                            enter-active-class="transition duration-200 ease-out"
                            enter-from-class="transform scale-95 opacity-0"
                            enter-to-class="transform scale-100 opacity-100"
                            leave-active-class="transition duration-75 ease-in"
                            leave-from-class="transform scale-100 opacity-100"
                            leave-to-class="transform scale-95 opacity-0"
                        >
                            <div v-show="showingNavigationDropdown" class="dropdown-menu">
                                <div class="dropdown-header">
                                    <div class="user-info">
                                        <div class="user-full-name">{{ $page.props.auth.user.name }}</div>
                                        <div class="user-email">{{ $page.props.auth.user.email }}</div>
                                    </div>
                                </div>
                                <div class="dropdown-divider"></div>
                                <Link :href="route('profile.edit')" class="dropdown-item">
                                    <svg class="dropdown-item-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                              d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                    </svg>
                                    Profile
                                </Link>
                                <Link :href="route('logout')" method="post" as="button" class="dropdown-item">
                                    <svg class="dropdown-item-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                              d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                                    </svg>
                                    Log Out
                                </Link>
                            </div>
                        </Transition>
                    </div>

                    <!-- Mobile menu button -->
                    <div class="mobile-menu-button">
                        <button @click="toggleMobileMenu"
                                class="mobile-toggle">
                            <svg class="hamburger-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path :class="{'hidden': showingMobileMenu, 'inline-flex': !showingMobileMenu}"
                                      stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                                <path :class="{'hidden': !showingMobileMenu, 'inline-flex': showingMobileMenu}"
                                      stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>
                </div>

                <!-- Mobile Navigation Menu -->
                <div :class="{'block': showingMobileMenu, 'hidden': !showingMobileMenu}" 
                     class="mobile-nav">
                    <div class="mobile-nav-content">
                        <Link :href="route('dashboard')" 
                              :class="route().current('dashboard') ? 'mobile-nav-link active' : 'mobile-nav-link'">
                            Dashboard
                        </Link>
                        
                        <div class="mobile-user-section">
                            <div class="mobile-user-info">
                                <div class="mobile-user-name">{{ $page.props.auth.user.name }}</div>
                                <div class="mobile-user-email">{{ $page.props.auth.user.email }}</div>
                            </div>
                            <Link :href="route('profile.edit')" class="mobile-nav-link">
                                Profile
                            </Link>
                            <Link :href="route('logout')" method="post" as="button" class="mobile-nav-link">
                                Log Out
                            </Link>
                        </div>
                    </div>
                </div>
            </nav>

            <!-- Page Content -->
            <main class="main-content">
                <slot />
            </main>
        </div>
    </div>
</template>

<style scoped>
/* Main Navbar */
.navbar {
    background: #ffffff;
    border-bottom: 1px solid #e5e7eb;
    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
    position: sticky;
    top: 0;
    z-index: 100;
}

.navbar-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1rem;
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: 4rem;
}

/* Brand */
.navbar-brand {
    flex-shrink: 0;
}

.brand-link {
    font-size: 1.5rem;
    font-weight: 700;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    text-decoration: none;
    transition: all 0.2s ease;
}

.brand-link:hover {
    transform: scale(1.05);
}

/* Desktop Navigation */
.navbar-nav-desktop {
    display: none;
    margin-left: 2rem;
}

@media (min-width: 768px) {
    .navbar-nav-desktop {
        display: flex;
        gap: 1.5rem;
    }
}

.nav-link {
    padding: 0.5rem 1rem;
    color: #6b7280;
    text-decoration: none;
    font-weight: 500;
    border-radius: 0.5rem;
    transition: all 0.2s ease;
}

.nav-link:hover {
    color: #374151;
    background-color: #f3f4f6;
}

.nav-link.active {
    color: #ffffff;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

/* User Dropdown */
.user-dropdown {
    position: relative;
    display: none;
    z-index: 999;
}

@media (min-width: 768px) {
    .user-dropdown {
        display: block;
    }
}

.user-button {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    background: #f9fafb;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    color: #374151;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
}

.user-button:hover {
    background: #f3f4f6;
    border-color: #d1d5db;
}

.user-name {
    font-size: 0.875rem;
}

.dropdown-icon {
    width: 1rem;
    height: 1rem;
    transition: transform 0.2s ease;
}

.dropdown-icon.rotate-180 {
    transform: rotate(180deg);
}

.dropdown-menu {
    position: absolute;
    top: 100%;
    right: 0;
    margin-top: 0.5rem;
    background: #ffffff;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
    min-width: 12rem;
    overflow: hidden;
    z-index: 1000;
    display: block;
}

.dropdown-header {
    padding: 0.75rem 1rem;
    background: #f9fafb;
    border-bottom: 1px solid #e5e7eb;
}

.user-info {
    text-align: left;
}

.user-full-name {
    font-weight: 600;
    color: #1f2937;
    font-size: 0.875rem;
}

.user-email {
    color: #6b7280;
    font-size: 0.75rem;
    margin-top: 0.125rem;
}

.dropdown-divider {
    height: 1px;
    background: #e5e7eb;
}

.dropdown-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.75rem 1rem;
    color: #374151;
    text-decoration: none;
    font-size: 0.875rem;
    font-weight: 500;
    transition: all 0.2s ease;
    border: none;
    background: none;
    width: 100%;
    text-align: left;
    cursor: pointer;
}

.dropdown-item:hover {
    background: #f3f4f6;
    color: #1f2937;
}

.dropdown-item-icon {
    width: 1rem;
    height: 1rem;
}

/* Mobile Menu */
.mobile-menu-button {
    display: block;
}

@media (min-width: 768px) {
    .mobile-menu-button {
        display: none;
    }
}

.mobile-toggle {
    padding: 0.5rem;
    color: #374151;
    background: none;
    border: none;
    border-radius: 0.25rem;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.mobile-toggle:hover {
    background: #f3f4f6;
}

.hamburger-icon {
    width: 1.5rem;
    height: 1.5rem;
}

.mobile-nav {
    border-top: 1px solid #e5e7eb;
    background: #ffffff;
}

@media (min-width: 768px) {
    .mobile-nav {
        display: none !important;
    }
}

.mobile-nav-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 1rem;
}

.mobile-nav-link {
    display: block;
    padding: 0.75rem 1rem;
    color: #374151;
    text-decoration: none;
    font-weight: 500;
    border-radius: 0.5rem;
    margin-bottom: 0.25rem;
    transition: all 0.2s ease;
    border: none;
    background: none;
    width: 100%;
    text-align: left;
    cursor: pointer;
}

.mobile-nav-link:hover {
    background: #f3f4f6;
    color: #1f2937;
}

.mobile-nav-link.active {
    color: #ffffff;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.mobile-user-section {
    margin-top: 1rem;
    padding-top: 1rem;
    border-top: 1px solid #e5e7eb;
}

.mobile-user-info {
    padding: 0.75rem 1rem;
    background: #f9fafb;
    border-radius: 0.5rem;
    margin-bottom: 0.5rem;
}

.mobile-user-name {
    font-weight: 600;
    color: #1f2937;
    font-size: 0.875rem;
}

.mobile-user-email {
    color: #6b7280;
    font-size: 0.75rem;
    margin-top: 0.125rem;
}

/* Main Content */
.main-content {
    background-color: #f8fafc;
    min-height: calc(100vh - 4rem);
}

/* Responsive adjustments */
@media (max-width: 640px) {
    .navbar-container {
        padding: 0 0.5rem;
    }
    
    .brand-link {
        font-size: 1.25rem;
    }
}
</style>
