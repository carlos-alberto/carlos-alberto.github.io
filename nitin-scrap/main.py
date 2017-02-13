from flask import Flask, jsonify, request

from db import get_db
from forms import ScrapForm


DATABASE = 'nitin.db'

app = Flask(__name__, static_folder="frontend")


@app.teardown_appcontext
def close_connection(exception):
    get_db().close()


@app.route('/')
def root():
    return app.send_static_file('index.html')


@app.route('/log', methods=['POST'])
def create_log():
    form = ScrapForm.from_json(request.json)
    if form.validate():
        db = get_db()
        values = (form.project.value, form.part.value, form.tool.value,
                  form.reason.value)
        db.execute(("INSERT INTO log (project, part, tool, reason) "
                    "VALUES (?, ?, ?, ?)"), values)

        return jsonify({"success": True})

    return jsonify({"success": False})


if __name__ == '__main__':
    app.run(debug=True)
