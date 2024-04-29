# DDEV Pact Broker Integration

This project integrates the Pact Broker into the DDEV local development environment, enabling easy management of contract testing with your services. The Pact Broker is a service for storing and retrieving consumer-driven contracts, ensuring all parties (consumer and provider) in a microservice architecture have a common understanding of the APIs.

## Features

- **PostgreSQL Database Setup**: Automates the setup of the PostgreSQL database required by Pact Broker.
- **Accessible via DDEV Router**: The Pact Broker UI is easily accessible via a custom URL mapped through the DDEV router.
- **Custom Commands**: Includes DDEV custom commands for opening the UI and other utilities.

## Prerequisites

- **Docker**: Ensure you have Docker installed and running on your machine.
- **DDEV**: You need to have DDEV installed. Visit [DDEV Installation](https://ddev.readthedocs.io/en/stable/#installation) for guidance on setting up DDEV.

## Installation

Follow these steps to set up the Pact Broker in your DDEV environment:

1. **Clone this Repository**
   ```sh
   git clone https://your-repository-url.git
   cd your-repository-directory
   ```

2. **Start DDEV**
   - Initialize a DDEV project if you haven't already done so in your directory:
     ```sh
     ddev config --project-type=php --docroot=public --create-docroot
     ```
   - Start the DDEV environment:
     ```sh
     ddev start
     ```

3. **Install the Pact Broker Add-on**
   - Copy the `docker-compose.pact-broker.yaml` and `install.yml` files to your `.ddev` directory.
   - Ensure the `open-ui` command script is placed in `.ddev/commands/web` and is executable:
     ```sh
     chmod +x .ddev/commands/web/open-ui
     ```
   - Restart DDEV to apply the configurations:
     ```sh
     ddev restart
     ```

## Usage

- **Accessing the Pact Broker UI**
  - You can open the Pact Broker UI directly in your browser using:
    ```sh
    ddev open-ui
    ```
  - Alternatively, visit `http://pact-broker.<DDEV_SITENAME>.ddev.site` in your web browser.

- **Managing the Database**
  - The PostgreSQL database is set up automatically when you install the add-on. However, if you need to perform database operations, you can use standard PostgreSQL commands within the DDEV environment:
    ```sh
    ddev exec db psql -U db pact_broker
    ```

## Troubleshooting

- **Database Connection Issues**: Ensure the PostgreSQL service is running correctly. Check the logs for any startup errors:
  ```sh
  ddev logs -s postgres
  ```

- **Pact Broker Not Accessible**: Verify that the Pact Broker service is up and running:
  ```sh
  ddev logs -s pact-broker
  ```

## Customization

- **Environment Variables**: Adjust the environment variables in the `docker-compose.pact-broker.yaml` for different configurations such as database passwords or logging levels.

## Removing the Add-on

To remove the Pact Broker and clean up the environment, you can run the predefined removal actions:
```sh
ddev remove-addon pact-broker
```

## Support

For issues not covered by the README or troubleshooting guide, please open an issue in the project repository or consult the [Pact Broker documentation](https://docs.pact.io/pact_broker).

## Contributing

Contributions to this DDEV Pact Broker integration are welcome. Please feel free to fork the repository, make changes, and submit pull requests.

## License

Specify your project's license here, typically one that suits your community and enterprise usage.
