FROM cypress/included:7.3.0

# copy necessary files to run web e2e tests
WORKDIR /cypress

COPY . .

# environment variables used to inject jenkins build parameters
ARG ENV
ENV ENV="${ENV}"

ARG BROWSER
ENV BROWSER="${BROWSER}"

ARG CYPRESS_KEY
ENV CYPRESS_KEY="${CYPRESS_KEY}"

ENTRYPOINT [ "" ]

# install project
RUN npm install

# run tests
CMD CYPRESS_ENV="${ENV}" \
    npm run "cy:run" \
    --headless \
    -- --browser "${BROWSER}" \
    --record --key "${CYPRESS_KEY}"
