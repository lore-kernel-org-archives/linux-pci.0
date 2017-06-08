Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751466AbdFHOPx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:15:53 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: [RFT PATCH v2 42/42] ARM64: PCI: Drop DT IRQ allocation from pcibios_alloc_irq()
Date: Thu,  8 Jun 2017 15:13:42 +0100
Message-Id: <20170608141342.2018-43-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With the introduction of struct pci_host_bridge.map_irq pointer it is
possible to assign IRQs for all devices originating from a PCI host
bridge at probe time; this is implemented through pci_assign_irq() that
relies on the struct pci_host_bridge.map_irq pointer to map IRQ for a
given device.

The benefits this brings are twofold:

- the IRQ for a device is assigned once at probe time
- the IRQ assignment works also for hotplugged devices

With all DT based PCI host bridges converted to the struct
pci_host_bridge.{map/swizzle}_irq hooks mechanism the DT IRQ
allocation in ARM64 pcibios_alloc_irq() is now redundant and can
be removed.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm64/kernel/pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 4f0e3eb..efcc351 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -39,20 +39,18 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return res->start;
 }
 
+#ifdef CONFIG_ACPI
 /*
  * Try to assign the IRQ number when probing a new device
  */
 int pcibios_alloc_irq(struct pci_dev *dev)
 {
-	if (acpi_disabled)
-		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
-#ifdef CONFIG_ACPI
-	else
-		return acpi_pci_irq_enable(dev);
-#endif
+	if (!acpi_disabled)
+		acpi_pci_irq_enable(dev);
 
 	return 0;
 }
+#endif
 
 /*
  * raw_pci_read/write - Platform-specific PCI config space access.
-- 
2.10.0
