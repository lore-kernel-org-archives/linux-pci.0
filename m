Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:36435 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758218AbaKUL3y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Nov 2014 06:29:54 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>
Subject: [PATCH v3 2/2] arm: pcibios: move to generic PCI domains
Date: Fri, 21 Nov 2014 11:29:26 +0000
Message-Id: <1416569367-29409-3-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1416569367-29409-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1416569367-29409-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Most if not all ARM PCI host controller device drivers either ignore the
domain field in the pci_sys_data structure or just increment it every
time a host controller is probed, using it as a domain counter.

Therefore, instead of relying on pci_sys_data to stash the domain number
in a standard location, ARM pcibios code can be moved to the newly
introduced generic PCI domains code, implemented in commits:

commit 41e5c0f81d3e676d671d96a0a1fafb27abfbd9
("of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr()")

commit 670ba0c8883b576d0aec28bd7a838358a4be1
("PCI: Add generic domain handling")

ARM code is made to select PCI_DOMAINS_GENERIC by default, which
builds core PCI code that assigns the domain number through the
generic function:

void pci_bus_assign_domain_nr(...)

that relies on a DT property to define the domain number or falls back to
a counter according to a predefined logic; its usage replaces the current
domain assignment code in PCI host controllers present in the kernel.

Acked-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Phil Edworthy <phil.edworthy@renesas.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Mohit Kumar <mohit.kumar@st.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/arm/Kconfig                   |  3 +++
 arch/arm/include/asm/mach/pci.h    |  6 ------
 arch/arm/include/asm/pci.h         |  7 -------
 arch/arm/kernel/bios32.c           |  3 ---
 drivers/pci/host/pci-mvebu.c       | 15 ++-------------
 drivers/pci/host/pcie-designware.c |  3 ---
 drivers/pci/host/pcie-rcar.c       |  3 ---
 7 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 89c4b5c..29544f0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1292,6 +1292,9 @@ config PCI_DOMAINS
 	bool
 	depends on PCI
 
+config PCI_DOMAINS_GENERIC
+	def_bool PCI_DOMAINS
+
 config PCI_NANOENGINE
 	bool "BSE nanoEngine PCI support"
 	depends on SA1100_NANOENGINE
diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 7fc4278..112b770 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -19,9 +19,6 @@ struct pci_bus;
 struct device;
 
 struct hw_pci {
-#ifdef CONFIG_PCI_DOMAINS
-	int		domain;
-#endif
 	struct pci_ops	*ops;
 	int		nr_controllers;
 	void		**private_data;
@@ -44,9 +41,6 @@ struct hw_pci {
  * Per-controller structure
  */
 struct pci_sys_data {
-#ifdef CONFIG_PCI_DOMAINS
-	int		domain;
-#endif
 	struct list_head node;
 	int		busnr;		/* primary bus number			*/
 	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 7e95d85..585dc33 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -18,13 +18,6 @@ static inline int pcibios_assign_all_busses(void)
 }
 
 #ifdef CONFIG_PCI_DOMAINS
-static inline int pci_domain_nr(struct pci_bus *bus)
-{
-	struct pci_sys_data *root = bus->sysdata;
-
-	return root->domain;
-}
-
 static inline int pci_proc_domain(struct pci_bus *bus)
 {
 	return pci_domain_nr(bus);
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 17a26c1..76a76ec 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -468,9 +468,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		if (!sys)
 			panic("PCI: unable to allocate sys data!");
 
-#ifdef CONFIG_PCI_DOMAINS
-		sys->domain  = hw->domain;
-#endif
 		sys->busnr   = busnr;
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index b1315e1..dc2ed4d 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -101,9 +101,7 @@ struct mvebu_pcie {
 	struct mvebu_pcie_port *ports;
 	struct msi_chip *msi;
 	struct resource io;
-	char io_name[30];
 	struct resource realio;
-	char mem_name[30];
 	struct resource mem;
 	struct resource busn;
 	int nports;
@@ -722,18 +720,9 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
 {
 	struct mvebu_pcie *pcie = sys_to_pcie(sys);
 	int i;
-	int domain = 0;
 
-#ifdef CONFIG_PCI_DOMAINS
-	domain = sys->domain;
-#endif
-
-	snprintf(pcie->mem_name, sizeof(pcie->mem_name), "PCI MEM %04x",
-		 domain);
-	pcie->mem.name = pcie->mem_name;
-
-	snprintf(pcie->io_name, sizeof(pcie->io_name), "PCI I/O %04x", domain);
-	pcie->realio.name = pcie->io_name;
+	pcie->mem.name = "PCI MEM";
+	pcie->realio.name = "PCI I/O";
 
 	if (request_resource(&iomem_resource, &pcie->mem))
 		return 0;
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index dfed00a..6790b87 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -502,9 +502,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	dw_pci.private_data = (void **)&pp;
 
 	pci_common_init_dev(pp->dev, &dw_pci);
-#ifdef CONFIG_PCI_DOMAINS
-	dw_pci.domain++;
-#endif
 
 	return 0;
 }
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 61158e0..b6b859e 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -404,9 +404,6 @@ static void rcar_pcie_enable(struct rcar_pcie *pcie)
 	rcar_pci.private_data = (void **)&pcie;
 
 	pci_common_init_dev(&pdev->dev, &rcar_pci);
-#ifdef CONFIG_PCI_DOMAINS
-	rcar_pci.domain++;
-#endif
 }
 
 static int phy_wait_for_ack(struct rcar_pcie *pcie)
-- 
2.1.2

