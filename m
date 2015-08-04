Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:33923 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbbHDVx7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 17:53:59 -0400
Received: by ioea135 with SMTP id a135so31217605ioe.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2015 14:53:59 -0700 (PDT)
Subject: [PATCH v5 1/9] ARM/PCI: Replace panic with WARN messages on failures
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Duc Dang <dhdang@apm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Simon Horman <horms@verge.net.au>,
	James Morse <james.morse@arm.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>
Date: Tue, 04 Aug 2015 16:53:57 -0500
Message-ID: <20150804215357.9189.11942.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

In the ARM PCI bios32 layer, failures to dynamically allocate pci_sys_data
for a PCI bus, or a PCI bus scan failure have to be considered serious
warnings but they should not trigger a system panic so that at least the
system is given a chance to be debugged.

This patch replaces the panic statements with WARN() messages to improve
error reporting in the ARM PCI bios32 layer.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/bios32.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index bf370bc..4e95260 100644
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
 

