# helm-samba4

## Helm Chart for Samba4

Features:

 * generates arbitrarynnumber `persistentVolumeClaims`
 * Optionally creates users based on a secret provided outside of this chart.
 * Optionally uses an smb.conf configmap provided outside of this chart.
 * Works with any container image provided it supports above features

## Users

This chart will intentionally not provide users as there may be passwords involved. Instead create a Secret resource containing a `users.conf`, [as stated here](https://github.com/dockur/samba?tab=readme-ov-file#how-do-i-configure-multiple-users)

## Storage

```YaML
persistence:
  enabled: true
  type: pvcs
  pvcs:
  - name: samba-data
    mountPath: /storage
    size: 5Gi
    storageClassName: "zfs"
    claimName: "storage"
  - name: music-data
    mountPath: /music
    size: 8Gi
    storageClass: "zfs"
    claimName: "music"
```

Provide a suitable smb.conf to disclose these mounts.

It is assumed that users will not change their password.

FIXME: optionally store passwords on persistent storage.


## `smb.conf`

Optionally a preconfigured Configmap with an `smb.conf` can be mounted. None is provided by this chart. [See here](https://github.com/dockur/samba?tab=readme-ov-file#how-do-i-modify-other-settings)

