Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:26004 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594AbcFRCZm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2016 22:25:42 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v13 15/16] PCI: Only treat non-pref mmio64 as pref if host bridge has mmio64
Date: Fri, 17 Jun 2016 19:25:00 -0700
Message-Id: <20160618022501.15648-16-yinghai@kernel.org>
In-Reply-To: <20160618022501.15648-1-yinghai@kernel.org>
References: <20160618022501.15648-1-yinghai@kernel.org>
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
index ffb1941..9404032 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -741,7 +741,7 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 static bool pci_up_path_over_pref_mem64(struct pci_bus *bus)
 {
 	if (pci_is_root_bus(bus))
-		return true;
+		return to_pci_host_bridge(bus->bridge)->has_mem64;
 
 	if (bus->self) {
 		int i;
-- 
2.8.3

