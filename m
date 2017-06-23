Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/5] ACPI / PM: Consolidate device wakeup settings code
Date: Sat, 24 Jun 2017 01:54:39 +0200
Message-ID: <2258835.LOJ3fxWtdo@aspire.rjw.lan>
In-Reply-To: <2524735.NRzn8A9HAf@aspire.rjw.lan>
References: <12296383.UdE5HVtyng@aspire.rjw.lan> <2524735.NRzn8A9HAf@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Currently, there are two separate ways of handling device wakeup
settings in the ACPI core, depending on whether this is runtime
wakeup or system wakeup (from sleep states).  However, after the
previous commit eliminating the run_wake ACPI device wakeup flag,
there is no difference between the two any more at the ACPI level,
so they can be combined.

For this reason, introduce acpi_pm_set_device_wakeup() to replace both
acpi_pm_device_run_wake() and acpi_pm_device_sleep_wake() and make it
check the ACPI device object's wakeup.valid flag to determine whether
or not the device can be set up to generate wakeup signals.

Also notice that zpodd_enable/disable_run_wake() only call
device_set_run_wake() because acpi_pm_device_run_wake() called
device_run_wake(), which is not done by acpi_pm_set_device_wakeup(),
so drop the now redundant device_set_run_wake() calls from there.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---

-> v2: Rename acpi_pm_device_wakeup() to acpi_pm_set_device_wakeup().

---
 drivers/acpi/device_pm.c   |   39 ++++++++-------------------------------
 drivers/ata/libata-zpodd.c |    9 +++------
 drivers/pci/pci-acpi.c     |   12 ++++++------
 drivers/pnp/pnpacpi/core.c |    6 +++---
 include/acpi/acpi_bus.h    |   13 ++-----------
 5 files changed, 22 insertions(+), 57 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -717,55 +717,32 @@ static int acpi_device_wakeup(struct acp
 }
 
 /**
- * acpi_pm_device_run_wake - Enable/disable remote wakeup for given device.
- * @dev: Device to enable/disable the platform to wake up.
+ * acpi_pm_set_device_wakeup - Enable/disable remote wakeup for given device.
+ * @dev: Device to enable/disable to generate wakeup events.
  * @enable: Whether to enable or disable the wakeup functionality.
  */
-int acpi_pm_device_run_wake(struct device *phys_dev, bool enable)
-{
-	struct acpi_device *adev;
-
-	if (!device_run_wake(phys_dev))
-		return -EINVAL;
-
-	adev = ACPI_COMPANION(phys_dev);
-	if (!adev) {
-		dev_dbg(phys_dev, "ACPI companion missing in %s!\n", __func__);
-		return -ENODEV;
-	}
-
-	return acpi_device_wakeup(adev, ACPI_STATE_S0, enable);
-}
-EXPORT_SYMBOL(acpi_pm_device_run_wake);
-
-#ifdef CONFIG_PM_SLEEP
-/**
- * acpi_pm_device_sleep_wake - Enable or disable device to wake up the system.
- * @dev: Device to enable/desible to wake up the system from sleep states.
- * @enable: Whether to enable or disable @dev to wake up the system.
- */
-int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
+int acpi_pm_set_device_wakeup(struct device *dev, bool enable)
 {
 	struct acpi_device *adev;
 	int error;
 
-	if (!device_can_wakeup(dev))
-		return -EINVAL;
-
 	adev = ACPI_COMPANION(dev);
 	if (!adev) {
 		dev_dbg(dev, "ACPI companion missing in %s!\n", __func__);
 		return -ENODEV;
 	}
 
+	if (!acpi_device_can_wakeup(adev))
+		return -EINVAL;
+
 	error = acpi_device_wakeup(adev, acpi_target_system_state(), enable);
 	if (!error)
-		dev_dbg(dev, "System wakeup %s by ACPI\n",
+		dev_dbg(dev, "Wakeup %s by ACPI\n",
 			enable ? "enabled" : "disabled");
 
 	return error;
 }
-#endif /* CONFIG_PM_SLEEP */
+EXPORT_SYMBOL(acpi_pm_set_device_wakeup);
 
 /**
  * acpi_dev_pm_low_power - Put ACPI device into a low-power state.
Index: linux-pm/drivers/ata/libata-zpodd.c
===================================================================
--- linux-pm.orig/drivers/ata/libata-zpodd.c
+++ linux-pm/drivers/ata/libata-zpodd.c
@@ -174,8 +174,7 @@ void zpodd_enable_run_wake(struct ata_de
 	sdev_disable_disk_events(dev->sdev);
 
 	zpodd->powered_off = true;
-	device_set_run_wake(&dev->tdev, true);
-	acpi_pm_device_run_wake(&dev->tdev, true);
+	acpi_pm_set_device_wakeup(&dev->tdev, true);
 }
 
 /* Disable runtime wake capability if it is enabled */
@@ -183,10 +182,8 @@ void zpodd_disable_run_wake(struct ata_d
 {
 	struct zpodd *zpodd = dev->zpodd;
 
-	if (zpodd->powered_off) {
-		acpi_pm_device_run_wake(&dev->tdev, false);
-		device_set_run_wake(&dev->tdev, false);
-	}
+	if (zpodd->powered_off)
+		acpi_pm_set_device_wakeup(&dev->tdev, false);
 }
 
 /*
Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -578,20 +578,20 @@ static bool acpi_pci_can_wakeup(struct p
 static void acpi_pci_propagate_wakeup_enable(struct pci_bus *bus, bool enable)
 {
 	while (bus->parent) {
-		if (!acpi_pm_device_sleep_wake(&bus->self->dev, enable))
+		if (!acpi_pm_set_device_wakeup(&bus->self->dev, enable))
 			return;
 		bus = bus->parent;
 	}
 
 	/* We have reached the root bus. */
 	if (bus->bridge)
-		acpi_pm_device_sleep_wake(bus->bridge, enable);
+		acpi_pm_set_device_wakeup(bus->bridge, enable);
 }
 
 static int acpi_pci_sleep_wake(struct pci_dev *dev, bool enable)
 {
 	if (acpi_pci_can_wakeup(dev))
-		return acpi_pm_device_sleep_wake(&dev->dev, enable);
+		return acpi_pm_set_device_wakeup(&dev->dev, enable);
 
 	acpi_pci_propagate_wakeup_enable(dev->bus, enable);
 	return 0;
@@ -604,14 +604,14 @@ static void acpi_pci_propagate_run_wake(
 
 		if (bridge->pme_interrupt)
 			return;
-		if (!acpi_pm_device_run_wake(&bridge->dev, enable))
+		if (!acpi_pm_set_device_wakeup(&bridge->dev, enable))
 			return;
 		bus = bus->parent;
 	}
 
 	/* We have reached the root bus. */
 	if (bus->bridge)
-		acpi_pm_device_run_wake(bus->bridge, enable);
+		acpi_pm_set_device_wakeup(bus->bridge, enable);
 }
 
 static int acpi_pci_run_wake(struct pci_dev *dev, bool enable)
@@ -625,7 +625,7 @@ static int acpi_pci_run_wake(struct pci_
 	if (dev->pme_interrupt && !dev->runtime_d3cold)
 		return 0;
 
-	if (!acpi_pm_device_run_wake(&dev->dev, enable))
+	if (!acpi_pm_set_device_wakeup(&dev->dev, enable))
 		return 0;
 
 	acpi_pci_propagate_run_wake(dev->bus, enable);
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -603,7 +603,7 @@ acpi_status acpi_add_pm_notifier(struct
 			void (*func)(struct acpi_device_wakeup_context *context));
 acpi_status acpi_remove_pm_notifier(struct acpi_device *adev);
 int acpi_pm_device_sleep_state(struct device *, int *, int);
-int acpi_pm_device_run_wake(struct device *, bool);
+int acpi_pm_set_device_wakeup(struct device *dev, bool enable);
 #else
 static inline void acpi_pm_wakeup_event(struct device *dev)
 {
@@ -626,16 +626,7 @@ static inline int acpi_pm_device_sleep_s
 	return (m >= ACPI_STATE_D0 && m <= ACPI_STATE_D3_COLD) ?
 		m : ACPI_STATE_D0;
 }
-static inline int acpi_pm_device_run_wake(struct device *dev, bool enable)
-{
-	return -ENODEV;
-}
-#endif
-
-#ifdef CONFIG_PM_SLEEP
-int acpi_pm_device_sleep_wake(struct device *, bool);
-#else
-static inline int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
+static inline int acpi_pm_set_device_wakeup(struct device *dev, bool enable)
 {
 	return -ENODEV;
 }
Index: linux-pm/drivers/pnp/pnpacpi/core.c
===================================================================
--- linux-pm.orig/drivers/pnp/pnpacpi/core.c
+++ linux-pm/drivers/pnp/pnpacpi/core.c
@@ -149,8 +149,8 @@ static int pnpacpi_suspend(struct pnp_de
 	}
 
 	if (device_can_wakeup(&dev->dev)) {
-		error = acpi_pm_device_sleep_wake(&dev->dev,
-				device_may_wakeup(&dev->dev));
+		error = acpi_pm_set_device_wakeup(&dev->dev,
+					      device_may_wakeup(&dev->dev));
 		if (error)
 			return error;
 	}
@@ -185,7 +185,7 @@ static int pnpacpi_resume(struct pnp_dev
 	}
 
 	if (device_may_wakeup(&dev->dev))
-		acpi_pm_device_sleep_wake(&dev->dev, false);
+		acpi_pm_set_device_wakeup(&dev->dev, false);
 
 	if (acpi_device_power_manageable(acpi_dev))
 		error = acpi_device_set_power(acpi_dev, ACPI_STATE_D0);

