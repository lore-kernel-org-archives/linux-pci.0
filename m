Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35195 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217AbcDHARL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:17:11 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v11 15/60] PCI: Only treat non-pref mmio64 as pref if host bridge has mmio64
Date: Thu,  7 Apr 2016 17:15:28 -0700
Message-Id: <1460074573-7481-16-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
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
1.8.4.5

