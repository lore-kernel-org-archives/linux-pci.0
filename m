Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:29054 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeBIMDx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Feb 2018 07:03:53 -0500
From: Vignesh R <vigneshr@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/3] Revert "PCI: dwc: Clear MSI interrupt status after it is handled, not before"
Date: Fri, 9 Feb 2018 17:34:13 +0530
Message-ID: <20180209120415.17590-2-vigneshr@ti.com>
In-Reply-To: <20180209120415.17590-1-vigneshr@ti.com>
References: <20180209120415.17590-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since commit 06e15e6883bed ("PCI: dwc: Clear MSI interrupt status after
it is handled, not before"), MSI IRQ status in PCIE_MSI_INTR0_STATUS
register is cleared after calling EP's IRQ handler.
But, MSI IRQs in case of PCIe are bit like edge interrupts. If a
another MSI IRQ is raised and the end of current EP's IRQ handler call
but before clearing the MSI IRQ status in PCIE_MSI_INTR0_STATUS register
then the new MSI IRQ is lost.

This issue has been observed in case of USB-Ethernet adapter connected
to PCIe USB card running iperf3 test. iperf3 client stalls after
sometime as reported here[1]. This is because XHCI raises MSI IRQ at the
end of its IRQ handler but before PCIe driver has cleared its status
in PCIE_MSI_INTR0_STATUS register. Hence, the new IRQ is never
registered by PCIe designware core. Since, XHCI does not raise any more
IRQs until the previous one is handled, it leads to a stall in
communication.
Therefore driver should always clear the MSI IRQ status in
PCIE_MSI_INTR0_STATUS before calling EP's IRQ handler. This make sure
that DW PCIe core catches new IRQ raised during the call to EP's IRQ
handler

[1] https://lkml.kernel.org/r/BN6PR18MB124994D85EAC4B5B1AD5EC56866E0@BN6PR18MB1249.namprd18.prod.outlook.com

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/pci/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 8de2d5c69b1d..c29cbcd430f4 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -68,9 +68,9 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 		while ((pos = find_next_bit((unsigned long *) &val, 32,
 					    pos)) != 32) {
 			irq = irq_find_mapping(pp->irq_domain, i * 32 + pos);
-			generic_handle_irq(irq);
 			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12,
 					    4, 1 << pos);
+			generic_handle_irq(irq);
 			pos++;
 		}
 	}
-- 
2.16.1
