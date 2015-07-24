Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45941 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbbGXQMX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 24 Jul 2015 12:12:23 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	James Morse <james.morse@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 1/2] ARM: PCI: bios32: replace panic with WARN messages on failures
Date: Fri, 24 Jul 2015 17:13:02 +0100
Message-Id: <1437754383-8162-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In the ARM PCI bios32 layer, failures to dynamically allocate pci_sys_data
for a PCI bus, or a PCI bus scan failure have to be considered serious
warnings but they should not trigger a system panic so that at least the
system is given a chance to be debugged.

This patch replaces the panic statements with WARN() messages to
improve error reporting in the ARM PCI bios32 layer.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/bios32.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index fcbbbb1..a5c782c 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -459,8 +459,8 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 
 	for (nr = busnr = 0; nr < hw->nr_controllers; nr++) {
 		sys = kzalloc(sizeof(struct pci_sys_data), GFP_KERNEL);
-		if (!sys)
-			panic("PCI: unable to allocate sys data!");
+		if (WARN(!sys, "PCI: unable to allocate sys data!"))
+			break;
 
 #ifdef CONFIG_PCI_MSI
 		sys->msi_ctrl = hw->msi_ctrl;
@@ -489,8 +489,10 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 				sys->bus = pci_scan_root_bus(parent, sys->busnr,
 						hw->ops, sys, &sys->resources);
 
-			if (!sys->bus)
-				panic("PCI: unable to scan bus!");
+			if (WARN(!sys->bus, "PCI: unable to scan bus!")) {
+				kfree(sys);
+				break;
+			}
 
 			busnr = sys->bus->busn_res.end + 1;
 
-- 
2.2.1

