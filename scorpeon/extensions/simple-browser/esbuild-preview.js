/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the MIT License. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/
// @ts-check
const path = require('path');
const esbuild = require('esbuild');

const args = process.argv.slice(2);

const isWatch = args.indexOf('--watch') >= 0;

let outputRoot = __dirname;
const outputRootIndex = args.indexOf('--outputRoot');
if (outputRootIndex >= 0) {
	outputRoot = args[outputRootIndex + 1];
}

const srcDir = path.join(__dirname, 'preview-src');
const outDir = path.join(outputRoot, 'media');

async function build() {
	await esbuild.build({
		entryPoints: {
			'index': path.join(srcDir, 'index.ts'),
			'codicon': path.join(__dirname, 'node_modules', 'vscode-codicons', 'dist', 'codicon.css'),
		},
		loader: {
			'.ttf': 'dataurl',
		},
		bundle: true,
		minify: true,
		sourcemap: false,
		format: 'esm',
		outdir: outDir,
		platform: 'browser',
		target: ['es2020'],
	});
}

build().catch(() => process.exit(1));

if (isWatch) {
	const watcher = require('@parcel/watcher');
	watcher.subscribe(srcDir, () => {
		return build();
	});
}
