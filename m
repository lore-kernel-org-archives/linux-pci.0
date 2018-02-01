Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI: designware-ep: Return an error when requesting a too large BAR size
Date: Thu,  1 Feb 2018 17:11:19 +0100
Message-Id: <20180201161119.3852-4-niklas.cassel@axis.com>
In-Reply-To: <20180201161119.3852-1-niklas.cassel@axis.com>
References: <20180201161119.3852-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
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
index 3a6feeff5f5b..4a0085ead1e3 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -126,6 +126,11 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
 	enum dw_pcie_as_type as_type;
 	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
 
+	if (size > 0x100000000ULL) {
+		dev_err(pci->dev, "can't handle BAR larger than 4GB\n");
+		return -EINVAL;
+	}
+
 	if (!(flags & PCI_BASE_ADDRESS_SPACE))
 		as_type = DW_PCIE_AS_MEM;
 	else
-- 
2.14.2
