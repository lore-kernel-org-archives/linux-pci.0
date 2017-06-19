Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44243 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751022AbdFSVpt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 17:45:49 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5/6] PCI / ACPI / PM: Avoid disabling wakeup for bridges too early
Date: Mon, 19 Jun 2017 23:36:21 +0200
Message-ID: <374495495.9Wgi8cFFrW@aspire.rjw.lan>
In-Reply-To: <12296383.UdE5HVtyng@aspire.rjw.lan>
References: <12296383.UdE5HVtyng@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If acpi_pci_propagate_wakeup() is used, it may trigger wakeup
configuration twice for the same bridge indirectly, when configuring
wakeup for two different PCI devices under that bridge.  Actually,
however, the ACPI wakeup code can only be enabled to trigger wakeup
notifications for the bridge once in a row and there is no reference
counting in that code, so wakeup signaling on the bridge can be
disabled prematurely when it is disabled for the first of those
devices.

To prevent that from happening, add optional reference counting to
the ACPI device wakeup code and make acpi_pci_propagate_wakeup()
use if for bridges.

This works, because ACPI wakeup signaling for PCI bridges is only
set up by acpi_pci_propagate_wakeup(), so the reference counting
will only be used for them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |   35 +++++++++++++++++++++++++++++++----
 drivers/pci/pci-acpi.c   |    4 ++--
 include/acpi/acpi_bus.h  |   11 +++++++++--
 3 files changed, 42 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -385,6 +385,7 @@ EXPORT_SYMBOL(acpi_bus_power_manageable)
 
 #ifdef CONFIG_PM
 static DEFINE_MUTEX(acpi_pm_notifier_lock);
+static DEFINE_MUTEX(acpi_wakeup_lock);
 
 void acpi_pm_wakeup_event(struct device *dev)
 {
@@ -724,11 +725,11 @@ static int acpi_device_wakeup(struct acp
 }
 
 /**
- * acpi_pm_device_wakeup - Enable/disable remote wakeup for given device.
+ * __acpi_pm_device_wakeup - Enable/disable remote wakeup for given device.
  * @dev: Device to enable/disable to generate wakeup events.
  * @enable: Whether to enable or disable the wakeup functionality.
  */
-int acpi_pm_device_wakeup(struct device *dev, bool enable)
+int __acpi_pm_device_wakeup(struct device *dev, bool enable, bool refcount)
 {
 	struct acpi_device *adev;
 	int error;
@@ -742,13 +743,39 @@ int acpi_pm_device_wakeup(struct device
 	if (!acpi_device_can_wakeup(adev))
 		return -EINVAL;
 
+	if (refcount) {
+		mutex_lock(&acpi_wakeup_lock);
+
+		if (enable) {
+			if (++adev->wakeup.enable_count > 1)
+				goto out;
+		} else {
+			if (WARN_ON_ONCE(adev->wakeup.enable_count == 0))
+				goto out;
+
+			if (--adev->wakeup.enable_count > 0)
+				goto out;
+		}
+	}
 	error = acpi_device_wakeup(adev, acpi_target_system_state(), enable);
-	if (!error)
+	if (error) {
+		if (refcount) {
+			if (enable)
+				adev->wakeup.enable_count--;
+			else
+				adev->wakeup.enable_count++;
+		}
+	} else {
 		dev_dbg(dev, "Wakeup %s by ACPI\n", enable ? "enabled" : "disabled");
+	}
+
+out:
+	if (refcount)
+		mutex_unlock(&acpi_wakeup_lock);
 
 	return error;
 }
-EXPORT_SYMBOL(acpi_pm_device_wakeup);
+EXPORT_SYMBOL(__acpi_pm_device_wakeup);
 
 /**
  * acpi_dev_pm_low_power - Put ACPI device into a low-power state.
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -331,6 +331,7 @@ struct acpi_device_wakeup {
 	struct acpi_device_wakeup_context context;
 	struct wakeup_source *ws;
 	int prepare_count;
+	unsigned int enable_count;
 };
 
 struct acpi_device_physical_node {
@@ -603,7 +604,7 @@ acpi_status acpi_add_pm_notifier(struct
 acpi_status acpi_remove_pm_notifier(struct acpi_device *adev);
 bool acpi_pm_device_can_wakeup(struct device *dev);
 int acpi_pm_device_sleep_state(struct device *, int *, int);
-int acpi_pm_device_wakeup(struct device *dev, bool enable);
+int __acpi_pm_device_wakeup(struct device *dev, bool enable, bool refcount);
 #else
 static inline void acpi_pm_wakeup_event(struct device *dev)
 {
@@ -630,12 +631,18 @@ static inline int acpi_pm_device_sleep_s
 	return (m >= ACPI_STATE_D0 && m <= ACPI_STATE_D3_COLD) ?
 		m : ACPI_STATE_D0;
 }
-static inline int acpi_pm_device_wakeup(struct device *dev, bool enable)
+static inline int __acpi_pm_device_wakeup(struct device *dev, bool enable,
+					  bool refcount)
 {
 	return -ENODEV;
 }
 #endif
 
+static inline int acpi_pm_device_wakeup(struct device *dev, bool enable)
+{
+	return __acpi_pm_device_wakeup(dev, enable, false);
+}
+
 #ifdef CONFIG_ACPI_SLEEP
 u32 acpi_target_system_state(void);
 #else
Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -574,7 +574,7 @@ static int acpi_pci_propagate_wakeup(str
 {
 	while (bus->parent) {
 		if (acpi_pm_device_can_wakeup(&bus->self->dev))
-			return acpi_pm_device_wakeup(&bus->self->dev, enable);
+			return __acpi_pm_device_wakeup(&bus->self->dev, enable, true);
 
 		bus = bus->parent;
 	}
@@ -582,7 +582,7 @@ static int acpi_pci_propagate_wakeup(str
 	/* We have reached the root bus. */
 	if (bus->bridge) {
 		if (acpi_pm_device_can_wakeup(bus->bridge))
-			return acpi_pm_device_wakeup(bus->bridge, enable);
+			return __acpi_pm_device_wakeup(bus->bridge, enable, true);
 	}
 	return 0;
 }
