Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11954 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880AbbBBCk5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 1 Feb 2015 21:40:57 -0500
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
Subject: [Patch v2 08/23] ACPI: Add prefetch decoding to the address space parser
Date: Mon,  2 Feb 2015 10:42:53 +0800
Message-Id: <1422844988-13854-9-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1422844988-13854-1-git-send-email-jiang.liu@linux.intel.com>
References: <1422844988-13854-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Add support of PREFETCH attributre to ACPI address space and extended
address space parser.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 15d17937c431..7ce00a63f695 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -200,6 +200,9 @@ static bool acpi_decode_space(struct resource *res,
 	if (addr->producer_consumer == ACPI_PRODUCER)
 		res->flags |= IORESOURCE_WINDOW;
 
+	if (addr->info.mem.caching == ACPI_PREFETCHABLE_MEMORY)
+		res->flags |= IORESOURCE_PREFETCH;
+
 	return !(res->flags & IORESOURCE_DISABLED);
 }
 
-- 
1.7.10.4

