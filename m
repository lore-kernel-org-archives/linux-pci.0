Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Niklas Cassel <niklass@axis.com>,
        Jesper Nilsson <jespern@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/18] PCI: dwc: artpec6: Deassert the core before waiting for PHY
Date: Mon, 20 Nov 2017 14:32:19 +0100
Message-Id: <20171120133222.27771-17-niklas.cassel@axis.com>
In-Reply-To: <20171120133222.27771-1-niklas.cassel@axis.com>
References: <20171120133222.27771-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Waiting for the PHY while the core was held in reset worked for artpec6,
but for artpec7, in order to read the required registers, the core has to
be out of reset.
Refactor the code so we always wait for the PHY after the core has been
deasserted, since this works for both artpec6 and artpec7.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pcie-artpec6.c | 45 +++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 318a2bd0d97e..064c5a93ea80 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -125,11 +125,37 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.stop_link = artpec6_pcie_stop_link,
 };
 
-static void artpec6_pcie_init_phy(struct artpec6_pcie *artpec6_pcie)
+static void artpec6_pcie_wait_for_phy(struct artpec6_pcie *artpec6_pcie)
 {
+	struct dw_pcie *pci = artpec6_pcie->pci;
+	struct device *dev = pci->dev;
 	u32 val;
 	unsigned int retries;
 
+	retries = 50;
+	do {
+		usleep_range(1000, 2000);
+		val = artpec6_pcie_readl(artpec6_pcie, NOCCFG);
+		retries--;
+	} while (retries &&
+		(val & (NOCCFG_POWER_PCIE_IDLEACK | NOCCFG_POWER_PCIE_IDLE)));
+	if (!retries)
+		dev_err(dev, "PCIe clock manager did not leave idle state\n");
+
+	retries = 50;
+	do {
+		usleep_range(1000, 2000);
+		val = readl(artpec6_pcie->phy_base + PHY_STATUS);
+		retries--;
+	} while (retries && !(val & PHY_COSPLLLOCK));
+	if (!retries)
+		dev_err(dev, "PHY PLL did not lock\n");
+}
+
+static void artpec6_pcie_init_phy(struct artpec6_pcie *artpec6_pcie)
+{
+	u32 val;
+
 	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
 	val |=  PCIECFG_RISRCREN |	/* Receiver term. 50 Ohm */
 		PCIECFG_MODE_TX_DRV_EN |
@@ -154,21 +180,6 @@ static void artpec6_pcie_init_phy(struct artpec6_pcie *artpec6_pcie)
 	val = artpec6_pcie_readl(artpec6_pcie, NOCCFG);
 	val &= ~NOCCFG_POWER_PCIE_IDLEREQ;
 	artpec6_pcie_writel(artpec6_pcie, NOCCFG, val);
-
-	retries = 50;
-	do {
-		usleep_range(1000, 2000);
-		val = artpec6_pcie_readl(artpec6_pcie, NOCCFG);
-		retries--;
-	} while (retries &&
-		(val & (NOCCFG_POWER_PCIE_IDLEACK | NOCCFG_POWER_PCIE_IDLE)));
-
-	retries = 50;
-	do {
-		usleep_range(1000, 2000);
-		val = readl(artpec6_pcie->phy_base + PHY_STATUS);
-		retries--;
-	} while (retries && !(val & PHY_COSPLLLOCK));
 }
 
 static void artpec6_pcie_assert_core_reset(struct artpec6_pcie *artpec6_pcie)
@@ -207,6 +218,7 @@ static int artpec6_pcie_host_init(struct pcie_port *pp)
 	artpec6_pcie_assert_core_reset(artpec6_pcie);
 	artpec6_pcie_init_phy(artpec6_pcie);
 	artpec6_pcie_deassert_core_reset(artpec6_pcie);
+	artpec6_pcie_wait_for_phy(artpec6_pcie);
 	dw_pcie_setup_rc(pp);
 	artpec6_pcie_establish_link(pci);
 	dw_pcie_wait_for_link(pci);
@@ -274,6 +286,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
 	artpec6_pcie_assert_core_reset(artpec6_pcie);
 	artpec6_pcie_init_phy(artpec6_pcie);
 	artpec6_pcie_deassert_core_reset(artpec6_pcie);
+	artpec6_pcie_wait_for_phy(artpec6_pcie);
 
 	for (bar = BAR_0; bar <= BAR_5; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
-- 
2.14.2
