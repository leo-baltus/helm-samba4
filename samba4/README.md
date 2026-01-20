# helm-samba4

## Helm Chart for Samba4

Features:

 * Optionally creates users based on a secret provided outside of this chart.
 * Optionally uses an smb.conf configmap provided outside of this chart.
 * Works with any container image provided it supports above features
 * uses either `volumes` or `volumeClaimTemplates`

## Users

This chart will intentionally not provide users as there may be passwords involved. Instead create a Secret resource containing a `users.conf`, [as stated here](https://github.com/dockur/samba?tab=readme-ov-file#how-do-i-configure-multiple-users)

## Storage

Examples for `volumeMounts`, `volumes` and `volumeClaimTemplates`:

```YaML
volumeMounts:
- mountPath: /etc/samba/smb.conf
  name: smbconf
  subPath: smb.conf
- mountPath: /etc/samba/users.conf
  name: users
  subPath: users.conf
- name: mp3
  mountPath: /mp3
  readOnly: true

volumes:
- name: smbconf
  configMap:
    name: smbconf
    defaultMode: 0644
- name: users
  secret:
    secretName: users
    defaultMode: 0600
- name: mp3
  persistentVolumeClaim:
    claimName: mp3

volumeClaimTemplates:
  - metadata:
      name: mp3
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 8Gi
      storageClassName: "zfs"
```



It is assumed that users will not change their password.

FIXME: optionally store passwords on persistent storage.

## `smb.conf`

Provide a suitable smb.conf to disclose these mounts.

None is provided by this chart. [See here](https://github.com/dockur/samba?tab=readme-ov-file#how-do-i-modify-other-settings)

