Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:59336 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab3D0JQJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 27 Apr 2013 05:16:09 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH 1/7] PCI/X86: fix always use info->res[0] to store _CRS resource when pci=nocrs set
Date: Sat, 27 Apr 2013 17:12:23 +0800
Message-ID: <1367053949-38424-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1367053949-38424-1-git-send-email-wangyijing@huawei.com>
References: <1367053949-38424-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We should increase info->res_num before checking pci_use_crs return, otherwise
only the res[0] of pci_root_info will be used during setup_resource() when
pci=nocrs set. And the old resource value will be overwritten by new resource item.

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


