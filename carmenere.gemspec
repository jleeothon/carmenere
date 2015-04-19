Gem::Specification.new do |s|
  s.name        = 'carmenere'
  s.version     = '0.1.2'
  s.date        = '2015-04-19'
  s.summary     = "Single Linkage and K-means algorithms for clustering"
  s.description = "Cluster algorithms"
  s.authors     = ["Johnny Lee Othon"]
  s.email       = 'jleeothon@gmail.com'
  s.files       = [
    'lib/carmenere/kmeans/algorithm.rb',
    'lib/carmenere/kmeans/cluster.rb',
    'lib/carmenere/singlelinkage/algorithm.rb',
    'lib/carmenere/singlelinkage/cluster.rb',
    'lib/carmenere/algorithm.rb',
    'lib/carmenere/cluster.rb',
    'lib/carmenere/node.rb',
    'lib/carmenere.rb'
  ]
  s.homepage    = 'https://github.com/jleeothon/carmenere'
  s.license     = 'MIT'
end
