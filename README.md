# vision-freeipa

[![Build Status](https://travis-ci.org/vision-it/vision-freeipa.svg?branch=production)](https://travis-ci.org/vision-it/vision-freeipa)


## Parameter

## Usage

Include in the *Puppetfile*:

```
mod vision_freeipa:
    :git => 'https://github.com/vision-it/vision-freeipa.git,
    :ref => 'production'
```

Include in a role/profile:

```puppet
contain ::vision_freeipa
```

