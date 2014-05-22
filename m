Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:10583 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbaEVDha (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 May 2014 23:37:30 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI: fix return in pci_bus_add_device
Date: Thu, 22 May 2014 11:32:24 +0800
Message-ID: <1400729544-7940-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix device_attach() return vaule in pci_bus_add_device
instead of meaningless 0.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index ba2bf55..42b42b7 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -253,7 +253,7 @@ int pci_bus_add_device(struct pci_dev *dev)
 
 	dev->is_added = 1;
 
-	return 0;
+	return retval;
 }
 
 /**
-- 
1.7.1


