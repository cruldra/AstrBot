<template>
  <v-card elevation="1" class="stat-card uptime-card">
    <v-card-text>
      <div class="d-flex align-start">
        <div class="icon-wrapper">
          <v-icon icon="mdi-clock-outline" size="24"></v-icon>
        </div>
        
        <div class="stat-content">
          <div class="stat-title">{{ t('stats.runningTime.title') }}</div>
          <div class="stat-value-wrapper">
            <h2 class="stat-value">{{ formattedTime }}</h2>
          </div>
          <div class="stat-subtitle">{{ t('stats.runningTime.subtitle') }}</div>
        </div>
      </div>
    </v-card-text>
  </v-card>
</template>

<script>
import { useModuleI18n } from '@/i18n/composables';

export default {
  name: 'RunningTime',
  props: ['stat'],
  setup() {
    const { tm: t } = useModuleI18n('features/dashboard');
    return { t };
  },
  computed: {
    formattedTime() {
      if (!this.stat?.running) {
        return this.t('status.loading');
      }

      const { hours, minutes, seconds } = this.stat.running;
      return this.t('stats.runningTime.format', {
        hours,
        minutes,
        seconds
      });
    }
  }
};
</script>

<style scoped>
.stat-card {
  height: 100%;
  border-radius: 8px;
  transition: transform 0.2s, box-shadow 0.2s;
  overflow: hidden;
}

.stat-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08) !important;
}

.uptime-card {
  background-color: #4caf50;
  color: white;
}

.icon-wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 48px;
  height: 48px;
  border-radius: 8px;
  margin-right: 16px;
  background: rgba(255, 255, 255, 0.2);
}

.stat-content {
  flex: 1;
}

.stat-title {
  font-size: 14px;
  font-weight: 500;
  opacity: 0.9;
  margin-bottom: 4px;
}

.stat-value-wrapper {
  display: flex;
  align-items: baseline;
  margin-bottom: 4px;
}

.stat-value {
  font-size: 24px;
  font-weight: 600;
  line-height: 1.2;
}

.stat-subtitle {
    font-size: 12px;
    opacity: 0.7;
  }
</style>
