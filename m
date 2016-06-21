Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Ley Foon Tan <lftan.linux@gmail.com>,
	Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 2/2] PCI: altera: Polling for link up status after retrain the link
Date: Tue, 21 Jun 2016 16:53:13 +0800
Message-ID: <1466499193-1987-3-git-send-email-lftan@altera.com>
In-Reply-To: <1466499193-1987-1-git-send-email-lftan@altera.com>
References: <1466499193-1987-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some PCIe devices take longer time to reach link up state after retrain.
This patch polling for link up status after retrain the link. This is to
make sure the link is stable and up before we access to configuration space
registers after this.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/host/pcie-altera.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 78f77e1..a9de2a0 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -61,6 +61,8 @@
 #define TLP_LOOP			500
 #define RP_DEVFN			0
 
+#define LINK_UP_TIMEOUT			5000
+
 #define INTX_NUM			4
 
 #define DWORD_MASK			3
@@ -101,6 +103,7 @@ static void altera_pcie_retrain(struct pci_dev *dev)
 {
 	u16 linkcap, linkstat;
 	struct altera_pcie *pcie = dev->bus->sysdata;
+	int timeout =  0;
 
 	if(!altera_pcie_link_is_up(pcie))
 		return;
@@ -115,9 +118,16 @@ static void altera_pcie_retrain(struct pci_dev *dev)
 		return;
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
-	if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB)
+	if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
 		pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
 					 PCI_EXP_LNKCTL_RL);
+		while(!altera_pcie_link_is_up(pcie)) {
+			timeout++;
+			if (timeout > LINK_UP_TIMEOUT)
+				break;
+			udelay(5);
+		}
+	}
 }
 DECLARE_PCI_FIXUP_EARLY(0x1172, PCI_ANY_ID, altera_pcie_retrain);
 
-- 
1.8.2.1
