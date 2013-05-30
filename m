Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:37449 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab3E3Ebo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2013 00:31:44 -0400
Received: by mail-pb0-f50.google.com with SMTP id wy17so10354262pbc.37
        for <linux-pci@vger.kernel.org>; Wed, 29 May 2013 21:31:44 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI, IOV: fix a resource leakage on error recovery path
Date: Thu, 30 May 2013 12:31:33 +0800
Message-Id: <1369888293-13387-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1369489718-25869-10-git-send-email-jiang.liu@huawei.com>
References: <1369489718-25869-10-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
Hi Bjorn,
	Could you please help to apply this small patch onto the
jiang-bus-lock-v3, which addresses a memory leakage issue pointed
out by Yinghai? Or you may fold it into " PCI, IOV: simplify IOV 
implementation".
Thanks!
Gerry
---
 drivers/pci/iov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 5eb8165..458fb39 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -122,8 +122,9 @@ failed1:
 	pci_dev_put(dev);
 	mutex_lock(&iov->dev->sriov->lock);
 	pci_stop_and_remove_bus_device(virtfn);
-	virtfn_remove_bus(dev->bus, bus);
 failed0:
+	if (bus)
+		virtfn_remove_bus(dev->bus, bus);
 	mutex_unlock(&iov->dev->sriov->lock);
 
 	return rc;
-- 
1.8.1.2

