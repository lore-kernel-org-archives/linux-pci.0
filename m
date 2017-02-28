Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: bhelgaas@google.com
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: dwc: Fix NULL pointer dereference due to missing assignment
Date: Tue, 28 Feb 2017 13:38:18 +0530
Message-Id: <1488269298-23056-1-git-send-email-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add missing assignment of dw_pci core structure for
designware-plat.

Commit 8b130f815a6b ("PCI: dwc: Fix crashes seen due to missing
assignments") fixed all other platforms, but missed
designware-plat file.

Fixes: 442ec4c04d12 ("PCI: dwc: all: Split struct pcie_port into host-only and core structures")

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---

Based on torvald's master branch.
Build tested.

 drivers/pci/dwc/pcie-designware-plat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index 65250f63515c..b6c832ba39dd 100644
--- a/drivers/pci/dwc/pcie-designware-plat.c
+++ b/drivers/pci/dwc/pcie-designware-plat.c
@@ -104,6 +104,8 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 
 	pci->dev = dev;
 
+	dw_plat_pcie->pci = pci;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pci->dbi_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pci->dbi_base))
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
