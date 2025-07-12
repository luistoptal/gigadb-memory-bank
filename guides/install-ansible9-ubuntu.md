Of course. It's an excellent idea to document the final, working solution. The process we went through is very common for developers on modern Linux systems.

Here is a concise cheatsheet for your future reference.

---

### **Cheatsheet: Installing a Specific Ansible Version on Modern Ubuntu (22.04+)**

This guide uses `pipx` to safely install a specific version of Ansible so it's available globally without interfering with system packages or requiring manual virtual environment activation.

#### **The "Why"**

*   **Problem:** Modern Ubuntu uses "externally managed environments" (PEP 668), which prevents `sudo pip install` to protect the OS.
*   **Problem:** The `ansible` package is a "metapackage" that bundles `ansible-core` and community collections. A simple `pipx install ansible` doesn't expose the core commands correctly.
*   **Solution:** We use `pipx` to install `ansible-core` (for the commands) and then `inject` the specific `ansible` community version into it. This gives us the safety of an isolated environment with the convenience of a global command.

---

### **The Steps**

#### **Step 1: Setup `pipx` & Clean Up Old Attempts**

*(Only needs to be done once per machine)*

1.  **Install pipx:**
    ```bash
    sudo apt update
    sudo apt install pipx -y
    ```

2.  **Add pipx to your PATH:**
    ```bash
    pipx ensurepath
    ```
    **Important:** Close and reopen your terminal after this step for the changes to take effect.

3.  **(Optional) Clean up any old installations:**
    If you've tried other methods, run these commands to ensure a clean slate.
    ```bash
    pipx uninstall --all
    rm -f ~/.local/bin/ansible*
    ```

#### **Step 2: Install the Base Commands with `ansible-core`**

This step installs the actual command-line tools like `ansible`, `ansible-playbook`, etc.

```bash
pipx install ansible-core
```
*   **Verification:** `which ansible` should now point to `~/.local/bin/ansible`.

#### **Step 3: Inject the Specific Ansible Community Version**

This is the key step. It adds the Ansible 9 community collections and automatically handles the dependencies, downgrading `ansible-core` to the correct version.

```bash
# Replace "9.*" with the major version you need (e.g., "8.*", "10.*")
pipx inject ansible-core "ansible==9.*"
```

#### **Step 4: Verify the Final Installation**

1.  **Refresh your shell's command cache:**
    ```bash
    hash -r
    ```

2.  **Check the version:**
    ```bash
    ansible --version
    ```
    *   **Look for:** The output should show the correct downgraded core version. For Ansible 9, this will be `ansible [core 2.16.x]`. This is your proof that the injection worked correctly.

---

### **Quick Reference & Management**

| Goal                                                | Command                                            |
| --------------------------------------------------- | -------------------------------------------------- |
| **Install Ansible 9 (from scratch)**                | `pipx install ansible-core`                        |
|                                                     | `pipx inject ansible-core "ansible==9.*"`          |
| **Completely Uninstall Ansible**                    | `pipx uninstall ansible-core`                      |
| **List Installed `pipx` Packages**                  | `pipx list`                                        |
| **See what's inside the Ansible environment**       | `pipx runpip ansible-core list`                    |