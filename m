Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbdB0PPc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Feb 2017 10:15:32 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        John Garry <john.garry@huawei.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Ray Jui <rjui@broadcom.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Jon Mason <jonmason@broadcom.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH 01/20] PCI: remove __weak tag from pci_remap_iospace()
Date: Mon, 27 Feb 2017 15:14:12 +0000
Message-Id: <20170227151436.18698-2-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_remap_iospace() is marked as a weak symbol even though
no architecture is currently overriding it; given that its
implementation internals have already code paths that are
arch specific (ie PCI_IOBASE and ioremap_page_range() attributes)
there is no need to leave the weak symbol in the kernel since the
same functionality can be achieved by customizing per-arch the
corresponding functionality.

Remove the __weak symbol from pci_remap_iospace().

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02..bd98674 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3363,7 +3363,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
  *	Only architectures that have memory mapped IO functions defined
  *	(and the PCI_IOBASE value defined) should call this function.
  */
-int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
+int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 {
 #if defined(PCI_IOBASE) && defined(CONFIG_MMU)
 	unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
-- 
2.10.0
