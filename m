Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1613 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753785AbbCBJtG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 Mar 2015 04:49:06 -0500
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Voegtle <tv@lio96.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Lv Zheng <lv.zheng@intel.com>
Subject: [Debug 2/2] x86/PCI/ACPI: Gather debug info
Date: Mon,  2 Mar 2015 17:51:38 +0800
Message-Id: <1425289898-22377-3-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1425289898-22377-1-git-send-email-jiang.liu@linux.intel.com>
References: <alpine.LSU.2.11.1503020932210.29400@er-systems.de>
 <1425289898-22377-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 4752b9939987..43de252a75b4 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -46,10 +46,10 @@ static bool acpi_dev_resource_len_valid(u64 start, u64 end, u64 len, bool io)
 	if (len && reslen && reslen == len && start <= end)
 		return true;
 
-	pr_info("ACPI: invalid or unassigned resource %s [%016llx - %016llx] length [%016llx]\n",
+	pr_warn("ACPI: invalid or unassigned resource %s [%016llx - %016llx] length [%016llx]\n",
 		io ? "io" : "mem", start, end, len);
 
-	return false;
+	return reslen != 0;
 }
 
 static void acpi_dev_memresource_flags(struct resource *res, u64 len,
@@ -193,13 +193,14 @@ static bool acpi_decode_space(struct resource_win *win,
 	u64 len = attr->address_length;
 	struct resource *res = &win->res;
 
+	pr_warn("acpi: address space [%llx-%llx] len %llx\n", attr->minimum, attr->maximum, attr->address_length);
 	/*
 	 * Filter out invalid descriptor according to ACPI Spec 5.0, section
 	 * 6.4.3.5 Address Space Resource Descriptors.
 	 */
 	if ((addr->min_address_fixed != addr->max_address_fixed && len) ||
 	    (addr->min_address_fixed && addr->max_address_fixed && !len))
-		pr_debug("ACPI: Invalid address space min_addr_fix %d, max_addr_fix %d, len %llx\n",
+		pr_warn("ACPI: Invalid address space min_addr_fix %d, max_addr_fix %d, len %llx\n",
 			 addr->min_address_fixed, addr->max_address_fixed, len);
 
 	res->start = attr->minimum;
-- 
1.7.10.4

