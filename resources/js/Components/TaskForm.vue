<template>
  <form class="task-form" @submit.prevent="handleSubmit">
    <input v-model="task.name" type="text" placeholder="Task Name" class="minimal-input" required />
    <textarea v-model="task.description" placeholder="Task Description" class="minimal-textarea" required></textarea>
    <input v-model="task.due_date" type="date" class="minimal-input" required />
    <select v-model="task.user_id" class="minimal-select" required>
      <option value="" disabled>Select User</option>
      <option v-for="user in users" :key="user.id" :value="user.id">
        {{ user.name }}
      </option>
    </select>
    <button type="submit" class="minimal-button" :disabled="loading">
      {{ loading ? 'Creating...' : 'Add Task' }}
    </button>
  </form>
</template>

<script>
import { router } from '@inertiajs/vue3';

export default {
  name: 'TaskForm',
  props: {
    users: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      loading: false,
      task: {
        name: '',
        description: '',
        user_id: '',
        due_date: ''
      },
    };
  },
  methods: {
    handleSubmit() {
      this.loading = true;
      
      router.post('/dashboard/tasks', this.task, {
        onSuccess: () => {
          this.task = { name: '', description: '', user_id: '', due_date: '' };
          this.loading = false;
        },
        onError: () => {
          this.loading = false;
        }
      });
    },
  },
};
</script>

<style scoped>
.task-form {
  display: flex;
  flex-direction: column;
  gap: 15px;
  margin: 20px 0;
  padding: 20px;
  background: #f8f9fa;
  border-radius: 8px;
}
.minimal-input,
.minimal-textarea,
.minimal-select {
  padding: 12px 16px;
  border: 2px solid #e5e7eb;
  border-radius: 8px;
  font-size: 16px;
  transition: all 0.2s ease-in-out;
  background-color: #ffffff;
}
.minimal-input:focus,
.minimal-textarea:focus,
.minimal-select:focus {
  outline: none;
  border-color: #667eea;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}
.minimal-button {
  padding: 12px 24px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #ffffff;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease-in-out;
}
.minimal-button:hover:not(:disabled) {
  transform: translateY(-1px);
  box-shadow: 0 8px 15px rgba(102, 126, 234, 0.3);
}
.minimal-button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}
</style>