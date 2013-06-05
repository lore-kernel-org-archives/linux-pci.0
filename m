Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:31364 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab3FEGFv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jun 2013 02:05:51 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yinghai@kernel.org>, <linux-pci@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v4 8/8] PCI: Replace printks with appropriate pr_*()
Date: Wed, 5 Jun 2013 14:01:57 +0800
Message-ID: <1370412117-12860-9-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1370412117-12860-1-git-send-email-wangyijing@huawei.com>
References: <1370412117-12860-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace deprecated printk(KERN_ERR...) with pr_err() in arch/ia64/pci/pci.c

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/ia64/pci/pci.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index f2139b4..3d26db3 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -157,7 +157,7 @@ new_space (u64 phys_base, int sparse)
 			return i;
 
 	if (num_io_spaces == MAX_IO_SPACES) {
-		printk(KERN_ERR "PCI: Too many IO port spaces "
+		pr_err("PCI: Too many IO port spaces "
 			"(MAX_IO_SPACES=%lu)\n", MAX_IO_SPACES);
 		return ~0;
 	}
@@ -181,8 +181,9 @@ static u64 add_io_space(struct pci_root_info *info,
 	len = strlen(info->name) + 32;
 	iospace = kzalloc(sizeof(*iospace) + len, GFP_KERNEL);
 	if (!iospace) {
-		printk(KERN_ERR "PCI: No memory for %s I/O port space\n",
-			info->name);
+		dev_err(&info->bridge->dev,
+				"PCI: No memory for %s I/O port space\n",
+				info->name);
 		goto out;
 	}
 
@@ -444,8 +445,9 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
-		printk(KERN_WARNING "pci_bus %04x:%02x: "
-				"ignored (out of memory)\n", domain, busnum);
+		dev_err(&device->dev,
+				"pci_bus %04x:%02x: ignored (out of memory)\n",
+				domain, busnum);
 		kfree(controller);
 		return NULL;
 	}
@@ -779,7 +781,7 @@ static void __init set_pci_dfl_cacheline_size(void)
 
 	status = ia64_pal_cache_summary(&levels, &unique_caches);
 	if (status != 0) {
-		printk(KERN_ERR "%s: ia64_pal_cache_summary() failed "
+		pr_err("%s: ia64_pal_cache_summary() failed "
 			"(status=%ld)\n", __func__, status);
 		return;
 	}
@@ -787,7 +789,7 @@ static void __init set_pci_dfl_cacheline_size(void)
 	status = ia64_pal_cache_config_info(levels - 1,
 				/* cache_type (data_or_unified)= */ 2, &cci);
 	if (status != 0) {
-		printk(KERN_ERR "%s: ia64_pal_cache_config_info() failed "
+		pr_err("%s: ia64_pal_cache_config_info() failed "
 			"(status=%ld)\n", __func__, status);
 		return;
 	}
-- 
1.7.1


