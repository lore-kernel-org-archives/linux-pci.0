Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48288 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaAKB2A (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2014 20:28:00 -0500
Received: by mail-pd0-f179.google.com with SMTP id y13so2742919pdi.38
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2014 17:27:59 -0800 (PST)
Subject: [PATCH v2 10/12] PCI: Make local functions static
To: Stephen Hemminger <stephen@networkplumber.org>,
	linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yu Zhao <yu.zhao@intel.com>
Date: Fri, 10 Jan 2014 18:27:57 -0700
Message-ID: <20140111012757.14505.76129.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

Using 'make namespacecheck' identify code which should be declared static.
Checked for users in other driver/archs as well.  Compile tested only.

This stops exporting the following interfaces to modules:

    pci_target_state()
    pci_load_saved_state()

[bhelgaas: retained pci_find_next_ext_capability() and pci_cfg_space_size()]
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h      |    1 
 drivers/pci/hotplug/pciehp_core.c |    2 -
 drivers/pci/pci.c                 |   54 +++++++++---------
 drivers/pci/pci.h                 |    2 -
 drivers/pci/probe.c               |  111 +++++++++++++++++++------------------
 include/linux/pci.h               |    5 --
 6 files changed, 84 insertions(+), 91 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 21e865ded1dc..8de88b052715 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -43,7 +43,6 @@
 extern bool pciehp_poll_mode;
 extern int pciehp_poll_time;
 extern bool pciehp_debug;
-extern bool pciehp_force;
 
 #define dbg(format, arg...)						\
 do {									\
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index bbd48bbe4e9b..67cbd3e90ffd 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -41,7 +41,7 @@
 bool pciehp_debug;
 bool pciehp_poll_mode;
 int pciehp_poll_time;
-bool pciehp_force;
+static bool pciehp_force;
 
 #define DRIVER_VERSION	"0.4"
 #define DRIVER_AUTHOR	"Dan Zink <dan.zink@compaq.com>, Greg Kroah-Hartman <greg@kroah.com>, Dely Sy <dely.l.sy@intel.com>"
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 730471a74fba..57529ffdff20 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -657,6 +657,28 @@ static int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state)
 }
 
 /**
+ * pci_wakeup - Wake up a PCI device
+ * @pci_dev: Device to handle.
+ * @ign: ignored parameter
+ */
+static int pci_wakeup(struct pci_dev *pci_dev, void *ign)
+{
+	pci_wakeup_event(pci_dev);
+	pm_request_resume(&pci_dev->dev);
+	return 0;
+}
+
+/**
+ * pci_wakeup_bus - Walk given bus and wake up devices on it
+ * @bus: Top bus of the subtree to walk.
+ */
+static void pci_wakeup_bus(struct pci_bus *bus)
+{
+	if (bus)
+		pci_walk_bus(bus, pci_wakeup, NULL);
+}
+
+/**
  * __pci_start_power_transition - Start power transition of a PCI device
  * @dev: PCI device to handle.
  * @state: State to put the device into.
@@ -835,8 +857,8 @@ EXPORT_SYMBOL(pci_choose_state);
 #define PCI_EXP_SAVE_REGS	7
 
 
-static struct pci_cap_saved_state *pci_find_saved_cap(
-	struct pci_dev *pci_dev, char cap)
+static struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *pci_dev,
+						      char cap)
 {
 	struct pci_cap_saved_state *tmp;
 
@@ -1071,7 +1093,8 @@ EXPORT_SYMBOL_GPL(pci_store_saved_state);
  * @dev: PCI device that we're dealing with
  * @state: Saved state returned from pci_store_saved_state()
  */
-int pci_load_saved_state(struct pci_dev *dev, struct pci_saved_state *state)
+static int pci_load_saved_state(struct pci_dev *dev,
+				struct pci_saved_state *state)
 {
 	struct pci_cap_saved_data *cap;
 
@@ -1099,7 +1122,6 @@ int pci_load_saved_state(struct pci_dev *dev, struct pci_saved_state *state)
 	dev->state_saved = true;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_load_saved_state);
 
 /**
  * pci_load_and_free_saved_state - Reload the save state pointed to by state,
@@ -1531,27 +1553,6 @@ void pci_pme_wakeup_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_pme_wakeup, (void *)true);
 }
 
-/**
- * pci_wakeup - Wake up a PCI device
- * @pci_dev: Device to handle.
- * @ign: ignored parameter
- */
-static int pci_wakeup(struct pci_dev *pci_dev, void *ign)
-{
-	pci_wakeup_event(pci_dev);
-	pm_request_resume(&pci_dev->dev);
-	return 0;
-}
-
-/**
- * pci_wakeup_bus - Walk given bus and wake up devices on it
- * @bus: Top bus of the subtree to walk.
- */
-void pci_wakeup_bus(struct pci_bus *bus)
-{
-	if (bus)
-		pci_walk_bus(bus, pci_wakeup, NULL);
-}
 
 /**
  * pci_pme_capable - check the capability of PCI device to generate PME#
@@ -1765,7 +1766,7 @@ int pci_wake_from_d3(struct pci_dev *dev, bool enable)
  * If the platform can't manage @dev, return the deepest state from which it
  * can generate wake events, based on any available PME info.
  */
-pci_power_t pci_target_state(struct pci_dev *dev)
+static pci_power_t pci_target_state(struct pci_dev *dev)
 {
 	pci_power_t target_state = PCI_D3hot;
 
@@ -4160,7 +4161,6 @@ EXPORT_SYMBOL(pci_restore_state);
 EXPORT_SYMBOL(pci_pme_capable);
 EXPORT_SYMBOL(pci_pme_active);
 EXPORT_SYMBOL(pci_wake_from_d3);
-EXPORT_SYMBOL(pci_target_state);
 EXPORT_SYMBOL(pci_prepare_to_sleep);
 EXPORT_SYMBOL(pci_back_from_sleep);
 EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9c91ecc1301b..4df38df224f4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -6,7 +6,6 @@
 #define PCI_CFG_SPACE_SIZE	256
 #define PCI_CFG_SPACE_EXP_SIZE	4096
 
-extern const unsigned char pcix_bus_speed[];
 extern const unsigned char pcie_link_speed[];
 
 /* Functions internal to the PCI core code */
@@ -68,7 +67,6 @@ void pci_power_up(struct pci_dev *dev);
 void pci_disable_enabled_device(struct pci_dev *dev);
 int pci_finish_runtime_suspend(struct pci_dev *dev);
 int __pci_pme_wakeup(struct pci_dev *dev, void *ign);
-void pci_wakeup_bus(struct pci_bus *bus);
 void pci_config_pm_runtime_get(struct pci_dev *dev);
 void pci_config_pm_runtime_put(struct pci_dev *dev);
 void pci_pm_init(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a4f53b677185..7fef23ba6bc6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -16,7 +16,7 @@
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
 
-struct resource busn_resource = {
+static struct resource busn_resource = {
 	.name	= "PCI busn",
 	.start	= 0,
 	.end	= 255,
@@ -518,7 +518,7 @@ static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
 	return bridge;
 }
 
-const unsigned char pcix_bus_speed[] = {
+static const unsigned char pcix_bus_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* 0 */
 	PCI_SPEED_66MHz_PCIX,		/* 1 */
 	PCI_SPEED_100MHz_PCIX,		/* 2 */
@@ -999,6 +999,60 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 		pdev->is_hotplug_bridge = 1;
 }
 
+
+/**
+ * pci_cfg_space_size - get the configuration space size of the PCI device.
+ * @dev: PCI device
+ *
+ * Regular PCI devices have 256 bytes, but PCI-X 2 and PCI Express devices
+ * have 4096 bytes.  Even if the device is capable, that doesn't mean we can
+ * access it.  Maybe we don't have a way to generate extended config space
+ * accesses, or the device is behind a reverse Express bridge.  So we try
+ * reading the dword at 0x100 which must either be 0 or a valid extended
+ * capability header.
+ */
+static int pci_cfg_space_size_ext(struct pci_dev *dev)
+{
+	u32 status;
+	int pos = PCI_CFG_SPACE_SIZE;
+
+	if (pci_read_config_dword(dev, pos, &status) != PCIBIOS_SUCCESSFUL)
+		goto fail;
+	if (status == 0xffffffff)
+		goto fail;
+
+	return PCI_CFG_SPACE_EXP_SIZE;
+
+ fail:
+	return PCI_CFG_SPACE_SIZE;
+}
+
+int pci_cfg_space_size(struct pci_dev *dev)
+{
+	int pos;
+	u32 status;
+	u16 class;
+
+	class = dev->class >> 8;
+	if (class == PCI_CLASS_BRIDGE_HOST)
+		return pci_cfg_space_size_ext(dev);
+
+	if (!pci_is_pcie(dev)) {
+		pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+		if (!pos)
+			goto fail;
+
+		pci_read_config_dword(dev, pos + PCI_X_STATUS, &status);
+		if (!(status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ)))
+			goto fail;
+	}
+
+	return pci_cfg_space_size_ext(dev);
+
+ fail:
+	return PCI_CFG_SPACE_SIZE;
+}
+
 #define LEGACY_IO_RESOURCE	(IORESOURCE_IO | IORESOURCE_PCI_FIXED)
 
 /**
@@ -1173,59 +1227,6 @@ static void pci_release_dev(struct device *dev)
 	kfree(pci_dev);
 }
 
-/**
- * pci_cfg_space_size - get the configuration space size of the PCI device.
- * @dev: PCI device
- *
- * Regular PCI devices have 256 bytes, but PCI-X 2 and PCI Express devices
- * have 4096 bytes.  Even if the device is capable, that doesn't mean we can
- * access it.  Maybe we don't have a way to generate extended config space
- * accesses, or the device is behind a reverse Express bridge.  So we try
- * reading the dword at 0x100 which must either be 0 or a valid extended
- * capability header.
- */
-int pci_cfg_space_size_ext(struct pci_dev *dev)
-{
-	u32 status;
-	int pos = PCI_CFG_SPACE_SIZE;
-
-	if (pci_read_config_dword(dev, pos, &status) != PCIBIOS_SUCCESSFUL)
-		goto fail;
-	if (status == 0xffffffff)
-		goto fail;
-
-	return PCI_CFG_SPACE_EXP_SIZE;
-
- fail:
-	return PCI_CFG_SPACE_SIZE;
-}
-
-int pci_cfg_space_size(struct pci_dev *dev)
-{
-	int pos;
-	u32 status;
-	u16 class;
-
-	class = dev->class >> 8;
-	if (class == PCI_CLASS_BRIDGE_HOST)
-		return pci_cfg_space_size_ext(dev);
-
-	if (!pci_is_pcie(dev)) {
-		pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
-		if (!pos)
-			goto fail;
-
-		pci_read_config_dword(dev, pos + PCI_X_STATUS, &status);
-		if (!(status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ)))
-			goto fail;
-	}
-
-	return pci_cfg_space_size_ext(dev);
-
- fail:
-	return PCI_CFG_SPACE_SIZE;
-}
-
 struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index da76c757d0ac..169ef1944d14 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -384,8 +384,6 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 	return (pdev->error_state != pci_channel_io_normal);
 }
 
-extern struct resource busn_resource;
-
 struct pci_host_bridge_window {
 	struct list_head list;
 	struct resource *res;		/* host bridge aperture (CPU address) */
@@ -971,7 +969,6 @@ void __iomem __must_check *pci_platform_rom(struct pci_dev *pdev, size_t *size);
 int pci_save_state(struct pci_dev *dev);
 void pci_restore_state(struct pci_dev *dev);
 struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev);
-int pci_load_saved_state(struct pci_dev *dev, struct pci_saved_state *state);
 int pci_load_and_free_saved_state(struct pci_dev *dev,
 				  struct pci_saved_state **state);
 int __pci_complete_power_transition(struct pci_dev *dev, pci_power_t state);
@@ -982,7 +979,6 @@ void pci_pme_active(struct pci_dev *dev, bool enable);
 int __pci_enable_wake(struct pci_dev *dev, pci_power_t state,
 		      bool runtime, bool enable);
 int pci_wake_from_d3(struct pci_dev *dev, bool enable);
-pci_power_t pci_target_state(struct pci_dev *dev);
 int pci_prepare_to_sleep(struct pci_dev *dev);
 int pci_back_from_sleep(struct pci_dev *dev);
 bool pci_dev_run_wake(struct pci_dev *dev);
@@ -1093,7 +1089,6 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
-int pci_cfg_space_size_ext(struct pci_dev *dev);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);

