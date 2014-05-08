#!/usr/bin/env python
# encoding: utf-8

import os.path as p
from landmarkerio.api import app_for_adapter
from landmarkerio.menpoadapter import MenpoAdapter
import webbrowser

def main(model_dir, landmark_dir=None, template_dir=None):
    r"""

    """
    model_dir = p.abspath(p.expanduser(model_dir))
    if landmark_dir is None:
        landmark_dir = p.join(model_dir, 'landmarks')
    else:
        landmark_dir = p.abspath(p.expanduser(landmark_dir))
    if template_dir is None:
        template_dir = p.join(model_dir, 'template')
    else:
        template_dir = p.abspath(p.expanduser(template_dir))

    gzip = False  # halves payload, increases server workload
    dev = False
    print ('models: {}'.format(model_dir))
    print ('landmarks: {}'.format(landmark_dir))
    print ('templates: {}'.format(template_dir))
    # Build a MenpoAdapter that will serve from the specified directories
    adapter = MenpoAdapter(model_dir, landmark_dir, template_dir)

    webbrowser.open("http://www.landmarker.io")
    app = app_for_adapter(adapter, gzip=gzip, dev=dev)
    app.run()


if __name__ == "__main__":
    from argparse import ArgumentParser
    parser = ArgumentParser(
        description=r"""
        Serve landmarks and assets for landmarker.io through Menpo.

        """)
    parser.add_argument("path", help="path that will be "
                                     "searched for models. model filenames "
                                     "must be unique.")
    parser.add_argument("-l", "--landmarks",
                        help="The directory containing the landmarks. "
                             "If None provided taken as path/landmarks")
    parser.add_argument("-t", "--templates",
                        help="The directory containing the landmarks. "
                             "If None provided taken as path/templates")
    ns = parser.parse_args()
    main(ns.path, ns.landmarks, ns.templates)
