Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:51505 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753835AbdLSXan (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 18:30:43 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/18] PCI: designware-ep: Pre-allocate memory for MSI in dw_pcie_ep_init
Date: Wed, 20 Dec 2017 00:29:25 +0100
Message-Id: <20171219232940.659-5-niklas.cassel@axis.com>
In-Reply-To: <20171219232940.659-1-niklas.cassel@axis.com>
References: <20171219232940.659-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Certain SoCs need to map the MSI address in raise_irq.
To map an address, you first need to call pci_epc_mem_alloc_addr(),
however, pci_epc_mem_alloc_addr() calls ioremap() (which can sleep).

Since raise_irq is only called from atomic context, we can't call
pci_epc_mem_alloc_addr() from raise_irq.

Pre-allocate a page in dw_pcie_ep_init(), so that this page can later
be used to map/unmap the MSI address in raise_irq.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pcie-designware-ep.c | 10 ++++++++++
 drivers/pci/dwc/pcie-designware.h    |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index 3fb34be99715..8d8019cdff2a 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -286,6 +286,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
 	struct pci_epc *epc = ep->epc;
 
+	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
+			      epc->mem->page_size);
+
 	pci_epc_mem_exit(epc);
 }
 
@@ -341,6 +344,13 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return ret;
 	}
 
+	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
+					     epc->mem->page_size);
+	if (!ep->msi_mem) {
+		dev_err(dev, "Failed to reserve memory for MSI\n");
+		return -ENOMEM;
+	}
+
 	ep->epc = epc;
 	epc_set_drvdata(epc, ep);
 	dw_pcie_setup(pci);
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 9aaf0cd04dd6..5a1da459eda5 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -198,6 +198,8 @@ struct dw_pcie_ep {
 	unsigned long		ob_window_map;
 	u32			num_ib_windows;
 	u32			num_ob_windows;
+	void __iomem		*msi_mem;
+	phys_addr_t		msi_mem_phys;
 };
 
 struct dw_pcie_ops {
-- 
2.14.2
