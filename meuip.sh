#!/bin/bash
wget meuip.com.br --quiet -O- | sed '/>[0-9].*\.[0-9].*\.[0-9].*</!d' | sed 's/.*>\([0-9].*\.[0-9].*\.[0-9].*\.[0-9].*\)\( <.*\)/\1/g'