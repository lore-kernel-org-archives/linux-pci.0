Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:50852 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759090AbaJ3LpL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Oct 2014 07:45:11 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: liviu.dudau@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Anton Vorontsov <avorontsov@mvista.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [RFC PATCH 1/2] arm: cns3xxx: pci: remove artificial dependency on pci_sys_data domain
Date: Thu, 30 Oct 2014 11:44:47 +0000
Message-Id: <1414669490-1217-2-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On cns3xxx platforms the PCI controller probing code relies on an
artificial dependency on the domain number to look-up the internal
data structures.

This patch reworks the host controller control data structure and
adds a domain equivalent field named port in it so that the dependency on
pci_sys_data domain field can be eventually removed.

Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Anton Vorontsov <avorontsov@mvista.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[lp: added commit log, removed pci_sys_data domain references]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/mach-cns3xxx/pcie.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 45d6bd0..f6bf9f6 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -30,18 +30,15 @@ struct cns3xxx_pcie {
 	unsigned int irqs[2];
 	struct resource res_io;
 	struct resource res_mem;
-	struct hw_pci hw_pci;
-
+	int port;
 	bool linked;
 };
 
-static struct cns3xxx_pcie cns3xxx_pcie[]; /* forward decl. */
-
 static struct cns3xxx_pcie *sysdata_to_cnspci(void *sysdata)
 {
 	struct pci_sys_data *root = sysdata;
 
-	return &cns3xxx_pcie[root->domain];
+	return root->private_data;
 }
 
 static struct cns3xxx_pcie *pdev_to_cnspci(const struct pci_dev *dev)
@@ -192,13 +189,7 @@ static struct cns3xxx_pcie cns3xxx_pcie[] = {
 			.flags = IORESOURCE_MEM,
 		},
 		.irqs = { IRQ_CNS3XXX_PCIE0_RC, IRQ_CNS3XXX_PCIE0_DEVICE, },
-		.hw_pci = {
-			.domain = 0,
-			.nr_controllers = 1,
-			.ops = &cns3xxx_pcie_ops,
-			.setup = cns3xxx_pci_setup,
-			.map_irq = cns3xxx_pcie_map_irq,
-		},
+		.port = 0,
 	},
 	[1] = {
 		.host_regs = (void __iomem *)CNS3XXX_PCIE1_HOST_BASE_VIRT,
@@ -217,19 +208,13 @@ static struct cns3xxx_pcie cns3xxx_pcie[] = {
 			.flags = IORESOURCE_MEM,
 		},
 		.irqs = { IRQ_CNS3XXX_PCIE1_RC, IRQ_CNS3XXX_PCIE1_DEVICE, },
-		.hw_pci = {
-			.domain = 1,
-			.nr_controllers = 1,
-			.ops = &cns3xxx_pcie_ops,
-			.setup = cns3xxx_pci_setup,
-			.map_irq = cns3xxx_pcie_map_irq,
-		},
+		.port = 1,
 	},
 };
 
 static void __init cns3xxx_pcie_check_link(struct cns3xxx_pcie *cnspci)
 {
-	int port = cnspci->hw_pci.domain;
+	int port = cnspci->port;
 	u32 reg;
 	unsigned long time;
 
@@ -260,9 +245,9 @@ static void __init cns3xxx_pcie_check_link(struct cns3xxx_pcie *cnspci)
 
 static void __init cns3xxx_pcie_hw_init(struct cns3xxx_pcie *cnspci)
 {
-	int port = cnspci->hw_pci.domain;
+	int port = cnspci->port;
 	struct pci_sys_data sd = {
-		.domain = port,
+		.private_data = cnspci,
 	};
 	struct pci_bus bus = {
 		.number = 0,
@@ -323,6 +308,14 @@ static int cns3xxx_pcie_abort_handler(unsigned long addr, unsigned int fsr,
 void __init cns3xxx_pcie_init_late(void)
 {
 	int i;
+	void *private_data;
+	struct hw_pci hw_pci = {
+	       .nr_controllers = 1,
+	       .ops = &cns3xxx_pcie_ops,
+	       .setup = cns3xxx_pci_setup,
+	       .map_irq = cns3xxx_pcie_map_irq,
+	       .private_data = &private_data,
+	};
 
 	pcibios_min_io = 0;
 	pcibios_min_mem = 0;
@@ -335,7 +328,8 @@ void __init cns3xxx_pcie_init_late(void)
 		cns3xxx_pwr_soft_rst(0x1 << PM_SOFT_RST_REG_OFFST_PCIE(i));
 		cns3xxx_pcie_check_link(&cns3xxx_pcie[i]);
 		cns3xxx_pcie_hw_init(&cns3xxx_pcie[i]);
-		pci_common_init(&cns3xxx_pcie[i].hw_pci);
+		private_data = &cns3xxx_pcie[i];
+		pci_common_init(&hw_pci);
 	}
 
 	pci_assign_unassigned_resources();
-- 
2.1.2

