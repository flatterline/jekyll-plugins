module Jekyll
  class TeamIndex < Page
    def initialize(site, base, dir)
      @site = site
      @base = base
      @dir  = dir
      @name = "index.html"

      self.read_yaml(File.join(base, '_layouts'), 'team.html')
      self.data['team'] = self.get_team(site)
      self.process(@name)
    end

    def get_team(site)
      {}.tap do |team|
        Dir['_team/*.yml'].each do |path|
          name   = File.basename(path, '.yml')
          config = YAML.load(File.read(File.join(@base, path)))
          type   = config['type']

          if config['active']
            team[type] = {} if team[type].nil?
            team[type][name] = config
          end
        end
      end
    end
  end

  class PersonIndex < Page
    def initialize(site, base, dir, path)
      @site     = site
      @base     = base
      @dir      = dir
      @name     = "index.html"
      self.data = YAML.load(File.read(File.join(@base, path)))
      self.data['title'] = "#{self.data['name']} | #{self.data['role']}"

      self.process(@name)
    end
  end

  class GenerateTeam < Generator
    safe true
    priority :normal

    def generate(site)
      write_team(site)
    end

    # Loops through the list of team pages and processes each one.
    def write_team(site)
      if Dir.exists?('_team')
        Dir.chdir('_team')
        Dir["*.yml"].each do |path|
          name = File.basename(path, '.yml')
          self.write_person_index(site, "_team/#{path}", name)
        end

        Dir.chdir(site.source)
        self.write_team_index(site)
      end
    end

    def write_team_index(site)
      team = TeamIndex.new(site, site.source, "/team")
      team.render(site.layouts, site.site_payload)
      team.write(site.dest)

      site.pages << team
      site.static_files << team
    end

    def write_person_index(site, path, name)
      person = PersonIndex.new(site, site.source, "/team/#{name}", path)

      if person.data['active']
        person.render(site.layouts, site.site_payload)
        person.write(site.dest)

        site.pages << person
        site.static_files << person
      end
    end
  end

  class AuthorsTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text   = text
      @tokens = tokens
    end

    def render(context)
      site = context.environments.first["site"]
      page = context.environments.first["page"]

      if page
        authors = page['author']
        authors = [authors] if authors.is_a?(String)

        "".tap do |output|
          authors.each do |author|
            data     = YAML.load(File.read(File.join(site['source'], '_team', "#{author.downcase.gsub(' ', '-')}.yml")))
            template = File.read(File.join(site['source'], '_includes', 'author.html'))

            output << Liquid::Template.parse(template).render('author' => data)
          end
        end
      end
    end
  end
end

Liquid::Template.register_tag('authors', Jekyll::AuthorsTag)
