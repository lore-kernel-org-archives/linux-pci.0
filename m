Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757395AbcJGQfv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:35:51 -0400
Subject: [PATCH 3/8] PCI: exynos: Reorder struct exynos_pcie
To: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Fri, 07 Oct 2016 11:35:43 -0500
Message-ID: <20161007163543.25314.71306.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reorder struct exynos_pcie to put generic fields first.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-exynos.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index fa0784d..c7b0809 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -29,13 +29,13 @@
 #define to_exynos_pcie(x)	container_of(x, struct exynos_pcie, pp)
 
 struct exynos_pcie {
-	void __iomem		*elbi_base;
-	void __iomem		*phy_base;
-	void __iomem		*block_base;
+	struct pcie_port	pp;
+	void __iomem		*elbi_base;	/* DT 0th resource */
+	void __iomem		*phy_base;	/* DT 1st resource */
+	void __iomem		*block_base;	/* DT 2nd resource */
 	int			reset_gpio;
 	struct clk		*clk;
 	struct clk		*bus_clk;
-	struct pcie_port	pp;
 };
 
 /* PCIe ELBI registers */

