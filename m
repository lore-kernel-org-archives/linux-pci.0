Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753456AbcJLNcC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:32:02 -0400
Subject: [PATCH v2 7/7] PCI: artpec6: Add resource name comments
To: Jesper Nilsson <jesper.nilsson@axis.com>,
        Niklas Cassel <niklas.cassel@axis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Date: Wed, 12 Oct 2016 08:29:52 -0500
Message-ID: <20161012132952.27228.56197.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012132616.27228.4618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012132616.27228.4618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add comments about the Device Tree source of resources.  No functional
change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 drivers/pci/host/pcie-artpec6.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index bdfdea2..212786b 100644
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

