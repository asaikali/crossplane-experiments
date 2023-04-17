#!/bin/bash

(cd deployment && ./apply.sh)
(cd kubernetes && ./apply.sh)
(cd repo && ./apply.sh)
(cd network && ./apply.sh)