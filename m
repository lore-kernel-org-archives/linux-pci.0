Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Stefan Schoefegger <stefan.schoefegger@ginzinger.com>
To: <linux-pci@vger.kernel.org>
Subject: [PATCH v2 1/1] PCI: imx6: Add pcie compliance test option
Date: Wed, 7 Jun 2017 13:36:11 +0200
Message-ID: <1496835374-13053-1-git-send-email-stefan.schoefegger@ginzinger.com>
In-Reply-To: <1472121518-9340-1-git-send-email-stefan.schoefegger@ginzinger.com>
References: <1472121518-9340-1-git-send-email-stefan.schoefegger@ginzinger.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Stefan Schoefegger <stefan.schoefegger@ginzinger.com>,
 open list <linux-kernel@vger.kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "moderated list:PCI DRIVER FOR IMX6" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Link speed must not be limited to gen1 during link test for compliance
tests

Signed-off-by: Stefan Schoefegger <stefan.schoefegger@ginzinger.com>
---

Changes since v1:
 - pci-imx6.c moved to dwc directory

 drivers/pci/dwc/Kconfig    | 10 ++++++++++
 drivers/pci/dwc/pci-imx6.c | 21 ++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index b7e15526d676..b6e9ced5a45d 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -77,6 +77,16 @@ config PCI_IMX6
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
 
+config PCI_IMX6_COMPLIANCE_TEST
+	bool "Enable pcie compliance tests on imx6"
+	depends on PCI_IMX6
+	default n
+	help
+	  Enables support for pcie compliance test on FSL iMX SoCs.
+	  The link speed wouldn't be limited to gen1 when enabled.
+	  Enable only during compliance tests, otherwise
+	  link detection will fail on some peripherals.
+
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
 	depends on PCI
diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index 19a289b8cc94..b0fbe52e25b0 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -533,15 +533,18 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	u32 tmp;
 	int ret;
 
-	/*
-	 * Force Gen1 operation when starting the link.  In case the link is
-	 * started in Gen2 mode, there is a possibility the devices on the
-	 * bus will not be detected at all.  This happens with PCIe switches.
-	 */
-	tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
-	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
-	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
-	dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
+	if (!IS_ENABLED(CONFIG_PCI_IMX6_COMPLIANCE_TEST)) {
+		/*
+		 * Force Gen1 operation when starting the link.  In case the
+		 * link is started in Gen2 mode, there is a possibility the
+		 * devices on the bus will not be detected at all.  This
+		 * happens with PCIe switches.
+		 */
+		tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
+		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
+		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
+		dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
+	}
 
 	/* Start LTSSM. */
 	if (imx6_pcie->variant == IMX7D)
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
