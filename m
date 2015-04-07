Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [RFC 4/7] x86/PCI: Rename struct pci_sysdata as struct pci_controller
Date: Tue,  7 Apr 2015 12:31:09 +0800
Message-Id: <1428381072-27486-5-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1428381072-27486-1-git-send-email-jiang.liu@linux.intel.com>
References: <1428381072-27486-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename struct pci_sysdata as struct pci_controller, so we could share
common code between IA64 and x86 later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/include/asm/pci.h    |   12 ++++++------
 arch/x86/include/asm/pci_64.h |    4 ++--
 arch/x86/pci/acpi.c           |    8 ++++----
 arch/x86/pci/common.c         |    2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 4e370a5d8117..5fcdf53fcd54 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -11,15 +11,15 @@
 
 #ifdef __KERNEL__
 
-struct pci_sysdata {
-	int		domain;		/* PCI domain */
-	int		node;		/* NUMA node */
+struct pci_controller {
 #ifdef CONFIG_ACPI
 	struct acpi_device *companion;	/* ACPI companion device */
 #endif
 #ifdef CONFIG_X86_64
 	void		*iommu;		/* IOMMU private data */
 #endif
+	int		segment;	/* PCI domain */
+	int		node;		/* NUMA node */
 };
 
 extern int pci_routeirq;
@@ -31,8 +31,8 @@ extern int noioapicreroute;
 #ifdef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus)
 {
-	struct pci_sysdata *sd = bus->sysdata;
-	return sd->domain;
+	struct pci_controller *sd = bus->sysdata;
+	return sd->segment;
 }
 
 static inline int pci_proc_domain(struct pci_bus *bus)
@@ -127,7 +127,7 @@ int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 /* Returns the node based on pci bus */
 static inline int __pcibus_to_node(const struct pci_bus *bus)
 {
-	const struct pci_sysdata *sd = bus->sysdata;
+	const struct pci_controller *sd = bus->sysdata;
 
 	return sd->node;
 }
diff --git a/arch/x86/include/asm/pci_64.h b/arch/x86/include/asm/pci_64.h
index fe15cfb21b9b..dcbb6b52d4fd 100644
--- a/arch/x86/include/asm/pci_64.h
+++ b/arch/x86/include/asm/pci_64.h
@@ -6,13 +6,13 @@
 #ifdef CONFIG_CALGARY_IOMMU
 static inline void *pci_iommu(struct pci_bus *bus)
 {
-	struct pci_sysdata *sd = bus->sysdata;
+	struct pci_controller *sd = bus->sysdata;
 	return sd->iommu;
 }
 
 static inline void set_pci_iommu(struct pci_bus *bus, void *val)
 {
-	struct pci_sysdata *sd = bus->sysdata;
+	struct pci_controller *sd = bus->sysdata;
 	sd->iommu = val;
 }
 #endif /* CONFIG_CALGARY_IOMMU */
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 150774be0f3f..e7f35dc84801 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -10,7 +10,7 @@
 struct pci_root_info {
 	struct acpi_device *bridge;
 	char name[16];
-	struct pci_sysdata sd;
+	struct pci_controller sd;
 #ifdef	CONFIG_PCI_MMCONFIG
 	bool mcfg_added;
 	u16 segment;
@@ -366,7 +366,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	LIST_HEAD(crs_res);
 	LIST_HEAD(resources);
 	struct pci_bus *bus;
-	struct pci_sysdata *sd;
+	struct pci_controller *sd;
 	int node;
 
 	if (pci_ignore_seg)
@@ -398,7 +398,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	}
 
 	sd = &info->sd;
-	sd->domain = domain;
+	sd->segment = domain;
 	sd->node = node;
 	sd->companion = device;
 
@@ -464,7 +464,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
-	struct pci_sysdata *sd = bridge->bus->sysdata;
+	struct pci_controller *sd = bridge->bus->sysdata;
 
 	ACPI_COMPANION_SET(&bridge->dev, sd->companion);
 	return 0;
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 2fb384724ebb..e87194bad7e6 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -475,7 +475,7 @@ void __init dmi_check_pciprobe(void)
 void pcibios_scan_root(int busnum)
 {
 	struct pci_bus *bus;
-	struct pci_sysdata *sd;
+	struct pci_controller *sd;
 	LIST_HEAD(resources);
 
 	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
-- 
1.7.10.4

