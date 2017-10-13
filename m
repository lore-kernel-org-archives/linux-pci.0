Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:52213 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751918AbdJMQJa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2017 12:09:30 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] PCI: designware-ep: read-only registers need DBI_RO_WR_EN to be writable
Date: Fri, 13 Oct 2017 18:09:06 +0200
Message-Id: <20171013160914.3220-4-niklas.cassel@axis.com>
In-Reply-To: <20171013160914.3220-1-niklas.cassel@axis.com>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Certain registers that pcie-designware-ep tries to write are read-only
registers. However, these registers can become read/write if we first
enable the DBI_RO_WR_EN bit.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pcie-designware-ep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index c92ab87fd660..3fb34be99715 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -35,8 +35,10 @@ static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 	u32 reg;
 
 	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writel_dbi2(pci, reg, 0x0);
 	dw_pcie_writel_dbi(pci, reg, 0x0);
+	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
 static int dw_pcie_ep_write_header(struct pci_epc *epc,
@@ -45,6 +47,7 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, hdr->vendorid);
 	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, hdr->deviceid);
 	dw_pcie_writeb_dbi(pci, PCI_REVISION_ID, hdr->revid);
@@ -58,6 +61,7 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc,
 	dw_pcie_writew_dbi(pci, PCI_SUBSYSTEM_ID, hdr->subsys_id);
 	dw_pcie_writeb_dbi(pci, PCI_INTERRUPT_PIN,
 			   hdr->interrupt_pin);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
 }
@@ -142,8 +146,10 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, enum pci_barno bar,
 	if (ret)
 		return ret;
 
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writel_dbi2(pci, reg, size - 1);
 	dw_pcie_writel_dbi(pci, reg, flags);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
 }
@@ -223,7 +229,9 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 encode_int)
 	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
 	val &= ~MSI_CAP_MMC_MASK;
 	val |= (encode_int << MSI_CAP_MMC_SHIFT) & MSI_CAP_MMC_MASK;
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writew_dbi(pci, MSI_MESSAGE_CONTROL, val);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
 }
-- 
2.11.0
