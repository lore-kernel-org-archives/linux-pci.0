Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:38163 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758331AbcBYCNa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 21:13:30 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v10 14/59] PCI: Only treat non-pref mmio64 as pref if host bridge has mmio64
Date: Wed, 24 Feb 2016 18:12:05 -0800
Message-Id: <1456366370-28995-15-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
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
index b7b64d2..38db51b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -742,7 +742,7 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 static bool pci_up_path_over_pref_mem64(struct pci_bus *bus)
 {
 	if (pci_is_root_bus(bus))
-		return true;
+		return to_pci_host_bridge(bus->bridge)->has_mem64;
 
 	if (bus->self) {
 		int i;
-- 
1.8.4.5

