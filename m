Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:60064 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499Ab3FFHfk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2013 03:35:40 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yinghai@kernel.org>, <linux-pci@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH -v5 6/8] PCI/IA64: add host bridge resource release for _CRS path
Date: Thu, 6 Jun 2013 15:34:51 +0800
Message-ID: <1370504093-14908-7-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1370504093-14908-1-git-send-email-wangyijing@huawei.com>
References: <1370504093-14908-1-git-send-email-wangyijing@huawei.com>
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
 arch/ia64/pci/pci.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 99a9f67..72a1957 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -369,6 +369,13 @@ static void __release_pci_root_info(struct pci_root_info *info)
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
@@ -446,6 +453,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		return NULL;
 	}
 
+	pci_set_host_bridge_release(to_pci_host_bridge(pbus->bridge),
+			release_pci_root_info, info);
 	pci_scan_child_bus(pbus);
 	return pbus;
 
-- 
1.7.1


