Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27186 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755999AbbAHCa6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Jan 2015 21:30:58 -0500
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
Subject: [RFC Patch 12/19] ACPI: Enforce stricter checks for address space descriptors
Date: Thu,  8 Jan 2015 10:32:59 +0800
Message-Id: <1420684386-5975-13-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com>
References: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enforce stricter checks for address space descriptors according to
ACPI spec.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 26b47f1da523..e82149e44347 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -192,6 +192,14 @@ static bool acpi_decode_space(struct resource *res,
 	bool wp = base->info.mem.write_protect;
 	u64 len = addr->address_length;
 
+	/*
+	 * Filter out invalid descriptor according to ACPI Spec 5.0, section
+	 * 6.4.3.5 Address Space Resource Descriptors.
+	 */
+	if ((base->min_address_fixed != base->max_address_fixed && len) ||
+	    (base->min_address_fixed && base->max_address_fixed && !len))
+		return false;
+
 	res->start = addr->minimum;
 	res->end = addr->maximum;
 
-- 
1.7.10.4

