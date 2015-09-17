Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:13364 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbbIQVWi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 17:22:38 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v1 3/7] PCI: Let kcmdline reserve bus numbers for hotplug
 bridges
Date: Thu, 17 Sep 2015 21:11:04 +0000
Message-ID: <66c9da3f76f74ee5a81473d35777a59b@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This introduces a new kernel command line parameter, "hpbuses", that
allows the user to set how many bus numbers to reserve for hotplug
bridges.  The default value is 0, which means do not reserve any bus
numbers for bridges that are hot-added after enumeration completes.

During device probing, increment a hotplug bridge's subordinate bus
number by the amount set by "hpbuses".  This way, bridges that are
hot-added after enumeration can have buses reserved for them.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 Documentation/kernel-parameters.txt | 2 ++
 drivers/pci/pci.c                   | 5 +++++
 drivers/pci/probe.c                 | 2 ++
 include/linux/pci.h                 | 1 +
 4 files changed, 10 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1d6f045..96948c7 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2815,6 +2815,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 		hpmemsize=nn[KMG]	The fixed amount of bus space which is
 				reserved for hotplug bridge's memory window.
 				Default size is 2 megabytes.
+		hpbuses=nn	Number of bus numbers reserved for hotplug
+				bridges.  Default is 0.
 		realloc=	Enable/disable reallocating PCI bridge resources
 				if allocations done by BIOS are too small to
 				accommodate resources required by all child
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0008c95..c56dd35 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -80,6 +80,8 @@ unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
 /* pci=hpmemsize=nnM,hpiosize=nn can override this */
 unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
 unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
+/* by default, do not reserve any additional buses for hotplug bridges */
+u8 pci_hotplug_buses;
 
 enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
 
@@ -4580,6 +4582,9 @@ static int __init pci_setup(char *str)
 				pci_hotplug_io_size = memparse(str + 9, &str);
 			} else if (!strncmp(str, "hpmemsize=", 10)) {
 				pci_hotplug_mem_size = memparse(str + 10, &str);
+			} else if (!strncmp(str, "hpbuses=", 8)) {
+				if (kstrtou8(str + 8, 0, &pci_hotplug_buses))
+					pci_hotplug_buses = 0;
 			} else if (!strncmp(str, "pcie_bus_tune_off", 17)) {
 				pcie_bus_config = PCIE_BUS_TUNE_OFF;
 			} else if (!strncmp(str, "pcie_bus_safe", 13)) {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 58ae892..553b345 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -930,6 +930,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 		/*
 		 * Set the subordinate bus number to its real value.
 		 */
+		if (child->self->is_hotplug_bridge)
+			max += pci_hotplug_buses;
 		child->subordinate = max;
 		pci_bus_update_busn_res_end(child, child->subordinate);
 		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 384106c..22c6a97 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1637,6 +1637,7 @@ extern u8 pci_cache_line_size;
 
 extern unsigned long pci_hotplug_io_size;
 extern unsigned long pci_hotplug_mem_size;
+extern u8 pci_hotplug_buses;
 
 /* Architecture-specific versions may override these (weak) */
 void pcibios_disable_device(struct pci_dev *dev);
-- 
1.8.3.1

