from fastapi import FastAPI
import googlecloudprofiler

# Profiler initialization. It starts a daemon thread which continuously
# collects and uploads profiles. Best done as early as possible.
try:
    googlecloudprofiler.start(
        service="hello-profiler",
        service_version="1.0.1",
        # verbose is the logging level. 0-error, 1-warning, 2-info,
        # 3-debug. It defaults to 0 (error) if not set.
        verbose=3,
        # project_id must be set if not running on GCP.
        project_id='starley-playground',
        service_account_json_file='/Users/kamillle/.config/gcloud/application_default_credentials.json'
    )
except (ValueError, NotImplementedError) as exc:
    print(exc)  # Handle errors here

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}
