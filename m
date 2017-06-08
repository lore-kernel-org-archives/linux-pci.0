Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751576AbdFHOPs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:15:48 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
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
Subject: [RFT PATCH v2 41/42] PCI: xilinx-nwl: Move to struct pci_host_bridge IRQ mapping functions
Date: Thu,  8 Jun 2017 15:13:41 +0100
Message-Id: <20170608141342.2018-42-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

struct pci_host_bridge gained hooks to map/swizzle IRQs, so that
the IRQ mapping can be done automatically by PCI core code through
the pci_assign_irq() function instead of resorting to per-arch
specific implementation callbacks to carry out the same task which
force PCI host bridge drivers implementation to implement per-arch
kludges to carry out a task that is inherently architecture agnostic.

Add map/swizzle IRQs hooks to the xilinx-nwl PCI host driver to move
the IRQ allocation into core code and stop relying on arch specific
callbacks.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index e8a5894..d1f7e4c 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -838,6 +838,8 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	bridge->sysdata = pcie;
 	bridge->busnr = pcie->root_busno;
 	bridge->ops = &nwl_pcie_ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = nwl_pcie_enable_msi(pcie);
-- 
2.10.0
