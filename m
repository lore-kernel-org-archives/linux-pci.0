Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Xiaowei Song <songxiaowei@hisilicon.com>
To: <wangbinghui@hisilicon.com>, <bhelgaas@google.com>,
        <xuwei5@huawei.com>, <robh+dt@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dimitrysh@google.com>, <andy.shevchenko@gmail.com>
CC: <guodong.xu@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <chenyao11@huawei.com>,
        <songxiaowei@hisilicon.com>
Subject: [PATCH v4] PCI: kirin: Add MSI support
Date: Wed, 16 May 2018 09:21:59 +0800
Message-ID: <20180516012159.44081-2-songxiaowei@hisilicon.com>
In-Reply-To: <20180516012159.44081-1-songxiaowei@hisilicon.com>
References: <20180516012159.44081-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yao Chen <chenyao11@huawei.com>

Add support for MSI.

Signed-off-by: Yao Chen <chenyao11@huawei.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>
---
 drivers/pci/dwc/pcie-kirin.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
index d2970a0..00ca4e5 100644
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
@@ -445,9 +464,41 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
 	.host_init = kirin_pcie_host_init,
 };
 
+static int kirin_pcie_add_msi(struct dw_pcie *pci,
+				struct platform_device *pdev)
+{
+	int ret = 0;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		ret = platform_get_irq(pdev, 0);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to get MSI IRQ (%d)\n",
+				pci->pp.msi_irq);
+			return ret;
+		}
+
+		pci->pp.msi_irq = ret;
+
+		ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq,
+					   kirin_pcie_msi_irq_handler,
+					   IRQF_SHARED | IRQF_NO_THREAD,
+					   "kirin_pcie_msi", &pci->pp);
+		if (ret)
+			dev_err(&pdev->dev, "failed to request MSI IRQ %d\n",
+				pci->pp.msi_irq);
+	}
+	return ret;
+}
+
 static int __init kirin_add_pcie_port(struct dw_pcie *pci,
 				      struct platform_device *pdev)
 {
+	int ret;
+
+	ret = kirin_pcie_add_msi(pci, pdev);
+	if (ret)
+		return ret;
+
 	pci->pp.ops = &kirin_pcie_host_ops;
 
 	return dw_pcie_host_init(&pci->pp);
-- 
2.7.3
