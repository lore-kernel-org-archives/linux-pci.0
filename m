Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:49901 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756383AbbGFXlv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2015 19:41:51 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 24/36] PCI: Only treat non-pef mmio64 as pref if host-bridge has_mem64
Date: Mon,  6 Jul 2015 16:39:14 -0700
Message-Id: <1436225966-27247-25-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If host bridge does not have mmio64 above 4G, We don't need to
treat device non-pref mmio64 as as pref mmio64.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ab7bafe..e8e9029 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1010,7 +1010,7 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 static bool pci_up_path_over_pref_mem64(struct pci_bus *bus)
 {
 	if (pci_is_root_bus(bus))
-		return true;
+		return to_pci_host_bridge(bus->bridge)->has_mem64;
 
 	if (bus->self && !(bus->self->resource[PCI_BRIDGE_RESOURCES + 2].flags &
 			   IORESOURCE_MEM_64))
-- 
1.8.4.5

