Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:58868 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbeB0L7c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Feb 2018 06:59:32 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] PCI: designware-ep: Return an error when requesting a too large BAR size
Date: Tue, 27 Feb 2018 12:59:07 +0100
Message-Id: <20180227115908.14593-4-niklas.cassel@axis.com>
In-Reply-To: <20180227115908.14593-1-niklas.cassel@axis.com>
References: <20180227115908.14593-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_epc_set_bar() can be called with flag PCI_BASE_ADDRESS_MEM_TYPE_64,
and can thus request a BAR size larger than 4 GB.

However, the pcie-designware-ep.c driver currently doesn't handle
BAR sizes larger than 4 GB. (Since we are only writing the BAR_mask[x]
register and not the BAR_mask[x+1] register.)

For now, return an error when requesting a BAR size larger than 4 GB.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pcie-designware-ep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index 3a6feeff5f5b..efb65a7c06b8 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -126,6 +126,11 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
 	enum dw_pcie_as_type as_type;
 	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
 
+	if (upper_32_bits(size)) {
+		dev_err(pci->dev, "can't handle BAR larger than 4GB\n");
+		return -EINVAL;
+	}
+
 	if (!(flags & PCI_BASE_ADDRESS_SPACE))
 		as_type = DW_PCIE_AS_MEM;
 	else
-- 
2.14.2
