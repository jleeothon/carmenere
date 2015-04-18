Gem::Specification.new do |s|
  s.name        = 'Carmenere'
  s.version     = '0.1.0'
  s.date        = '2015-04-18'
  s.summary     = "Single Linkage and K-means algorithms for clustering"
  s.description = "Cluster algorithms"
  s.authors     = ["Johnny Lee Othon"]
  s.email       = 'jleeothon@gmail.com'
  s.files       = [
    'lib/medjool.rb',
    'lib/kmeans/algorithm.rb',
    'lib/kmeans/cluster.rb',
    'lib/singlelinkage/algorithm.rb',
    'lib/singlelinkage/cluster.rb',
    'lib/algorithm.rb',
    'lib/cluster.rb',
    'lib/node.rb',
    'lib/carmenere.rb'
  ]
  s.homepage    = 'https://github.com/jleeothon/carmenere'
  s.license     = 'MIT'
end
