Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47469 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbbJUSnB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Oct 2015 14:43:01 -0400
Subject: [PATCH v4 2/4] PCI: designware: Use common LTSSM_STATE_RCVRY_LOCK
 definition
To: Fabio Estevam <festevam@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>,
	linux-pci@vger.kernel.org, pratyush.anand@gmail.com,
	m-karicheri2@ti.com, l.stach@pengutronix.de
Date: Wed, 21 Oct 2015 13:42:58 -0500
Message-ID: <20151021184258.28724.34444.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Add a #define for LTSSM_STATE_RCVRY_LOCK and use it to improve code
readability.

[bhelgaas: include both definition and use for reviewability]
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c        |    2 +-
 drivers/pci/host/pcie-designware.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 7b0d120..4c788d27 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -507,7 +507,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
 	if (rx_valid & PCIE_PHY_RX_ASIC_OUT_VALID)
 		return 0;
 
-	if ((debug_r0 & LTSSM_STATE_MASK) != 0x0d)
+	if ((debug_r0 & LTSSM_STATE_MASK) != LTSSM_STATE_RCVRY_LOCK)
 		return 0;
 
 	dev_err(pp->dev, "transition to gen2 is stuck, reset PHY!\n");
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index a1a76ff..f3a7583 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -22,6 +22,7 @@
 #define MAX_MSI_IRQS			32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
 
+#define LTSSM_STATE_RCVRY_LOCK		0x0d
 #define LTSSM_STATE_MASK		0x1f
 
 struct pcie_port {

