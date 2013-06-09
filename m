Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:34310 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab3FIDsI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 8 Jun 2013 23:48:08 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI: Fix comment typo for pcie_pme_remove()
Date: Sun, 9 Jun 2013 11:47:49 +0800
Message-ID: <1370749669-20348-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix trivial comment typo for pcie_pme_remove().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pcie/pme.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 795db1f..e56e594 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -408,7 +408,7 @@ static int pcie_pme_resume(struct pcie_device *srv)
 
 /**
  * pcie_pme_remove - Prepare PCIe PME service device for removal.
- * @srv - PCIe service device to resume.
+ * @srv - PCIe service device to remove.
  */
 static void pcie_pme_remove(struct pcie_device *srv)
 {
-- 
1.7.1


