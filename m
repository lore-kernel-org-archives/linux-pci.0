Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933341AbcJLNZd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:25:33 -0400
Subject: [PATCH v2 2/6] PCI: armada: Add local base pointer
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:25:27 -0500
Message-ID: <20161012132527.26736.98481.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012131957.26736.14194.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012131957.26736.14194.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a local "base" pointer, as is done for other uses, to simplify a
subsequent patch.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-armada8k.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
index b97ba97..121f6c8 100644
--- a/drivers/pci/host/pcie-armada8k.c
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -73,10 +73,11 @@ struct armada8k_pcie {
 static int armada8k_pcie_link_up(struct pcie_port *pp)
 {
 	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
+	void __iomem *base = pcie->base;
 	u32 reg;
 	u32 mask = PCIE_GLB_STS_RDLH_LINK_UP | PCIE_GLB_STS_PHY_LINK_UP;
 
-	reg = readl(pcie->base + PCIE_GLOBAL_STATUS_REG);
+	reg = readl(base + PCIE_GLOBAL_STATUS_REG);
 
 	if ((reg & mask) == mask)
 		return 1;

