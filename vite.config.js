import { defineConfig } from 'vite';
import { copyFileSync, mkdirSync, existsSync } from 'fs';
import { resolve, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

function copyHtmlFiles() {
  return {
    name: 'copy-html-files',
    closeBundle() {
      const outDir = '.vercel/output/static';
      const htmlFiles = ['docs.html', 'admin.html', 'components.html'];
      htmlFiles.forEach(file => {
        copyFileSync(resolve(__dirname, file), resolve(__dirname, outDir, file));
      });
    }
  };
}

export default defineConfig({
  root: '.',
  publicDir: 'public',
  build: {
    outDir: '.vercel/output/static',
    emptyOutDir: true,
    rollupOptions: {
      input: {
        main: resolve(__dirname, 'index.html'),
        docs: resolve(__dirname, 'docs.html'),
        admin: resolve(__dirname, 'admin.html'),
        components: resolve(__dirname, 'components.html')
      }
    }
  },
  plugins: [copyHtmlFiles()],
  server: {
    port: 3000,
    open: true
  }
});
