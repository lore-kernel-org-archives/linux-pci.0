Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:39629 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbbKIKte (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2015 05:49:34 -0500
From: Sanjeev Sharma <sanjeev_sharma@mentor.com>
To: <Richard.Zhu@freescale.com>, <l.stach@pengutronix.de>,
	<bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	Sanjeev Sharma <sanjeev_sharma@mentor.com>,
	David Mueller <dave.mueller@gmx.ch>
Subject: [PATCH] PCI: imx6:don't sleep in atomic context
Date: Mon, 9 Nov 2015 16:18:00 +0530
Message-ID: <1447066080-5859-1-git-send-email-sanjeev_sharma@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If additional PCIe switch get connected between the
host and the NIC,the kernel crashes with "BUG:
scheduling while atomic". To handle this we need to
call mdelay() instead of usleep_range().

For more detail please refer bugzilla.kernel.org, Bug
100031

Signed-off-by: Sanjeev Sharma <sanjeev_sharma@mentor.com>
Signed-off-by: David Mueller <dave.mueller@gmx.ch>
---
 drivers/pci/host/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 233a196..9769b13 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -499,7 +499,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
 		 * Wait a little bit, then re-check if the link finished
 		 * the training.
 		 */
-		usleep_range(1000, 2000);
+		mdelay(1000);
 	}
 	/*
 	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
-- 
1.7.11.7

