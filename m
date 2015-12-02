Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:37170 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbbLBHoi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2015 02:44:38 -0500
From: Sanjeev Sharma <sanjeev_sharma@mentor.com>
To: <Richard.Zhu@freescale.com>, <l.stach@pengutronix.de>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	David Mueller <dave.mueller@gmx.ch>,
	Sanjeev Sharma <sanjeev_sharma@mentor.com>
Subject: [PATCH v2] PCI: imx6:don't sleep in atomic context
Date: Wed, 2 Dec 2015 13:13:16 +0530
Message-ID: <1449042196-25710-1-git-send-email-sanjeev_sharma@mentor.com>
In-Reply-To: <1447066080-5859-1-git-send-email-sanjeev_sharma@mentor.com>
References: <1447066080-5859-1-git-send-email-sanjeev_sharma@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Mueller <dave.mueller@gmx.ch>

If additional PCIe switch get connected between the
host and the NIC,the kernel crashes with "BUG:
scheduling while atomic". To handle this we need to
call mdelay() instead of usleep_range().

This is currently called from atomic context through
pci_config_{read,write).

For more detail please refer bugzilla.kernel.org, Bug
100031

Signed-off-by: David Mueller <dave.mueller@gmx.ch>
Signed-off-by: Sanjeev Sharma <sanjeev_sharma@mentor.com>

Changes in v2:
	-order of signoff has been change
	-Author of patch has been change
	-A mdelay(1000) is different timescale than
a usleep(1000).change it to correct scale i.e mdelay(1)
	-updated comment
---
 drivers/pci/host/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 233a196..c03527f 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -499,7 +499,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
 		 * Wait a little bit, then re-check if the link finished
 		 * the training.
 		 */
-		usleep_range(1000, 2000);
+		mdelay(1);
 	}
 	/*
 	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
-- 
1.7.11.7

