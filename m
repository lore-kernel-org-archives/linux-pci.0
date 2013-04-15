Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:24834 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab3DOG75 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2013 02:59:57 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: [PATCH -v2 1/2] PCI: decrease pci_dev->enable_cnt when no pcie capability found
Date: Mon, 15 Apr 2013 14:58:54 +0800
Message-ID: <1366009135-19088-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We should decrease dev->enable_cnt when no pcie port capability
found for balance.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Jiang Liu <jiang.liu@huawei.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 drivers/pci/pcie/portdrv_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 31063ac..aef3fac 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -369,8 +369,8 @@ int pcie_port_device_register(struct pci_dev *dev)
 
 	/* Get and check PCI Express port services */
 	capabilities = get_port_device_capability(dev);
-	if (!capabilities)
-		return 0;
+	if (!capabilities)
+		goto error_disable;
 
 	pci_set_master(dev);
 	/*
-- 
1.7.1


