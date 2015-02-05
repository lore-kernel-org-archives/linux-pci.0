Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v4 04/23] ACPI: Use the length check for io resources as well
Date: Thu,  5 Feb 2015 13:44:30 +0800
Message-Id: <1423115089-12904-5-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
References: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Also apply length check to IO resources.

[Jiang] Remove enforcement that resource starting address must be
non-zero.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |   44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 3e7d9f6eb875..16d291c60277 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -117,31 +117,30 @@ bool acpi_dev_resource_memory(struct acpi_resource *ares, struct resource *res)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_resource_memory);
 
-static unsigned int acpi_dev_ioresource_flags(u64 start, u64 end, u8 io_decode,
-					      bool window)
+static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
+				      u8 io_decode, bool window)
 {
-	int flags = IORESOURCE_IO;
+	res->flags = IORESOURCE_IO;
 
-	if (io_decode == ACPI_DECODE_16)
-		flags |= IORESOURCE_IO_16BIT_ADDR;
+	if (!acpi_dev_resource_len_valid(res->start, res->end, len, true))
+		res->flags |= IORESOURCE_DISABLED;
 
-	if (start > end || end >= 0x10003)
-		flags |= IORESOURCE_DISABLED;
+	if (res->end >= 0x10003)
+		res->flags |= IORESOURCE_DISABLED;
 
-	if (window)
-		flags |= IORESOURCE_WINDOW;
+	if (io_decode == ACPI_DECODE_16)
+		res->flags |= IORESOURCE_IO_16BIT_ADDR;
 
-	return flags;
+	if (window)
+		res->flags |= IORESOURCE_WINDOW;
 }
 
 static void acpi_dev_get_ioresource(struct resource *res, u64 start, u64 len,
 				    u8 io_decode)
 {
-	u64 end = start + len - 1;
-
 	res->start = start;
-	res->end = end;
-	res->flags = acpi_dev_ioresource_flags(start, end, io_decode, false);
+	res->end = start + len - 1;
+	acpi_dev_ioresource_flags(res, len, io_decode, false);
 }
 
 /**
@@ -161,16 +160,12 @@ bool acpi_dev_resource_io(struct acpi_resource *ares, struct resource *res)
 	switch (ares->type) {
 	case ACPI_RESOURCE_TYPE_IO:
 		io = &ares->data.io;
-		if (!io->minimum && !io->address_length)
-			return false;
 		acpi_dev_get_ioresource(res, io->minimum,
 					io->address_length,
 					io->io_decode);
 		break;
 	case ACPI_RESOURCE_TYPE_FIXED_IO:
 		fixed_io = &ares->data.fixed_io;
-		if (!fixed_io->address && !fixed_io->address_length)
-			return false;
 		acpi_dev_get_ioresource(res, fixed_io->address,
 					fixed_io->address_length,
 					ACPI_DECODE_10);
@@ -178,7 +173,8 @@ bool acpi_dev_resource_io(struct acpi_resource *ares, struct resource *res)
 	default:
 		return false;
 	}
-	return true;
+
+	return !(res->flags & IORESOURCE_DISABLED);
 }
 EXPORT_SYMBOL_GPL(acpi_dev_resource_io);
 
@@ -216,9 +212,8 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
 	case ACPI_IO_RANGE:
 		io_decode = addr.address.granularity == 0xfff ?
 				ACPI_DECODE_10 : ACPI_DECODE_16;
-		res->flags = acpi_dev_ioresource_flags(addr.address.minimum,
-						       addr.address.maximum,
-						       io_decode, window);
+		acpi_dev_ioresource_flags(res, addr.address.address_length,
+					  io_decode, window);
 		break;
 	case ACPI_BUS_NUMBER_RANGE:
 		res->flags = IORESOURCE_BUS;
@@ -266,9 +261,8 @@ bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
 	case ACPI_IO_RANGE:
 		io_decode = ext_addr->address.granularity == 0xfff ?
 				ACPI_DECODE_10 : ACPI_DECODE_16;
-		res->flags = acpi_dev_ioresource_flags(ext_addr->address.minimum,
-						       ext_addr->address.maximum,
-						       io_decode, window);
+		acpi_dev_ioresource_flags(res, ext_addr->address.address_length,
+					  io_decode, window);
 		break;
 	case ACPI_BUS_NUMBER_RANGE:
 		res->flags = IORESOURCE_BUS;
-- 
1.7.10.4

