import { defineConfig } from 'vitepress';

export default defineConfig({
  title: 'DataForge',
  description: 'Modern TypeScript utilities and components for developers',
  base: '/dataforge/',

  head: [
    ['link', { rel: 'icon', href: '/favicon.ico' }],
    ['meta', { name: 'theme-color', content: '#3eaf7c' }],
  ],

  themeConfig: {
    logo: '/logo.svg',

    nav: [
      { text: 'Home', link: '/' },
      { text: 'Packages', link: '/packages/' },
      { text: 'API', link: '/api/' },
      { text: 'GitHub', link: 'https://github.com/mcabreradev/dataforge' },
    ],

    sidebar: {
      '/packages/': [
        {
          text: 'Packages',
          items: [
            { text: 'Overview', link: '/packages/' },
            { text: '@dataforge/core', link: '/packages/core' },
            { text: '@dataforge/utils', link: '/packages/utils' },
            { text: '@dataforge/validation', link: '/packages/validation' },
          ],
        },
      ],
      '/api/': [
        {
          text: 'API Reference',
          items: [
            { text: 'Core', link: '/api/core' },
            { text: 'Utils', link: '/api/utils' },
            { text: 'Validation', link: '/api/validation' },
          ],
        },
      ],
    },

    socialLinks: [{ icon: 'github', link: 'https://github.com/mcabreradev/dataforge' }],

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2024 Miguelángel Cabrera',
    },

    search: {
      provider: 'local',
    },
  },
});
