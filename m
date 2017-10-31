Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/17] PCI: designware-ep: dw_pcie_ep_set_msi() should only set MMC bits
Date: Tue, 31 Oct 2017 23:39:20 +0100
Message-Id: <20171031223936.27549-3-niklas.cassel@axis.com>
In-Reply-To: <20171031223936.27549-1-niklas.cassel@axis.com>
References: <20171031223936.27549-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously, dw_pcie_ep_set_msi() wrote all bits in the Message Control
register, thus overwriting the PCI_MSI_FLAGS_64BIT bit.
By clearing the PCI_MSI_FLAGS_64BIT bit, we break MSI
on systems where the RC has set a 64 bit MSI address.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
V3:
* No change.

 drivers/pci/dwc/pcie-designware-ep.c | 4 +++-
 drivers/pci/dwc/pcie-designware.h    | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index d53d5f168363..c92ab87fd660 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -220,7 +220,9 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 encode_int)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	val = (encode_int << MSI_CAP_MMC_SHIFT);
+	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
+	val &= ~MSI_CAP_MMC_MASK;
+	val |= (encode_int << MSI_CAP_MMC_SHIFT) & MSI_CAP_MMC_MASK;
 	dw_pcie_writew_dbi(pci, MSI_MESSAGE_CONTROL, val);
 
 	return 0;
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index ecdede68522a..9aaf0cd04dd6 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -101,6 +101,7 @@
 
 #define MSI_MESSAGE_CONTROL		0x52
 #define MSI_CAP_MMC_SHIFT		1
+#define MSI_CAP_MMC_MASK		(7 << MSI_CAP_MMC_SHIFT)
 #define MSI_CAP_MME_SHIFT		4
 #define MSI_CAP_MME_MASK		(7 << MSI_CAP_MME_SHIFT)
 #define MSI_MESSAGE_ADDR_L32		0x54
-- 
2.14.2
