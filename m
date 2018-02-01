Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: kishon@ti.com, Niklas Cassel <niklass@axis.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: designware-ep: Fix typo in error message
Date: Thu,  1 Feb 2018 15:02:23 +0100
Message-Id: <20180201140224.28229-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix typo in error message. s/deb_base2/dbi_base2/

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index 3a6feeff5f5b..9236b998327f 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -322,7 +322,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device_node *np = dev->of_node;
 
 	if (!pci->dbi_base || !pci->dbi_base2) {
-		dev_err(dev, "dbi_base/deb_base2 is not populated\n");
+		dev_err(dev, "dbi_base/dbi_base2 is not populated\n");
 		return -EINVAL;
 	}
 
-- 
2.14.2
