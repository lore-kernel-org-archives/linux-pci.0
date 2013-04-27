Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:57308 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab3D0JNg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 27 Apr 2013 05:13:36 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>,
	Tony Luck <tony.luck@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-ia64@vger.kernel.org>
Subject: [PATCH 6/7] PCI/IA64: add host bridge resource release for _CRS path
Date: Sat, 27 Apr 2013 17:12:28 +0800
Message-ID: <1367053949-38424-7-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1367053949-38424-1-git-send-email-wangyijing@huawei.com>
References: <1367053949-38424-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Set IA64 host bridge release function to make sure root bridge
related resources get freed during root bus removal.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/pci/pci.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 658030f..2857a83 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -358,6 +358,13 @@ static void __release_pci_root_info(struct pci_root_info *info)
 	kfree(info);
 }
 
+static void release_pci_root_info(struct pci_host_bridge *bridge)
+{
+	struct pci_root_info *info = bridge->release_data;
+
+	__release_pci_root_info(info);
+}
+
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 {
 	struct acpi_device *device = root->device;
@@ -433,7 +440,9 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		__release_pci_root_info(info);
 		return NULL;
 	}
-
+
+	pci_set_host_bridge_release(to_pci_host_bridge(pbus->bridge),
+			release_pci_root_info, info);
 	pci_scan_child_bus(pbus);
 	return pbus;
 
-- 
1.7.1


