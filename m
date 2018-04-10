Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:35901 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbeDJROz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2018 13:14:55 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, niklas.cassel@axis.com,
        jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [RFC 02/10] PCI: cadence: Update cdns_pcie_ep_raise_irq function signature
Date: Tue, 10 Apr 2018 18:14:41 +0100
Message-Id: <52314006c63f8d21907dfaa03207b39e36bb8171.1523379766.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes the cdns_pcie_ep_raise_irq function signature, namely the
interrupt_num variable type from u8 to u16 to accommodate the MSI-X maximum
interrupts of 2048.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/cadence/pcie-cadence-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
index 3d8283e..6d6322c 100644
--- a/drivers/pci/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/cadence/pcie-cadence-ep.c
@@ -363,7 +363,7 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 }
 
 static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
-				  enum pci_epc_irq_type type, u8 interrupt_num)
+				  enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 
-- 
2.7.4
