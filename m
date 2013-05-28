Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:23870 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758611Ab3E1Czj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 May 2013 22:55:39 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH] PCI/X86: increase info->res_num before checking pci_use_crs return
Date: Tue, 28 May 2013 10:55:09 +0800
Message-ID: <1369709709-14504-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I separate this patch from patchset "Add hostbridge resource release to
support root bus hotplug in IA64", because it's a Separate issue.

We should increase info->res_num before we checking pci_use_crs return
when pci=nocrs set.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <liuj97@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Feng Tang <feng.tang@intel.com>
---
 arch/x86/pci/acpi.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 3e72425..662dfdf 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -324,14 +324,11 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
 	res->start = start;
 	res->end = end;
 	info->res_offset[info->res_num] = addr.translation_offset;
+	info->res_num++;
 
-	if (!pci_use_crs) {
+	if (!pci_use_crs)
 		dev_printk(KERN_DEBUG, &info->bridge->dev,
 			   "host bridge window %pR (ignored)\n", res);
-		return AE_OK;
-	}
-
-	info->res_num++;
 
 	return AE_OK;
 }
-- 
1.7.1


