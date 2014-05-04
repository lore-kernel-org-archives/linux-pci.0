Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:3440 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbaEDE0k (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 4 May 2014 00:26:40 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	<sparclinux@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	<x86@kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 09/13] PCI, shpchp: Use new pci_is_bridge() to simplify code
Date: Sun, 4 May 2014 12:23:44 +0800
Message-ID: <1399177428-3784-10-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1399177428-3784-1-git-send-email-wangyijing@huawei.com>
References: <1399177428-3784-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we can use new pci_is_bridge() helper function
to simplify code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/shpchp_pci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
index 2bf69fe..ea8ad31 100644
--- a/drivers/pci/hotplug/shpchp_pci.c
+++ b/drivers/pci/hotplug/shpchp_pci.c
@@ -64,8 +64,7 @@ int __ref shpchp_configure_device(struct slot *p_slot)
 	list_for_each_entry(dev, &parent->devices, bus_list) {
 		if (PCI_SLOT(dev->devfn) != p_slot->device)
 			continue;
-		if ((dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) ||
-		    (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS))
+		if (pci_is_bridge(dev))
 			pci_hp_add_bridge(dev);
 	}
 
-- 
1.7.1


