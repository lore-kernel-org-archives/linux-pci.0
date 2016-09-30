Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:22816 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750818AbcI3CwJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2016 22:52:09 -0400
From: Cao jin <caoj.fnst@cn.fujitsu.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>, <bigeasy@linutronix.de>
Subject: [PATCH] aer: function comments cleanup
Date: Fri, 30 Sep 2016 10:52:57 +0800
Message-ID: <1475203977-21926-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 drivers/pci/pcie/aer/aerdrv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 48d21e0..20eea86 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -294,7 +294,6 @@ static void aer_remove(struct pcie_device *dev)
 /**
  * aer_probe - initialize resources
  * @dev: pointer to the pcie_dev data structure
- * @id: pointer to the service id data structure
  *
  * Invoked when PCI Express bus loads AER service driver.
  */
-- 
2.1.0



