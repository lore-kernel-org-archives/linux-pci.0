Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] PCI: designware-ep: pre-allocate memory for MSI in dw_pcie_ep_init
Date: Fri, 13 Oct 2017 18:09:07 +0200
Message-Id: <20171013160914.3220-5-niklas.cassel@axis.com>
In-Reply-To: <20171013160914.3220-1-niklas.cassel@axis.com>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Certain SoCs need to map the MSI address in raise_irq.
To map an address, you first need to call pci_epc_mem_alloc_addr,
however, pci_epc_mem_alloc_addr calls ioremap (which can sleep).

Since raise_irq is only called from atomic context, we can't call
pci_epc_mem_alloc_addr from raise_irq, instead we pre-allocate
a page in dw_pcie_ep_init, so this page can later be used to map/unmap
the MSI address in raise_irq.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pcie-designware-ep.c | 8 ++++++++
 drivers/pci/dwc/pcie-designware.h    | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index 3fb34be99715..c291da2a10ba 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -286,6 +286,8 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
 	struct pci_epc *epc = ep->epc;
 
+	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem, PAGE_SIZE);
+
 	pci_epc_mem_exit(epc);
 }
 
@@ -341,6 +343,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return ret;
 	}
 
+	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys, PAGE_SIZE);
+	if (!ep->msi_mem) {
+		dev_err(dev, "Failed to reserve memory for MSI\n");
+		return -ENOMEM;
+	}
+
 	ep->epc = epc;
 	epc_set_drvdata(epc, ep);
 	dw_pcie_setup(pci);
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 36183906e1d2..f56d040afde4 100644
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
2.11.0
