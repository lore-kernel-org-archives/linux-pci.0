Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:53026 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab2JIDGL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2012 23:06:11 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 4/7] PCI, cpqphp: disable ARI forwarding for cpqphp
Date: Tue, 9 Oct 2012 11:03:21 +0800
Message-ID: <1349751804-7476-5-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1349751804-7476-1-git-send-email-wangyijing@huawei.com>
References: <1349751804-7476-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Disable the port ARI forwarding after an ARI device hot removed.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/cpci_hotplug_pci.c |    1 +
 drivers/pci/hotplug/cpqphp_pci.c       |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
index dcc75c7..d59d228 100644
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
@@ -319,6 +319,7 @@ int cpci_unconfigure_slot(struct slot* slot)
 				    PCI_DEVFN(PCI_SLOT(slot->devfn), i));
 		if (dev) {
 			pci_stop_and_remove_bus_device(dev);
+			pci_configure_ari(dev, false);
 			pci_dev_put(dev);
 		}
 	}
diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 09801c6..a818c1a 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -128,6 +128,7 @@ int cpqhp_unconfigure_device(struct pci_func* func)
 		if (temp) {
 			pci_dev_put(temp);
 			pci_stop_and_remove_bus_device(temp);
+			pci_configure_ari(temp, false);
 		}
 	}
 	return 0;
-- 
1.7.1


