import base64
import logging
import os

from flask import Flask, request, jsonify, render_template, send_from_directory, abort, send_file
from dotenv import load_dotenv

app = Flask(__name__)

app.logger.setLevel(logging.INFO)

# load environment variables (from .env file, not committed to the repo)
load_dotenv()
app.config["UPLOAD_PATH"] = "/var/www/mesa-logs/uploads"
app.config["API_KEYS"] = os.getenv("API_KEYS").split(",")


@app.route("/", defaults={'req_path': ''})
@app.route("/<path:req_path>", methods=["GET"])
def dir_listing(req_path):
    abs_path = os.path.join(app.config["UPLOAD_PATH"], req_path)
    if not os.path.exists(abs_path):
        return abort(404)
    
    if os.path.isfile(abs_path):
        return send_file(abs_path)
    
    files = os.listdir(abs_path)
    return render_template('files.html', files=files)


@app.route("/uploads", methods=["POST"])
def uploads():

    headers = request.headers
    auth = headers.get("X-Api-Key")
    if not auth in app.config["API_KEYS"]:
        return jsonify({"message": "ERROR: Unauthorized"}), 401
    else:
        if not request.is_json:
            return jsonify({"message": "ERROR: JSON-only endpoint"}), 415
        else:
            content = request.json
            response = save_mesa_test_logs(content)
            return response


def save_mesa_test_logs(json):

    # check that we have the required info
    if "commit" in json:
        commit = json["commit"]
    else:
        return jsonify({"message": "ERROR: JSON missing commit field"}), 400

    if "computer_name" in json:
        computer_name = json["computer_name"]
    else:
        return jsonify({"message": "ERROR: JSON missing computer_name field"}), 400

    app.logger.info(
        "Receiving data from {} for commit {}".format(computer_name, commit)
    )

    # if test case is set, expect test logs
    # otherwise, expect overall build logs
    if "test_case" in json:
        output_dir = os.path.join(
            app.config["UPLOAD_PATH"], commit, computer_name, json["test_case"]
        )
        expected_files = (
            "mk.txt",
            "out.txt",
            "err.txt",
        )
    else:
        output_dir = os.path.join(app.config["UPLOAD_PATH"], commit, computer_name)
        expected_files = ("build.log",)

    # first make directory for computer
    os.makedirs(output_dir, exist_ok=True)

    # now write each of the expected files
    for fname in expected_files:
        if fname in json:
            save_file(os.path.join(output_dir, fname), json[fname])

    return jsonify({"message": "OK: Authorized"}), 200


def save_file(filename, base64data):
    app.logger.info("Saving file {}".format(filename))
    with open(filename, "wb") as f:
        f.write(base64.b64decode(base64data))


if __name__ == "__main__":
    app.run(debug=True)
