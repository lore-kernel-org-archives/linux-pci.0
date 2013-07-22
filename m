Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:20994 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933154Ab3GVViU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jul 2013 17:38:20 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v6 6/7] PCI: Enable pci bridge when it is needed
Date: Mon, 22 Jul 2013 14:37:17 -0700
Message-Id: <1374529038-14311-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1374529038-14311-1-git-send-email-yinghai@kernel.org>
References: <1374529038-14311-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current we enable bridges after bus scan and assign resources.
and it is spreaded a lot of places.

We can enable them later when their children pci device is enabled.
Need to go up to root bus and enable bridge one by one down to pci
device.

So that will delay enable bridge as needed bassis,
also kill one inconsistent between boot path and hot-add
path in acpi_pci_root_add().

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/arm/kernel/bios32.c           |  5 -----
 arch/m68k/platform/coldfire/pci.c  |  1 -
 arch/mips/pci/pci.c                |  1 -
 arch/sh/drivers/pci/pci.c          |  1 -
 drivers/acpi/pci_root.c            |  3 ---
 drivers/parisc/lba_pci.c           |  1 -
 drivers/pci/bus.c                  | 19 -------------------
 drivers/pci/hotplug/acpiphp_glue.c |  1 -
 drivers/pci/pci.c                  | 20 ++++++++++++++++++++
 drivers/pci/probe.c                |  1 -
 drivers/pci/setup-bus.c            | 10 +++-------
 drivers/pcmcia/cardbus.c           |  1 -
 include/linux/pci.h                |  1 -
 13 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 261fcc8..88e14d7 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -525,11 +525,6 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 			 * Assign resources.
 			 */
 			pci_bus_assign_resources(bus);
-
-			/*
-			 * Enable bridges
-			 */
-			pci_enable_bridges(bus);
 		}
 
 		/*
diff --git a/arch/m68k/platform/coldfire/pci.c b/arch/m68k/platform/coldfire/pci.c
index b33f97a..df96792 100644
--- a/arch/m68k/platform/coldfire/pci.c
+++ b/arch/m68k/platform/coldfire/pci.c
@@ -319,7 +319,6 @@ static int __init mcf_pci_init(void)
 	pci_fixup_irqs(pci_common_swizzle, mcf_pci_map_irq);
 	pci_bus_size_bridges(rootbus);
 	pci_bus_assign_resources(rootbus);
-	pci_enable_bridges(rootbus);
 	return 0;
 }
 
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 594e60d..33e7aa5 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -113,7 +113,6 @@ static void pcibios_scanbus(struct pci_controller *hose)
 		if (!pci_has_flag(PCI_PROBE_ONLY)) {
 			pci_bus_size_bridges(bus);
 			pci_bus_assign_resources(bus);
-			pci_enable_bridges(bus);
 		}
 	}
 }
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 102f5d5..60ed3e1 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -69,7 +69,6 @@ static void pcibios_scanbus(struct pci_channel *hose)
 
 		pci_bus_size_bridges(bus);
 		pci_bus_assign_resources(bus);
-		pci_enable_bridges(bus);
 	} else {
 		pci_free_resource_list(&resources);
 	}
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 5917839..faa1d29 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -527,9 +527,6 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	if (system_state != SYSTEM_BOOTING) {
 		pcibios_resource_survey_bus(root->bus);
 		pci_assign_unassigned_bus_resources(root->bus);
-
-		/* need to after hot-added ioapic is registered */
-		pci_enable_bridges(root->bus);
 	}
 
 	pci_bus_add_devices(root->bus);
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index 19f6f70..37e71ff 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1590,7 +1590,6 @@ lba_driver_probe(struct parisc_device *dev)
 		lba_dump_res(&lba_dev->hba.lmmio_space, 2);
 #endif
 	}
-	pci_enable_bridges(lba_bus);
 
 	/*
 	** Once PCI register ops has walked the bus, access to config
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index b1ff02a..fc1b740 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -216,24 +216,6 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 	}
 }
 
-void pci_enable_bridges(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-	int retval;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (dev->subordinate) {
-			if (!pci_is_enabled(dev)) {
-				retval = pci_enable_device(dev);
-				if (retval)
-					dev_err(&dev->dev, "Error enabling bridge (%d), continuing\n", retval);
-				pci_set_master(dev);
-			}
-			pci_enable_bridges(dev->subordinate);
-		}
-	}
-}
-
 /** pci_walk_bus - walk devices on/under bus, calling callback.
  *  @top      bus whose devices should be walked
  *  @cb       callback to be called for each device found
@@ -301,4 +283,3 @@ EXPORT_SYMBOL(pci_bus_put);
 EXPORT_SYMBOL(pci_bus_alloc_resource);
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
 EXPORT_SYMBOL(pci_bus_add_devices);
-EXPORT_SYMBOL(pci_enable_bridges);
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 59df857..52dee9d 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -723,7 +723,6 @@ static int __ref enable_device(struct acpiphp_slot *slot)
 	acpiphp_sanitize_bus(bus);
 	acpiphp_set_hpp_values(bus);
 	acpiphp_set_acpi_region(slot);
-	pci_enable_bridges(bus);
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		/* Assume that newly added devices are powered on already. */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e37fea6..44a1a8a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1145,6 +1145,24 @@ int pci_reenable_device(struct pci_dev *dev)
 	return 0;
 }
 
+static void pci_enable_bridge(struct pci_dev *dev)
+{
+	int retval;
+
+	if (!dev)
+		return;
+
+	pci_enable_bridge(dev->bus->self);
+
+	if (pci_is_enabled(dev))
+		return;
+	retval = pci_enable_device(dev);
+	if (retval)
+		dev_err(&dev->dev, "Error enabling bridge (%d), continuing\n",
+			retval);
+	pci_set_master(dev);
+}
+
 static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 {
 	int err;
@@ -1165,6 +1183,8 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 	if (atomic_inc_return(&dev->enable_cnt) > 1)
 		return 0;		/* already enabled */
 
+	pci_enable_bridge(dev->bus->self);
+
 	/* only skip sriov related */
 	for (i = 0; i <= PCI_ROM_RESOURCE; i++)
 		if (dev->resource[i].flags & flags)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 46ada5c..85c114c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1979,7 +1979,6 @@ unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
 
 	max = pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
-	pci_enable_bridges(bus);
 	pci_bus_add_devices(bus);
 
 	return max;
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 19e619d..bd90cc1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1440,7 +1440,7 @@ again:
 
 	/* any device complain? */
 	if (list_empty(&fail_head))
-		goto enable_and_dump;
+		goto dump;
 
 	if (tried_times >= pci_try_num) {
 		if (enable_local == undefined)
@@ -1449,7 +1449,7 @@ again:
 			dev_info(&bus->dev, "Automatically enabled pci realloc, if you have problem, try booting with pci=realloc=off\n");
 
 		free_list(&fail_head);
-		goto enable_and_dump;
+		goto dump;
 	}
 
 	dev_printk(KERN_DEBUG, &bus->dev,
@@ -1482,10 +1482,7 @@ again:
 
 	goto again;
 
-enable_and_dump:
-	/* Depth last, update the hardware. */
-	pci_enable_bridges(bus);
-
+dump:
 	/* dump the resource on buses */
 	pci_bus_dump_resources(bus);
 }
@@ -1558,7 +1555,6 @@ enable_all:
 	if (retval)
 		dev_err(&bridge->dev, "Error reenabling bridge (%d)\n", retval);
 	pci_set_master(bridge);
-	pci_enable_bridges(parent);
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
 
diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
index 9d3ac99..b2a98cd 100644
--- a/drivers/pcmcia/cardbus.c
+++ b/drivers/pcmcia/cardbus.c
@@ -91,7 +91,6 @@ int __ref cb_alloc(struct pcmcia_socket *s)
 	if (s->tune_bridge)
 		s->tune_bridge(s, bus);
 
-	pci_enable_bridges(bus);
 	pci_bus_add_devices(bus);
 
 	return 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0fd1f15..8cd1e6f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1043,7 +1043,6 @@ int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
 						  resource_size_t,
 						  resource_size_t),
 			void *alignf_data);
-void pci_enable_bridges(struct pci_bus *bus);
 
 /* Proper probing supporting hot-pluggable devices */
 int __must_check __pci_register_driver(struct pci_driver *, struct module *,
-- 
1.8.1.4

