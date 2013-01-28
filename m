Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58202 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab3A1S4x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 13:56:53 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v2 07/27] PCI: Add software-emulated host bridge
Date: Mon, 28 Jan 2013 19:56:16 +0100
Message-Id: <1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <thierry.reding@avionic-design.de>

[Thomas Petazzoni:
 - Simplify capabilities handling.
 - Move to a separate file.
 - Fix mask used when writing a 4 bytes value.]

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/Kconfig          |    3 +
 drivers/pci/Makefile         |    3 +
 drivers/pci/sw-host-bridge.c |  144 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h          |   23 +++++++
 4 files changed, 173 insertions(+)
 create mode 100644 drivers/pci/sw-host-bridge.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 6d51aa6..f7548e2 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -119,3 +119,6 @@ config PCI_IOAPIC
 config PCI_LABEL
 	def_bool y if (DMI || ACPI)
 	select NLS
+
+config PCI_SW_HOST_BRIDGE
+	bool
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 0c3efcf..44ce914 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -15,6 +15,9 @@ obj-$(CONFIG_PCIEPORTBUS) += pcie/
 
 obj-$(CONFIG_PCI_IOAPIC) += ioapic.o
 
+# Emulated PCI elements
+obj-$(CONFIG_PCI_SW_HOST_BRIDGE) += sw-host-bridge.o
+
 # Build the PCI Hotplug drivers if we were asked to
 obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
 ifdef CONFIG_HOTPLUG_PCI
diff --git a/drivers/pci/sw-host-bridge.c b/drivers/pci/sw-host-bridge.c
new file mode 100644
index 0000000..b5a2aed
--- /dev/null
+++ b/drivers/pci/sw-host-bridge.c
@@ -0,0 +1,144 @@
+/*
+ * Implementation of a simple emulated PCI host bridge.
+ *
+ * Thierry Reding <thierry.reding@avionic-design.de>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+
+int pci_sw_host_bridge_init(struct pci_sw_host_bridge *bridge)
+{
+	unsigned int i;
+
+	if (!bridge)
+		return -EINVAL;
+
+	bridge->vendor = 0x0000;
+	bridge->device = 0x0000;
+
+	bridge->command = 0x0000;
+	bridge->status = PCI_STATUS_CAP_LIST;
+
+	bridge->class = PCI_CLASS_BRIDGE_HOST;
+	bridge->interface = 0x00;
+	bridge->revision = 0x00;
+
+	bridge->bist = 0x00;
+	bridge->header_type = PCI_HEADER_TYPE_NORMAL;
+	bridge->latency_timer = 0x00;
+	bridge->cache_line_size = 0x10;
+
+	for (i = 0; i < 6; i++)
+		bridge->bar[i] = 0x00000000;
+
+	bridge->subsystem_vendor = 0x0000;
+	bridge->subsystem_device = 0x0000;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_sw_host_bridge_init);
+
+int pci_sw_host_bridge_read(struct pci_sw_host_bridge *bridge,
+			    unsigned int where, int size, u32 *value)
+{
+	switch (where & ~3) {
+	case PCI_VENDOR_ID:
+		*value = bridge->device << 16 | bridge->vendor;
+		break;
+
+	case PCI_COMMAND:
+		*value = bridge->status << 16 | bridge->command;
+		break;
+
+	case PCI_STATUS:
+		*value = 0;
+		break;
+
+	case PCI_CLASS_REVISION:
+		*value = bridge->class << 16 | bridge->interface << 8 |
+			 bridge->revision;
+		break;
+
+	case PCI_CACHE_LINE_SIZE:
+		*value = bridge->bist << 24 | bridge->header_type << 16 |
+			 bridge->latency_timer << 8 | bridge->cache_line_size;
+		break;
+
+	case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_5:
+		*value = bridge->bar[((where & ~3) - PCI_BASE_ADDRESS_0) / 4];
+		break;
+
+	case PCI_CARDBUS_CIS:
+		*value = 0;
+		break;
+
+	case PCI_SUBSYSTEM_VENDOR_ID:
+		*value = bridge->subsystem_device << 16 |
+			 bridge->subsystem_vendor;
+		break;
+
+	case PCI_ROM_ADDRESS:
+		*value = 0;
+		break;
+
+	case PCI_INTERRUPT_LINE:
+		break;
+
+	default:
+		*value = 0xffffffff;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	if (size == 2)
+		*value = (*value >> (8 * (where & 3))) & 0xffff;
+	else if (size == 1)
+		*value = (*value >> (8 * (where & 3))) & 0xff;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+EXPORT_SYMBOL_GPL(pci_sw_host_bridge_read);
+
+int pci_sw_host_bridge_write(struct pci_sw_host_bridge *bridge,
+			     unsigned int where, int size, u32 value)
+{
+	u32 mask, reg;
+	int err;
+
+	if (size == 4)
+		mask = 0x0;
+	else if (size == 2)
+		mask = ~(0xffff << ((where & 3) * 8));
+	else if (size == 1)
+		mask = ~(0xff << ((where & 3) * 8));
+	else
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	err = pci_sw_host_bridge_read(bridge, where & ~3, 4, &reg);
+	if (err)
+		return err;
+
+	value = (reg & mask) | value << ((where & 3) * 8);
+
+	switch (where & ~3) {
+	case PCI_COMMAND:
+		bridge->command = value & 0xffff;
+		bridge->status = value >> 16;
+		break;
+
+	case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_5:
+		bridge->bar[((where & ~3) - PCI_BASE_ADDRESS_0) / 4] = value;
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+EXPORT_SYMBOL_GPL(pci_sw_host_bridge_write);
+
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 15472d6..c93e258 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1841,4 +1841,27 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
  */
 struct pci_dev *pci_find_upstream_pcie_bridge(struct pci_dev *pdev);
 
+struct pci_sw_host_bridge {
+	u16 vendor;
+	u16 device;
+	u16 command;
+	u16 status;
+	u16 class;
+	u8 interface;
+	u8 revision;
+	u8 bist;
+	u8 header_type;
+	u8 latency_timer;
+	u8 cache_line_size;
+	u32 bar[6];
+	u16 subsystem_vendor;
+	u16 subsystem_device;
+};
+
+extern int pci_sw_host_bridge_init(struct pci_sw_host_bridge *bridge);
+extern int pci_sw_host_bridge_read(struct pci_sw_host_bridge *bridge,
+				   unsigned int where, int size, u32 *value);
+extern int pci_sw_host_bridge_write(struct pci_sw_host_bridge *bridge,
+				    unsigned int where, int size, u32 value);
+
 #endif /* LINUX_PCI_H */
-- 
1.7.9.5

