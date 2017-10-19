Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.137]:44790 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbdJSLKW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2017 07:10:22 -0400
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, bhelgaas@google.com
Cc: shawn.lin@rock-chips.com, briannorris@chromium.org,
        dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v7 1/3] PCI: Add support for wake irq
Date: Thu, 19 Oct 2017 19:10:05 +0800
Message-Id: <20171019111007.25234-2-jeffy.chen@rock-chips.com>
In-Reply-To: <20171019111007.25234-1-jeffy.chen@rock-chips.com>
References: <20171019111007.25234-1-jeffy.chen@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add support for PCIE_WAKE pin.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v7:
Move PCIE_WAKE handling into pci core.

Changes in v6:
Fix device_init_wake error handling, and add some comments.

Changes in v5:
Rebase

Changes in v3:
Fix error handling

Changes in v2:
Use dev_pm_set_dedicated_wake_irq
        -- Suggested by Brian Norris <briannorris@chromium.com>

 drivers/pci/pci.c    | 34 ++++++++++++++++++++++++++++++++--
 drivers/pci/probe.c  | 32 ++++++++++++++++++++++++++++----
 drivers/pci/remove.c |  9 +++++++++
 3 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f0d68066c726..49080a10bdf0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -603,10 +603,40 @@ static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
 			pci_platform_pm->choose_state(dev) : PCI_POWER_ERROR;
 }
 
+static int pci_dev_check_wakeup(struct pci_dev *dev, void *data)
+{
+	bool *wakeup = data;
+
+	if (device_may_wakeup(&dev->dev))
+		*wakeup = true;
+
+	return *wakeup;
+}
+
 static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
 {
-	return pci_platform_pm ?
-			pci_platform_pm->set_wakeup(dev, enable) : -ENODEV;
+	struct pci_dev *parent = dev;
+	struct pci_bus *bus;
+	bool wakeup = false;
+
+	if (pci_platform_pm)
+		return pci_platform_pm->set_wakeup(dev, enable);
+
+	device_set_wakeup_capable(&dev->dev, enable);
+
+	while ((parent = pci_upstream_bridge(parent)))
+		bus = parent->bus;
+
+	if (!bus || !pci_is_root_bus(bus) || !bus->bridge->parent)
+		return -ENODEV;
+
+	pci_walk_bus(bus, pci_dev_check_wakeup, &wakeup);
+	device_set_wakeup_capable(bus->bridge->parent, wakeup);
+
+	dev_dbg(bus->bridge->parent,
+		"Wakeup %s\n", wakeup ? "enabled" : "disabled");
+
+	return 0;
 }
 
 static inline bool platform_pci_need_resume(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cdc2f83c11c5..fd43ca832665 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/slab.h>
@@ -17,6 +18,7 @@
 #include <linux/acpi.h>
 #include <linux/irqdomain.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -756,11 +758,28 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	struct resource *res;
 	char addr[64], *fmt;
 	const char *name;
-	int err;
+	int err, irq;
+
+	if (IS_ENABLED(CONFIG_OF) && parent && parent->of_node) {
+		irq = of_irq_get_byname(parent->of_node, "wakeup");
+		if (irq == -EPROBE_DEFER)
+			return irq;
+		if (irq > 0) {
+			device_init_wakeup(parent, true);
+			err = dev_pm_set_dedicated_wake_irq(parent, irq);
+			if (err) {
+				dev_err(parent, "Failed to setup wakeup IRQ\n");
+				goto deinit_wakeup;
+			}
+			dev_info(parent, "Wakeup enabled with IRQ %d\n", irq);
+		}
+	}
 
 	bus = pci_alloc_bus(NULL);
-	if (!bus)
-		return -ENOMEM;
+	if (!bus) {
+		err = -ENOMEM;
+		goto clear_wake_irq;
+	}
 
 	bridge->bus = bus;
 
@@ -856,9 +875,14 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 unregister:
 	put_device(&bridge->dev);
 	device_unregister(&bridge->dev);
-
 free:
 	kfree(bus);
+clear_wake_irq:
+	if (parent)
+		dev_pm_clear_wake_irq(parent);
+deinit_wakeup:
+	if (parent)
+		device_init_wakeup(parent, false);
 	return err;
 }
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 73a03d382590..cb7a326429e1 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,6 +1,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/pci-aspm.h>
+#include <linux/pm_wakeirq.h>
 #include "pci.h"
 
 static void pci_free_resources(struct pci_dev *dev)
@@ -131,17 +132,25 @@ void pci_stop_root_bus(struct pci_bus *bus)
 {
 	struct pci_dev *child, *tmp;
 	struct pci_host_bridge *host_bridge;
+	struct device *parent;
 
 	if (!pci_is_root_bus(bus))
 		return;
 
 	host_bridge = to_pci_host_bridge(bus->bridge);
+	parent = host_bridge->dev.parent;
+
 	list_for_each_entry_safe_reverse(child, tmp,
 					 &bus->devices, bus_list)
 		pci_stop_bus_device(child);
 
 	/* stop the host bridge */
 	device_release_driver(&host_bridge->dev);
+
+	if (parent) {
+		dev_pm_clear_wake_irq(parent);
+		device_init_wakeup(parent, false);
+	}
 }
 EXPORT_SYMBOL_GPL(pci_stop_root_bus);
 
-- 
2.11.0
