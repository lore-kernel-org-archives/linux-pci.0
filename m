Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:63995 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254AbaE2HCs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 May 2014 03:02:48 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 3/3] edac: remove the unnecessary checking for pci_bus_add_device
Date: Thu, 29 May 2014 15:01:06 +0800
Message-ID: <1401346866-11648-4-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1401346866-11648-1-git-send-email-wangyijing@huawei.com>
References: <1401346866-11648-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Pci_bus_add_device() always return 0, remove the unnecessary
checking for pci_bus_add_device().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/edac/i82875p_edac.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/i82875p_edac.c b/drivers/edac/i82875p_edac.c
index 8d0450b..8705ba6 100644
--- a/drivers/edac/i82875p_edac.c
+++ b/drivers/edac/i82875p_edac.c
@@ -293,12 +293,7 @@ static int i82875p_setup_overfl_dev(struct pci_dev *pdev,
 		if (dev == NULL)
 			return 1;
 
-		err = pci_bus_add_device(dev);
-		if (err) {
-			i82875p_printk(KERN_ERR,
-				"%s(): pci_bus_add_device() Failed\n",
-				__func__);
-		}
+		pci_bus_add_device(dev);
 		pci_bus_assign_resources(dev->bus);
 	}
 
-- 
1.7.1


