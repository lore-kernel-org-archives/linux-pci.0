Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941286AbcJGQmV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:42:21 -0400
Subject: [PATCH 4/7] PCI: layerscape: Reorder struct ls_pcie
To: Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 07 Oct 2016 11:42:17 -0500
Message-ID: <20161007164217.26341.37212.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007164149.26341.87049.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007164149.26341.87049.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reorder struct ls_pcie to put generic fields first.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index d69614c..8d10665 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -45,9 +45,9 @@ struct ls_pcie_drvdata {
 };
 
 struct ls_pcie {
+	struct pcie_port pp;		/* pp.dbi_base is DT regs */
 	void __iomem *lut;
 	struct regmap *scfg;
-	struct pcie_port pp;
 	const struct ls_pcie_drvdata *drvdata;
 	int index;
 };

