Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from p3plsmtps2ded04.prod.phx3.secureserver.net ([208.109.80.198]:53394
        "EHLO p3plsmtps2ded04.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756564AbcILWEn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Sep 2016 18:04:43 -0400
From: Long Li <longli@exchange.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: [PATCH 2/2] pci-hyperv: properly handle device eject
Date: Mon, 12 Sep 2016 16:54:01 -0700
Message-Id: <1473724441-21207-2-git-send-email-longli@exchange.microsoft.com>
In-Reply-To: <1473724441-21207-1-git-send-email-longli@exchange.microsoft.com>
References: <1473724441-21207-1-git-send-email-longli@exchange.microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Long Li <longli@microsoft.com>

A PCI_EJECT message can arrive at the same time we are calling pci_scan_child_bus in the workqueue for the previous PCI_BUS_RELATIONS message, in this case we could potentailly modify the bus from two places. Properly lock the bus access.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 3c2b330..ca77009 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1587,7 +1587,7 @@ static void hv_eject_device_work(struct work_struct *work)
 	pdev = pci_get_domain_bus_and_slot(hpdev->hbus->sysdata.domain, 0,
 					   wslot);
 	if (pdev) {
-		pci_stop_and_remove_bus_device(pdev);
+		pci_stop_and_remove_bus_device_locked(pdev);
 		pci_dev_put(pdev);
 	}
 
-- 
1.8.5.6

