# Project definition
project('xar', 'c', version: 1.6.1)

# Config object declaration
config = configuration_data()

# Build dependencies
## Build machine

## Programs
find_program('xml2-config')

## Libraries
### Required
zlib_dep = dependency('zlib')
libcrypto_dep = dependency('libcrypto')
libxml_dep = dependency('libxml-2.0', version: '>= 2.6.11')

### Optional
have_libacl = dependency('libacl', required: false).found()
config.set('HAVE_LIBLZMA',
    dependency('liblzma', required: false).found())

### Sub-projects

## Headers
headers = [
    {
        'name': 'openssl/evp.h',
        'prereq': libcrypto_dep.found(),
        'required': true
    },
    {
        'name': 'sys/acl.h',
        'prereq': have_libacl,
        'macro': 'HAVE_SYS_ACL_H',
        'required': false
    },
    {
        'name': 'sys/statfs.h',
        'macro': 'HAVE_SYS_STATFS_H',
        'required': false
    },
    {
        'name': 'sys/xattr.h',
        'macro': 'HAVE_SYS_XATTR_H',
        'required': false
    },
    {
        'name': 'sys/extattr.h',
        'macro': 'HAVE_SYS_EXTATTR_H',
        'required': false
    },
    {
        'name': 'sys/param.h',
        'macro': 'HAVE_SYS_PARAM_H',
        'required': false
    },
    {
        'name': 'libutil.h',
        'macro': 'HAVE_LIBUTIL_H',
        'required': false
    },
    {
        'name': 'ext2fs/ext2_fs.h',
        'macro': 'HAVE_EXT2FS_EXT2_FS_H',
        'required': false
    }
]
cc = meson.get_compiler('c')
foreach header: headers
    assert('name' in header,
        'Invalid check: \'name\' property required for header definitions.')
    if 'prereq' in header and not header['prereq'] # prereq not found
        if 'required' in header and header['required'] # required
            error('Prerequisite for required header '
                + header['name']
                + ' not found.')
        endif
        if 'macro' in header # not required
            config.set(header['macro'], false)
        endif
        continue
    endif
    if 'required' in header and header['required'] # required
        assert(cc.has_header(header['name']),
            'Could not find required header: ' + header['name'] + '.')
        if 'macro' in header # found
            config.set(header['macro'], true)
        endif
    else
        if 'macro' in header # not required
            config.set(header['macro'], cc.has_header(header['name']))
        endif
    endif
endforeach

## Functions
functions = [
    {
        'name': 'lgetxattr',
        'required': false,
        'macro': 'HAVE_',
        'prefix': ''
    },
    {
        'name': 'lsetxattr',
        'required': false,
        'macro': 'HAVE_',
        'prefix': ''
    },
    {
        'name': 'getxattr',
        'required': false,
        'macro': 'HAVE_',
        'prefix': ''
    },
    {
        'name': 'setxattr',
        'required': false,
        'macro': 'HAVE_',
        'prefix': ''
    },
    {
        'name': 'getattrlist',
        'required': false,
        'macro': 'HAVE_',
        'prefix': ''
    },
    {
        'name': 'setattrlist',
        'required': false,
        'macro': 'HAVE_',
        'prefix': ''
    },
    {
        'name': 'chflags',
        'required': false,
        'macro': 'HAVE_',
        'prefix': ''
    },
    {
        'name': 'statvfs',
        'required': false,
        'macro': 'HAVE_',
        'prefix': ''
    },
    {
        'name': 'statfs',
        'required': false,
        'macro': 'HAVE_',
        'prefix': ''
    },
    {
        'name': 'asprintf',
        'required': false,
        'macro': 'HAVE_',
        'prefix': ''
    },
    {
        'name': 'lchown',
        'required': false,
        'macro': 'HAVE_',
        'prefix': ''
    },
    {
        'name': 'lchmod',
        'required': false,
        'macro': 'HAVE_',
        'prefix': ''
    },
    {
        'name': 'strmode',
        'required': false,
        'macro': 'HAVE_',
        'prefix': ''
    }
]

## Struct members

## Type sizes

# Runtime dependencies
## Host machine

## Programs

## Libraries
### Sub-projects

# Configuration output

# Build
## Sub-directories

## Libraries

## Executables