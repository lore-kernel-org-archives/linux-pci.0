Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753257AbcJGQdE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:33:04 -0400
Subject: [PATCH 4/8] PCI: artpec6: Add resource name comments
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Niklas Cassel <niklas.cassel@axis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Date: Fri, 07 Oct 2016 11:33:00 -0500
Message-ID: <20161007163300.24751.76570.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add comments about the Device Tree source of resources.  No functional
change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-artpec6.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index 585aac21b..add6b21 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -27,9 +27,9 @@
 #define to_artpec6_pcie(x)	container_of(x, struct artpec6_pcie, pp)
 
 struct artpec6_pcie {
-	struct pcie_port	pp;
-	struct regmap		*regmap;
-	void __iomem		*phy_base;
+	struct pcie_port	pp;		/* pp.dbi_base is DT dbi */
+	struct regmap		*regmap;	/* DT axis,syscon-pcie */
+	void __iomem		*phy_base;	/* DT phy */
 };
 
 /* PCIe Port Logic registers (memory-mapped) */

