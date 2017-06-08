Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751659AbdFHOPo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:15:44 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ley Foon Tan <lftan@altera.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Matthew Minter <matt@masarand.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RFT PATCH v2 38/42] PCI: altera: Drop pci_fixup_irqs()
Date: Thu,  8 Jun 2017 15:13:38 +0100
Message-Id: <20170608141342.2018-39-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since, through struct pci_host_bridge.map/swizzle_irq hooks, IRQs
are now allocated in the pci_assign_irq() callback automatically,
PCI host bridge drivers can stop relying on pci_fixup_irqs()
for IRQ allocation.

Drop pci_fixup_irqs() usage from PCI altera host bridge driver.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/host/pcie-altera.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 7f023b2..4ea4f8f 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -620,6 +620,8 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	bridge->sysdata = pcie;
 	bridge->busnr = pcie->root_bus_nr;
 	bridge->ops = &altera_pcie_ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret < 0)
@@ -627,8 +629,6 @@ static int altera_pcie_probe(struct platform_device *pdev)
 
 	bus = bridge->bus;
 
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
-
 	pci_assign_unassigned_bus_resources(bus);
 
 	/* Configure PCI Express setting. */
-- 
2.10.0
