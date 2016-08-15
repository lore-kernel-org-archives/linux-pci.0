Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0075.outbound.protection.outlook.com ([104.47.34.75]:31809
	"EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752073AbcHOJgd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Aug 2016 05:36:33 -0400
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Ley Foon Tan <lftan.linux@gmail.com>,
	Ley Foon Tan <lftan@altera.com>
Subject: [PATCH] PCI: altera: Poll for link training status after retraining the link
Date: Mon, 15 Aug 2016 14:06:02 +0800
Message-ID: <1471241162-23021-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Poll for link training status is cleared before poll for link up status.
This can help to get the reliable link up status, especially when PCIe
is in Gen 3 speed.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/host/pcie-altera.c | 45 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 2b78376..58eef99 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -61,7 +61,8 @@
 #define TLP_LOOP			500
 #define RP_DEVFN			0
 
-#define LINK_UP_TIMEOUT			5000
+#define LINK_UP_TIMEOUT			HZ
+#define LINK_RETRAIN_TIMEOUT		HZ
 
 #define INTX_NUM			4
 
@@ -99,11 +100,44 @@ static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
 	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
 }
 
+static void altera_wait_link_retrain(struct pci_dev *dev)
+{
+	u16 reg16;
+	unsigned long start_jiffies;
+	struct altera_pcie *pcie = dev->bus->sysdata;
+
+	/* Wait for link training end. */
+	start_jiffies = jiffies;
+	for (;;) {
+		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &reg16);
+		if (!(reg16 & PCI_EXP_LNKSTA_LT))
+			break;
+
+		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT)) {
+			dev_err(&pcie->pdev->dev, "link retrain timeout\n");
+			break;
+		}
+		udelay(100);
+	}
+
+	/* Wait for link is up */
+	start_jiffies = jiffies;
+	for (;;) {
+		if (altera_pcie_link_is_up(pcie))
+			break;
+
+		if (time_after(jiffies, start_jiffies + LINK_UP_TIMEOUT)) {
+			dev_err(&pcie->pdev->dev, "link up timeout\n");
+			break;
+		}
+		udelay(100);
+	}
+}
+
 static void altera_pcie_retrain(struct pci_dev *dev)
 {
 	u16 linkcap, linkstat;
 	struct altera_pcie *pcie = dev->bus->sysdata;
-	int timeout =  0;
 
 	if (!altera_pcie_link_is_up(pcie))
 		return;
@@ -121,12 +155,7 @@ static void altera_pcie_retrain(struct pci_dev *dev)
 	if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
 		pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
 					 PCI_EXP_LNKCTL_RL);
-		while (!altera_pcie_link_is_up(pcie)) {
-			timeout++;
-			if (timeout > LINK_UP_TIMEOUT)
-				break;
-			udelay(5);
-		}
+		altera_wait_link_retrain(dev);
 	}
 }
 DECLARE_PCI_FIXUP_EARLY(0x1172, PCI_ANY_ID, altera_pcie_retrain);
-- 
1.8.2.1

