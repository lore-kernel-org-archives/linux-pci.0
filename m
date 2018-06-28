Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:9132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966069AbeF1Ms0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jun 2018 08:48:26 -0400
From: Xiaowei Song <songxiaowei@hisilicon.com>
To: <wangbinghui@hisilicon.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dimitrysh@google.com>
CC: <chenyao11@huawei.com>, <songxiaowei@hisilicon.com>
Subject: [PATCH v5 1/1] PCI: kirin: Add MSI support
Date: Thu, 28 Jun 2018 20:48:03 +0800
Message-ID: <20180628124803.110315-2-songxiaowei@hisilicon.com>
In-Reply-To: <20180628124803.110315-1-songxiaowei@hisilicon.com>
References: <20180628124803.110315-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add support for MSI.

Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
---
 drivers/pci/dwc/pcie-kirin.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
index d2970a009eb5..6997276eb69c 100644
--- a/drivers/pci/dwc/pcie-kirin.c
+++ b/drivers/pci/dwc/pcie-kirin.c
@@ -430,6 +430,9 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
 {
 	kirin_pcie_establish_link(pp);
 
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		dw_pcie_msi_init(pp);
+
 	return 0;
 }
 
@@ -445,9 +448,34 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
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
+			dev_err(&pdev->dev,
+				"failed to get MSI IRQ (%d)\n", ret);
+			return ret;
+		}
+
+		pci->pp.msi_irq = ret;
+	}
+
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
2.11.GIT
