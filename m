Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:64849 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288AbbFRH6O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Jun 2015 03:58:14 -0400
From: =?UTF-8?q?David=20M=C3=BCller?= <dave.mueller@gmx.ch>
To: linux-pci@vger.kernel.org
Cc: Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: imx6: Fix "BUG: scheduling while atomic" if PCIe switch is attached
Date: Thu, 18 Jun 2015 09:56:54 +0200
Message-Id: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This problem has already been reported as 
https://bugzilla.kernel.org/show_bug.cgi?id=100031

Signed-off-by: David Müller <dave.mueller@gmx.ch>
---
 drivers/pci/host/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index fdb9536..c63691c 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -489,7 +489,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
 		 * Wait a little bit, then re-check if the link finished
 		 * the training.
 		 */
-		usleep_range(1000, 2000);
+		mdelay(20);
 	}
 	/*
 	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
-- 
1.8.4

