Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:54003 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761Ab3L0V1i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Dec 2013 16:27:38 -0500
Received: by mail-pa0-f51.google.com with SMTP id fa1so9692027pad.38
        for <linux-pci@vger.kernel.org>; Fri, 27 Dec 2013 13:27:37 -0800 (PST)
Date: Fri, 27 Dec 2013 13:27:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH pci-next 1/2] pci: make local function static
Message-ID: <20131227132734.2aa9bc16@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Using 'make namespacecheck' identify code which should be
declared static. Checked for users in other driver/archs as well.
Compile tested only.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

---
Patch against next branch of pci git

 drivers/pci/access.c              |    3 -
 drivers/pci/hotplug/pciehp.h      |    1 
 drivers/pci/hotplug/pciehp_core.c |    2 
 drivers/pci/pci.c                 |   56 +++++++++----------
 drivers/pci/pci.h                 |    2 
 drivers/pci/probe.c               |  111 +++++++++++++++++++-------------------
 include/linux/pci.h               |    9 ---
 7 files changed, 86 insertions(+), 98 deletions(-)

--- a/drivers/pci/pci.c	2013-12-27 12:51:57.592814680 -0800
+++ b/drivers/pci/pci.c	2013-12-27 13:00:54.784294985 -0800
@@ -265,7 +265,7 @@ int pci_bus_find_capability(struct pci_b
  * not support it.  Some capabilities can occur several times, e.g., the
  * vendor-specific capability, and this provides a way to find them all.
  */
-int pci_find_next_ext_capability(struct pci_dev *dev, int start, int cap)
+static int pci_find_next_ext_capability(struct pci_dev *dev, int start, int cap)
 {
 	u32 header;
 	int ttl;
@@ -304,7 +304,6 @@ int pci_find_next_ext_capability(struct
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
 
 /**
  * pci_find_ext_capability - Find an extended capability
@@ -683,6 +682,28 @@ static int pci_platform_power_transition
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
@@ -873,7 +894,8 @@ static struct pci_cap_saved_state *_pci_
 	return NULL;
 }
 
-struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap)
+static struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev,
+						      char cap)
 {
 	return _pci_find_saved_cap(dev, cap, false);
 }
@@ -1110,7 +1132,8 @@ EXPORT_SYMBOL_GPL(pci_store_saved_state)
  * @dev: PCI device that we're dealing with
  * @state: Saved state returned from pci_store_saved_state()
  */
-int pci_load_saved_state(struct pci_dev *dev, struct pci_saved_state *state)
+static int pci_load_saved_state(struct pci_dev *dev,
+				struct pci_saved_state *state)
 {
 	struct pci_cap_saved_data *cap;
 
@@ -1138,7 +1161,6 @@ int pci_load_saved_state(struct pci_dev
 	dev->state_saved = true;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_load_saved_state);
 
 /**
  * pci_load_and_free_saved_state - Reload the save state pointed to by state,
@@ -1570,27 +1592,6 @@ void pci_pme_wakeup_bus(struct pci_bus *
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
@@ -1804,7 +1805,7 @@ int pci_wake_from_d3(struct pci_dev *dev
  * If the platform can't manage @dev, return the deepest state from which it
  * can generate wake events, based on any available PME info.
  */
-pci_power_t pci_target_state(struct pci_dev *dev)
+static pci_power_t pci_target_state(struct pci_dev *dev)
 {
 	pci_power_t target_state = PCI_D3hot;
 
@@ -4482,7 +4483,6 @@ EXPORT_SYMBOL(pci_restore_state);
 EXPORT_SYMBOL(pci_pme_capable);
 EXPORT_SYMBOL(pci_pme_active);
 EXPORT_SYMBOL(pci_wake_from_d3);
-EXPORT_SYMBOL(pci_target_state);
 EXPORT_SYMBOL(pci_prepare_to_sleep);
 EXPORT_SYMBOL(pci_back_from_sleep);
 EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
--- a/include/linux/pci.h	2013-12-27 12:51:57.592814680 -0800
+++ b/include/linux/pci.h	2013-12-27 13:03:11.518137906 -0800
@@ -386,8 +386,6 @@ static inline int pci_channel_offline(st
 	return (pdev->error_state != pci_channel_io_normal);
 }
 
-extern struct resource busn_resource;
-
 struct pci_host_bridge_window {
 	struct list_head list;
 	struct resource *res;		/* host bridge aperture (CPU address) */
@@ -799,7 +797,6 @@ enum pci_lost_interrupt_reason pci_lost_
 int pci_find_capability(struct pci_dev *dev, int cap);
 int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
 int pci_find_ext_capability(struct pci_dev *dev, int cap);
-int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
 int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
@@ -864,7 +861,6 @@ static inline int pci_write_config_dword
 int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
 int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val);
 int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val);
-int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val);
 int pcie_capability_clear_and_set_word(struct pci_dev *dev, int pos,
 				       u16 clear, u16 set);
 int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
@@ -974,10 +970,8 @@ void __iomem __must_check *pci_platform_
 int pci_save_state(struct pci_dev *dev);
 void pci_restore_state(struct pci_dev *dev);
 struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev);
-int pci_load_saved_state(struct pci_dev *dev, struct pci_saved_state *state);
 int pci_load_and_free_saved_state(struct pci_dev *dev,
 				  struct pci_saved_state **state);
-struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap);
 struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
 						   u16 cap);
 int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size);
@@ -991,7 +985,6 @@ void pci_pme_active(struct pci_dev *dev,
 int __pci_enable_wake(struct pci_dev *dev, pci_power_t state,
 		      bool runtime, bool enable);
 int pci_wake_from_d3(struct pci_dev *dev, bool enable);
-pci_power_t pci_target_state(struct pci_dev *dev);
 int pci_prepare_to_sleep(struct pci_dev *dev);
 int pci_back_from_sleep(struct pci_dev *dev);
 bool pci_dev_run_wake(struct pci_dev *dev);
@@ -1126,8 +1119,6 @@ int pci_scan_bridge(struct pci_bus *bus,
 
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
-int pci_cfg_space_size_ext(struct pci_dev *dev);
-int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
--- a/drivers/pci/hotplug/pciehp.h	2013-12-27 12:51:57.592814680 -0800
+++ b/drivers/pci/hotplug/pciehp.h	2013-12-27 12:51:59.328787022 -0800
@@ -43,7 +43,6 @@
 extern bool pciehp_poll_mode;
 extern int pciehp_poll_time;
 extern bool pciehp_debug;
-extern bool pciehp_force;
 
 #define dbg(format, arg...)						\
 do {									\
--- a/drivers/pci/hotplug/pciehp_core.c	2013-12-27 12:51:57.592814680 -0800
+++ b/drivers/pci/hotplug/pciehp_core.c	2013-12-27 12:51:59.328787022 -0800
@@ -41,7 +41,7 @@
 bool pciehp_debug;
 bool pciehp_poll_mode;
 int pciehp_poll_time;
-bool pciehp_force;
+static bool pciehp_force;
 
 #define DRIVER_VERSION	"0.4"
 #define DRIVER_AUTHOR	"Dan Zink <dan.zink@compaq.com>, Greg Kroah-Hartman <greg@kroah.com>, Dely Sy <dely.l.sy@intel.com>"
--- a/drivers/pci/access.c	2013-12-27 12:51:57.592814680 -0800
+++ b/drivers/pci/access.c	2013-12-27 13:00:54.784294985 -0800
@@ -622,7 +622,7 @@ int pcie_capability_write_word(struct pc
 }
 EXPORT_SYMBOL(pcie_capability_write_word);
 
-int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val)
+static int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val)
 {
 	if (pos & 3)
 		return -EINVAL;
@@ -632,7 +632,6 @@ int pcie_capability_write_dword(struct p
 
 	return pci_write_config_dword(dev, pci_pcie_cap(dev) + pos, val);
 }
-EXPORT_SYMBOL(pcie_capability_write_dword);
 
 int pcie_capability_clear_and_set_word(struct pci_dev *dev, int pos,
 				       u16 clear, u16 set)
--- a/drivers/pci/pci.h	2013-12-27 12:51:57.592814680 -0800
+++ b/drivers/pci/pci.h	2013-12-27 13:05:34.731886981 -0800
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
--- a/drivers/pci/probe.c	2013-12-27 13:00:54.784294985 -0800
+++ b/drivers/pci/probe.c	2013-12-27 13:05:46.163709361 -0800
@@ -16,7 +16,7 @@
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
 
-struct resource busn_resource = {
+static struct resource busn_resource = {
 	.name	= "PCI busn",
 	.start	= 0,
 	.end	= 255,
@@ -518,7 +518,7 @@ static struct pci_host_bridge *pci_alloc
 	return bridge;
 }
 
-const unsigned char pcix_bus_speed[] = {
+static const unsigned char pcix_bus_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* 0 */
 	PCI_SPEED_66MHz_PCIX,		/* 1 */
 	PCI_SPEED_100MHz_PCIX,		/* 2 */
@@ -999,6 +999,60 @@ void set_pcie_hotplug_bridge(struct pci_
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
+static int pci_cfg_space_size(struct pci_dev *dev)
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
@@ -1190,59 +1244,6 @@ static void pci_release_dev(struct devic
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
