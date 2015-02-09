Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"Will Deacon" <will.deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>
CC: Marc Zyngier <marc.zyngier@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 1/2] pci: generic: Use the pci_scan_root_bus instead of pci_common_init_dev
Date: Mon, 9 Feb 2015 23:22:29 +0800
Message-ID: <1423495350-12295-2-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1423495350-12295-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1423495350-12295-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replacing pci_common_init_dev with pci_scan_root_bus, and remove reference
to struct pci_sys_data and pci_hw, which is specific to ARM32. This allows
the PCI host generic driver to also usable in ARM64 architecture.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

---
 drivers/pci/host/Kconfig            |  2 +-
 drivers/pci/host/pci-host-generic.c | 33 ++++++++++-----------------------
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index c4b6568..739bab0 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -53,7 +53,7 @@ config PCI_RCAR_GEN2_PCIE
 
 config PCI_HOST_GENERIC
 	bool "Generic PCI host controller"
-	depends on ARM && OF
+	depends on (ARM||ARM64) && OF
 	help
 	  Say Y here if you want to support a simple generic PCI host
 	  controller, such as the one emulated by kvmtool.
diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 6eb1aa7..93f64e4 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -48,8 +48,7 @@ static void __iomem *gen_pci_map_cfg_bus_cam(struct pci_bus *bus,
 					     unsigned int devfn,
 					     int where)
 {
-	struct pci_sys_data *sys = bus->sysdata;
-	struct gen_pci *pci = sys->private_data;
+	struct gen_pci *pci = bus->sysdata;
 	resource_size_t idx = bus->number - pci->cfg.bus_range->start;
 
 	return pci->cfg.win[idx] + ((devfn << 8) | where);
@@ -64,8 +63,7 @@ static void __iomem *gen_pci_map_cfg_bus_ecam(struct pci_bus *bus,
 					      unsigned int devfn,
 					      int where)
 {
-	struct pci_sys_data *sys = bus->sysdata;
-	struct gen_pci *pci = sys->private_data;
+	struct gen_pci *pci = bus->sysdata;
 	resource_size_t idx = bus->number - pci->cfg.bus_range->start;
 
 	return pci->cfg.win[idx] + ((devfn << 12) | where);
@@ -80,8 +78,7 @@ static int gen_pci_config_read(struct pci_bus *bus, unsigned int devfn,
 				int where, int size, u32 *val)
 {
 	void __iomem *addr;
-	struct pci_sys_data *sys = bus->sysdata;
-	struct gen_pci *pci = sys->private_data;
+	struct gen_pci *pci = bus->sysdata;
 
 	addr = pci->cfg.ops->map_bus(bus, devfn, where);
 
@@ -103,8 +100,7 @@ static int gen_pci_config_write(struct pci_bus *bus, unsigned int devfn,
 				 int where, int size, u32 val)
 {
 	void __iomem *addr;
-	struct pci_sys_data *sys = bus->sysdata;
-	struct gen_pci *pci = sys->private_data;
+	struct gen_pci *pci = bus->sysdata;
 
 	addr = pci->cfg.ops->map_bus(bus, devfn, where);
 
@@ -244,13 +240,6 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
 	return 0;
 }
 
-static int gen_pci_setup(int nr, struct pci_sys_data *sys)
-{
-	struct gen_pci *pci = sys->private_data;
-	list_splice_init(&pci->resources, &sys->resources);
-	return 1;
-}
-
 static int gen_pci_probe(struct platform_device *pdev)
 {
 	int err;
@@ -260,13 +249,6 @@ static int gen_pci_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	struct hw_pci hw = {
-		.nr_controllers	= 1,
-		.private_data	= (void **)&pci,
-		.setup		= gen_pci_setup,
-		.map_irq	= of_irq_parse_and_map_pci,
-		.ops		= &gen_pci_ops,
-	};
 
 	if (!pci)
 		return -ENOMEM;
@@ -303,7 +285,12 @@ static int gen_pci_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	pci_common_init_dev(dev, &hw);
+	if (!pci_scan_root_bus(&pdev->dev, pci->cfg.bus_range->start,
+			       &gen_pci_ops, pci, &pci->resources)) {
+		dev_err(&pdev->dev, "failed to enable PCIe ports\n");
+		return -ENODEV;
+	}
+
 	return 0;
 }
 
-- 
2.1.0

