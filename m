Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751712AbdFHONZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:13:25 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [RFT PATCH v2 10/42] PCI: Make pci_register_host_bridge() PCI core internal
Date: Thu,  8 Jun 2017 15:13:10 +0100
Message-Id: <20170608141342.2018-11-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With the introduction of pci_scan_root_bus_bridge() there is no
need to export pci_register_host_bridge() to other kernel subsystems
other than the PCI compilation unit that needs it.

Make pci_register_host_bridge() static to its compilation unit and
convert the existing drivers usage over to pci_scan_root_bus_bridge().

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-ftpci100.c | 5 ++---
 drivers/pci/host/pci-tegra.c    | 4 +---
 drivers/pci/probe.c             | 3 +--
 include/linux/pci.h             | 1 -
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index 89cbb1f..435a646 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -520,14 +520,13 @@ static int faraday_pci_probe(struct platform_device *pdev)
 		return ret;
 
 	list_splice_init(&res, &host->windows);
-	ret = pci_register_host_bridge(host);
+	ret = pci_scan_root_bus_bridge(host);
 	if (ret) {
-		dev_err(dev, "failed to register host: %d\n", ret);
+		dev_err(dev, "failed to scan host: %d\n", ret);
 		return ret;
 	}
 	p->bus = host->bus;
 
-	pci_scan_child_bus(p->bus);
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 	pci_bus_assign_resources(p->bus);
 	pci_bus_add_devices(p->bus);
diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 84c98a2..0383418 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -2285,14 +2285,12 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	host->dev.parent = &pdev->dev;
 	host->ops = &tegra_pcie_ops;
 
-	err = pci_register_host_bridge(host);
+	err = pci_scan_root_bus_bridge(host);
 	if (err < 0) {
 		dev_err(dev, "failed to register host: %d\n", err);
 		goto disable_msi;
 	}
 
-	pci_scan_child_bus(host->bus);
-
 	pci_fixup_irqs(pci_common_swizzle, tegra_pcie_map_irq);
 	pci_bus_size_bridges(host->bus);
 	pci_bus_assign_resources(host->bus);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 690f0b3..5c457c1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -746,7 +746,7 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	dev_set_msi_domain(&bus->dev, d);
 }
 
-int pci_register_host_bridge(struct pci_host_bridge *bridge)
+static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
 	struct resource_entry *window, *n;
@@ -861,7 +861,6 @@ int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	kfree(bus);
 	return err;
 }
-EXPORT_SYMBOL(pci_register_host_bridge);
 
 static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 					   struct pci_dev *bridge, int busnr)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 72940cc..22f549e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -466,7 +466,6 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv);
 struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 						   size_t priv);
 void pci_free_host_bridge(struct pci_host_bridge *bridge);
-int pci_register_host_bridge(struct pci_host_bridge *bridge);
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
-- 
2.10.0
