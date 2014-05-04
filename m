Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:5438 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbaEDEbm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 4 May 2014 00:31:42 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	<sparclinux@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	<x86@kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 12/13] PCI, pcmcia: Use new pci_is_bridge() to simplify code
Date: Sun, 4 May 2014 12:23:47 +0800
Message-ID: <1399177428-3784-13-git-send-email-wangyijing@huawei.com>
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
 drivers/pcmcia/cardbus.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
index 8bde619..4fe4cc4 100644
--- a/drivers/pcmcia/cardbus.c
+++ b/drivers/pcmcia/cardbus.c
@@ -78,8 +78,7 @@ int __ref cb_alloc(struct pcmcia_socket *s)
 	max = bus->busn_res.start;
 	for (pass = 0; pass < 2; pass++)
 		list_for_each_entry(dev, &bus->devices, bus_list)
-			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+			if (pci_is_bridge(dev))
 				max = pci_scan_bridge(bus, dev, max, pass);
 
 	/*
-- 
1.7.1


