Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:54226 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368AbbFRH7L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Jun 2015 03:59:11 -0400
From: =?UTF-8?q?David=20M=C3=BCller?= <dave.mueller@gmx.ch>
To: linux-pci@vger.kernel.org
Cc: Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: imx6: Fix non-working MSI interrupts if PCIe switch is attached
Date: Thu, 18 Jun 2015 09:59:07 +0200
Message-Id: <1434614347-2154-1-git-send-email-dave.mueller@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This problem has already been reported as 
https://bugzilla.kernel.org/show_bug.cgi?id=100051

Signed-off-by: David Müller <dave.mueller@gmx.ch>
---
 drivers/pci/host/pci-imx6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index c63691c..53f8dea 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -433,9 +433,6 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 
 	imx6_pcie_start_link(pp);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
 }
 
 static void imx6_pcie_reset_phy(struct pcie_port *pp)
@@ -550,6 +547,9 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 		return ret;
 	}
 
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		dw_pcie_msi_init(pp);
+
 	return 0;
 }
 
-- 
1.8.4

