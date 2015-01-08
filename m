Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFC Patch 11/19] ACPI: Set flag IORESOURCE_UNSET for unassigned resources
Date: Thu,  8 Jan 2015 10:32:58 +0800
Message-Id: <1420684386-5975-12-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com>
References: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Also set flag IORESOURCE_UNSET for unassigned resource in addition to
IORESOURCE_DISABLED to mark resource as unassigned.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index db444c5cdd0e..26b47f1da523 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -58,7 +58,7 @@ static void acpi_dev_memresource_flags(struct resource *res, u64 len,
 	res->flags = IORESOURCE_MEM;
 
 	if (!acpi_dev_resource_len_valid(res->start, res->end, len, false))
-		res->flags |= IORESOURCE_DISABLED;
+		res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
 
 	if (write_protect == ACPI_READ_WRITE_MEMORY)
 		res->flags |= IORESOURCE_MEM_WRITEABLE;
@@ -126,10 +126,10 @@ static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
 	res->flags = IORESOURCE_IO;
 
 	if (!acpi_dev_resource_len_valid(res->start, res->end, len, true))
-		res->flags |= IORESOURCE_DISABLED;
+		res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
 
 	if (res->end >= 0x10003)
-		res->flags |= IORESOURCE_DISABLED;
+		res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
 
 	if (io_decode == ACPI_DECODE_16)
 		res->flags |= IORESOURCE_IO_16BIT_ADDR;
@@ -303,7 +303,7 @@ static void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
 {
 	res->start = gsi;
 	res->end = gsi;
-	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED;
+	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
 }
 
 static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
-- 
1.7.10.4

