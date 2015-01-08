Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>
Subject: [RFC Patch 07/19] ACPI: Move the window flag logic to the combined parser
Date: Thu,  8 Jan 2015 10:32:54 +0800
Message-Id: <1420684386-5975-8-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com>
References: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Normal memory and io resources have window always set to false. Move
the flag logic to the unified address space parser.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index d1ceba02afde..a56a64164410 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -53,7 +53,7 @@ static bool acpi_dev_resource_len_valid(u64 start, u64 end, u64 len, bool io)
 }
 
 static void acpi_dev_memresource_flags(struct resource *res, u64 len,
-				       u8 write_protect, bool window)
+				       u8 write_protect)
 {
 	res->flags = IORESOURCE_MEM;
 
@@ -62,9 +62,6 @@ static void acpi_dev_memresource_flags(struct resource *res, u64 len,
 
 	if (write_protect == ACPI_READ_WRITE_MEMORY)
 		res->flags |= IORESOURCE_MEM_WRITEABLE;
-
-	if (window)
-		res->flags |= IORESOURCE_WINDOW;
 }
 
 static void acpi_dev_get_memresource(struct resource *res, u64 start, u64 len,
@@ -72,7 +69,7 @@ static void acpi_dev_get_memresource(struct resource *res, u64 start, u64 len,
 {
 	res->start = start;
 	res->end = start + len - 1;
-	acpi_dev_memresource_flags(res, len, write_protect, false);
+	acpi_dev_memresource_flags(res, len, write_protect);
 }
 
 /**
@@ -118,7 +115,7 @@ bool acpi_dev_resource_memory(struct acpi_resource *ares, struct resource *res)
 EXPORT_SYMBOL_GPL(acpi_dev_resource_memory);
 
 static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
-				      u8 io_decode, bool window)
+				      u8 io_decode)
 {
 	res->flags = IORESOURCE_IO;
 
@@ -130,9 +127,6 @@ static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
 
 	if (io_decode == ACPI_DECODE_16)
 		res->flags |= IORESOURCE_IO_16BIT_ADDR;
-
-	if (window)
-		res->flags |= IORESOURCE_WINDOW;
 }
 
 static void acpi_dev_get_ioresource(struct resource *res, u64 start, u64 len,
@@ -140,7 +134,7 @@ static void acpi_dev_get_ioresource(struct resource *res, u64 start, u64 len,
 {
 	res->start = start;
 	res->end = start + len - 1;
-	acpi_dev_ioresource_flags(res, len, io_decode, false);
+	acpi_dev_ioresource_flags(res, len, io_decode);
 }
 
 /**
@@ -183,7 +177,6 @@ static bool acpi_decode_space(struct resource *res,
 			      struct acpi_resource_address64_common *addr)
 {
 	u8 iodec = addr->granularity == 0xfff ? ACPI_DECODE_10 : ACPI_DECODE_16;
-	bool window = base->producer_consumer == ACPI_PRODUCER;
 	bool wp = base->info.mem.write_protect;
 	u64 len = addr->address_length;
 
@@ -192,10 +185,10 @@ static bool acpi_decode_space(struct resource *res,
 
 	switch(base->resource_type) {
 	case ACPI_MEMORY_RANGE:
-		acpi_dev_memresource_flags(res, len, wp, window);
+		acpi_dev_memresource_flags(res, len, wp);
 		break;
 	case ACPI_IO_RANGE:
-		acpi_dev_ioresource_flags(res, len, iodec, window);
+		acpi_dev_ioresource_flags(res, len, iodec);
 		break;
 	case ACPI_BUS_NUMBER_RANGE:
 		res->flags = IORESOURCE_BUS;
@@ -204,6 +197,9 @@ static bool acpi_decode_space(struct resource *res,
 		return false;
 	}
 
+	if (base->producer_consumer == ACPI_PRODUCER)
+		res->flags |= IORESOURCE_WINDOW;
+
 	return !(res->flags & IORESOURCE_DISABLED);
 }
 
-- 
1.7.10.4

