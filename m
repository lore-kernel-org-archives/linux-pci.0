Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:27875 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965341AbcIPUHp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2016 16:07:45 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v14 16/17] PCI: Only treat non-pref mmio64 as pref if host bridge has mmio64
Date: Fri, 16 Sep 2016 13:02:06 -0700
Message-Id: <20160916200207.21439-17-yinghai@kernel.org>
In-Reply-To: <20160916200207.21439-1-yinghai@kernel.org>
References: <20160916200207.21439-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If host bridge does not have mmio64 above 4G, We don't need to
treat device non-pref mmio64 as as pref mmio64.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6d88a2e..1fcfa13 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -746,7 +746,7 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 static bool pci_up_path_over_pref_mem64(struct pci_bus *bus)
 {
 	if (pci_is_root_bus(bus))
-		return true;
+		return to_pci_host_bridge(bus->bridge)->has_mem64;
 
 	if (bus->self) {
 		int i;
-- 
2.8.3

