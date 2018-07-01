[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

# Bitwiser
An educational library that lets you play with bit-sequences and elemental binary instruction sets with simple ruby syntax.

## Usage

Clone it and run the following:

1. open irb (or pry.. whichever REPL you'd like)

```ruby
$ irb
```

2. then load the main component;

```ruby
 > load './bitwiser.rb'
```

3. Now you are ready to go!

```ruby
> a = Bitwiser::Signed4.new(-7)
=> 1001

> b = Bitwiser::Signed4.new(2)
=> 0010

> a + b
=> 1011

> (b + a).abs.to_i
=> 5

> a * b
=> [1111, 0010] # `multiply` gives double-length results
```

..or you can try logical operations as well

```ruby
> a.rol(2) # rotating leftwards
=> 1101

> b.not.xor a
=> 1010

> a.or(a.asl) # arithmetic shift (rightwards)
=> 1011
```

For quick start, readymade fixed-length bit sequences, e.g. Bitwiser::Signed8 / Signed4 / Unsigned8 / Unsigned4 are available.
You can further customize any length of bit sequences (see signed_sequence, bit_sequence under core folders)

## Todo

- test and refactor
- add further instructions (currently missing div instruction, for instance)
- quick chart for available instruction sets
- package it as rubygems

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fursich/bitwiser.git.

## License

The program is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
