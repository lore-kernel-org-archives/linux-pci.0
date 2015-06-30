Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:34416 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbbF3BRq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2015 21:17:46 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 30 Jun 2015 11:17:44 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1A85F3578048
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 11:17:41 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5U1HT0C66125926
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 11:17:38 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5U1H84A005278
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 11:17:08 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V2 2/4] PCI: use u8 to represent pci configuration space pos and cap
Date: Tue, 30 Jun 2015 09:16:42 +0800
Message-Id: <1435627004-6029-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1435627004-6029-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1435627004-6029-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For pci devices complying with PCI LB 3.0, the configuration space size is 256
and the Cap ID is represented by a 8bit field. This means a type of u8 is
enough to represent the Cap's position and ID.

This patch does some clean up for the Cap position and ID by replacing the
int/char type with u8.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/pci.c    |   49 +++++++++++++++++++++++++------------------------
 drivers/pci/probe.c  |    8 ++++----
 drivers/pci/quirks.c |   19 ++++++++++---------
 include/linux/pci.h  |   20 ++++++++++----------
 4 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 24ebb1b..3f7770a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -141,8 +141,8 @@ EXPORT_SYMBOL_GPL(pci_ioremap_bar);
 #endif
 
 
-static int __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
-				   u8 pos, int cap, int *ttl)
+static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
+				   u8 pos, u8 cap, int *ttl)
 {
 	u8 id;
 	u16 ent;
@@ -165,22 +165,22 @@ static int __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
 	return 0;
 }
 
-static int __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
-			       u8 pos, int cap)
+static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
+			       u8 pos, u8 cap)
 {
 	int ttl = PCI_FIND_CAP_TTL;
 
 	return __pci_find_next_cap_ttl(bus, devfn, pos, cap, &ttl);
 }
 
-int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
+u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, u8 cap)
 {
 	return __pci_find_next_cap(dev->bus, dev->devfn,
 				   pos + PCI_CAP_LIST_NEXT, cap);
 }
 EXPORT_SYMBOL_GPL(pci_find_next_capability);
 
-static int __pci_bus_find_cap_start(struct pci_bus *bus,
+static u8 __pci_bus_find_cap_start(struct pci_bus *bus,
 				    unsigned int devfn, u8 hdr_type)
 {
 	u16 status;
@@ -221,9 +221,9 @@ static int __pci_bus_find_cap_start(struct pci_bus *bus,
  *  %PCI_CAP_ID_PCIX         PCI-X
  *  %PCI_CAP_ID_EXP          PCI Express
  */
-int pci_find_capability(struct pci_dev *dev, int cap)
+u8 pci_find_capability(struct pci_dev *dev, u8 cap)
 {
-	int pos;
+	u8 pos;
 
 	pos = __pci_bus_find_cap_start(dev->bus, dev->devfn, dev->hdr_type);
 	if (pos)
@@ -246,9 +246,9 @@ EXPORT_SYMBOL(pci_find_capability);
  * device's PCI configuration space or 0 in case the device does not
  * support it.
  */
-int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap)
+u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, u8 cap)
 {
-	int pos;
+	u8 pos;
 	u8 hdr_type;
 
 	pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE, &hdr_type);
@@ -333,7 +333,7 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap)
 }
 EXPORT_SYMBOL_GPL(pci_find_ext_capability);
 
-static int __pci_find_next_ht_cap(struct pci_dev *dev, int pos, int ht_cap)
+static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 {
 	int rc, ttl = PCI_FIND_CAP_TTL;
 	u8 cap, mask;
@@ -373,7 +373,7 @@ static int __pci_find_next_ht_cap(struct pci_dev *dev, int pos, int ht_cap)
  * NB. To be 100% safe against broken PCI devices, the caller should take
  * steps to avoid an infinite loop.
  */
-int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap)
+u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap)
 {
 	return __pci_find_next_ht_cap(dev, pos + PCI_CAP_LIST_NEXT, ht_cap);
 }
@@ -390,9 +390,9 @@ EXPORT_SYMBOL_GPL(pci_find_next_ht_capability);
  * The address points to the PCI capability, of type PCI_CAP_ID_HT,
  * which has a Hypertransport capability matching @ht_cap.
  */
-int pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
+u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
 {
-	int pos;
+	u8 pos;
 
 	pos = __pci_bus_find_cap_start(dev->bus, dev->devfn, dev->hdr_type);
 	if (pos)
@@ -907,7 +907,7 @@ static struct pci_cap_saved_state *_pci_find_saved_cap(struct pci_dev *pci_dev,
 	return NULL;
 }
 
-struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap)
+struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, u8 cap)
 {
 	return _pci_find_saved_cap(dev, cap, false);
 }
@@ -967,7 +967,7 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 
 static int pci_save_pcix_state(struct pci_dev *dev)
 {
-	int pos;
+	u8 pos;
 	struct pci_cap_saved_state *save_state;
 
 	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
@@ -988,7 +988,8 @@ static int pci_save_pcix_state(struct pci_dev *dev)
 
 static void pci_restore_pcix_state(struct pci_dev *dev)
 {
-	int i = 0, pos;
+	int i = 0;
+	u8 pos;
 	struct pci_cap_saved_state *save_state;
 	u16 *cap;
 
@@ -2068,7 +2069,7 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
  */
 void pci_pm_init(struct pci_dev *dev)
 {
-	int pm;
+	u8 pm;
 	u16 pmc;
 
 	pm_runtime_forbid(&dev->dev);
@@ -2173,7 +2174,7 @@ static int _pci_add_cap_save_buffer(struct pci_dev *dev, u16 cap,
 	return 0;
 }
 
-int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size)
+int pci_add_cap_save_buffer(struct pci_dev *dev, u8 cap, unsigned int size)
 {
 	return _pci_add_cap_save_buffer(dev, cap, false, size);
 }
@@ -3110,7 +3111,7 @@ EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
  */
 void pci_msi_off(struct pci_dev *dev)
 {
-	int pos;
+	u8 pos;
 	u16 control;
 
 	/*
@@ -3182,7 +3183,7 @@ static int pcie_flr(struct pci_dev *dev, int probe)
 
 static int pci_af_flr(struct pci_dev *dev, int probe)
 {
-	int pos;
+	u8 pos;
 	u8 cap;
 
 	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
@@ -3978,7 +3979,7 @@ EXPORT_SYMBOL_GPL(pci_try_reset_bus);
  */
 int pcix_get_max_mmrbc(struct pci_dev *dev)
 {
-	int cap;
+	u8 cap;
 	u32 stat;
 
 	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
@@ -4001,7 +4002,7 @@ EXPORT_SYMBOL(pcix_get_max_mmrbc);
  */
 int pcix_get_mmrbc(struct pci_dev *dev)
 {
-	int cap;
+	u8 cap;
 	u16 cmd;
 
 	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
@@ -4026,7 +4027,7 @@ EXPORT_SYMBOL(pcix_get_mmrbc);
  */
 int pcix_set_mmrbc(struct pci_dev *dev, int mmrbc)
 {
-	int cap;
+	u8 cap;
 	u32 stat, v, o;
 	u16 cmd;
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6675a7a..ea253fa 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -606,7 +606,7 @@ static enum pci_bus_speed agp_speed(int agp3, int agpstat)
 static void pci_set_bus_speed(struct pci_bus *bus)
 {
 	struct pci_dev *bridge = bus->self;
-	int pos;
+	u8 pos;
 
 	pos = pci_find_capability(bridge, PCI_CAP_ID_AGP);
 	if (!pos)
@@ -971,7 +971,7 @@ static void pci_read_irq(struct pci_dev *dev)
 
 void set_pcie_port_type(struct pci_dev *pdev)
 {
-	int pos;
+	u8 pos;
 	u16 reg16;
 
 	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
@@ -1059,7 +1059,7 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
 
 int pci_cfg_space_size(struct pci_dev *dev)
 {
-	int pos;
+	u8 pos;
 	u32 status;
 	u16 class;
 
@@ -1100,7 +1100,7 @@ int pci_setup_device(struct pci_dev *dev)
 	u32 class;
 	u8 hdr_type;
 	struct pci_slot *slot;
-	int pos = 0;
+	u8 pos = 0;
 	struct pci_bus_region region;
 	struct resource *res;
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ad3b62c..fd8a528 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2250,7 +2250,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x9601, quirk_amd_780_apc_msi);
  * return 1 if a HT MSI capability is found and enabled */
 static int msi_ht_cap_enabled(struct pci_dev *dev)
 {
-	int pos, ttl = PCI_FIND_CAP_TTL;
+	u8 pos, ttl = PCI_FIND_CAP_TTL;
 
 	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
 	while (pos && ttl--) {
@@ -2309,7 +2309,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
 /* Force enable MSI mapping capability on HT bridges */
 static void ht_enable_msi_mapping(struct pci_dev *dev)
 {
-	int pos, ttl = PCI_FIND_CAP_TTL;
+	u8 pos, ttl = PCI_FIND_CAP_TTL;
 
 	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
 	while (pos && ttl--) {
@@ -2388,7 +2388,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
 
 static int ht_check_msi_mapping(struct pci_dev *dev)
 {
-	int pos, ttl = PCI_FIND_CAP_TTL;
+	u8 pos, ttl = PCI_FIND_CAP_TTL;
 	int found = 0;
 
 	/* check if there is HT MSI cap or enabled on this device */
@@ -2417,7 +2417,7 @@ static int ht_check_msi_mapping(struct pci_dev *dev)
 static int host_bridge_with_leaf(struct pci_dev *host_bridge)
 {
 	struct pci_dev *dev;
-	int pos;
+	u8 pos;
 	int i, dev_no;
 	int found = 0;
 
@@ -2450,7 +2450,8 @@ static int host_bridge_with_leaf(struct pci_dev *host_bridge)
 
 static int is_end_of_ht_chain(struct pci_dev *dev)
 {
-	int pos, ctrl_off;
+	int ctrl_off;
+	u8 pos;
 	int end = 0;
 	u16 flags, ctrl;
 
@@ -2475,7 +2476,7 @@ out:
 static void nv_ht_enable_msi_mapping(struct pci_dev *dev)
 {
 	struct pci_dev *host_bridge;
-	int pos;
+	u8 pos;
 	int i, dev_no;
 	int found = 0;
 
@@ -2513,7 +2514,7 @@ out:
 
 static void ht_disable_msi_mapping(struct pci_dev *dev)
 {
-	int pos, ttl = PCI_FIND_CAP_TTL;
+	u8 pos, ttl = PCI_FIND_CAP_TTL;
 
 	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
 	while (pos && ttl--) {
@@ -2534,7 +2535,7 @@ static void ht_disable_msi_mapping(struct pci_dev *dev)
 static void __nv_msi_ht_cap_quirk(struct pci_dev *dev, int all)
 {
 	struct pci_dev *host_bridge;
-	int pos;
+	u8 pos;
 	int found;
 
 	if (!pci_msi_enabled())
@@ -3337,7 +3338,7 @@ fs_initcall_sync(pci_apply_final_quirks);
  */
 static int reset_intel_generic_dev(struct pci_dev *dev, int probe)
 {
-	int pos;
+	u8 pos;
 
 	/* only implement PCI_CLASS_SERIAL_USB at present */
 	if (dev->class == PCI_CLASS_SERIAL_USB) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 353db8d..b36de1f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -825,12 +825,12 @@ enum pci_lost_interrupt_reason {
 	PCI_LOST_IRQ_DISABLE_ACPI,
 };
 enum pci_lost_interrupt_reason pci_lost_interrupt(struct pci_dev *dev);
-int pci_find_capability(struct pci_dev *dev, int cap);
-int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
+u8 pci_find_capability(struct pci_dev *dev, u8 cap);
+u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, u8 cap);
 int pci_find_ext_capability(struct pci_dev *dev, int cap);
 int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
-int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
-int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
+u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
+u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 
 struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
@@ -1023,10 +1023,10 @@ int pci_load_saved_state(struct pci_dev *dev,
 			 struct pci_saved_state *state);
 int pci_load_and_free_saved_state(struct pci_dev *dev,
 				  struct pci_saved_state **state);
-struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap);
+struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, u8 cap);
 struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
 						   u16 cap);
-int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size);
+int pci_add_cap_save_buffer(struct pci_dev *dev, u8 cap, unsigned int size);
 int pci_add_ext_cap_save_buffer(struct pci_dev *dev,
 				u16 cap, unsigned int size);
 int __pci_complete_power_transition(struct pci_dev *dev, pci_power_t state);
@@ -1064,7 +1064,7 @@ void set_pcie_port_type(struct pci_dev *pdev);
 void set_pcie_hotplug_bridge(struct pci_dev *pdev);
 
 /* Functions for PCI Hotplug drivers to use */
-int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
+u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, u8 cap);
 unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
 unsigned int pci_rescan_bus(struct pci_bus *bus);
 void pci_lock_rescan_remove(void);
@@ -1404,10 +1404,10 @@ static inline int __pci_register_driver(struct pci_driver *drv,
 static inline int pci_register_driver(struct pci_driver *drv)
 { return 0; }
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
-static inline int pci_find_capability(struct pci_dev *dev, int cap)
+static inline u8 pci_find_capability(struct pci_dev *dev, u8 cap)
 { return 0; }
-static inline int pci_find_next_capability(struct pci_dev *dev, u8 post,
-					   int cap)
+static inline u8 pci_find_next_capability(struct pci_dev *dev, u8 post,
+					   u8 cap)
 { return 0; }
 static inline int pci_find_ext_capability(struct pci_dev *dev, int cap)
 { return 0; }
-- 
1.7.9.5

