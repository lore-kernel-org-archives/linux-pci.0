Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:42394 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab2FSNYP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jun 2012 09:24:15 -0400
From: Jiang Liu <jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
CC: Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	<linux-pci@vger.kernel.org>, Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v8 06/12] PCI/ACPI: provide MCFG address for PCI host bridges
Date: Tue, 19 Jun 2012 21:15:26 +0800
Message-ID: <1340111732-6276-7-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340111732-6276-1-git-send-email-jiang.liu@huawei.com>
References: <1340111732-6276-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch provide MCFG address for PCI host bridges, which will
be used to support host bridge hotplug.  It gets MCFG address
by evaluating _CBA method if available, or by scanning the ACPI
MCFG table.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---

v8: add acpi_pci_cache_mcfg() for better readable code and fix a condition
    compilation issue

---
 arch/x86/pci/mmconfig-shared.c |    4 ++
 drivers/acpi/pci_root.c        |   12 ++++++++
 drivers/pci/pci-acpi.c         |   60 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/acnames.h         |    1 +
 include/acpi/acpi_bus.h        |    3 ++
 include/linux/pci-acpi.h       |    5 +++
 6 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 7d1c6bc..94ed360 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/rculist.h>
+#include <linux/pci-acpi.h>
 #include <asm/e820.h>
 #include <asm/pci_x86.h>
 #include <asm/acpi.h>
@@ -675,6 +676,9 @@ static void __init __pci_mmcfg_init(int early)
 		pci_mmcfg_resources_inserted = 1;
 		pci_mmcfg_arch_init_failed = true;
 	}
+
+	if (!early && !known_bridge)
+		acpi_pci_cache_mcfg();
 }
 
 void __init pci_mmcfg_early_init(void)
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7aff631..3ce6a28 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -458,6 +458,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	acpi_handle handle;
 	struct acpi_device *child;
 	u32 flags, base_flags;
+	int end_bus = -1;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
@@ -505,6 +506,17 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	device->driver_data = root;
 
+	root->mcfg_addr = acpi_pci_root_get_mcfg_addr(device->handle,
+		root->segment, (u8) root->secondary.start, &end_bus);
+
+	/*
+	 * End bus number for MCFG may be less than root's subordinary
+	 * bus number with buggy BIOS implementation.
+	 */
+	if (end_bus < 0 || end_bus > root->secondary.end)
+		end_bus = root->secondary.end;
+	root->mcfg_end_bus = (u8) end_bus;
+
 	/*
 	 * All supported architectures that use ACPI have support for
 	 * PCI domains, so we indicate this in _OSC support capabilities.
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 61e2fef..0c6e0bb 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -162,6 +162,66 @@ acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
 	return remove_pm_notifier(dev, pci_acpi_wake_dev);
 }
 
+/* acpi_table_parse() is marked as __init, so cache MCFG info at boot time */
+static int pci_acpi_mcfg_entries;
+static struct acpi_mcfg_allocation *pci_acpi_mcfg_array;
+
+static int __init pci_cache_mcfg(struct acpi_table_header *header)
+{
+	u32 sz;
+	void *ptr;
+
+	if (!header || (header->length <= sizeof(struct acpi_table_mcfg)))
+		return -EINVAL;
+
+	sz = (header->length - sizeof(struct acpi_table_mcfg));
+	pci_acpi_mcfg_array = kmalloc(sz, GFP_KERNEL);
+	if (!pci_acpi_mcfg_array)
+		return -ENOMEM;
+
+	ptr = (void *)header + sizeof(struct acpi_table_mcfg);
+	memcpy(pci_acpi_mcfg_array, ptr, sz);
+	pci_acpi_mcfg_entries = sz / sizeof (struct acpi_mcfg_allocation);
+
+	return 0;
+}
+
+int __init acpi_pci_cache_mcfg(void)
+{
+	acpi_table_parse(ACPI_SIG_MCFG, pci_cache_mcfg);
+	return pci_acpi_mcfg_array ? 0 : -EINVAL;
+}
+
+phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle, u16 seg,
+					u8 start, int *endp)
+{
+	int i, end_bus = -1;
+	acpi_status status = AE_NOT_EXIST;
+	unsigned long long mcfg_addr = 0;
+	struct acpi_mcfg_allocation *cfg;
+
+	if (handle)
+		status = acpi_evaluate_integer(handle, METHOD_NAME__CBA,
+					       NULL, &mcfg_addr);
+	if (ACPI_FAILURE(status) && pci_acpi_mcfg_entries &&
+	    pci_acpi_mcfg_array) {
+		mcfg_addr = 0;
+		cfg = pci_acpi_mcfg_array;
+		for (i = 0; i < pci_acpi_mcfg_entries; i++, cfg++)
+			if (seg == cfg->pci_segment &&
+			    start >= cfg->start_bus_number &&
+			    start <= cfg->end_bus_number) {
+				end_bus = cfg->end_bus_number;
+				mcfg_addr = cfg->address;
+				break;
+			}
+	}
+	if (endp)
+		*endp = end_bus;
+
+	return (phys_addr_t)mcfg_addr;
+}
+
 /*
  * _SxD returns the D-state with the highest power
  * (lowest D-state number) supported in the S-state "x".
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index 38f5088..b177f97 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -62,6 +62,7 @@
 #define METHOD_NAME__AEI        "_AEI"
 #define METHOD_NAME__PRW        "_PRW"
 #define METHOD_NAME__SRS        "_SRS"
+#define METHOD_NAME__CBA        "_CBA"
 
 /* Method names - these methods must appear at the namespace root */
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 9e6e1c6..dc06515 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -401,6 +401,9 @@ struct acpi_pci_root {
 
 	u32 osc_support_set;	/* _OSC state of support bits */
 	u32 osc_control_set;	/* _OSC state of control bits */
+	u8 mcfg_end_bus;	/* End bus for MCFG may differ from
+				 * root's subordinate bus. */
+	phys_addr_t mcfg_addr;
 };
 
 /* helper */
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 4462350..e03207c 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -17,6 +17,9 @@ extern acpi_status pci_acpi_remove_bus_pm_notifier(struct acpi_device *dev);
 extern acpi_status pci_acpi_add_pm_notifier(struct acpi_device *dev,
 					     struct pci_dev *pci_dev);
 extern acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev);
+extern int acpi_pci_cache_mcfg(void);
+extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle,
+			u16 seg, u8 start, int *endp);
 
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 {
@@ -35,6 +38,8 @@ static inline acpi_handle acpi_pci_get_bridge_handle(struct pci_bus *pbus)
 	return acpi_get_pci_rootbridge_handle(pci_domain_nr(pbus),
 					      pbus->number);
 }
+#else
+static inline int acpi_pci_cache_mcfg(void) { return -EINVAL; }
 #endif
 
 #ifdef CONFIG_ACPI_APEI
-- 
1.7.1


