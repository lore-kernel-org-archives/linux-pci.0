Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:13423 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbbIQVXk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 17:23:40 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v1 6/7] PCI: Use static enumeration to mark a bridge as
 hotpluggable
Date: Thu, 17 Sep 2015 21:11:27 +0000
Message-ID: <81d86f196c1a48edb683d81e989cd001@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With the "enum" kcmdline, the user can mark specific PCI bridges as
hotpluggable, even if those devices do not normally have that
capability.  The user can then use the "hpbuses" kcmdline to reserve
bus numbers for those bridges, to accommodate dynamic PCI device
discovery, including hot-added bridges.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 Documentation/kernel-parameters.txt |  9 +++++
 drivers/pci/pci.h                   |  2 +
 drivers/pci/pci_static_enum.c       | 80 +++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c                 |  1 +
 4 files changed, 92 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 96948c7..3072b70 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2828,6 +2828,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 		pcie_scan_all	Scan all possible PCIe devices.  Otherwise we
 				only look for one device below a PCIe downstream
 				port.
+		enum=		Enable static enumeration, overriding any
+				BIOS/firmware settings.  If "off" then disable
+				all static enumeration.  Otherwise, format is:
+				<bridge>[;<bridge2>...]
+				where <bridge> is <domain>:<bus>:<slot>.<func>.
+				All values are in hexadecimal.
+				Bridges will be marked as hotpluggable, and thus
+				use hpmemsize and hpbuses options to further
+				statically configure them.
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0a37794..e1a1cce 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -337,8 +337,10 @@ struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
 #ifdef CONFIG_PCI_STATIC_ENUMERATION
 void pci_static_enum_set_opt(const char *str);
+void pci_static_enum_bridge(struct pci_bus *bus);
 #else
 static inline void pci_static_enum_set_opt(const char *str) { return; }
+static inline void pci_static_enum_bridge(struct pci_bus *bus) { };
 #endif
 
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pci_static_enum.c b/drivers/pci/pci_static_enum.c
index 2d6cb33..47b7bd5 100644
--- a/drivers/pci/pci_static_enum.c
+++ b/drivers/pci/pci_static_enum.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/pci.h>
 #include <linux/string.h>
 
 #include <asm/setup.h>
@@ -19,6 +20,12 @@
 #define PCI_STATIC_ENUM_PARAM_SIZE COMMAND_LINE_SIZE
 static char pci_static_enum_param[PCI_STATIC_ENUM_PARAM_SIZE] = { 0 };
 
+struct pci_static_enum_setting {
+	int seg;
+	int bus;
+	int devfn;
+};
+
 /**
  * pci_static_enum_set_opt() - set PCI static enumeration options as
  * given by kernel command line
@@ -29,3 +36,76 @@ void __init pci_static_enum_set_opt(const char *str)
 	strncpy(pci_static_enum_param, str, sizeof(pci_static_enum_param));
 	pci_static_enum_param[sizeof(pci_static_enum_param) - 1] = '\0';
 }
+
+/**
+ * pci_static_enum_find_setting() - find requested bridge within options
+ * @bus: bridge to find
+ * @setting: found static enumeration settings
+ * Return: %true if @bus has a static enumeration setting, %false otherwise
+ */
+static bool pci_static_enum_find_setting(struct pci_bus *bus, struct pci_static_enum_setting
+					 *setting)
+{
+	const char *p = pci_static_enum_param;
+	int target_seg = pci_domain_nr(bus);
+	int target_bus = bus->parent->number;
+	int target_devfn = bus->self->devfn;
+
+	pr_debug(PREFIX "Options are: `%s'\n", p);
+	pr_debug(PREFIX "Looking for seg %x bus %x devfn %x\n", target_seg,
+		 target_bus, target_devfn);
+
+	while (*p) {
+		int seg, bus, slot, func;
+		int count = 0;
+
+		if (strncmp(p, "off", 3) == 0)
+			return false;
+
+		if (sscanf(p, "%x:%x:%x.%x%n",
+			   &seg, &bus, &slot, &func, &count) != 4
+		    || count == 0) {
+			/* invalid format */
+			pr_err(PREFIX "Can't parse enum parameters: `%s'\n", p);
+			return false;
+		}
+		p += count;
+
+		setting->seg = seg;
+		setting->bus = bus;
+		setting->devfn = PCI_DEVFN(slot, func);
+
+		if (target_seg == setting->seg &&
+		    target_bus == setting->bus &&
+		    target_devfn == setting->devfn)
+			return true;
+
+		/* increment to next field, if any */
+		if (*p == ';')
+			p++;
+	}
+
+	return false;
+}
+
+/**
+ * pci_static_enum_bridge() - mark this bridge as hotpluggable if its
+ * location is specified by kernel command line
+ */
+void pci_static_enum_bridge(struct pci_bus *bus)
+{
+	bool setting_found;
+	struct pci_static_enum_setting setting;
+
+	if (pci_is_root_bus(bus)) {
+		/* cannot reenumerate the root complex */
+		return;
+	}
+	setting_found = pci_static_enum_find_setting(bus, &setting);
+	if (!setting_found)
+		return;
+	pr_info(PREFIX "Overriding %x:%x:%x.%x\n",
+		setting.seg, setting.bus, PCI_SLOT(setting.devfn),
+		PCI_FUNC(setting.devfn));
+	bus->self->is_hotplug_bridge = 1;
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 553b345..7cc80c3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -703,6 +703,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	child->self = bridge;
 	child->bridge = get_device(&bridge->dev);
 	child->dev.parent = child->bridge;
+	pci_static_enum_bridge(child);
 	pci_set_bus_of_node(child);
 	pci_set_bus_speed(child);
 
-- 
1.8.3.1

