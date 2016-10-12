Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754964AbcJLN6q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:58:46 -0400
Subject: [PATCH v2 7/7] PCI: layerscape: Reorder struct ls_pcie
To: Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Oct 2016 08:58:18 -0500
Message-ID: <20161012135818.29815.61642.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index 3a86c1a..2cb7315 100644
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

