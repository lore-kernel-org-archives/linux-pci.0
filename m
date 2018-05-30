Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <marc.zyngier@arm.com>,
 <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <yingjoe.chen@mediatek.com>,
 <eddie.huang@mediatek.com>, <ryder.lee@mediatek.com>
Subject: [PATCH] PCI: mediatek: Add system pm support for MT2712
Date: Wed, 30 May 2018 10:35:36 +0800
Message-ID: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, hongkun.cao@mediatek.com, sean.wang@mediatek.com,
 xinping.qian@mediatek.com, honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 yong.wu@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

The MTCMOS of PCIe Host for MT2712 will be off when system suspend, and all
the internel control register will be reset after system resume. The PCIe
link should be re-established and the related control register values should
be re-set after system resume.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
CC: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index dabf1086..60f98d92 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -132,12 +132,14 @@ struct mtk_pcie_port;
 /**
  * struct mtk_pcie_soc - differentiate between host generations
  * @need_fix_class_id: whether this host's class ID needed to be fixed or not
+ * @pm_support: whether the host's MTCMOS will be off when suspend
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
  * @setup_irq: pointer to initialize IRQ functions
  */
 struct mtk_pcie_soc {
 	bool need_fix_class_id;
+	bool pm_support;
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
 	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
@@ -1179,12 +1181,91 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct mtk_pcie *pcie;
+	struct mtk_pcie_port *port;
+	const struct mtk_pcie_soc *soc;
+
+	pdev = to_platform_device(dev);
+	pcie = platform_get_drvdata(pdev);
+	soc = pcie->soc;
+	if (!soc->pm_support)
+		return 0;
+
+	list_for_each_entry(port, &pcie->ports, list) {
+		clk_disable_unprepare(port->ahb_ck);
+		clk_disable_unprepare(port->sys_ck);
+		phy_power_off(port->phy);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct mtk_pcie *pcie;
+	struct mtk_pcie_port *port;
+	const struct mtk_pcie_soc *soc;
+	int ret;
+
+	pdev = to_platform_device(dev);
+	pcie = platform_get_drvdata(pdev);
+	soc = pcie->soc;
+	if (!soc->pm_support)
+		return 0;
+
+	list_for_each_entry(port, &pcie->ports, list) {
+		ret = phy_power_on(port->phy);
+		if (ret) {
+			dev_err(dev, "could not power on phy\n");
+			return ret;
+		}
+		ret = clk_prepare_enable(port->sys_ck);
+		if (ret) {
+			dev_err(dev, "enable sys clock error\n");
+			phy_power_off(port->phy);
+			return ret;
+		}
+
+		ret = clk_prepare_enable(port->ahb_ck);
+		if (ret) {
+			dev_err(dev, "enable ahb clock error\n");
+			phy_power_off(port->phy);
+			clk_disable_unprepare(port->sys_ck);
+			return ret;
+		}
+
+		ret = soc->startup(port);
+		if (ret) {
+			dev_err(dev, "pcie linkup failed\n");
+			phy_power_off(port->phy);
+			clk_disable_unprepare(port->sys_ck);
+			clk_disable_unprepare(port->ahb_ck);
+			return ret;
+		}
+
+		if (IS_ENABLED(CONFIG_PCI_MSI))
+			mtk_pcie_enable_msi(port);
+	}
+
+	return 0;
+}
+
+const struct dev_pm_ops mtk_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
+				      mtk_pcie_resume_noirq)
+};
+
 static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
 	.ops = &mtk_pcie_ops,
 	.startup = mtk_pcie_startup_port,
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
+	.pm_support = true,
 	.ops = &mtk_pcie_ops_v2,
 	.startup = mtk_pcie_startup_port_v2,
 	.setup_irq = mtk_pcie_setup_irq,
@@ -1211,6 +1292,7 @@ static struct platform_driver mtk_pcie_driver = {
 		.name = "mtk-pcie",
 		.of_match_table = mtk_pcie_ids,
 		.suppress_bind_attrs = true,
+		.pm = &mtk_pcie_pm_ops,
 	},
 };
 builtin_platform_driver(mtk_pcie_driver);
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
