Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [Patch v4 19/23] x86/PCI: Fix the range check for IO resources
Date: Thu,  5 Feb 2015 13:44:45 +0800
Message-Id: <1423115089-12904-20-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
References: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The range check in setup_res() checks the IO range against
iomem_resource. That's just wrong.

Reworked based on Thomas original patch.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/pci/acpi.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index bb98afd0591e..1d725d99963d 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -283,7 +283,7 @@ static acpi_status setup_resource(struct acpi_resource *acpi_res, void *data)
 	struct acpi_resource_address64 addr;
 	acpi_status status;
 	unsigned long flags;
-	u64 start, orig_end, end;
+	u64 start, orig_end, end, res_end;
 
 	status = resource_to_addr(acpi_res, &addr);
 	if (!ACPI_SUCCESS(status))
@@ -293,8 +293,10 @@ static acpi_status setup_resource(struct acpi_resource *acpi_res, void *data)
 		flags = IORESOURCE_MEM;
 		if (addr.info.mem.caching == ACPI_PREFETCHABLE_MEMORY)
 			flags |= IORESOURCE_PREFETCH;
+		res_end = (u64)iomem_resource.end;
 	} else if (addr.resource_type == ACPI_IO_RANGE) {
 		flags = IORESOURCE_IO;
+		res_end = (u64)ioport_resource.end;
 	} else
 		return AE_OK;
 
@@ -302,7 +304,7 @@ static acpi_status setup_resource(struct acpi_resource *acpi_res, void *data)
 	orig_end = end = addr.address.maximum + addr.address.translation_offset;
 
 	/* Exclude non-addressable range or non-addressable portion of range */
-	end = min(end, (u64)iomem_resource.end);
+	end = min(end, res_end);
 	if (end <= start) {
 		dev_info(&info->bridge->dev,
 			"host bridge window [%#llx-%#llx] "
-- 
1.7.10.4

