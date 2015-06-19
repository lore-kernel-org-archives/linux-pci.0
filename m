Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:8886 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbbFSICM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 04:02:12 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 2/3] PCI: Simplify pcie_poll_cmd()
Date: Fri, 19 Jun 2015 15:57:45 +0800
Message-ID: <1434700666-6346-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1434700666-6346-1-git-send-email-wangyijing@huawei.com>
References: <1434700666-6346-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move first slot status read into while to simplify code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 2913f7e..daf54be 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -109,21 +109,17 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (slot_status & PCI_EXP_SLTSTA_CC) {
-		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
-					   PCI_EXP_SLTSTA_CC);
-		return 1;
-	}
-	while (timeout > 0) {
-		msleep(10);
-		timeout -= 10;
+	while (true) {
 		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 		if (slot_status & PCI_EXP_SLTSTA_CC) {
 			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
 						   PCI_EXP_SLTSTA_CC);
 			return 1;
 		}
+		if (timeout < 0)
+			break;
+		msleep(10);
+		timeout -= 10;
 	}
 	return 0;	/* timeout */
 }
-- 
1.7.1

