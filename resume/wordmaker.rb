require 'htmltoword'

# Configure the location of your custom templates
# Htmltoword.config.custom_templates_path = 'some_path'

# my_html = '<html><head></head><body><p>Hello</p></body></html>'
# file = Htmltoword::Document.create my_html, file_name, word_template_file_name
# my_html = '<html><head></head><body><p>Hello</p></body></html>'


my_html = File.read("./index.html")
document = Htmltoword::Document.create(my_html)
file = Htmltoword::Document.create_and_save(my_html, './testfile.docx')
# file = Htmltoword::Document.create my_html, test_file
