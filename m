Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:51358 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756588Ab3HZIj7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2013 04:39:59 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>, <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>
Subject: [PATCH v9 1/2] PCI: Fix comment syntax
Date: Mon, 26 Aug 2013 16:33:05 +0800
Message-ID: <1377505986-7484-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jon Mason <jdmason@kudzu.us>

Correct minor wording issue in MPS Peer-to-peer comment.

Noticed by Don Dutile

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 drivers/pci/probe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0e8cff2..21ca9a1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1625,7 +1625,7 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
 		return;
 
 	/* FIXME - Peer to peer DMA is possible, though the endpoint would need
-	 * to be aware to the MPS of the destination.  To work around this,
+	 * to be aware of the MPS of the destination.  To work around this,
 	 * simply force the MPS of the entire system to the smallest possible.
 	 */
 	if (pcie_bus_config == PCIE_BUS_PEER2PEER)
-- 
1.7.1


