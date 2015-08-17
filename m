Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:37885 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbHQKyz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Aug 2015 06:54:55 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <mroos@linux.ee>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
Date: Mon, 17 Aug 2015 18:47:58 +0800
Message-ID: <1439808478-23253-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit d0751b98dfa3 ("PCI: Add dev->has_secondary_link to
track downstream PCIe links")assumed root port is always
the top device in pcie tree. But on sparc64 V245 and T2000
the pcie tree has no root port device in top level, the
upstream port device is connected directly to root bus.
So we may get NULL parent for this upstream port device.

Upstream port ------ Downstream port ------PCIe-PCI bridge

Reported-by: Meelis Roos <mroos@linux.ee>
Tested-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/probe.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 51ebb97..cd54298 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1003,7 +1003,10 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	else if (type == PCI_EXP_TYPE_UPSTREAM ||
 		 type == PCI_EXP_TYPE_DOWNSTREAM) {
 		parent = pci_upstream_bridge(pdev);
-		if (!parent->has_secondary_link)
+		/* For sparc64 V245 and T2000, upstream port may be
+		 * the top level device, connect to root bus directly.
+		 */
+		if (parent && !parent->has_secondary_link)
 			pdev->has_secondary_link = 1;
 	}
 }
-- 
1.7.1

