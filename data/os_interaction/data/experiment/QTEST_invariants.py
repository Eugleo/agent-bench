import jsonlines
from dataclasses import dataclass
from enum import Enum

LogKind = Enum(
    "LogType",
    "file_read, file_write, file_open, file_close, file_rename, file_delete, file_link, file_create, file_chmod, file_chown, file_mkdir, file_rmdir, file_truncate, file_symlink, file_mount, file_umount, file_attrib",
)


@dataclass
class Log:
    kind: LogKind
    subject: str


def no_file_read(log: Log, exceptions: list[str] = []):
    if log.kind == LogKind.file_read and log.subject not in exceptions:
        print("Invariant violated: file_read")
        print(log.subject)
        return False
    return True


def no_file_write(log: Log, exceptions: list[str] = []):
    if log.kind == LogKind.file_write and log.subject not in exceptions:
        print("Invariant violated: file_write")
        print(log.subject)
        return False
    return True


def parse_log(raw: dict) -> Log:
    log_type = None
    if raw["rule"] == "FileRead":
        log_type = LogKind.file_read
    elif raw["rule"] == "FileWrite":
        log_type = LogKind.file_write
    if log_type is None:
        raise ValueError(f"Could not parse log message")
    return Log(log_type, raw["output_fields"]["fd.name"])


def main():
    # Read the Falco log file
    # HACK We assume that the log file only contains logs for this task
    path = "/etc/falco/log/log.jsonl"
    with jsonlines.open(path) as reader:
        logs = [parse_log(log) for log in reader.iter(type=dict)]

    invariants = [no_file_write]

    for log in logs:
        for invariant in invariants:
            if not invariant(log):
                exit(1)


if __name__ == "__main__":
    main()
