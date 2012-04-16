Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:37869 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab2DPJ0R (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 05:26:17 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 16 Apr 2012 14:56:11 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q3G9QCtk2314242
	for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 14:56:12 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q3GEtsoC020408
	for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 20:25:54 +0530
Date: Mon, 16 Apr 2012 17:26:10 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH] Optimize the resource overlap check
Message-ID: <20120416092610.GA28908@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <1334223550-9514-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334223550-9514-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


In coalesce_windows() it tries to check whether the res1 and res2 overlap.
This function do four comparisons, which could be done with one
comparisons.

Also make the resource_check_overlap() a common function for others.

Signed-Off-By: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/x86/pci/acpi.c    |   12 +-----------
 include/linux/ioport.h |    7 +++++++
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 68c3c13..f2bb99e 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -181,13 +181,6 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
 	return AE_OK;
 }

-static bool resource_contains(struct resource *res, resource_size_t point)
-{
-	if (res->start <= point && point <= res->end)
-		return true;
-	return false;
-}
-
 static void coalesce_windows(struct pci_root_info *info, unsigned long type)
 {
 	int i, j;
@@ -208,10 +201,7 @@ static void coalesce_windows(struct pci_root_info *info, unsigned long type)
 			 * our resources no longer match the ACPI _CRS, but
 			 * the kernel resource tree doesn't allow overlaps.
 			 */
-			if (resource_contains(res1, res2->start) ||
-			    resource_contains(res1, res2->end) ||
-			    resource_contains(res2, res1->start) ||
-			    resource_contains(res2, res1->end)) {
+			if (resource_check_overlap(res1, res2)) {
 				res1->start = min(res1->start, res2->start);
 				res1->end = max(res1->end, res2->end);
 				dev_info(&info->bridge->dev,
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index e9bb22c..374259b 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -198,5 +198,12 @@ extern int
 walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
 		void *arg, int (*func)(unsigned long, unsigned long, void *));

+static inline int resource_check_overlap(struct resource *r1,
+                                         struct resource *r2)
+{
+       return (r1->start <= r2->end && r1->end >= r2->start);
+}
+
+
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
-- 
1.7.4.1

-- 
Richard Yang
Help you, Help me

