# PaperTrailGlobalid
[![Code Climate](https://codeclimate.com/github/ankit1910/paper_trail-globalid/badges/gpa.svg)](https://codeclimate.com/github/ankit1910/paper_trail-globalid)

####Master branch build status:
![](https://travis-ci.org/ankit1910/MovingHelper.svg?branch=master)

This gem is an extension to paper_trail gem https://github.com/airblade/paper_trail. That means you need to pre install `paper_trail` gem. This gem will add one more method `actor` to instances of `PaperTrail::Version` that will return you the `ActiveRecord` object who was responsible for change.


## Supported Rails

This Gem only support `>= rails 4.1.0` and above versions.

## Installation

1. Add PaperTrailGlobalid to your `Gemfile`.

  `gem 'paper_trail-globalid'`

1. And then execute:

  ```
  bundle install
  ```

## Basic Usage

Basically this gem works on stroring global_id to whodunnit field of `PaperTrail::Version table`. As this is an additional extension installed, this will not hinder / break existing paper_trail functionalities.

```ruby
widget = Widget.find 42
widget.versions               # [<PaperTrail::Version>, <PaperTrail::Version>, ...]
v = widget.versions.last
```
Now you can also store object to `PaperTrail.whodunnit=`, and if object will be instance of `ActiveRecord::Base` it will store the global id in the version's `whodunnit` column.

And you can also retrieve the actually object later just by using method `actor`.

```ruby
admin = Admin.find(1)                       # <Admin:0x007fa2df9a5590>

PaperTrail.whodunnit = admin
PaperTrail.actor                            # <Admin:0x007fa2df9a5590> actual object

widget.update_attributes :name => 'Wibble'
widget.versions.last.whodunnit              # "gid://app/Admin/1"
widget.versions.last.actor                  # retruns the actuall object
```

Method `actor` will return the whodunnit value if we pass value another than `ActiveRecord` object.

```ruby
PaperTrail.whodunnit = 'admin_name'
PaperTrail.actor                            # "admin_name"

widget.update_attributes :name => 'Wibble'
widget.versions.last.whodunnit              # "admin_name"
widget.versions.last.actor                  # "admin_name"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/paper_trail-globalid/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
