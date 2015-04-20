Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62389 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbbDTDGr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 19 Apr 2015 23:06:47 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Bugfix v5] x86/PCI/ACPI: Fix regression caused by commit 63f1789ec716
Date: Mon, 20 Apr 2015 11:08:58 +0800
Message-Id: <1429499338-16967-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

An IO port or MMIO resource assigned to a PCI host bridge may be
consumed by the host bridge itself or available to its child
bus/devices. On x86 and IA64 platforms, all IO port and MMIO
resources are assumed to be available to child bus/devices
except one special case:
    IO port [0xCF8-0xCFF] is consumed by the host bridge itself
    to access PCI configuration space.

But the ACPI and PCI Firmware specifications haven't provided a method
to tell whether a resource is consumed by the host bridge itself.
So before commit 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource
interfaces to simplify implementation"), arch/x86/pci/acpi.c ignored
all IO port resources defined by acpi_resource_io and
acpi_resource_fixed_io to filter out IO ports consumed by the host
bridge itself.

Commit 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource interfaces
to simplify implementation")started accepting all IO port and MMIO
resources, which caused a regression that IO port resources consumed
by the host bridge itself became available to its child devices.

Then commit 63f1789ec716 ("x86/PCI/ACPI: Ignore resources consumed by
host bridge itself") ignored resources consumed by the host bridge
itself by checking the IORESOURCE_WINDOW flag, which accidently removed
MMIO resources defined by acpi_resource_memory24, acpi_resource_memory32
and acpi_resource_fixed_memory32.

So revert to the behavior before v3.19 to fix the regression.

There is also a discussion about ignoring the Producer/Consumer flag on
IA64 platforms at:
http://patchwork.ozlabs.org/patch/461633/

Related ACPI table are archived at:
https://bugzilla.kernel.org/show_bug.cgi?id=94221

Fixes: 63f1789ec716("Ignore resources consumed by host bridge itself")
Reported-by: Bernhard Thaler <bernhard.thaler@wvnet.at>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/pci/acpi.c     |   25 ++++++++++++++++++++++---
 drivers/acpi/resource.c |    6 +++++-
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index e4695985f9de..fc2da98985c3 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -332,12 +332,32 @@ static void probe_pci_root_info(struct pci_root_info *info,
 {
 	int ret;
 	struct resource_entry *entry, *tmp;
+	unsigned long res_flags;
 
 	sprintf(info->name, "PCI Bus %04x:%02x", domain, busnum);
 	info->bridge = device;
+
+	/*
+	 * An IO or MMIO resource assigned to PCI host bridge may be consumed
+	 * by the host bridge itself or available to its child bus/devices.
+	 * On x86 and IA64 platforms, all IO and MMIO resources are assumed to
+	 * be available to child bus/devices except one special case:
+	 *	IO port [0xCF8-0xCFF] is consumed by host bridge itself to
+	 *	access PCI configuration space.
+	 *
+	 * Due to lack of specification to define resources consumed by host
+	 * bridge itself, all IO port resources defined by acpi_resource_io
+	 * and acpi_resource_fixed_io are ignored to filter out IO
+	 * port[0xCF8-0xCFF]. Seems this solution works with all BIOSes, though
+	 * it's not perfect.
+	 *
+	 * Another possible solution is to explicitly filter out IO
+	 * port[0xCF8-0xCFF].
+	 */
+	res_flags = IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_IO_FIXED;
 	ret = acpi_dev_get_resources(device, list,
 				     acpi_dev_filter_resource_type_cb,
-				     (void *)(IORESOURCE_IO | IORESOURCE_MEM));
+				     (void *)res_flags);
 	if (ret < 0)
 		dev_warn(&device->dev,
 			 "failed to parse _CRS method, error code %d\n", ret);
@@ -346,8 +366,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
 			"no IO and memory resources present in _CRS\n");
 	else
 		resource_list_for_each_entry_safe(entry, tmp, list) {
-			if ((entry->res->flags & IORESOURCE_WINDOW) == 0 ||
-			    (entry->res->flags & IORESOURCE_DISABLED))
+			if (entry->res->flags & IORESOURCE_DISABLED)
 				resource_list_destroy_entry(entry);
 			else
 				entry->res->name = info->name;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 5589a6e2a023..79b6d3b5ffd2 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -575,6 +575,9 @@ EXPORT_SYMBOL_GPL(acpi_dev_get_resources);
  *
  * This is a hepler function to support acpi_dev_get_resources(), which filters
  * ACPI resource objects according to resource types.
+ *
+ * Flag IORESOURCE_IO_FIXED is used to opt out io and fixed_io resource
+ * descriptors for ACPI host bridges on x86 and IA64 platforms.
  */
 int acpi_dev_filter_resource_type(struct acpi_resource *ares,
 				  unsigned long types)
@@ -589,7 +592,8 @@ int acpi_dev_filter_resource_type(struct acpi_resource *ares,
 		break;
 	case ACPI_RESOURCE_TYPE_IO:
 	case ACPI_RESOURCE_TYPE_FIXED_IO:
-		type = IORESOURCE_IO;
+		if ((types & IORESOURCE_IO_FIXED) == 0)
+			type = IORESOURCE_IO;
 		break;
 	case ACPI_RESOURCE_TYPE_IRQ:
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
-- 
1.7.10.4

