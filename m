Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:1092 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746Ab2JIDEd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2012 23:04:33 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 6/7] PCI, sgi: disable ARI forwarding for sgiphp
Date: Tue, 9 Oct 2012 11:03:23 +0800
Message-ID: <1349751804-7476-7-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1349751804-7476-1-git-send-email-wangyijing@huawei.com>
References: <1349751804-7476-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Disable the port ARI forwarding when a ARI device was hot removed.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/sgi_hotplug.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/hotplug/sgi_hotplug.c b/drivers/pci/hotplug/sgi_hotplug.c
index f64ca92..8d02367 100644
--- a/drivers/pci/hotplug/sgi_hotplug.c
+++ b/drivers/pci/hotplug/sgi_hotplug.c
@@ -553,6 +553,7 @@ static int disable_slot(struct hotplug_slot *bss_hotplug_slot)
 		if (dev) {
 			sn_bus_free_data(dev);
 			pci_stop_and_remove_bus_device(dev);
+			pci_configure_ari(dev, false);
 			pci_dev_put(dev);
 		}
 	}
-- 
1.7.1


