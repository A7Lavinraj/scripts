# This is my collection of scripts written in both python and bash script.

## List of scripts:

- **clean_directory.sh** _(Bash script)_
- **codechef_sample_gen.sh** _(PythonEXE script)_
- **codechef_sample_gen.py** _(Python script)_
- **codeforces_sample_gen.sh** _(PythonEXE script)_
- **codeforces_sample_gen.py** _(Python script)_
- **dbrun.sh** _(Bash script)_
- **dbrun.py** _(Python script)_
- **pretest.sh** _(Bash script)_
- **pretest.py** _(Python script)_
- **stress_test.sh** _(Bash script)_
- **stress_test.py** _(Python script)_

## How to make a script executable in linux:

```bash
chmod +x <script_name>.sh
```

Replace _<script_name>_ with your name of script.

## Usage:

- **clean_directory.sh** (linux specific)

  - Make the script executable (Mention above).
  - Follow the syntax to execute.

    ```bash
    ./clean_directory.sh
    ```

- **codechef_sample_gen.sh** (linux specific)

  - Make the script executable (Mention above).
  - Follow the syntax to execute.

    ```bash
    ./codechef_sample_gen.sh <PROBLEM_CODE>
    ```

  - Replace <PROBLEM_CODE> with code of the problem.

- **codechef_sample_gen.py**

  - for LINUX or MAC users.

    ```powershell
    python3 codechef_sample_gen.py <PROBLEM_CODE>
    ```

  - for WINDOWS users.

    ```powershell
    python codechef_sample_gen.py <PROBLEM_CODE>
    ```

  - Replace <PROBLEM_CODE> with code of the problem.

- **codeforces_sample_gen.sh** (linux specific)

  - Make the script executable (Mention above).
  - Follow the syntax to execute.

    - To fetch a contest.

      ```bash
      ./codeforces_sample_gen.sh -c <CONTEST_ID> A B C D ...
      ```

    - To fetch a problem.

      ```bash
      ./codeforces_sample_gen.sh -p <PROBLEM1> <PROBLEM2> ...
      ```

- **codechef_sample_gen.py**

  - Follow the syntax to execute.

    - for LINUX or MAC users.

      - To fetch a contest.

        ```bash
        ./codeforces_sample_gen.sh -c <CONTEST_ID> A B C D ...
        ```

      - To fetch a problem.

        ```bash
        ./codeforces_sample_gen.sh -p <PROBLEM1> <PROBLEM2> ...
        ```

    - for WINDOWS users.

      - To fetch a contest.

        ```powershell
        ./codeforces_sample_gen.sh -c <CONTEST_ID> A B C D ...
        ```

      - To fetch a problem.

        ```powershell
        codeforces_sample_gen.sh -p <PROBLEM1> <PROBLEM2> ...
        ```

- **dbrun.sh**

  - Make the script executable (Mention above).
  - Follow the syntax.

    ```bash
    ./dbrun.sh <FILE_NAME_WITH_EXTENSION>
    ```

- **dbrun.py**

  - For LINUX or MAC users.

    ```bash
    python3 dbrun.py <FILE_NAME_WITH_EXTENSION>
    ```

  - For WINDOWS users.

    ```powershell
    python dbrun.py <FILE_NAME_WITH_EXTENSION>
    ```

- **pretest.sh**

  - Make the script executable (Mention above).
  - Follow the syntax.

    ```bash
    ./pretest.sh <FILE_NAME_WITH_EXTENSION>
    ```

- **pretest.py**

  - For LINUX or MAC users.

    ```bash
    python3 pretest.py <FILE_NAME_WITH_EXTENSION>
    ```

  - For WINDOWS users.

    ```powershell
    python pretest.py <FILE_NAME_WITH_EXTENSION>
    ```

- **stress_test.sh**

  - Make the script executable (Mention above).
  - Follow the syntax.

    ```bash
    ./stress_test.sh <WRONG_SOLUTION> <BRUTE_SOLUTION> <GENERATOR> <NUMBER_OF_TESTS>
    ```

- **stress_test.py**

  - For LINUX or MAC users.

    ```bash
    python3 stress_test.py <WRONG_SOLUTION> <BRUTE_SOLUTION> <GENERATOR> <NUMBER_OF_TESTS>
    ```

  - For WINDOWS users.

    ```powershell
    python stress_test.py <WRONG_SOLUTION> <BRUTE_SOLUTION> <GENERATOR> <NUMBER_OF_TESTS>
    ```
