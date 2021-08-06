set -e

# make sure an events file exists
EVENTSFILE=events.ini
if [[ ! -f "$EVENTSFILE" ]]; then
    echo "No events config file ${EVENTSFILE} found; please create one"
    exit 1
fi

# Set WORKFLOW_NAME to a unique string; e.g., inference-bbh1
WORKFLOW_NAME='plot_posterior'
if [ "${WORKFLOW_NAME}" == '' ]; then
    echo "Please set a WORKFLOW_NAME"
    exit 1
fi
# Set the HTML_DIR to point to your public html page. This is where the results
# page will be written.
HTML_DIR=$(pwd)/html
if [ "${HTML_DIR}" == '' ]; then
    echo "Please set an HTML_DIR"
    exit 1
fi
# Add a descriptive title
TITLE='parity'
if [ "${TITLE}" == '' ]; then
    echo "Please set an TITLE"
    exit 1
fi

# we'll create a random seed; override if you want a fixed
SEED=30
echo "Using seed: ${SEED}"

pycbc_make_inference_plots_workflow \
    --config-files workflow_config.ini ${EVENTSFILE} \
    --workflow-name ${WORKFLOW_NAME} \
    --config-overrides results_page:output-path:${HTML_DIR} \
                       results_page:analysis-title:"${TITLE}"

echo "Now cd into the workflow directory and submit the dax by doing:"
echo ""
echo "cd ${WORKFLOW_NAME}_output"
echo "pycbc_submit_dax --no-create-proxy --no-grid --dax ${WORKFLOW_NAME}.dax --accounting-group cbc.prod.pe --enable-shared-filesystem"
