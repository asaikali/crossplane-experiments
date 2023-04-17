#!/bin/bash

(cd deployment && ./delete.sh)
(cd kubernetes && ./delete.sh)
(cd repo && ./delete.sh)
(cd network && ./delete.sh)