Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:32863 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966198AbcBDR3W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2016 12:29:22 -0500
Received: by mail-wm0-f54.google.com with SMTP id g62so15093255wme.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Feb 2016 09:29:21 -0800 (PST)
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V4 12/23] x86, ia64, pci: Remove ACPI companion device from platform specific data.
Date: Thu,  4 Feb 2016 18:28:50 +0100
Message-Id: <1454606941-9523-13-git-send-email-tn@semihalf.com>
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since PCI core code is setting ACPI companion device for us now,
platform specific ACPI companion device setting turns out to be dead now.
Therefore we can get rid of it, including related companion reference
from PCI sysdata structure.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/ia64/hp/common/sba_iommu.c    |  2 +-
 arch/ia64/include/asm/pci.h        |  1 -
 arch/ia64/pci/pci.c                | 16 ----------------
 arch/ia64/sn/kernel/io_acpi_init.c |  4 ++--
 arch/x86/include/asm/pci.h         |  3 ---
 arch/x86/pci/acpi.c                | 17 -----------------
 6 files changed, 3 insertions(+), 40 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index a6d6190..78e4444 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -1981,7 +1981,7 @@ sba_connect_bus(struct pci_bus *bus)
 	if (PCI_CONTROLLER(bus)->iommu)
 		return;
 
-	handle = acpi_device_handle(PCI_CONTROLLER(bus)->companion);
+	handle = acpi_device_handle(ACPI_COMPANION(bus->bridge));
 	if (!handle)
 		return;
 
diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index 07039d1..5050748 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -65,7 +65,6 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 #define pci_legacy_write platform_pci_legacy_write
 
 struct pci_controller {
-	struct acpi_device *companion;
 	void *iommu;
 	int segment;
 	int node;		/* nearest node with memory or NUMA_NO_NODE for global allocation */
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 8f6ac2f..978d6af 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -301,28 +301,12 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	}
 
 	info->controller.segment = root->segment;
-	info->controller.companion = device;
 	info->controller.node = acpi_get_node(device->handle);
 	INIT_LIST_HEAD(&info->io_resources);
 	return acpi_pci_root_create(root, &pci_acpi_root_ops,
 				    &info->common, &info->controller);
 }
 
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
-{
-	/*
-	 * We pass NULL as parent to pci_create_root_bus(), so if it is not NULL
-	 * here, pci_create_root_bus() has been called by someone else and
-	 * sysdata is likely to be different from what we expect.  Let it go in
-	 * that case.
-	 */
-	if (!bridge->dev.parent) {
-		struct pci_controller *controller = bridge->bus->sysdata;
-		ACPI_COMPANION_SET(&bridge->dev, controller->companion);
-	}
-	return 0;
-}
-
 void pcibios_fixup_device_resources(struct pci_dev *dev)
 {
 	int idx;
diff --git a/arch/ia64/sn/kernel/io_acpi_init.c b/arch/ia64/sn/kernel/io_acpi_init.c
index 0640739..bcfddc2 100644
--- a/arch/ia64/sn/kernel/io_acpi_init.c
+++ b/arch/ia64/sn/kernel/io_acpi_init.c
@@ -132,7 +132,7 @@ sn_get_bussoft_ptr(struct pci_bus *bus)
 	struct acpi_resource_vendor_typed *vendor;
 
 
-	handle = acpi_device_handle(PCI_CONTROLLER(bus)->companion);
+	handle = acpi_device_handle(ACPI_COMPANION(bus->bridge));
 	status = acpi_get_vendor_resource(handle, METHOD_NAME__CRS,
 					  &sn_uuid, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -360,7 +360,7 @@ sn_acpi_get_pcidev_info(struct pci_dev *dev, struct pcidev_info **pcidev_info,
 	acpi_status status;
 	struct acpi_buffer name_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
-	rootbus_handle = acpi_device_handle(PCI_CONTROLLER(dev)->companion);
+	rootbus_handle = acpi_device_handle(ACPI_COMPANION(dev->bus->bridge));
         status = acpi_evaluate_integer(rootbus_handle, METHOD_NAME__SEG, NULL,
                                        &segment);
         if (ACPI_SUCCESS(status)) {
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 4625943..a98c022 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -14,9 +14,6 @@
 struct pci_sysdata {
 	int		domain;		/* PCI domain */
 	int		node;		/* NUMA node */
-#ifdef CONFIG_ACPI
-	struct acpi_device *companion;	/* ACPI companion device */
-#endif
 #ifdef CONFIG_X86_64
 	void		*iommu;		/* IOMMU private data */
 #endif
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 8e89921..d5086d1 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -341,7 +341,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		struct pci_sysdata sd = {
 			.domain = domain,
 			.node = node,
-			.companion = root->device
 		};
 
 		memcpy(bus->sysdata, &sd, sizeof(sd));
@@ -356,7 +355,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		else {
 			info->sd.domain = domain;
 			info->sd.node = node;
-			info->sd.companion = root->device;
 			bus = acpi_pci_root_create(root, &acpi_pci_root_ops,
 						   &info->common, &info->sd);
 		}
@@ -374,21 +372,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	return bus;
 }
 
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
-{
-	/*
-	 * We pass NULL as parent to pci_create_root_bus(), so if it is not NULL
-	 * here, pci_create_root_bus() has been called by someone else and
-	 * sysdata is likely to be different from what we expect.  Let it go in
-	 * that case.
-	 */
-	if (!bridge->dev.parent) {
-		struct pci_sysdata *sd = bridge->bus->sysdata;
-		ACPI_COMPANION_SET(&bridge->dev, sd->companion);
-	}
-	return 0;
-}
-
 int __init pci_acpi_init(void)
 {
 	struct pci_dev *dev = NULL;
-- 
1.9.1

