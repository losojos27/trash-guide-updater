# trash-guide-updater

A Docker image that automatically mirrors TRaSH guides to your Sonarr/Radarr instance.

## Docker-Compose

Sample `docker-compose.yml`

```yaml
version: "2.1"
services:
  trash-guides-sync:
    image: docker.io/losojos/trash-guides-sync:0.0.1
    container_name: trash-guides-sync
    network_mode: bridge
    logging:
      driver: json-file
    environment:
      - PUID=1050
      - PGID=100
      - TZ=America/Chicago
      - DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
    volumes:
      - "/volume1/docker/appdata/trash-guides-sync/config/trash.yml:/usr/local/bin/trash.yml"
      - "/volume1/docker/appdata/trash-guides-sync/cache:/root/.config/trash-updater/cache"
    restart: unless-stopped
```

## [Wiki](https://github.com/rcdailey/trash-updater/tree/master/wiki) <---- wiki for [rcdailey/trash-updater](https://github.com/rcdailey/trash-updater), the binary this container runs

## Configuration

If not specified, the script will look for `trash.yml` in the same directory as the executable. Default: `/usr/local/bin/trash.yml`

Sample config file:

```yaml
# A starter config to use with Trash Updater. Most values are set to "reasonable defaults".
# Update the values below as needed for your instance. You will be required to update the
# API Key and URL for each instance you want to use.
#
# Many optional settings have been omitted to keep this template simple.
#
# For more details on the configuration, see the Configuration Reference on the wiki here:
# https://github.com/rcdailey/trash-updater/wiki/Configuration-Reference

# Configuration specific to Sonarr
sonarr:
    # Set the URL/API Key to your actual instance
  - base_url: http://localhost:8989
    api_key: f7e74ba6c80046e39e076a27af5a8444

    # Quality definitions from the guide to sync to Sonarr. Choice: anime, series, hybrid
    quality_definition: hybrid

    # Release profiles from the guide to sync to Sonarr. Types: anime, series
    # You can optionally add tags and make negative scores strictly ignored
    release_profiles:
      - type: anime
      - type: series

# Configuration specific to Radarr.
radarr:
  # Set the URL/API Key to your actual instance
  - base_url: http://localhost:7878
    api_key: bf99da49d0b0488ea34e4464aa63a0e5

    # Which quality definition in the guide to sync to Radarr. Only choice right now is 'movie'
    quality_definition:
      type: movie

    # Set to 'true' to automatically remove custom formats from Radarr when they are removed from
    # the guide or your configuration. This will NEVER delete custom formats you manually created!
    delete_old_custom_formats: false

    custom_formats:
      # A list of custom formats to sync to Radarr. Must match the "name" in the importable JSON.
      # Do NOT use the heading names here, those do not work! These are case-insensitive.
      - names:
          - BR-DISK
          - EVO (no WEB-DL)
          - LQ
          - x265 (720/1080p)
          - 3D

        # Uncomment the below properties to specify one or more quality profiles that should be
        # updated with scores from the guide for each custom format. Without this, custom formats
        # are synced to Radarr but no scores are set in any quality profiles.

#        quality_profiles:
#          - name: Quality Profile 1
#          - name: Quality Profile 2
#            #score: -9999 # Optional score to assign to all CFs. Overrides scores in the guide.
#            #reset_unmatched_scores: true # Optionally set other scores to 0 if they are not listed in 'names' above.
```

## Credits

Based on the [ubuntu:bionic](https://hub.docker.com/_/ubuntu) image

Uses the binary from [rcdailey/trash-updater](https://github.com/rcdailey/trash-updater)

