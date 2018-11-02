# -*- encoding: utf-8 -*-

require File.expand_path('../lib/ckfiles/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'ckfiles'
  s.version     = Ckfiles::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.description = "General file integrity checker, can check recursively. Support SFV, MD5, ZIP, CBZ, 7Z, GZ, BZ2, LHA, LZH, ARJ, CHM, XZ, RAR, CBR and media file containing CRC32 sum in filename with extension  with AVI, MKV, MP4, OGM, ASF, RM, RAM, WEBM. Require 7zip and Unrar for checking archive file. Supports Linux / Mac OS X / Windows."
  s.summary     = s.description
  s.authors     = ["Mac Ma"]
  s.homepage    = 'https://github.org/comomac/ckfiles'
  s.license     = 'MIT'

  s.add_dependency 'ffi-xattr', '>= 0.0.5'

  s.require_paths = ["lib"]
  s.files = `git ls-files`.split($\)
  s.executables = s.files.grep(%r{^bin/}).map { |f| File.basename(f) }
end