Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V6 05/13] acpi, pci: Support IO resources when parsing PCI host bridge resources.
Date: Fri, 15 Apr 2016 19:06:40 +0200
Message-Id: <1460740008-19489-6-git-send-email-tn@semihalf.com>
In-Reply-To: <1460740008-19489-1-git-send-email-tn@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Platforms that have memory mapped IO port (such as ARM64) need special
handling for PCI I/O resources. For host bridge's resource probing case
these resources need to be fixed up with pci_register_io_range/pci_remap_iospace etc.

Furthermore, the same I/O resources need to be released after hotplug
removal so that it can be re-added back by the pci_remap_iospace
function during insertion. Therefore we implement new pci_unmap_iospace call
which unmaps I/O space as the symmetry to pci_remap_iospace.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/pci_root.c | 33 +++++++++++++++++++++++++++++++++
 drivers/pci/pci.c       | 24 ++++++++++++++++++++++++
 include/linux/pci.h     |  1 +
 3 files changed, 58 insertions(+)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d9a70c4..815b6ca 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -742,6 +742,34 @@ next:
 			resource_list_add_tail(entry, resources);
 	}
 }
+static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
+{
+#ifdef PCI_IOBASE
+	struct resource *res = entry->res;
+	resource_size_t cpu_addr = res->start;
+	resource_size_t pci_addr = cpu_addr - entry->offset;
+	resource_size_t length = resource_size(res);
+	unsigned long port;
+
+	if (pci_register_io_range(cpu_addr, length))
+		goto err;
+
+	port = pci_address_to_pio(cpu_addr);
+	if (port == (unsigned long)-1)
+		goto err;
+
+	res->start = port;
+	res->end = port + length - 1;
+	entry->offset = port - pci_addr;
+
+	if (pci_remap_iospace(res, cpu_addr) < 0)
+		goto err;
+	pr_info("Remapped I/O %pa to %pR\n", &cpu_addr, res);
+	return;
+err:
+	res->flags |= IORESOURCE_DISABLED;
+#endif
+}
 
 int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
 {
@@ -763,6 +791,9 @@ int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
 			"no IO and memory resources present in _CRS\n");
 	else {
 		resource_list_for_each_entry_safe(entry, tmp, list) {
+			if (entry->res->flags & IORESOURCE_IO)
+				acpi_pci_root_remap_iospace(entry);
+
 			if (entry->res->flags & IORESOURCE_DISABLED)
 				resource_list_destroy_entry(entry);
 			else
@@ -834,6 +865,8 @@ static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
 
 	resource_list_for_each_entry(entry, &bridge->windows) {
 		res = entry->res;
+		if (res->flags & IORESOURCE_IO)
+			pci_unmap_iospace(res);
 		if (res->parent &&
 		    (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
 			release_resource(res);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 89e9996..c0f8a4e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -26,6 +26,7 @@
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
+#include <linux/vmalloc.h>
 #include <asm/setup.h>
 #include <linux/aer.h>
 #include "pci.h"
@@ -3168,6 +3169,29 @@ int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 #endif
 }
 
+/**
+ *	pci_unmap_iospace - Unmap the memory mapped I/O space
+ *	@res: resource to be unmapped
+ *
+ *	Unmap the CPU virtual address @res from virtual address space.
+ *	Only architectures that have memory mapped IO functions defined
+ *	(and the PCI_IOBASE value defined) should call this function.
+ */
+void  pci_unmap_iospace(struct resource *res)
+{
+#if defined(PCI_IOBASE) && defined(CONFIG_MMU)
+	unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
+
+	unmap_kernel_range(vaddr, resource_size(res));
+#else
+	/*
+	 * This architecture does not have memory mapped I/O space,
+	 * so this function should never be called.
+	 */
+	WARN_ONCE(1, "This architecture does not support memory mapped I/O\n");
+#endif
+}
+
 static void __pci_set_master(struct pci_dev *dev, bool enable)
 {
 	u16 old_cmd, cmd;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c28adb4..df1f33d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1168,6 +1168,7 @@ int pci_register_io_range(phys_addr_t addr, resource_size_t size);
 unsigned long pci_address_to_pio(phys_addr_t addr);
 phys_addr_t pci_pio_to_address(unsigned long pio);
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
+void pci_unmap_iospace(struct resource *res);
 
 static inline pci_bus_addr_t pci_bus_address(struct pci_dev *pdev, int bar)
 {
-- 
1.9.1
