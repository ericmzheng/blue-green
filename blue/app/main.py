from __future__ import print_function

import os
import re

################################################################################
# application
################################################################################

from flask import Flask, render_template, session, request, redirect, url_for

import collections

app = Flask(__name__)
app.secret_key = eval(os.getenv('SECRET_KEY'))

@app.errorhandler(404)
def notfound(e):
    return render_template('404.html'), 404

@app.route('/', methods=['GET', 'POST'])
def index():
    render = collections.defaultdict(list)
    return render_template('index.html', **render)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=False)

