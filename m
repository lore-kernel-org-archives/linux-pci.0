Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com, sboyd@codeaurora.org
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v5 02/11] PCI: Update xxx_pcie_ep_raise_irq() and pci_epc_raise_irq() signatures
Date: Wed, 20 Jun 2018 17:28:24 +0100
Message-Id: <180c7a9743a67120e77ab198889c1373e91643b9.1529507416.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
References: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
References: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change {cdns, dra7xx, artpec6, dw, rockchip}_pcie_ep_raise_irq() and
pci_epc_raise_irq() signature, namely the interrupt_num variable type
from u8 to u16 to accommodate 2048 maximum MSI-X interrupts.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Alan Douglas <adouglas@cadence.com>
---
Change v1->v2:
 - Nothing changed, just to follow the patch set version.
Change v2->v3:
 - Move into here the pci_epc_raise_irq() signature change from patch
file #1.
 - Move into here the {dra7xx, artpec6}_pcie_ep_raise_irq() signature
changes from patch file #2.
Change v3->v4:
 - Rebased to Lorenzo's master branch v4.18-rc1.
Change v4->v5:
 - Swap patch files position (#3 -> #2).
 - Moved dw_pcie_ep_raise_irq and dw_plat_pcie_ep_raise_irq functions
signatures changes from patch file #3.
 - Changed rockchip_pcie_ep_raise_irq function signature.

 drivers/pci/controller/dwc/pci-dra7xx.c           | 2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c         | 2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 2 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h      | 2 +-
 drivers/pci/controller/pcie-cadence-ep.c          | 3 ++-
 drivers/pci/controller/pcie-rockchip-ep.c         | 2 +-
 drivers/pci/endpoint/pci-epc-core.c               | 8 ++++----
 include/linux/pci-epc.h                           | 6 +++---
 9 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 345aab5..ce9224a 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -370,7 +370,7 @@ static void dra7xx_pcie_raise_msi_irq(struct dra7xx_pcie *dra7xx,
 }
 
 static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				 enum pci_epc_irq_type type, u8 interrupt_num)
+				 enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 321b56c..9a2474b 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -428,7 +428,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
 }
 
 static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-				  enum pci_epc_irq_type type, u8 interrupt_num)
+				  enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 8650416..b86cb99 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -242,7 +242,7 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 encode_int)
 }
 
 static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no,
-				enum pci_epc_irq_type type, u8 interrupt_num)
+				enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 5937fed..14b6b4b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -78,7 +78,7 @@ static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
 
 static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 				     enum pci_epc_irq_type type,
-				     u8 interrupt_num)
+				     u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index bee4e25..9d581c0 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -191,7 +191,7 @@ enum dw_pcie_as_type {
 struct dw_pcie_ep_ops {
 	void	(*ep_init)(struct dw_pcie_ep *ep);
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
-			     enum pci_epc_irq_type type, u8 interrupt_num);
+			     enum pci_epc_irq_type type, u16 interrupt_num);
 };
 
 struct dw_pcie_ep {
diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index e3fe412..208d11f 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -363,7 +363,8 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 }
 
 static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
-				  enum pci_epc_irq_type type, u8 interrupt_num)
+				  enum pci_epc_irq_type type,
+				  u16 interrupt_num)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 6beba8e..b8163c5 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -472,7 +472,7 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 
 static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
 				      enum pci_epc_irq_type type,
-				      u8 interrupt_num)
+				      u16 interrupt_num)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 7d77bd0..c72e656 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -131,13 +131,13 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
  * pci_epc_raise_irq() - interrupt the host system
  * @epc: the EPC device which has to interrupt the host
  * @func_no: the endpoint function number in the EPC device
- * @type: specify the type of interrupt; legacy or MSI
- * @interrupt_num: the MSI interrupt number
+ * @type: specify the type of interrupt; legacy, MSI or MSI-X
+ * @interrupt_num: the MSI or MSI-X interrupt number
  *
- * Invoke to raise an MSI or legacy interrupt
+ * Invoke to raise an legacy, MSI or MSI-X interrupt
  */
 int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
-		      enum pci_epc_irq_type type, u8 interrupt_num)
+		      enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	int ret;
 	unsigned long flags;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 89f079f..bb2395b 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -35,7 +35,7 @@ enum pci_epc_irq_type {
  *	     MSI-X capability register
  * @get_msix: ops to get the number of MSI-X interrupts allocated by the RC
  *	     from the MSI-X capability register
- * @raise_irq: ops to raise a legacy or MSI interrupt
+ * @raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @owner: the module owner containing the ops
@@ -56,7 +56,7 @@ struct pci_epc_ops {
 	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u16 interrupts);
 	int	(*get_msix)(struct pci_epc *epc, u8 func_no);
 	int	(*raise_irq)(struct pci_epc *epc, u8 func_no,
-			     enum pci_epc_irq_type type, u8 interrupt_num);
+			     enum pci_epc_irq_type type, u16 interrupt_num);
 	int	(*start)(struct pci_epc *epc);
 	void	(*stop)(struct pci_epc *epc);
 	struct module *owner;
@@ -154,7 +154,7 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no);
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts);
 int pci_epc_get_msix(struct pci_epc *epc, u8 func_no);
 int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
-		      enum pci_epc_irq_type type, u8 interrupt_num);
+		      enum pci_epc_irq_type type, u16 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 struct pci_epc *pci_epc_get(const char *epc_name);
-- 
2.7.4
