Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 3/5] PCI / PM: Drop pme_interrupt flag from struct pci_dev
Date: Sat, 24 Jun 2017 01:56:13 +0200
Message-ID: <2331413.7usz8IdcnZ@aspire.rjw.lan>
In-Reply-To: <2524735.NRzn8A9HAf@aspire.rjw.lan>
References: <12296383.UdE5HVtyng@aspire.rjw.lan> <2524735.NRzn8A9HAf@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The pme_interrupt flag in struct pci_dev is set when PMEs generated
by the device are going to be signaled via root port PME interrupts.

Ironically enough, that information is only used by the code setting
up device wakeup through ACPI which returns as soon as it sees the
pme_interrupt flag set while setting up "remote runtime wakeup".
That is questionable, however, because in theory there may be PCIe
devices using out-of-band PME signaling under root ports handled
by the native PME code or devices requiring wakeup power setup to be
carried out by AML.  For such devices, ACPI wakeup should be invoked
regardless of whether or not native PME signaling is used in general.

For this reason, drop the pme_interrupt flag and rework the code
using it which then allows the ACPI-based device wakeup handling
in PCI to be consolidated to use one code path for both "runtime
remote wakeup" and system wakeup (from sleep states).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---

-> v2: Rename acpi_pm_device_wakeup() to acpi_pm_set_device_wakeup(),
          update the changelog.

---
 drivers/acpi/device_pm.c |   10 +++++-
 drivers/pci/pci-acpi.c   |   68 ++++++++++-------------------------------------
 drivers/pci/pcie/pme.c   |   14 ++++-----
 include/acpi/acpi_bus.h  |    5 +++
 include/linux/pci.h      |    1 
 5 files changed, 34 insertions(+), 64 deletions(-)

Index: linux-pm/include/linux/pci.h
===================================================================
--- linux-pm.orig/include/linux/pci.h
+++ linux-pm/include/linux/pci.h
@@ -307,7 +307,6 @@ struct pci_dev {
 	u8		pm_cap;		/* PM capability offset */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
-	unsigned int	pme_interrupt:1;
 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -569,67 +569,29 @@ static pci_power_t acpi_pci_get_power_st
 	return state_conv[state];
 }
 
-static bool acpi_pci_can_wakeup(struct pci_dev *dev)
-{
-	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
-	return adev ? acpi_device_can_wakeup(adev) : false;
-}
-
-static void acpi_pci_propagate_wakeup_enable(struct pci_bus *bus, bool enable)
+static int acpi_pci_propagate_wakeup(struct pci_bus *bus, bool enable)
 {
 	while (bus->parent) {
-		if (!acpi_pm_set_device_wakeup(&bus->self->dev, enable))
-			return;
-		bus = bus->parent;
-	}
+		if (acpi_pm_device_can_wakeup(&bus->self->dev))
+			return acpi_pm_set_device_wakeup(&bus->self->dev, enable);
 
-	/* We have reached the root bus. */
-	if (bus->bridge)
-		acpi_pm_set_device_wakeup(bus->bridge, enable);
-}
-
-static int acpi_pci_sleep_wake(struct pci_dev *dev, bool enable)
-{
-	if (acpi_pci_can_wakeup(dev))
-		return acpi_pm_set_device_wakeup(&dev->dev, enable);
-
-	acpi_pci_propagate_wakeup_enable(dev->bus, enable);
-	return 0;
-}
-
-static void acpi_pci_propagate_run_wake(struct pci_bus *bus, bool enable)
-{
-	while (bus->parent) {
-		struct pci_dev *bridge = bus->self;
-
-		if (bridge->pme_interrupt)
-			return;
-		if (!acpi_pm_set_device_wakeup(&bridge->dev, enable))
-			return;
 		bus = bus->parent;
 	}
 
 	/* We have reached the root bus. */
-	if (bus->bridge)
-		acpi_pm_set_device_wakeup(bus->bridge, enable);
+	if (bus->bridge) {
+		if (acpi_pm_device_can_wakeup(bus->bridge))
+			return acpi_pm_set_device_wakeup(bus->bridge, enable);
+	}
+	return 0;
 }
 
-static int acpi_pci_run_wake(struct pci_dev *dev, bool enable)
+static int acpi_pci_wakeup(struct pci_dev *dev, bool enable)
 {
-	/*
-	 * Per PCI Express Base Specification Revision 2.0 section
-	 * 5.3.3.2 Link Wakeup, platform support is needed for D3cold
-	 * waking up to power on the main link even if there is PME
-	 * support for D3cold
-	 */
-	if (dev->pme_interrupt && !dev->runtime_d3cold)
-		return 0;
-
-	if (!acpi_pm_set_device_wakeup(&dev->dev, enable))
-		return 0;
+	if (acpi_pm_device_can_wakeup(&dev->dev))
+		return acpi_pm_set_device_wakeup(&dev->dev, enable);
 
-	acpi_pci_propagate_run_wake(dev->bus, enable);
-	return 0;
+	return acpi_pci_propagate_wakeup(dev->bus, enable);
 }
 
 static bool acpi_pci_need_resume(struct pci_dev *dev)
@@ -653,8 +615,8 @@ static const struct pci_platform_pm_ops
 	.set_state = acpi_pci_set_power_state,
 	.get_state = acpi_pci_get_power_state,
 	.choose_state = acpi_pci_choose_state,
-	.sleep_wake = acpi_pci_sleep_wake,
-	.run_wake = acpi_pci_run_wake,
+	.sleep_wake = acpi_pci_wakeup,
+	.run_wake = acpi_pci_wakeup,
 	.need_resume = acpi_pci_need_resume,
 };
 
@@ -778,7 +740,7 @@ static void pci_acpi_setup(struct device
 
 	device_set_wakeup_capable(dev, true);
 	device_set_run_wake(dev, true);
-	acpi_pci_sleep_wake(pci_dev, false);
+	acpi_pci_wakeup(pci_dev, false);
 }
 
 static void pci_acpi_cleanup(struct device *dev)
Index: linux-pm/drivers/pci/pcie/pme.c
===================================================================
--- linux-pm.orig/drivers/pci/pcie/pme.c
+++ linux-pm/drivers/pci/pcie/pme.c
@@ -294,31 +294,29 @@ static irqreturn_t pcie_pme_irq(int irq,
 }
 
 /**
- * pcie_pme_set_native - Set the PME interrupt flag for given device.
+ * pcie_pme_can_wakeup - Set the wakeup capability flag.
  * @dev: PCI device to handle.
  * @ign: Ignored.
  */
-static int pcie_pme_set_native(struct pci_dev *dev, void *ign)
+static int pcie_pme_can_wakeup(struct pci_dev *dev, void *ign)
 {
 	device_set_run_wake(&dev->dev, true);
-	dev->pme_interrupt = true;
 	return 0;
 }
 
 /**
- * pcie_pme_mark_devices - Set the PME interrupt flag for devices below a port.
+ * pcie_pme_mark_devices - Set the wakeup flag for devices below a port.
  * @port: PCIe root port or event collector to handle.
  *
  * For each device below given root port, including the port itself (or for each
  * root complex integrated endpoint if @port is a root complex event collector)
- * set the flag indicating that it can signal run-time wake-up events via PCIe
- * PME interrupts.
+ * set the flag indicating that it can signal run-time wake-up events.
  */
 static void pcie_pme_mark_devices(struct pci_dev *port)
 {
-	pcie_pme_set_native(port, NULL);
+	pcie_pme_can_wakeup(port, NULL);
 	if (port->subordinate)
-		pci_walk_bus(port->subordinate, pcie_pme_set_native, NULL);
+		pci_walk_bus(port->subordinate, pcie_pme_can_wakeup, NULL);
 }
 
 /**
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -496,6 +496,13 @@ bool acpi_bus_can_wakeup(acpi_handle han
 }
 EXPORT_SYMBOL(acpi_bus_can_wakeup);
 
+bool acpi_pm_device_can_wakeup(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	return adev ? acpi_device_can_wakeup(adev) : false;
+}
+
 /**
  * acpi_dev_pm_get_state - Get preferred power state of ACPI device.
  * @dev: Device whose preferred target power state to return.
@@ -737,8 +744,7 @@ int acpi_pm_set_device_wakeup(struct device
 
 	error = acpi_device_wakeup(adev, acpi_target_system_state(), enable);
 	if (!error)
-		dev_dbg(dev, "Wakeup %s by ACPI\n",
-			enable ? "enabled" : "disabled");
+		dev_dbg(dev, "Wakeup %s by ACPI\n", enable ? "enabled" : "disabled");
 
 	return error;
 }
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -602,6 +602,7 @@ void acpi_pm_wakeup_event(struct device
 acpi_status acpi_add_pm_notifier(struct acpi_device *adev, struct device *dev,
 			void (*func)(struct acpi_device_wakeup_context *context));
 acpi_status acpi_remove_pm_notifier(struct acpi_device *adev);
+bool acpi_pm_device_can_wakeup(struct device *dev);
 int acpi_pm_device_sleep_state(struct device *, int *, int);
 int acpi_pm_set_device_wakeup(struct device *dev, bool enable);
 #else
@@ -618,6 +619,10 @@ static inline acpi_status acpi_remove_pm
 {
 	return AE_SUPPORT;
 }
+static inline bool acpi_pm_device_can_wakeup(struct device *dev)
+{
+	return false;
+}
 static inline int acpi_pm_device_sleep_state(struct device *d, int *p, int m)
 {
 	if (p)

