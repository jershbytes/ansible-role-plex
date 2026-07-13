# jershbytes.plex

Ansible role to install Plex Media Server on Debian/Ubuntu and Red Hat family hosts.

## What This Role Does

- Installs Plex Media Server package.
- Configures the Plex package repository for the host package manager.
- Enables and starts the `plexmediaserver` service.
- On EL systems, enables the `plex` firewalld service.

## Supported Platforms

From [meta/main.yml](meta/main.yml):

- Ubuntu: `jammy`, `noble`
- EL: `8`, `9`, `10`

## Requirements

- Ansible `>= 2.9` (per [meta/main.yml](meta/main.yml)).
- For EL hosts, collection support for `ansible.posix.firewalld`.

Optional local development tools are listed in [requirements-ansible.txt](requirements-ansible.txt).

## Role Variables

Defaults are defined in [defaults/main.yml](defaults/main.yml):

| Variable | Default | Description |
| --- | --- | --- |
| `plex_repo` | `true` | Reserved toggle for repository configuration. |
| `plex_repo_key` | `https://downloads.plex.tv/plex-keys/PlexSign.v2.key` | Plex signing key URL used on APT-based hosts. |
| `debian_plex_repo_url` | `deb [signed-by=/etc/apt/keyrings/plexmediaserver.v2.gpg] https://repo.plex.tv/deb/ public main` | APT repository line written to `/etc/apt/sources.list.d/plex.list`. |

## Behavior by Platform

### Debian/Ubuntu

Role tasks in [tasks/debian.yml](tasks/debian.yml):

- Ensures `/etc/apt/keyrings` exists.
- Downloads Plex signing key to `/etc/apt/keyrings/plexmediaserver.v2.gpg`.
- Writes repository entry to `/etc/apt/sources.list.d/plex.list`.
- Installs `plexmediaserver` with cache refresh.

Note: The repository is managed via a `.list` file instead of `apt_repository`, which avoids deprecated `apt-key` usage on modern Debian derivatives.

### EL (RHEL/Rocky/Alma/CentOS Stream)

Role tasks in [tasks/redhat.yml](tasks/redhat.yml):

- Templates repo file to `/etc/yum.repos.d/plex.repo`.
- Installs `plexmediaserver` using `dnf`.
- Enables firewalld `plex` service.

## Example Playbook

```yaml
- name: Install Plex
  hosts: media
  become: true
  roles:
    - role: jershbytes.plex
```

## Handlers

Handlers in [handlers/main.yml](handlers/main.yml):

- Reload systemd daemon
- Enable and start `plexmediaserver`

## License

MIT. See [LICENSE](LICENSE).
