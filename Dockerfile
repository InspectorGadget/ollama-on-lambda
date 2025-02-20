FROM ollama/ollama:latest
COPY --from=inspectorgadget12/lambda-runtime-adapter /lambda-runtime-adapter /opt/extensions/lambda-adapter

ENV OLLAMA_HOST=0.0.0.0:8080
ENV HOME=/mnt/ollama

# Pre-pull the model during build
RUN ollama serve & sleep 2 && ollama pull llama3 && pkill ollama

EXPOSE 8080

# Add a script to run the model
COPY <<EOF /run.sh
#!/bin/bash

echo "Starting Ollama server..."
ollama serve &
SERVE_PID=$!

echo "Waiting for Ollama server to be ready..."
while ! curl -s localhost:8080/api/tags >/dev/null 2>&1; do
    sleep 1
done

echo "Running llama3 model..."
ollama run llama3 &
LLAMA_PID=$!

# Keep the container running and wait for both processes
wait $SERVE_PID $LLAMA_PID
EOF

RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
