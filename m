Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:65267 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaAMI2y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jan 2014 03:28:54 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>,
	"Hanjun Guo" <guohanjun@huawei.com>
Subject: [PATCH] PCI,pciehp: Don't set slot off when found device already exists.
Date: Mon, 13 Jan 2014 16:02:48 +0800
Message-ID: <1389600168-23228-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we found device already exists during hot add device, we should
leave it, not to set slot off.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c |    3 ++-
 drivers/pci/hotplug/pciehp_pci.c  |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 38f0186..f27b0ff 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -224,7 +224,8 @@ static int board_added(struct slot *p_slot)
 	if (retval) {
 		ctrl_err(ctrl, "Cannot add device at %04x:%02x:00\n",
 			 pci_domain_nr(parent), parent->number);
-		goto err_exit;
+		if (retval != -EEXIST)
+			goto err_exit;
 	}
 
 	if (PWR_LED(ctrl))
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index aac7a40..9b87b49 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -48,7 +48,7 @@ int pciehp_configure_device(struct slot *p_slot)
 			 "at %04x:%02x:00, cannot hot-add\n", pci_name(dev),
 			 pci_domain_nr(parent), parent->number);
 		pci_dev_put(dev);
-		return -EINVAL;
+		return -EEXIST;
 	}
 
 	num = pci_scan_slot(parent, PCI_DEVFN(0, 0));
-- 
1.7.1


