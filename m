Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:41906 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727348AbeIRUw4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 16:52:56 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <lorenzo.pieralisi@arm.com>
CC: <kishon@ti.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v3 4/5] PCI: cadence: Check link is up before sending IRQ from EP
Date: Tue, 18 Sep 2018 16:19:36 +0100
Message-ID: <1537283976-19703-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If EP attempts to send an IRQ (legacy, MSI or MSI-X) while the
link is not up, return -EINVAL

Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/controller/pcie-cadence-ep.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index 56f6b87..1248d75 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -370,6 +370,12 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
 				  enum pci_epc_irq_type type, u8 interrupt_num)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	u32 link_status;
+
+	/* Can't send an IRQ if the link is down. */
+	link_status = cdns_pcie_readl(&ep->pcie, CDNS_PCIE_LM_BASE);
+	if (!(link_status & 0x1))
+		return -EINVAL;
 
 	switch (type) {
 	case PCI_EPC_IRQ_LEGACY:
-- 
1.9.0
