#!/usr/bin/env python3
import json, os, shutil, sys

def build():
    pages_path = 'data/pages.json'
    if not os.path.exists(pages_path):
        print("ERROR: pages.json not found")
        sys.exit(1)
    with open(pages_path, 'r') as f:
        pages = json.load(f)
    with open('theme/base.html', 'r') as f:
        template = f.read()
    if os.path.exists('build'):
        shutil.rmtree('build')
    os.makedirs('build')
    for page in pages:
        slug = page['slug']
        content = page.get('body_content', '')
        html = template.replace('{{ content }}', content)
        out_dir = os.path.join('build', slug) if slug else 'build'
        os.makedirs(out_dir, exist_ok=True)
        with open(os.path.join(out_dir, 'index.html'), 'w') as f:
            f.write(html)
    if os.path.exists('assets'):
        shutil.copytree('assets', 'build/assets', dirs_exist_ok=True)
    # Generate robots.txt
    with open("build/robots.txt", "w") as f:
        f.write("User-agent: *\nAllow: /\nSitemap: https://clearances-in-devon.co.uk/sitemap.xml\n")
    # Generate sitemap.xml
    urls = []
    for page in pages:
        slug = page["slug"]
        loc = "https://clearances-in-devon.co.uk/" + (slug + "/" if slug else "")
        urls.append(f"  <url><loc>{loc}</loc><changefreq>monthly</changefreq><priority>0.7</priority></url>")
    sitemap = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n"
    sitemap += "\n".join(urls)
    sitemap += "\n</urlset>\n"
    with open("build/sitemap.xml", "w") as f:
        f.write(sitemap)
    print(f"Built {len(pages)} pages")

if __name__ == '__main__':
    build()
