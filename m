Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <nsekhar@ti.com>, <kishon@ti.com>,
        Niklas Cassel <niklas.cassel@axis.com>
Subject: [RESEND PATCH v3 3/7] PCI: dwc: artpec6: Populate cpu_addr_fixup ops
Date: Thu, 9 Mar 2017 12:09:01 +0530
Message-ID: <1489041545-15730-4-git-send-email-kishon@ti.com>
In-Reply-To: <1489041545-15730-1-git-send-email-kishon@ti.com>
References: <1489041545-15730-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Populate cpu_addr_fixup ops to extract the least 28 bits of the
corresponding cpu address.

Cc: Niklas Cassel <niklas.cassel@axis.com>
Acked-by: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pcie-artpec6.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index fcd3ef8..5b3b3af 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -78,6 +78,11 @@ static void artpec6_pcie_writel(struct artpec6_pcie *artpec6_pcie, u32 offset, u
 	regmap_write(artpec6_pcie->regmap, offset, val);
 }
 
+static u64 artpec6_pcie_cpu_addr_fixup(u64 pci_addr)
+{
+	return pci_addr & ARTPEC6_CPU_TO_BUS_ADDR;
+}
+
 static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
 {
 	struct dw_pcie *pci = artpec6_pcie->pci;
@@ -142,11 +147,6 @@ static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
 	 */
 	dw_pcie_writel_dbi(pci, MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
 
-	pp->io_base &= ARTPEC6_CPU_TO_BUS_ADDR;
-	pp->mem_base &= ARTPEC6_CPU_TO_BUS_ADDR;
-	pp->cfg0_base &= ARTPEC6_CPU_TO_BUS_ADDR;
-	pp->cfg1_base &= ARTPEC6_CPU_TO_BUS_ADDR;
-
 	/* setup root complex */
 	dw_pcie_setup_rc(pp);
 
@@ -234,6 +234,10 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 	return 0;
 }
 
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.cpu_addr_fixup = artpec6_pcie_cpu_addr_fixup,
+};
+
 static int artpec6_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -252,6 +256,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
 
 	artpec6_pcie->pci = pci;
 
-- 
1.7.9.5
