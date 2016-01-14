Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:26580 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbcANHI3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2016 02:08:29 -0500
From: Jayachandran C <jchandra@broadcom.com>
To: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Jayachandran C <jchandra@broadcom.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH v6 2/5] PCI: Handle ACPI companion and domain number
Date: Thu, 14 Jan 2016 13:02:38 +0530
Message-ID: <1452756761-29584-3-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1452756761-29584-1-git-send-email-jchandra@broadcom.com>
References: <1452756761-29584-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_create_root_bus is called with NULL as parent in ACPI. This
ends up calling pci_bus_assign_domain_nr with a NULL parent, which
crashes when dereferencing parent.

Fix this by providing a way to set the ACPI domain number and ACPI
companion in PCI code. We define pci_acpi_set_companion() to set
the ACPI companion pointer and acpi_pci_get_segment() and to get
the PCI domain number. This is just defined for the generic ACPI
PCI controller, using the corresponding sysdata.

pci_bus_assign_domain_nr is updated to call acpi_pci_get_segment()
to get the domain number to set on the root bus, in case of ACPI.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/pci/pci.c        | 15 ++++++++++++++-
 drivers/pci/probe.c      |  2 ++
 include/linux/pci-acpi.h | 28 +++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 314db8c..39d2bcc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -20,6 +20,7 @@
 #include <linux/string.h>
 #include <linux/log2.h>
 #include <linux/pci-aspm.h>
+#include <linux/pci-acpi.h>
 #include <linux/pm_wakeup.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
@@ -4772,9 +4773,21 @@ int pci_get_new_domain_nr(void)
 void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 {
 	static int use_dt_domains = -1;
-	int domain = of_get_pci_domain_nr(parent->of_node);
+	int domain;
 
 	/*
+	 * Handle ACPI early
+	 *
+	 * The companion is not set at this point, and ACPI sets parent to
+	 * NULL, we have to try to get the segment from acpi root info.
+	 */
+	if (!parent || !parent->of_node) {
+		bus->domain_nr = acpi_pci_get_segment(bus->sysdata);
+		return;
+	}
+
+	domain = of_get_pci_domain_nr(parent->of_node);
+	/*
 	 * Check DT domain and use_dt_domains values.
 	 *
 	 * If DT domain property is valid (domain >= 0) and
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index edb1984..5af66496 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/pci-aspm.h>
+#include <linux/pci-acpi.h>
 #include <linux/aer.h>
 #include <linux/acpi.h>
 #include <asm-generic/pci-bridge.h>
@@ -2105,6 +2106,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	bridge->dev.parent = parent;
 	bridge->dev.release = pci_release_host_bridge_dev;
 	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
+	pci_acpi_set_companion(bridge);
 	error = pcibios_root_bridge_prepare(bridge);
 	if (error) {
 		kfree(bridge);
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index e9450ef..f8d62e3 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -138,12 +138,38 @@ extern struct list_head pci_mmcfg_list;
 
 #define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
 #define PCI_MMCFG_OFFSET(bus, devfn)   ((bus) << 20 | (devfn) << 12)
-
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
 #endif	/* CONFIG_ACPI */
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_ACPI_PCI_HOST_GENERIC)
+static inline void pci_acpi_set_companion(struct pci_host_bridge *bridge)
+{
+	struct pci_bus *b = bridge->bus;
+	struct acpi_pci_root_info *ci = (struct acpi_pci_root_info *)b->sysdata;
+
+	ACPI_COMPANION_SET(&bridge->dev, ci->bridge);
+}
+
+static inline u16 acpi_pci_get_segment(void *sysdata)
+{
+	struct acpi_pci_root_info *ci = (struct acpi_pci_root_info *)sysdata;
+
+	return ci->root->segment;
+}
+#else
+static inline void pci_acpi_set_companion(struct pci_host_bridge *bridge)
+{
+	/* leave it to the platform for now */
+}
+
+static inline u16 acpi_pci_get_segment(void *sysdata)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_ACPI_APEI
 extern bool aer_acpi_firmware_first(void);
 #else
-- 
1.9.1

