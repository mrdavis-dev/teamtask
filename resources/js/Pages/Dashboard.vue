<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head } from '@inertiajs/vue3';
import TaskList from '@/Components/TaskList.vue';
import TaskForm from '@/Components/TaskForm.vue';
import TaskFilter from '@/Components/TaskFilter.vue';
import { ref } from 'vue';

// Props que recibiremos del controlador
defineProps({
    users: Array,
    tasks: Array,
});

const currentFilter = ref('all');

const handleFilterChange = (filter) => {
    currentFilter.value = filter;
};
</script>

<template>
    <Head title="Dashboard" />

    <AuthenticatedLayout>
        <template #header>
            <h2 class="text-xl font-semibold leading-tight text-gray-800">
                Dashboard
            </h2>
        </template>

        <div class="py-12">
            <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
                <div class="overflow-hidden bg-white shadow-sm sm:rounded-lg">
                    <div class="p-6 text-gray-900">
                        <h3 class="text-lg font-semibold">Task Management</h3>

                        <!-- Task Form -->
                        <div class="mb-6">
                            <TaskForm :users="users" />
                        </div>

                        <!-- Task Filter -->
                        <div class="mb-6">
                            <TaskFilter @filter-changed="handleFilterChange" />
                        </div>

                        <!-- Task List -->
                        <TaskList :tasks="tasks" :filter="currentFilter" />
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
