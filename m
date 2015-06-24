Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55298 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbbFXHmA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Jun 2015 03:42:00 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Boszormenyi Zoltan <zboszor@pr.hu>, Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: [Bugfix v2] PCI, ACPI: Fix regressions caused by resource_size_t overflow with 32bit kernel
Date: Wed, 24 Jun 2015 15:43:37 +0800
Message-Id: <1435131817-28167-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since commit 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource
interfaces to simplify implementation"), x86 PCI ACPI host bridge driver
validates ACPI resources by first converting an ACPI resource to
a 'struct resource' structure and then applying checks against the
converted resource structure. The 'start' and 'end' fields in 'struct
resource' are defined to be type of resource_size_t, which may be 32 bits
or 64 bits depending on CONFIG_PHYS_ADDR_T_64BIT.

This may cause incorrect resource validation results with 32 bit kernels
because 64bit ACPI resource descriptors may get truncated when converting
to 32bit 'start' and 'end' fields in 'struct resource'. And eventually
affects PCI resource allocation subsystem and causes some PCI devices
unusable.

So enhance the ACPI resource parsing interfaces to ignore ACPI resource
descriptors with address/offset observe 4G when running in 32bit mode.
This reverts to the behavior before commit 593669c2ac0f.

This issue was triggered on a platform running 32bit kernel with an
ACPI resource descriptor with address range [0x400000000-0xfffffffff].
Please refer to https://lkml.org/lkml/2015/6/19/277 for more information.

Reported-by: Boszormenyi Zoltan <zboszor@pr.hu>
Fixes: 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource interfaces to simplify implementation")
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: stable@vger.kernel.org # 4.0
---

Hi Zoltan,
	Could you please help to test this patch against the latest kernel?
Thanks!
Gerry

---
 drivers/acpi/resource.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 8244f013f210..f1c966e05078 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -193,6 +193,7 @@ static bool acpi_decode_space(struct resource_win *win,
 	u8 iodec = attr->granularity == 0xfff ? ACPI_DECODE_10 : ACPI_DECODE_16;
 	bool wp = addr->info.mem.write_protect;
 	u64 len = attr->address_length;
+	u64 start, end, offset = 0;
 	struct resource *res = &win->res;
 
 	/*
@@ -204,9 +205,6 @@ static bool acpi_decode_space(struct resource_win *win,
 		pr_debug("ACPI: Invalid address space min_addr_fix %d, max_addr_fix %d, len %llx\n",
 			 addr->min_address_fixed, addr->max_address_fixed, len);
 
-	res->start = attr->minimum;
-	res->end = attr->maximum;
-
 	/*
 	 * For bridges that translate addresses across the bridge,
 	 * translation_offset is the offset that must be added to the
@@ -214,12 +212,22 @@ static bool acpi_decode_space(struct resource_win *win,
 	 * primary side. Non-bridge devices must list 0 for all Address
 	 * Translation offset bits.
 	 */
-	if (addr->producer_consumer == ACPI_PRODUCER) {
-		res->start += attr->translation_offset;
-		res->end += attr->translation_offset;
-	} else if (attr->translation_offset) {
+	if (addr->producer_consumer == ACPI_PRODUCER)
+		offset = attr->translation_offset;
+	else if (attr->translation_offset)
 		pr_debug("ACPI: translation_offset(%lld) is invalid for non-bridge device.\n",
 			 attr->translation_offset);
+	start = attr->minimum + offset;
+	end = attr->maximum + offset;
+
+	win->offset = offset;
+	res->start = start;
+	res->end = end;
+	if (sizeof(resource_size_t) < sizeof(u64) &&
+	    (offset != win->offset || start != res->start || end != res->end)) {
+		pr_warn("acpi resource window ([%#llx-%#llx] ignored, not CPU addressable)\n",
+			attr->minimum, attr->maximum);
+		return false;
 	}
 
 	switch (addr->resource_type) {
@@ -236,8 +244,6 @@ static bool acpi_decode_space(struct resource_win *win,
 		return false;
 	}
 
-	win->offset = attr->translation_offset;
-
 	if (addr->producer_consumer == ACPI_PRODUCER)
 		res->flags |= IORESOURCE_WINDOW;
 
-- 
1.7.10.4

