Return-Path: <linux-acpi-owner@vger.kernel.org>
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
Date: Mon, 13 Apr 2015 14:38:38 +0800
Message-Id: <1428907118-27099-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <552B4698.4020703@linux.intel.com>
References: <552B4698.4020703@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Before commit 593669c2ac0f("Use common ACPI resource interfaces to
simplify implementation"), arch/x86/pci/acpi.c applies following
rules when parsing ACPI resources for PCI host bridge:
1) Ignore IO port resources defined by acpi_resource_io and
   acpi_resource_fixed_io, which should be used to define resource
   for PCI device instead of PCI bridge.
2) Accept IOMEM resource defined by acpi_resource_memory24,
   acpi_resource_memory32 and acpi_resource_fixed_memory32.
   These IOMEM resources are accepted to workaround some BIOS issue,
   though they should be ignored. For example, PC Engines APU.1C
   platform defines PCI host bridge IOMEM resources as:
                Memory32Fixed (ReadOnly,
                    0x000A0000,         // Address Base
                    0x00020000,         // Address Length
                    )
                Memory32Fixed (ReadOnly,
                    0x00000000,         // Address Base
                    0x00000000,         // Address Length
                    _Y00)
3) Accept all IO port and IOMEM resources defined by
   acpi_resource_address{16,32,64,extended64}, no matter it's marked as
   ACPI_CONSUMER or ACPI_PRODUCER.

Commit 593669c2ac0f("Use common ACPI resource interfaces to
simplify implementation") accept all IO port and IOMEM resources
defined by acpi_resource_io, acpi_resource_fixed_io,
acpi_resource_memory24, acpi_resource_memory32,
acpi_resource_fixed_memory32 and
acpi_resource_address{16,32,64,extended64}, which causes IO port
resources consumed by host bridge itself are listed in to host bridge
resource list.

Then commit 63f1789ec716("Ignore resources consumed by host bridge
itself") ignores resources consumed by host bridge itself by checking
IORESOURCE_WINDOW flag, which accidently removed the workaround in 2)
above for BIOS bug .

So revert to the behavior before v3.19 to fix the regression.

Sample ACPI table are archived at:
https://bugzilla.kernel.org/show_bug.cgi?id=94221

Fixes: 63f1789ec716("Ignore resources consumed by host bridge itself")
Reported-and-Tested-by: Bernhard Thaler <bernhard.thaler@wvnet.at>
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

