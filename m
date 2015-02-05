Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62564 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756626AbbBEFnE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 Feb 2015 00:43:04 -0500
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v4 14/23] ACPI: Translate resource into master side address for bridge window resources
Date: Thu,  5 Feb 2015 13:44:40 +0800
Message-Id: <1423115089-12904-15-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
References: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add translation_offset into the result address for bridge window
resources to form the master side address.

Currently acpi_dev_resource_{ext_}address_space() are only used for
devices instead of bridges, so it won't break current users. Later
it will be used to support PCI host bridge drivers.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index c902c8eece81..4dc8cfb2e94e 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -205,6 +205,21 @@ static bool acpi_decode_space(struct resource_win *win,
 	res->start = attr->minimum;
 	res->end = attr->maximum;
 
+	/*
+	 * For bridges that translate addresses across the bridge,
+	 * translation_offset is the offset that must be added to the
+	 * address on the secondary side to obtain the address on the
+	 * primary side. Non-bridge devices must list 0 for all Address
+	 * Translation offset bits.
+	 */
+	if (addr->producer_consumer == ACPI_PRODUCER) {
+		res->start += attr->translation_offset;
+		res->end += attr->translation_offset;
+	} else if (attr->translation_offset) {
+		pr_debug("ACPI: translation_offset(%lld) is invalid for non-bridge device.\n",
+			 attr->translation_offset);
+	}
+
 	switch (addr->resource_type) {
 	case ACPI_MEMORY_RANGE:
 		acpi_dev_memresource_flags(res, len, wp);
-- 
1.7.10.4

