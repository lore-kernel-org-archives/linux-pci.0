Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <marc.zyngier@arm.com>,
 <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <yingjoe.chen@mediatek.com>,
 <eddie.huang@mediatek.com>, <ryder.lee@mediatek.com>
Subject: [PATCH v2 3/4] PCI: mediatek: Add system pm support for MT2712 and
 MT7622
Date: Mon, 2 Jul 2018 11:49:43 +0800
Message-ID: <1530503384-1218-4-git-send-email-honghui.zhang@mediatek.com>
In-Reply-To: <1530503384-1218-1-git-send-email-honghui.zhang@mediatek.com>
References: <1530503384-1218-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, hongkun.cao@mediatek.com, sean.wang@mediatek.com,
 honghui.zhang@mediatek.com, yt.shen@mediatek.com, yong.wu@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

The MTCMOS of PCIe Host for MT2712 and MT7622 will be off when system
suspend, and all the internal control register will be reset after system
resume. The PCIe link should be re-established and the related control
register values should be re-set after system resume.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 67 ++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 86918d4..c530539 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -134,12 +134,14 @@ struct mtk_pcie_port;
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
@@ -1197,12 +1199,75 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
+{
+	struct mtk_pcie *pcie = dev_get_drvdata(dev);
+	const struct mtk_pcie_soc *soc = pcie->soc;
+	struct mtk_pcie_port *port;
+
+	if (!soc->pm_support)
+		return 0;
+
+	if (list_empty(&pcie->ports))
+		return 0;
+
+	list_for_each_entry(port, &pcie->ports, list) {
+		clk_disable_unprepare(port->pipe_ck);
+		clk_disable_unprepare(port->obff_ck);
+		clk_disable_unprepare(port->axi_ck);
+		clk_disable_unprepare(port->aux_ck);
+		clk_disable_unprepare(port->ahb_ck);
+		clk_disable_unprepare(port->sys_ck);
+		phy_power_off(port->phy);
+		phy_exit(port->phy);
+	}
+
+	mtk_pcie_subsys_powerdown(pcie);
+
+	return 0;
+}
+
+static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
+{
+	struct mtk_pcie *pcie = dev_get_drvdata(dev);
+	const struct mtk_pcie_soc *soc = pcie->soc;
+	struct mtk_pcie_port *port;
+
+	if (!soc->pm_support)
+		return 0;
+
+	if (list_empty(&pcie->ports))
+		return 0;
+
+	if (dev->pm_domain) {
+		pm_runtime_enable(dev);
+		pm_runtime_get_sync(dev);
+	}
+
+	clk_prepare_enable(pcie->free_ck);
+
+	list_for_each_entry_safe(port, &pcie->ports, list)
+		mtk_pcie_enable_port(port);
+
+	/* In case of EP was removed while system suspend. */
+	if (list_empty(&pcie->ports))
+		mtk_pcie_subsys_powerdown(pcie);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mtk_pcie_pm_ops = {
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
@@ -1210,6 +1275,7 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
 	.need_fix_class_id = true,
+	.pm_support = true,
 	.ops = &mtk_pcie_ops_v2,
 	.startup = mtk_pcie_startup_port_v2,
 	.setup_irq = mtk_pcie_setup_irq,
@@ -1229,6 +1295,7 @@ static struct platform_driver mtk_pcie_driver = {
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
