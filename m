Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:57391 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbbE0VLI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 17:11:08 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v0 06/13] PCI: Set secondary and subordinate bus numbers
Date: Wed, 27 May 2015 20:59:10 +0000
Message-ID: <146310523b594c58b867e5a257b54798@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

By using the static enumeration kcmdline, a user can override secondary
and subordinate bus numbers assigned to child bridges. This includes
adding padding to subordinate bus numbers, to accommodate dynamic PCI
device discovery.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 Documentation/kernel-parameters.txt |    9 ++
 drivers/pci/pci.h                   |    4 +
 drivers/pci/pci_static_enum.c       |  173 +++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c                 |    8 +-
 4 files changed, 193 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 4d68ec8..af2ce92 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2765,6 +2765,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 		pcie_scan_all	Scan all possible PCIe devices.  Otherwise we
 				only look for one device below a PCIe downstream
 				port.
+		enum=		Enable static enumeration, overriding any
+				BIOS/firmware settings.  If "off" then disable
+				all static enumeration. Otherwise format is:
+				<device>@<option>[<option2>...]
+				Where <device> is <domain>:<bus>:<slot>.<func>
+				and <option> is any combination of:
+				B<secondary>-<subordinate> -
+				  force secondary and subordinate bus numbers
+				All values are in hexadecimal.
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3282b51..7a051f5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -323,6 +323,8 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 
 #ifdef CONFIG_PCI_STATIC_ENUMERATION
 void pci_static_enum_set_opt(const char *str);
+int pci_static_enum_exists(void);
+void pci_static_enum_bus_nums(struct pci_bus *bus);
 /**
  * pci_bus_subordinate() - return the subordinate bus number assigned
  * to @dev by the static enumeration profile, or 0 if not set
@@ -333,6 +335,8 @@ static inline unsigned char pci_bus_subordinate(struct pci_bus *bus)
 }
 #else
 static inline void pci_static_enum_set_opt(const char *str) { return; }
+static inline int pci_static_enum_exists(void) { return 0; }
+static inline void pci_static_enum_bus_nums(struct pci_bus *bus) { return; }
 static inline unsigned char pci_bus_subordinate(struct pci_bus *bus)
 {
 	return 0;
diff --git a/drivers/pci/pci_static_enum.c b/drivers/pci/pci_static_enum.c
index a28bd33..dda9055 100644
--- a/drivers/pci/pci_static_enum.c
+++ b/drivers/pci/pci_static_enum.c
@@ -11,6 +11,7 @@
 
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
 
@@ -20,6 +21,18 @@
 
 static DEFINE_SPINLOCK(static_enum_lock);
 
+struct pci_static_enum_setting {
+	struct list_head list;
+	int seg;
+	int bus;
+	int devfn;
+	unsigned char secondary_bus;
+	unsigned char subordinate_bus;
+};
+
+LIST_HEAD(settings_list);
+static int options_parsed;
+
 #define PCI_STATIC_ENUM_PARAM_SIZE COMMAND_LINE_SIZE
 static char pci_static_enum_param[PCI_STATIC_ENUM_PARAM_SIZE] = { 0 };
 
@@ -52,3 +65,163 @@ void __init pci_static_enum_set_opt(const char *str)
 	strncat(pci_static_enum_param + cur, str, len);
 	spin_unlock(&static_enum_lock);
 }
+
+/**
+ * pci_static_enum_parse_options() - parse the static enumeration
+ * options string, creating the linked list of settings
+ * Return: 0 on success, negative on error or if static enumeration is
+ * disabled.
+ */
+static int pci_static_enum_parse_options(void)
+{
+	const char *p = pci_static_enum_param;
+
+	pr_debug(PREFIX "Set options are: %s\n", pci_static_enum_param);
+	options_parsed = 1;
+	while (*p) {
+		struct pci_static_enum_setting *setting, *tmp;
+		int seg, bus, slot, func;
+		unsigned int secondary_bus, subordinate_bus;
+		int count = 0, entry_found = 0;
+
+		if (strncmp(p, "off", 3) == 0) {
+			/* delete existing profile, if any */
+			list_for_each_entry_safe(setting, tmp, &settings_list,
+						 list) {
+				kfree(setting);
+			}
+			INIT_LIST_HEAD(&settings_list);
+			return -1;
+		}
+
+		if (sscanf(p, "%x:%x:%x.%x@%n",
+			   &seg, &bus, &slot, &func, &count) != 4
+		    || count == 0) {
+			/* Invalid format */
+			pr_err(PREFIX "Can't parse enum parameter: `%s'\n", p);
+			return -1;
+		}
+		p += count;
+
+		/* check if an entry already created; if not, make one
+		   and add it to the list */
+		list_for_each_entry(setting, &settings_list, list) {
+			if (setting->seg == seg && setting->bus == bus
+			    && setting->devfn == PCI_DEVFN(slot, func)) {
+				entry_found = 1;
+				break;
+			}
+		}
+
+		if (!entry_found) {
+			setting = kzalloc(sizeof(*setting), GFP_KERNEL);
+			if (!setting) {
+				pr_err(PREFIX "Out of memory\n");
+				return -1;
+			}
+			setting->seg = seg;
+			setting->bus = bus;
+			setting->devfn = PCI_DEVFN(slot, func);
+			list_add(&setting->list, &settings_list);
+		}
+
+		while (*p && *p != ';') {
+			count = 0;
+			if (sscanf
+			    (p, "B%x-%x%n", &secondary_bus, &subordinate_bus,
+			     &count) == 2 && count > 0) {
+				p += count;
+				setting->secondary_bus = secondary_bus;
+				setting->subordinate_bus = subordinate_bus;
+			} else {
+				pr_err(PREFIX "Invalid enum option: `%s'\n", p);
+				return -1;
+			}
+		}
+
+		/* increment to next field, if any */
+		if (*p == ';')
+			p++;
+	}
+
+	return 0;
+}
+
+/**
+ * pci_static_enum_find_setting() - look for the requested PCI
+ * device's setting within the static enumeration settings
+ * @domain: target domain to find
+ * @bus: target bus to find
+ * @devfn: target device and function to find
+ * Return: pointer to found static enumeration settings, or NULL if
+ * not found or on error
+ */
+static struct pci_static_enum_setting *pci_static_enum_find_setting(int domain, unsigned
+								    char
+								    bus,
+								    unsigned int
+								    devfn)
+{
+	struct pci_static_enum_setting *setting = NULL;
+
+	spin_lock(&static_enum_lock);
+	if (!options_parsed && pci_static_enum_parse_options() < 0)
+		goto out;
+
+	list_for_each_entry(setting, &settings_list, list) {
+		if (setting->seg == domain && setting->bus == bus
+		    && setting->devfn == devfn)
+			goto out;
+	}
+
+	/* no static enumeration profile for the requested device */
+	setting = NULL;
+out:
+	spin_unlock(&static_enum_lock);
+	return setting;
+}
+
+/**
+ * pci_static_enum_exists() - returns non-zero if a static enumeration
+ * mapping exists, 0 otherwise
+ */
+int pci_static_enum_exists(void)
+{
+	int retval;
+
+	spin_lock(&static_enum_lock);
+	retval = pci_static_enum_param[0];
+	spin_unlock(&static_enum_lock);
+	return retval;
+}
+
+/**
+ * pci_static_enum_bus_nums() - statically enumerate the secondary and
+ * subordinate bus numbers for the given bus, according to its static
+ * enumeration profile
+ * @bus: bus to reenumerate
+ */
+void pci_static_enum_bus_nums(struct pci_bus *bus)
+{
+	struct pci_static_enum_setting *setting;
+
+	if (pci_is_root_bus(bus)) {
+		/* cannot reenumerate the root complex */
+		return;
+	}
+	setting =
+	    pci_static_enum_find_setting(pci_domain_nr(bus),
+					 bus->parent->number, bus->self->devfn);
+	if (!setting)
+		return;
+	if (setting->secondary_bus == 0) {
+		/* no bus settings specified for this device */
+		return;
+	}
+	pr_info(PREFIX "Overriding %x:%x:%x.%x to bus numbers %x-%x\n",
+		pci_domain_nr(bus), bus->parent->number,
+		PCI_SLOT(bus->self->devfn), PCI_FUNC(bus->self->devfn),
+		setting->secondary_bus, setting->subordinate_bus);
+	bus->number = bus->busn_res.start = setting->secondary_bus;
+	bus->subordinate = setting->subordinate_bus;
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9c3a9b2..a7bf7c5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -704,6 +704,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	child->bridge = get_device(&bridge->dev);
 	child->dev.parent = child->bridge;
 
+	/* if the child bus has a static enumeration profile, override
+	   its bus numbers here */
+	pci_static_enum_bus_nums(child);
+
 	dev_set_name(&child->dev, "%04x:%02x", pci_domain_nr(child),
 		     child->number);
 
@@ -805,6 +809,7 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 	pci_enable_crs(dev);
 
 	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
+	    !pci_static_enum_exists() &&
 	    !is_cardbus && !broken) {
 		unsigned int cmax;
 		/*
@@ -843,7 +848,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken || is_cardbus)
+			if (pcibios_assign_all_busses() || broken ||
+			    is_cardbus || pci_static_enum_exists())
 				/* Temporarily disable forwarding of the
 				   configuration cycles on all bridges in
 				   this bus segment to avoid possible
-- 
1.7.9.5

