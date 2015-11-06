Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59671 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1033190AbbKFNWw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 6 Nov 2015 08:22:52 -0500
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
To: Tomasz Nowicki <tn@semihalf.com>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <1444804182-6596-5-git-send-email-jiang.liu@linux.intel.com>
 <563B65EE.7000406@semihalf.com> <20151105181959.GA352@red-moon>
 <563C6A5F.5030500@linux.intel.com> <563C82FA.7050707@semihalf.com>
 <563C930F.4060206@linux.intel.com> <563C9FBE.2090303@semihalf.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <563CA9A6.7050309@linux.intel.com>
Date: Fri, 6 Nov 2015 21:22:46 +0800
MIME-Version: 1.0
In-Reply-To: <563C9FBE.2090303@semihalf.com>
Content-Type: multipart/mixed;
 boundary="------------070805030300030602060601"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070805030300030602060601
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 2015/11/6 20:40, Tomasz Nowicki wrote:
> On 06.11.2015 12:46, Jiang Liu wrote:
>> On 2015/11/6 18:37, Tomasz Nowicki wrote:
>>> On 06.11.2015 09:52, Jiang Liu wrote:
>>> Sure, ARM64 (0-16M IO space) QEMU example:
>>> DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
>>>           0x00000000,         // Granularity
>>>           0x00000000,         // Range Minimum
>>>           0x0000FFFF,         // Range Maximum
>>>           0x3EFF0000,         // Translation Offset
>>>           0x00010000,         // Length
>>>           ,, , TypeStatic)
>> The above DWordIO resource descriptor doesn't confirm to the ACPI spec.
>> According to my understanding, ARM/ARM64 has no concept of IO port
>> address space, so the PCI host bridge will map IO port on PCI side
>> onto MMIO on host side. In other words, PCI host bridge on ARM64
>> implement a IO Port->MMIO translation instead of a IO Port->IO Port
>> translation. If that's true, it should use 'TypeTranslation' instead
>> of 'TypeStatic'. And kernel ACPI resource parsing interface doesn't
>> support 'TypeTranslation' yet, so we need to find a solution for it.
> 
> I think you are right, we need TypeTranslation flag for ARM64 DWordIO
> descriptors and an extra kernel patch to support it.
How about the attached to patch to support TypeTranslation?
It only passes compilation:)

> 
> Thanks,
> Tomasz

--------------070805030300030602060601
Content-Type: text/x-patch;
 name="0001-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-.patch"

>From 51f5cddd8c4301b731805074ebc3e3a6c7dbaf59 Mon Sep 17 00:00:00 2001
From: Liu Jiang <jiang.liu@linux.intel.com>
Date: Fri, 6 Nov 2015 20:01:59 +0800
Subject: [PATCH]


Signed-off-by: Liu Jiang <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c      |   25 +++++++++++++++++++++++--
 include/linux/resource_ext.h |    7 +++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index cdc5c2599beb..1bd3e21f56fe 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -215,8 +215,29 @@ static bool acpi_decode_space(struct resource_win *win,
 	else if (attr->translation_offset)
 		pr_debug("ACPI: translation_offset(%lld) is invalid for non-bridge device.\n",
 			 attr->translation_offset);
-	start = attr->minimum + offset;
-	end = attr->maximum + offset;
+	start = attr->minimum;
+	end = attr->maximum;
+
+	/*
+	 * Convert bus local address into system global address if it's an
+	 * IO Port->IO Port or MMIO->MMIO translation.
+	 */
+	switch (addr->resource_type) {
+	case ACPI_MEMORY_RANGE:
+		if (addr->info.mem.translation)
+			win->translation_type = RESOURCE_TRANS_MMIO_TO_IOPORT;
+		else
+			start += offset;
+		break;
+	case ACPI_IO_RANGE:
+		if (addr->info.io.translation)
+			win->translation_type = RESOURCE_TRANS_IOPORT_TO_MMIO;
+		else
+			start += offset;
+		break;
+	default:
+		break;
+	}
 
 	win->offset = offset;
 	res->start = start;
diff --git a/include/linux/resource_ext.h b/include/linux/resource_ext.h
index e2bf63d881d4..f06d358c1f22 100644
--- a/include/linux/resource_ext.h
+++ b/include/linux/resource_ext.h
@@ -22,8 +22,15 @@
 struct resource_win {
 	struct resource res;		/* In master (CPU) address space */
 	resource_size_t offset;		/* Translation offset for bridge */
+	int translation_type;		/* Translation type for bridge */
 };
 
+#define RESOURCE_TRANS_SAME		0x0
+/* Translate from IO port on slave into MMIO on master */
+#define RESOURCE_TRANS_IOPORT_TO_MMIO	0x1
+/* Translate from MMIO on slave into IO port on master */
+#define RESOURCE_TRANS_MMIO_TO_IOPORT	0x2
+
 /*
  * Common resource list management data structure and interfaces to support
  * ACPI, PNP and PCI host bridge etc.
-- 
1.7.10.4


--------------070805030300030602060601--
