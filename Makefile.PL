use inc::Module::Install;
name 'Acme-POE-Acronym-Generator';
author 'Chris Williams <chris@bingosnet.co.uk>';
version_from 'lib/Acme/POE/Acronym/Generator.pm';
abstract_from 'lib/Acme/POE/Acronym/Generator.pm';
license 'perl';
build_requires 'Test::More' => 0.47;
requires 'Math::Random' => 0.69;
WriteAll();
