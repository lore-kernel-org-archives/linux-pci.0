Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:41864 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbcA1Xh0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2016 18:37:26 -0500
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Bjorn Helgaas <helgaas@kernel.org>,
	Rafal Milecki <zajec5@gmail.com>,
	Hante Meuleman <meuleman@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH] PCI: iproc: Remove redundant function number check for PAXC
Date: Thu, 28 Jan 2016 15:37:20 -0800
Message-ID: <1454024240-12270-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch removes the conditional check that limits the number of
functions to be supported by the internally emulated endpoint device
connected to PAXC. Investigation shows that the emulated PAXC endpoint
device can properly reject request for unsupported functions, which
makes this conditional check redundant

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 9ae43ed..b65185d 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -204,7 +204,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 	 * allows only one device and supports a limited number of functions.
 	 */
 	if (pcie->type == IPROC_PCIE_PAXC)
-		if (slot > 0 || fn >= MAX_NUM_PAXC_PF)
+		if (slot > 0)
 			return NULL;
 
 	/* EP device access */
-- 
1.9.1

