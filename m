Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752798AbcJGQdM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:33:12 -0400
Subject: [PATCH 5/8] PCI: artpec6: Remove unnecessary artpec6_pcie_link_up()
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Niklas Cassel <niklas.cassel@axis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Date: Fri, 07 Oct 2016 11:33:08 -0500
Message-ID: <20161007163308.24751.61973.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove artpec6_pcie_link_up(); the generic dw_pcie_link_up() does the same
thing, so we don't need a device-specific version.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-artpec6.c |   16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index add6b21..8840e30 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -181,23 +181,7 @@ static void artpec6_pcie_host_init(struct pcie_port *pp)
 	artpec6_pcie_enable_interrupts(artpec6);
 }
 
-static int artpec6_pcie_link_up(struct pcie_port *pp)
-{
-	u32 rc;
-
-	/*
-	 * Get status from Synopsys IP
-	 * link is debug bit 36, debug register 1 starts at bit 32
-	 */
-	rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1) & (0x1 << (36 - 32));
-	if (rc)
-		return 1;
-
-	return 0;
-}
-
 static struct pcie_host_ops artpec6_pcie_host_ops = {
-	.link_up = artpec6_pcie_link_up,
 	.host_init = artpec6_pcie_host_init,
 };
 

