import logging


# ANSI escape codes for colors
class LogColors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


# Custom formatter that adds color based on log level
class ColoredFormatter(logging.Formatter):
    def format(self, record):
        log_colors = {
            logging.DEBUG: LogColors.OKBLUE,
            logging.INFO: LogColors.OKGREEN,
            logging.WARNING: LogColors.WARNING,
            logging.ERROR: LogColors.FAIL,
            logging.CRITICAL: LogColors.BOLD + LogColors.FAIL
        }
        color = log_colors.get(record.levelno, LogColors.ENDC)
        message = super().format(record)
        return f"{color}{message}{LogColors.ENDC}"


# Function to configure logging
def configure_logging(level = logging.DEBUG):
    logger = logging.getLogger()
    logger.setLevel(level)

    # Create console handler
    ch = logging.StreamHandler()
    ch.setLevel(level)

    # Create formatter and add it to the handler
    formatter = ColoredFormatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    ch.setFormatter(formatter)

    # Add the handler to the logger
    logger.addHandler(ch)


# Example usage
if __name__ == "__main__":
    configure_logging()
    logger = logging.getLogger(__name__)
