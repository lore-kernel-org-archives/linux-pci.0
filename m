Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Yao Chen <chenyao11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
 <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>, <xuwei5@hisilicon.com>,
 <robh+dt@kernel.org>, <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
 <will.deacon@arm.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>
Subject: [PATCH] Kirin-PCIe: Add kirin pcie msi feature.
Date: Tue, 8 May 2018 15:03:48 +0800
Message-ID: <1525763028-107417-1-git-send-email-chenyao11@huawei.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: dimitrysh@google.com, guodong.xu@linaro.org, chenyao11@huawei.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds kirin pcie msi feature.

Signed-off-by: Yao Chen <chenyao11@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi |  2 ++
 drivers/pci/dwc/pcie-kirin.c              | 38 +++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index ec3eb8e..4ef684f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -872,6 +872,8 @@
 				  0x0 0x02000000>;
 			num-lanes = <1>;
 			#interrupt-cells = <1>;
+			interrupts = <0 283 4>;
+			interrupts-names = "msi";
 			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map = <0x0 0 0 1
 					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
index d2970a0..2319c9c 100644
--- a/drivers/pci/dwc/pcie-kirin.c
+++ b/drivers/pci/dwc/pcie-kirin.c
@@ -426,9 +426,28 @@ static int kirin_pcie_establish_link(struct pcie_port *pp)
 	return 0;
 }
 
+static irqreturn_t kirin_pcie_msi_irq_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+
+	return dw_handle_msi_irq(pp);
+}
+
+static void kirin_pcie_msi_init(struct pcie_port *pp)
+{
+	dw_pcie_msi_init(pp);
+}
+
+static void kirin_pcie_enable_interrupts(struct pcie_port *pp)
+{
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		kirin_pcie_msi_init(pp);
+}
+
 static int kirin_pcie_host_init(struct pcie_port *pp)
 {
 	kirin_pcie_establish_link(pp);
+	kirin_pcie_enable_interrupts(pp);
 
 	return 0;
 }
@@ -448,6 +467,25 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
 static int __init kirin_add_pcie_port(struct dw_pcie *pci,
 				      struct platform_device *pdev)
 {
+	int ret;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pci->pp.msi_irq = platform_get_irq(pdev, 0);
+		if (!pci->pp.msi_irq) {
+			dev_err(&pdev->dev, "failed to get msi irq\n");
+			return -ENODEV;
+		}
+		ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq,
+				       kirin_pcie_msi_irq_handler,
+				       IRQF_SHARED | IRQF_NO_THREAD,
+				       "kirin_pcie_msi", &pci->pp);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request msi irq\n");
+			return ret;
+		}
+	}
+
+	pci->pp.root_bus_nr = -1;
 	pci->pp.ops = &kirin_pcie_host_ops;
 
 	return dw_pcie_host_init(&pci->pp);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
