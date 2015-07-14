Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
CC: <linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH 1/4] PCI: iproc: enable arm64 support for iProc PCIe
Date: Mon, 13 Jul 2015 18:39:12 -0700
Message-ID: <1436837955-26279-2-git-send-email-rjui@broadcom.com>
In-Reply-To: <1436837955-26279-1-git-send-email-rjui@broadcom.com>
References: <1436837955-26279-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch enables arm64 support to iProc PCIe driver by wrapping
ARM 32-bit specific PCI APIs with CONFIG_ARM

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c |   12 ++++++++++++
 drivers/pci/host/pcie-iproc.h |    2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index d77481e..a76b4df 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -58,10 +58,12 @@
 #define SYS_RC_INTX_EN               0x330
 #define SYS_RC_INTX_MASK             0xf
 
+#ifdef CONFIG_ARM
 static inline struct iproc_pcie *sys_to_pcie(struct pci_sys_data *sys)
 {
 	return sys->private_data;
 }
+#endif
 
 /**
  * Note access to the configuration registers are protected at the higher layer
@@ -71,8 +73,12 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 					    unsigned int devfn,
 					    int where)
 {
+#ifdef CONFIG_ARM
 	struct pci_sys_data *sys = bus->sysdata;
 	struct iproc_pcie *pcie = sys_to_pcie(sys);
+#else
+	struct iproc_pcie *pcie = bus->sysdata;
+#endif
 	unsigned slot = PCI_SLOT(devfn);
 	unsigned fn = PCI_FUNC(devfn);
 	unsigned busno = bus->number;
@@ -208,10 +214,14 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 
 	iproc_pcie_reset(pcie);
 
+#ifdef CONFIG_ARM
 	pcie->sysdata.private_data = pcie;
 
 	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops,
 				  &pcie->sysdata, res);
+#else
+	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops, pcie, res);
+#endif
 	if (!bus) {
 		dev_err(pcie->dev, "unable to create PCI root bus\n");
 		ret = -ENOMEM;
@@ -229,7 +239,9 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
+#ifdef CONFIG_ARM
 	pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
+#endif
 	pci_bus_add_devices(bus);
 
 	return 0;
diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
index ba0a108..12aaac4 100644
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -29,7 +29,9 @@
 struct iproc_pcie {
 	struct device *dev;
 	void __iomem *base;
+#ifdef CONFIG_ARM
 	struct pci_sys_data sysdata;
+#endif
 	struct pci_bus *root_bus;
 	struct phy *phy;
 	int irqs[IPROC_PCIE_MAX_NUM_IRQS];
-- 
1.7.9.5

