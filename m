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
Subject: [Bugfix] x86/PCI/ACPI: Fix regression caused by commit 63f1789ec716
Date: Mon, 23 Mar 2015 15:22:14 +0800
Message-Id: <1427095334-7430-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 63f1789ec716("Ignore resources consumed by host bridge itself")
tries to ignore resources consumed by PCI host bridge itself by
checking IORESOURCE_WINDOW flag, which causes regression on some
platforms.

For example, PC Engines APU.1C platform defines PCI MMIO resources with
ACPI Memory32Fixed operator as below:
Name (CRES, ResourceTemplate ()
{
    ...
    WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode,
        0x0000,             // Granularity
        0x0D00,             // Range Minimum
        0xFFFF,             // Range Maximum
        0x0000,             // Translation Offset
        0xF300,             // Length
        ,, , TypeStatic)
    Memory32Fixed (ReadOnly,
        0x000A0000,         // Address Base
        0x00020000,         // Address Length
        )
    Memory32Fixed (ReadOnly,
        0x00000000,         // Address Base
        0x00000000,         // Address Length
        _Y00)
})

Memory32Fixed operator doesn't support concept of "producer/consumer"
and it will be treated as "consumer" by the ACPI resource parsing
interface, thus cause regression. So the fix is only to check
"producer/consumer" flag for resources having "producer/consumer" flag.

Another possible fix is to only ignore IO resource consumed by host
bridge and keep IOMEM resource consumed by host bridge, please refer to:
http://www.spinics.net/lists/linux-pci/msg39706.html

Fixes: 63f1789ec716("Ignore resources consumed by host bridge itself")
Reported-by: Bernhard Thaler <bernhard.thaler@wvnet.at>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
Hi Bernhard,
	Could you please also help to test whether this patch works for
you too?
Thanks!
Gerry
---
 arch/x86/pci/acpi.c     |    5 ++---
 drivers/acpi/resource.c |    3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index e4695985f9de..8c4b1201f340 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -337,7 +337,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
 	info->bridge = device;
 	ret = acpi_dev_get_resources(device, list,
 				     acpi_dev_filter_resource_type_cb,
-				     (void *)(IORESOURCE_IO | IORESOURCE_MEM));
+				     (void *)(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_WINDOW));
 	if (ret < 0)
 		dev_warn(&device->dev,
 			 "failed to parse _CRS method, error code %d\n", ret);
@@ -346,8 +346,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
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
index 5589a6e2a023..b0d3f2ceef06 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -606,6 +606,9 @@ int acpi_dev_filter_resource_type(struct acpi_resource *ares,
 	case ACPI_RESOURCE_TYPE_ADDRESS32:
 	case ACPI_RESOURCE_TYPE_ADDRESS64:
 	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
+		if (((types & IORESOURCE_WINDOW) == 0) ^
+		    (ares->data.address.producer_consumer == ACPI_CONSUMER))
+			break;
 		if (ares->data.address.resource_type == ACPI_MEMORY_RANGE)
 			type = IORESOURCE_MEM;
 		else if (ares->data.address.resource_type == ACPI_IO_RANGE)
-- 
1.7.10.4

