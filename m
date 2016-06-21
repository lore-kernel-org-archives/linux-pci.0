Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Ley Foon Tan <lftan.linux@gmail.com>,
	Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 1/2] PCI: altera: check link status before retrain link
Date: Tue, 21 Jun 2016 16:53:12 +0800
Message-ID: <1466499193-1987-2-git-send-email-lftan@altera.com>
In-Reply-To: <1466499193-1987-1-git-send-email-lftan@altera.com>
References: <1466499193-1987-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Checking for link up status before retrain link.

Note, moves altera_pcie_link_is_up() and its dependency functions
to top of file.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/host/pcie-altera.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index dbac6fb..78f77e1 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -81,9 +81,29 @@ struct tlp_rp_regpair_t {
 	u32 reg1;
 };
 
+static inline void cra_writel(struct altera_pcie *pcie, const u32 value,
+			      const u32 reg)
+{
+	writel_relaxed(value, pcie->cra_base + reg);
+}
+
+static inline u32 cra_readl(struct altera_pcie *pcie, const u32 reg)
+{
+	return readl_relaxed(pcie->cra_base + reg);
+}
+
+static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
+{
+	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
+}
+
 static void altera_pcie_retrain(struct pci_dev *dev)
 {
 	u16 linkcap, linkstat;
+	struct altera_pcie *pcie = dev->bus->sysdata;
+
+	if(!altera_pcie_link_is_up(pcie))
+		return;
 
 	/*
 	 * Set the retrain bit if the PCIe rootport support > 2.5GB/s, but
@@ -120,17 +140,6 @@ static bool altera_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
 	return false;
 }
 
-static inline void cra_writel(struct altera_pcie *pcie, const u32 value,
-			      const u32 reg)
-{
-	writel_relaxed(value, pcie->cra_base + reg);
-}
-
-static inline u32 cra_readl(struct altera_pcie *pcie, const u32 reg)
-{
-	return readl_relaxed(pcie->cra_base + reg);
-}
-
 static void tlp_write_tx(struct altera_pcie *pcie,
 			 struct tlp_rp_regpair_t *tlp_rp_regdata)
 {
@@ -139,11 +148,6 @@ static void tlp_write_tx(struct altera_pcie *pcie,
 	cra_writel(pcie, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
 }
 
-static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
-{
-	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
-}
-
 static bool altera_pcie_valid_config(struct altera_pcie *pcie,
 				     struct pci_bus *bus, int dev)
 {
-- 
1.8.2.1
