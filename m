Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:57391 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbbE0VLK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 17:11:10 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v0 08/13] PCI: Statically specify bus memory regions
Date: Wed, 27 May 2015 20:59:21 +0000
Message-ID: <810549603c0b4ccf8186f7d549a975c5@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In the static enumeration profile, the user may override the memory
space associated with a bus. This is needed so that when a PCI endpoint
is later discovered, it can fit within its upstream bus's memory space
without requiring that the bus's memory be resized (and hence other
device potentially moved).

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 Documentation/kernel-parameters.txt |    2 ++
 drivers/pci/pci.h                   |    2 ++
 drivers/pci/pci_static_enum.c       |   47 +++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c                 |    3 +++
 4 files changed, 54 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index af2ce92..5413155 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2773,6 +2773,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 				and <option> is any combination of:
 				B<secondary>-<subordinate> -
 				  force secondary and subordinate bus numbers
+				M<address>-<address> -
+				  set MMIO memory range
 				All values are in hexadecimal.
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 665c798..db710ac 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -327,6 +327,7 @@ int pci_static_enum_exists(void);
 void pci_static_enum_bus_nums(struct pci_bus *bus);
 int pci_static_enum_get_busnr(struct pci_bus *bus, struct pci_dev *dev,
 			      int default_busnr);
+void pci_static_enum_device(struct pci_dev *dev);
 /**
  * pci_bus_subordinate() - return the subordinate bus number assigned
  * to @dev by the static enumeration profile, or 0 if not set
@@ -344,6 +345,7 @@ static inline int pci_static_enum_get_busnr(struct pci_bus *bus, struct pci_dev
 {
 	return default_busnr;
 }
+static inline void pci_static_enum_device(struct pci_dev *dev) { return; }
 static inline unsigned char pci_bus_subordinate(struct pci_bus *bus)
 {
 	return 0;
diff --git a/drivers/pci/pci_static_enum.c b/drivers/pci/pci_static_enum.c
index dbdc973..9c9ea4a 100644
--- a/drivers/pci/pci_static_enum.c
+++ b/drivers/pci/pci_static_enum.c
@@ -28,6 +28,7 @@ struct pci_static_enum_setting {
 	int devfn;
 	unsigned char secondary_bus;
 	unsigned char subordinate_bus;
+	resource_size_t bridgemem_start, bridgemem_end;
 };
 
 LIST_HEAD(settings_list);
@@ -82,6 +83,7 @@ static int pci_static_enum_parse_options(void)
 		struct pci_static_enum_setting *setting, *tmp;
 		int seg, bus, slot, func;
 		unsigned int secondary_bus, subordinate_bus;
+		resource_size_t start, end;
 		int count = 0, entry_found = 0;
 
 		if (strncmp(p, "off", 3) == 0) {
@@ -133,6 +135,12 @@ static int pci_static_enum_parse_options(void)
 				p += count;
 				setting->secondary_bus = secondary_bus;
 				setting->subordinate_bus = subordinate_bus;
+			} else
+			    if (sscanf(p, "M%llx-%llx%n", &start, &end, &count)
+				== 2 && count > 0) {
+				p += count;
+				setting->bridgemem_start = start;
+				setting->bridgemem_end = end;
 			} else {
 				pr_err(PREFIX "Invalid enum option: `%s'\n", p);
 				return -1;
@@ -249,3 +257,42 @@ int pci_static_enum_get_busnr(struct pci_bus *bus, struct pci_dev *dev,
 		return setting->secondary_bus;
 	return default_num;
 }
+
+/**
+ * pci_static_enum_set_bridge_memory() - override a PCI bridge's
+ * memory base and limit registers, according to its static
+ * enumeration profile
+ * @dev: PCI bridge device to override
+ * @setting: device's static enumeration profile
+ */
+static void pci_static_enum_set_bridge_memory(struct pci_dev *dev, struct pci_static_enum_setting
+					      *setting)
+{
+	u16 mem_base_lo, mem_limit_lo;
+
+	dev_info(&dev->dev, "Overriding memory base and limit to %pa-%pa\n",
+		 &setting->bridgemem_start, &setting->bridgemem_end);
+	mem_base_lo = setting->bridgemem_start >> 16;
+	mem_limit_lo = (setting->bridgemem_end >> 16) & ~0xf;
+	pci_write_config_word(dev, PCI_MEMORY_BASE, mem_base_lo);
+	pci_write_config_word(dev, PCI_MEMORY_LIMIT, mem_limit_lo);
+}
+
+/**
+ * pci_static_enum_device() - override a device's memory
+ * configuration, according to its static enumeration profile
+ * @dev: PCI device to override
+ */
+void pci_static_enum_device(struct pci_dev *dev)
+{
+	struct pci_static_enum_setting *setting;
+
+	/* if dev is a bridge, set its memory regions */
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		setting = pci_static_enum_find_setting(pci_domain_nr(dev->bus),
+						       dev->bus->number,
+						       dev->devfn);
+		if (setting && setting->bridgemem_start)
+			pci_static_enum_set_bridge_memory(dev, setting);
+	}
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b3e7db4..418fb59 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -315,6 +315,9 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
 	unsigned int pos, reg;
 
+	/* Override any memory settings that BIOS may have assigned */
+	pci_static_enum_device(dev);
+
 	for (pos = 0; pos < howmany; pos++) {
 		struct resource *res = &dev->resource[pos];
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
-- 
1.7.9.5
