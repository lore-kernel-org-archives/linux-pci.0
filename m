Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V2 15/23] x86, ia64, pci: Convert arches to use PCI_DOMAINS_GENERIC.
Date: Wed, 16 Dec 2015 16:16:25 +0100
Message-Id: <1450278993-12664-16-git-send-email-tn@semihalf.com>
In-Reply-To: <1450278993-12664-1-git-send-email-tn@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since we have now generic way to retrieve domain number using _SEG method,
x86 and ia64 can take advantage of it and forget about another
platform specific data from pci_sysdata.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/ia64/Kconfig           | 3 +++
 arch/ia64/include/asm/pci.h | 2 --
 arch/ia64/pci/pci.c         | 1 -
 arch/x86/Kconfig            | 3 +++
 arch/x86/include/asm/pci.h  | 7 -------
 arch/x86/pci/acpi.c         | 2 --
 6 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index eb0249e..6fecd04 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -572,6 +572,9 @@ config PCI
 config PCI_DOMAINS
 	def_bool PCI
 
+config PCI_DOMAINS_GENERIC
+	def_bool PCI
+
 config PCI_SYSCALL
 	def_bool PCI
 
diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index 5050748..4214be1 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -66,7 +66,6 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 
 struct pci_controller {
 	void *iommu;
-	int segment;
 	int node;		/* nearest node with memory or NUMA_NO_NODE for global allocation */
 
 	void *platform_data;
@@ -74,7 +73,6 @@ struct pci_controller {
 
 
 #define PCI_CONTROLLER(busdev) ((struct pci_controller *) busdev->sysdata)
-#define pci_domain_nr(busdev)    (PCI_CONTROLLER(busdev)->segment)
 
 extern struct pci_ops pci_root_ops;
 
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 978d6af..fe96bc9 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -300,7 +300,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		return NULL;
 	}
 
-	info->controller.segment = root->segment;
 	info->controller.node = acpi_get_node(device->handle);
 	INIT_LIST_HEAD(&info->io_resources);
 	return acpi_pci_root_create(root, &pci_acpi_root_ops,
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 102d7d1..63cc4b7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2383,6 +2383,9 @@ config PCI_DOMAINS
 	def_bool y
 	depends on PCI
 
+config PCI_DOMAINS_GENERIC
+	def_bool PCI
+
 config PCI_MMCONFIG
 	bool "Support mmconfig PCI config space access"
 	select PCI_ECAM
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index a98c022..1dc1ba1 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -12,7 +12,6 @@
 #ifdef __KERNEL__
 
 struct pci_sysdata {
-	int		domain;		/* PCI domain */
 	int		node;		/* NUMA node */
 #ifdef CONFIG_X86_64
 	void		*iommu;		/* IOMMU private data */
@@ -26,12 +25,6 @@ extern int noioapicreroute;
 #ifdef CONFIG_PCI
 
 #ifdef CONFIG_PCI_DOMAINS
-static inline int pci_domain_nr(struct pci_bus *bus)
-{
-	struct pci_sysdata *sd = bus->sysdata;
-	return sd->domain;
-}
-
 static inline int pci_proc_domain(struct pci_bus *bus)
 {
 	return pci_domain_nr(bus);
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 286e0f5..5f78595 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -331,7 +331,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		 * its bus->sysdata.
 		 */
 		struct pci_sysdata sd = {
-			.domain = domain,
 			.node = node,
 		};
 
@@ -345,7 +344,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 				"pci_bus %04x:%02x: ignored (out of memory)\n",
 				domain, busnum);
 		else {
-			info->sd.domain = domain;
 			info->sd.node = node;
 			bus = acpi_pci_root_create(root, &acpi_pci_root_ops,
 						   &info->common, &info->sd);
-- 
1.9.1

