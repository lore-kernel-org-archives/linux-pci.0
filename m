Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <hongxing.zhu@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] PCI: imx6: support MPLL reconfiguration for 100MHz and 200MHz
 refclock
Date: Tue, 31 Jul 2018 12:21:49 +0200
Message-Id: <20180731102149.8537-1-l.stach@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, patchwork-lst@pengutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The power up defaults of the MPLL are designed for the standard 125MHz
refclock derived from the ENET PLL. As this clock has a jitter that
violates the PCIe Gen2 timing requirements, some board designs use
an external reference clock generator. Those clock generators may
output a clock at a different rate than what the MPLL expects
(usually a 100MHz clock, to re-use the PCIe bus clock).

In that case the MPLL must be reconfigured via overrides to use
different refclock dividers and loop multipliers. The i.MX6
reference manual lists both 100MHz and 200MHz as supported refclock
rates and the associated mult and div values.

Only the 100MHz setup has been tested on a real board, but since the
200MHz setup only differs in the used pre-divider it seems safe to
add it now.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-imx6.c | 55 +++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80f604602783..c481c61a41b8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -97,6 +97,16 @@ struct imx6_pcie {
 #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
 
 /* PHY registers (not memory-mapped) */
+#define PCIE_PHY_ATEOVRD			0x10
+#define  PCIE_PHY_ATEOVRD_EN			(0x1 << 2)
+#define  PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT	0
+#define  PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK	0x1
+
+#define PCIE_PHY_MPLL_OVRD_IN_LO		0x11
+#define  PCIE_PHY_MPLL_MULTIPLIER_SHIFT		2
+#define  PCIE_PHY_MPLL_MULTIPLIER_MASK		0x7f
+#define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		(0x1 << 9)
+
 #define PCIE_PHY_RX_ASIC_OUT 0x100D
 #define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
 
@@ -508,6 +518,50 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
 }
 
+static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
+{
+	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
+	int mult, div;
+	u32 val;
+
+	switch (phy_rate) {
+	case 125000000:
+		/*
+		 * The default settings of the MPLL are for a 125MHz input
+		 * clock, so no need to reconfigure anything in that case.
+		 */
+		return 0;
+	case 100000000:
+		mult = 25;
+		div = 0;
+		break;
+	case 200000000:
+		mult = 25;
+		div = 1;
+		break;
+	default:
+		dev_err(imx6_pcie->pci->dev,
+			"Unsupported PHY reference clock rate %lu\n", phy_rate);
+		return -EINVAL;
+	}
+
+	pcie_phy_read(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, &val);
+	val &= ~(PCIE_PHY_MPLL_MULTIPLIER_MASK <<
+		 PCIE_PHY_MPLL_MULTIPLIER_SHIFT);
+	val |= mult << PCIE_PHY_MPLL_MULTIPLIER_SHIFT;
+	val |= PCIE_PHY_MPLL_MULTIPLIER_OVRD;
+	pcie_phy_write(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, val);
+
+	pcie_phy_read(imx6_pcie, PCIE_PHY_ATEOVRD, &val);
+	val &= ~(PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK <<
+		 PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT);
+	val |= div << PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT;
+	val |= PCIE_PHY_ATEOVRD_EN;
+	pcie_phy_write(imx6_pcie, PCIE_PHY_ATEOVRD, val);
+
+	return 0;
+}
+
 static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -632,6 +686,7 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	imx6_pcie_assert_core_reset(imx6_pcie);
 	imx6_pcie_init_phy(imx6_pcie);
 	imx6_pcie_deassert_core_reset(imx6_pcie);
+	imx6_setup_phy_mpll(imx6_pcie);
 	dw_pcie_setup_rc(pp);
 	imx6_pcie_establish_link(imx6_pcie);
 
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
