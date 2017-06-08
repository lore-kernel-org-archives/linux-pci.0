Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751450AbdFHONp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:13:45 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Scott Branden <sbranden@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
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
Subject: [RFT PATCH v2 15/42] PCI: iproc: Convert PCI scan API to pci_scan_root_bus_bridge()
Date: Thu,  8 Jun 2017 15:13:15 +0100
Message-Id: <20170608141342.2018-16-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge.

Convert PCI iproc host code to pci_scan_root_bus_bridge() to
improve the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
---
 drivers/pci/host/pcie-iproc-bcma.c     |  7 +++++--
 drivers/pci/host/pcie-iproc-platform.c |  7 +++++--
 drivers/pci/host/pcie-iproc.c          | 38 ++++++++++++++++++----------------
 3 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
index 384c27e..f03d5e3 100644
--- a/drivers/pci/host/pcie-iproc-bcma.c
+++ b/drivers/pci/host/pcie-iproc-bcma.c
@@ -45,12 +45,15 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 	struct device *dev = &bdev->dev;
 	struct iproc_pcie *pcie;
 	LIST_HEAD(resources);
+	struct pci_host_bridge *bridge;
 	int ret;
 
-	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
+	if (!bridge)
 		return -ENOMEM;
 
+	pcie = pci_host_bridge_priv(bridge);
+
 	pcie->dev = dev;
 
 	pcie->type = IPROC_PCIE_PAXB_BCMA;
diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index 90d2bdd..2253119 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -52,12 +52,15 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	struct resource reg;
 	resource_size_t iobase = 0;
 	LIST_HEAD(resources);
+	struct pci_host_bridge *bridge;
 	int ret;
 
-	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
+	if (!bridge)
 		return -ENOMEM;
 
+	pcie = pci_host_bridge_priv(bridge);
+
 	pcie->dev = dev;
 	pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);
 
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index e48b8e2..55a3665 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -1259,7 +1259,8 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	struct device *dev;
 	int ret;
 	void *sysdata;
-	struct pci_bus *bus, *child;
+	struct pci_bus *child;
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 
 	dev = pcie->dev;
 
@@ -1306,18 +1307,10 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	sysdata = pcie;
 #endif
 
-	bus = pci_create_root_bus(dev, 0, &iproc_pcie_ops, sysdata, res);
-	if (!bus) {
-		dev_err(dev, "unable to create PCI root bus\n");
-		ret = -ENOMEM;
-		goto err_power_off_phy;
-	}
-	pcie->root_bus = bus;
-
 	ret = iproc_pcie_check_link(pcie);
 	if (ret) {
 		dev_err(dev, "no PCIe EP device detected\n");
-		goto err_rm_root_bus;
+		goto err_power_off_phy;
 	}
 
 	iproc_pcie_enable(pcie);
@@ -1326,23 +1319,32 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 		if (iproc_pcie_msi_enable(pcie))
 			dev_info(dev, "not using iProc MSI\n");
 
-	pci_scan_child_bus(bus);
-	pci_assign_unassigned_bus_resources(bus);
+	list_splice_init(res, &host->windows);
+	host->busnr = 0;
+	host->dev.parent = dev;
+	host->ops = &iproc_pcie_ops;
+	host->sysdata = sysdata;
+
+	ret = pci_scan_root_bus_bridge(host);
+	if (ret < 0) {
+		dev_err(dev, "failed to scan host: %d\n", ret);
+		goto err_power_off_phy;
+	}
 
 	if (pcie->map_irq)
 		pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
 
-	list_for_each_entry(child, &bus->children, node)
+	pci_assign_unassigned_bus_resources(host->bus);
+
+	pcie->root_bus = host->bus;
+
+	list_for_each_entry(child, &host->bus->children, node)
 		pcie_bus_configure_settings(child);
 
-	pci_bus_add_devices(bus);
+	pci_bus_add_devices(host->bus);
 
 	return 0;
 
-err_rm_root_bus:
-	pci_stop_root_bus(bus);
-	pci_remove_root_bus(bus);
-
 err_power_off_phy:
 	phy_power_off(pcie->phy);
 err_exit_phy:
-- 
2.10.0
