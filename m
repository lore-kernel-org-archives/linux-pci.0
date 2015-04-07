Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1880 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753077AbbDGE27 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Apr 2015 00:28:59 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Len Brown <lenb@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: [RFC 1/7] ACPI/PCI: Enhance ACPI core to support sparse IO space
Date: Tue,  7 Apr 2015 12:31:06 +0800
Message-Id: <1428381072-27486-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1428381072-27486-1-git-send-email-jiang.liu@linux.intel.com>
References: <1428381072-27486-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enhance ACPI resource parsing interfaces to support sparse IO space,
which will be used to share common code between x86 and IA64.

Tested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    9 ++++++---
 include/linux/ioport.h  |    1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 0187e0e11bb8..5727c3bf98c9 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -123,7 +123,7 @@ bool acpi_dev_resource_memory(struct acpi_resource *ares, struct resource *res)
 EXPORT_SYMBOL_GPL(acpi_dev_resource_memory);
 
 static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
-				      u8 io_decode)
+				      u8 io_decode, u8 translation_type)
 {
 	res->flags = IORESOURCE_IO;
 
@@ -135,6 +135,8 @@ static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
 
 	if (io_decode == ACPI_DECODE_16)
 		res->flags |= IORESOURCE_IO_16BIT_ADDR;
+	if (translation_type == ACPI_SPARSE_TRANSLATION)
+		res->flags |= IORESOURCE_IO_SPARSE;
 }
 
 static void acpi_dev_get_ioresource(struct resource *res, u64 start, u64 len,
@@ -142,7 +144,7 @@ static void acpi_dev_get_ioresource(struct resource *res, u64 start, u64 len,
 {
 	res->start = start;
 	res->end = start + len - 1;
-	acpi_dev_ioresource_flags(res, len, io_decode);
+	acpi_dev_ioresource_flags(res, len, io_decode, 0);
 }
 
 /**
@@ -227,7 +229,8 @@ static bool acpi_decode_space(struct resource_win *win,
 		acpi_dev_memresource_flags(res, len, wp);
 		break;
 	case ACPI_IO_RANGE:
-		acpi_dev_ioresource_flags(res, len, iodec);
+		acpi_dev_ioresource_flags(res, len, iodec,
+					  addr->info.io.translation_type);
 		break;
 	case ACPI_BUS_NUMBER_RANGE:
 		res->flags = IORESOURCE_BUS;
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 2c5250222278..b9762760ca49 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -94,6 +94,7 @@ struct resource {
 /* PnP I/O specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_IO_16BIT_ADDR	(1<<0)
 #define IORESOURCE_IO_FIXED		(1<<1)
+#define IORESOURCE_IO_SPARSE		(1<<2)
 
 /* PCI ROM control bits (IORESOURCE_BITS) */
 #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
-- 
1.7.10.4

