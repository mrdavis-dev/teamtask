<template>
  <div class="task-filter">
    <label for="filter">Filter Tasks:</label>
    <select id="filter" v-model="selectedFilter" @change="handleFilterChange" class="minimal-select">
      <option value="all">All</option>
      <option value="pendiente">Pending</option>
      <option value="en progreso">In Progress</option>
      <option value="completada">Completed</option>
    </select>
  </div>
</template>

<script>
export default {
  name: 'TaskFilter',
  data() {
    return {
      selectedFilter: 'all'
    }
  },
  emits: ['filter-changed'],
  methods: {
    handleFilterChange() {
      this.$emit('filter-changed', this.selectedFilter);
    }
  }
};
</script>

<style scoped>
.task-filter {
  display: flex;
  flex-direction: column;
  gap: 10px;
  margin: 20px 0;
}
label {
  font-size: 14px;
  color: #333;
  font-weight: 500;
}
.minimal-select {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
  background-color: white;
  transition: border-color 0.2s;
}

.minimal-select:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
}
</style>