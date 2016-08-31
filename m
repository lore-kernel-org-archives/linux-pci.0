Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-Id: <ee1e8bbc387594877162ef09acb5027444ac8f9a.1472554278.git.lukas@wunner.de>
In-Reply-To: <cover.1472554278.git.lukas@wunner.de>
References: <cover.1472554278.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 31 Aug 2016 08:15:18 +0200
Subject: [PATCH 2/4] PCI: Query platform firmware for device power state
To: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Usually the most accurate way to determine a PCI device's power state is
to read its PM Control & Status Register.  There are two cases however
when this is not an option:  If the device doesn't have the PM
capability at all, or if it is in D3cold.

In D3cold, reading from config space typically results in a fabricated
"all ones" response.  But in D3hot, the two bits representing the power
state in the PMCSR are *also* set to 1.  Thus D3hot and D3cold are not
discernible by just reading the PMCSR.

A (supposedly) reliable way to detect D3cold is to query the platform
firmware for its opinion on the device's power state.  To this end,
add a ->get_power callback to struct pci_platform_pm_ops, and an
implementation to acpi_pci_platform_pm.  (The only pci_platform_pm_ops
existing so far).

Amend pci_update_current_state() to query the platform firmware before
reading the PMCSR.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci-acpi.c | 23 +++++++++++++++++++++++
 drivers/pci/pci.c      | 21 ++++++++++++++++-----
 drivers/pci/pci.h      |  3 +++
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 9a033e8..89f2707 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -452,6 +452,28 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 	return error;
 }
 
+static pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
+	static const pci_power_t state_conv[] = {
+		[ACPI_STATE_D0]      = PCI_D0,
+		[ACPI_STATE_D1]      = PCI_D1,
+		[ACPI_STATE_D2]      = PCI_D2,
+		[ACPI_STATE_D3_HOT]  = PCI_D3hot,
+		[ACPI_STATE_D3_COLD] = PCI_D3cold,
+	};
+	int state;
+
+	if (!adev || !acpi_device_power_manageable(adev))
+		return PCI_UNKNOWN;
+
+	if (acpi_device_get_power(adev, &state) || state < ACPI_STATE_D0
+						|| state > ACPI_STATE_D3_COLD)
+		return PCI_UNKNOWN;
+
+	return state_conv[state];
+}
+
 static bool acpi_pci_can_wakeup(struct pci_dev *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
@@ -534,6 +556,7 @@ static bool acpi_pci_need_resume(struct pci_dev *dev)
 static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
 	.is_manageable = acpi_pci_power_manageable,
 	.set_state = acpi_pci_set_power_state,
+	.get_state = acpi_pci_get_power_state,
 	.choose_state = acpi_pci_choose_state,
 	.sleep_wake = acpi_pci_sleep_wake,
 	.run_wake = acpi_pci_run_wake,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 72a9d3a..e52e3d4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -552,8 +552,9 @@ static const struct pci_platform_pm_ops *pci_platform_pm;
 
 int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
 {
-	if (!ops->is_manageable || !ops->set_state || !ops->choose_state ||
-	    !ops->sleep_wake || !ops->run_wake || !ops->need_resume)
+	if (!ops->is_manageable || !ops->set_state  || !ops->get_state ||
+	    !ops->choose_state  || !ops->sleep_wake || !ops->run_wake  ||
+	    !ops->need_resume)
 		return -EINVAL;
 	pci_platform_pm = ops;
 	return 0;
@@ -570,6 +571,11 @@ static inline int platform_pci_set_power_state(struct pci_dev *dev,
 	return pci_platform_pm ? pci_platform_pm->set_state(dev, t) : -ENOSYS;
 }
 
+static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
+{
+	return pci_platform_pm ? pci_platform_pm->get_state(dev) : PCI_UNKNOWN;
+}
+
 static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
 {
 	return pci_platform_pm ?
@@ -701,14 +707,19 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 }
 
 /**
- * pci_update_current_state - Read PCI power state of given device from its
- *                            PCI PM registers and cache it
+ * pci_update_current_state - Read power state of given device and cache it
  * @dev: PCI device to handle.
  * @state: State to cache in case the device doesn't have the PM capability
+ *
+ * The power state is read from the PMCSR register, which however is
+ * inaccessible in D3cold. The platform firmware is therefore queried first
+ * to detect accessibility of the register.
  */
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
 {
-	if (dev->pm_cap) {
+	if (platform_pci_get_power_state(dev) == PCI_D3cold) {
+		dev->current_state = PCI_D3cold;
+	} else if (dev->pm_cap) {
 		u16 pmcsr;
 
 		/*
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9730c47..01d5206 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -42,6 +42,8 @@ int pci_probe_reset_function(struct pci_dev *dev);
  *
  * @set_state: invokes the platform firmware to set the device's power state
  *
+ * @get_state: queries the platform firmware for a device's current power state
+ *
  * @choose_state: returns PCI power state of given device preferred by the
  *                platform; to be used during system-wide transitions from a
  *                sleeping state to the working state and vice versa
@@ -62,6 +64,7 @@ int pci_probe_reset_function(struct pci_dev *dev);
 struct pci_platform_pm_ops {
 	bool (*is_manageable)(struct pci_dev *dev);
 	int (*set_state)(struct pci_dev *dev, pci_power_t state);
+	pci_power_t (*get_state)(struct pci_dev *dev);
 	pci_power_t (*choose_state)(struct pci_dev *dev);
 	int (*sleep_wake)(struct pci_dev *dev, bool enable);
 	int (*run_wake)(struct pci_dev *dev, bool enable);
-- 
2.8.1

