Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Minghuan Lian <Minghuan.Lian@nxp.com>
To: <linux-pci@vger.kernel.org>
Subject: [PATCH] pci: layerscape: add LS1046a support
Date: Tue, 25 Oct 2016 20:36:56 +0800
Message-ID: <1477399016-22826-1-git-send-email-Minghuan.Lian@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Stuart Yoder <stuart.yoder@nxp.com>, Yang-Leo Li <leoyang.li@nxp.com>,
 Minghuan Lian <Minghuan.Lian@nxp.com>, linux-arm-kernel@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: "mingkai.hu@nxp.com" <mingkai.hu@nxp.com>

1. LS1046a PCIe controller has a different LUT_DBG offset.
Available "lut_dbg" is added to ls_pcie_drvdata to describe
this difference.
2. Match LS1046 PCIe compatible

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Signed-off-by: Mingkai Hu <mingkai.hu@nxp.com>
---
 Documentation/devicetree/bindings/pci/layerscape-pci.txt |  1 +
 drivers/pci/host/pci-layerscape.c                        | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 41e9f55..ee1c72d5 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -15,6 +15,7 @@ Required properties:
 - compatible: should contain the platform identifier such as:
         "fsl,ls1021a-pcie", "snps,dw-pcie"
         "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
+        "fsl,ls1046a-pcie"
 - reg: base addresses and lengths of the PCIe controller
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 958187f..8cebf9a 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -41,6 +41,7 @@
 struct ls_pcie_drvdata {
 	u32 lut_offset;
 	u32 ltssm_shift;
+	u32 lut_dbg;
 	struct pcie_host_ops *ops;
 };
 
@@ -134,7 +135,7 @@ static int ls_pcie_link_up(struct pcie_port *pp)
 	struct ls_pcie *pcie = to_ls_pcie(pp);
 	u32 state;
 
-	state = (ioread32(pcie->lut + PCIE_LUT_DBG) >>
+	state = (ioread32(pcie->lut + pcie->drvdata->lut_dbg) >>
 		 pcie->drvdata->ltssm_shift) &
 		 LTSSM_STATE_MASK;
 
@@ -196,18 +197,28 @@ static int ls_pcie_msi_host_init(struct pcie_port *pp,
 static struct ls_pcie_drvdata ls1043_drvdata = {
 	.lut_offset = 0x10000,
 	.ltssm_shift = 24,
+	.lut_dbg = 0x7fc,
+	.ops = &ls_pcie_host_ops,
+};
+
+static struct ls_pcie_drvdata ls1046_drvdata = {
+	.lut_offset = 0x80000,
+	.ltssm_shift = 24,
+	.lut_dbg = 0x407fc,
 	.ops = &ls_pcie_host_ops,
 };
 
 static struct ls_pcie_drvdata ls2080_drvdata = {
 	.lut_offset = 0x80000,
 	.ltssm_shift = 0,
+	.lut_dbg = 0x7fc,
 	.ops = &ls_pcie_host_ops,
 };
 
 static const struct of_device_id ls_pcie_of_match[] = {
 	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
 	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
+	{ .compatible = "fsl,ls1046a-pcie", .data = &ls1046_drvdata },
 	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
 	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
 	{ },
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
