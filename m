Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0042.outbound.protection.outlook.com ([104.47.40.42]:55299
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbeG3TDx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jul 2018 15:03:53 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>
CC: <kishon@ti.com>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, <stelford@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: [PATCH 4/5] PCI: cadence: Check link is up before sending IRQ from EP
Date: Mon, 30 Jul 2018 18:23:24 +0100
Message-ID: <1532971404-9444-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If EP attempts to send an IRQ (legacy, MSI or MSI-X) while the
link is not up, return -EINVAL

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/controller/pcie-cadence-ep.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index db75280..33e30dd 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -370,6 +370,12 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
 				  u16 interrupt_num)
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
1.7.1
