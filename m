Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:51514 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753839AbdLSXan (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 18:30:43 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/18] PCI: designware-ep: Remove static keyword from dw_pcie_ep_reset_bar()
Date: Wed, 20 Dec 2017 00:29:26 +0100
Message-Id: <20171219232940.659-6-niklas.cassel@axis.com>
In-Reply-To: <20171219232940.659-1-niklas.cassel@axis.com>
References: <20171219232940.659-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the static keyword from dw_pcie_ep_reset_bar() so that
pci-dra7xx.c does not need its own copy of dw_pcie_ep_reset_bar().

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c         | 9 ---------
 drivers/pci/dwc/pcie-designware-ep.c | 2 +-
 drivers/pci/dwc/pcie-designware.h    | 5 +++++
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index e77a4ceed74c..d330b7d86ce3 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -337,15 +337,6 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
-{
-	u32 reg;
-
-	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
-	dw_pcie_writel_dbi2(pci, reg, 0x0);
-	dw_pcie_writel_dbi(pci, reg, 0x0);
-}
-
 static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index 8d8019cdff2a..700ed2f4becf 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -30,7 +30,7 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 	pci_epc_linkup(epc);
 }
 
-static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
+void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 {
 	u32 reg;
 
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 5a1da459eda5..37dfad8d003f 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -338,6 +338,7 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
+void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar);
 #else
 static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 {
@@ -351,5 +352,9 @@ static inline int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
 }
+
+static inline void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
+{
+}
 #endif
 #endif /* _PCIE_DESIGNWARE_H */
-- 
2.14.2
