#!/usr/bin/env python3

import requests
import semver
import logging
from bs4 import BeautifulSoup
from subprocess import call

logging.basicConfig(level=logging.INFO)

base_url = 'https://releases.hashicorp.com/nomad'
logging.info('Using base URL "{}"'.format(base_url))
logging.info('Retrieving list of releases...')
releases = requests.get(base_url)
soup = BeautifulSoup(releases.text, 'html.parser')
min_version = ">=0.6.0"
logging.info('Minimum version is set to "{}"; everything below is going to be ignored...'.format(min_version))
image_name = 'hendrikmaus/nomad-cli'
result = {}

for link in soup.find_all('a'):
    href = link.get('href')
    if href.startswith('/nomad') == False:
        continue
    version = href.split('/')[2]
    if not semver.match(version, min_version):
        logging.info('"{}": too old, skipping...'.format(version))
        continue
    logging.info('"{}": processing...'.format(version))
    version_name = link.text
    logging.info('"{}": getting checksum...'.format(version))
    checksums = requests.get(base_url + '/' + version + '/' + version_name + '_SHA256SUMS')
    for line in checksums.text.splitlines():
        line = line.strip()
        if '_linux_amd64.zip' in line:
            sha256sum = line.split(' ')[0]
            result[version] = sha256sum
            logging.info('"{}": {}'.format(version, sha256sum))
            break
        else:
            continue

logging.info('Building and pushing Docker images...')
stable_detected = False
for v in result.items():
    logging.info('"{}": building Docker image...'.format(v[0]))
    call(['./build.sh', '-version', v[0], '-sha256', v[1]])
    logging.info('"{}": pushing...'.format(v[0]))
    call(['docker', 'push', '{}:{}'.format(image_name, v[0])])

    # build and push stable
    # the first version without any dash must be latest stable
    if stable_detected is False:
        version_parts = semver.parse(v[0])
        if version_parts['prerelease'] is None:
            stable_detected = True
            logging.info('"{}": seems to be latest stable'.format(v[0]))
            call(['docker', 'tag',
                  '{}:{}'.format(image_name, v[0]), '{}:{}'.format(image_name, "latest")])
            call(['docker', 'push',
                  '{}:{}'.format(image_name, "latest")])
            continue

    logging.info('"{}": done'.format(v[0]))
