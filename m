Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751542AbdFHOOX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:14:23 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [RFT PATCH v2 23/42] PCI: Remove pci_scan_root_bus_msi()
Date: Thu,  8 Jun 2017 15:13:23 +0100
Message-Id: <20170608141342.2018-24-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci_scan_root_bus_bridge() function allows passing a parameterized
struct pci_host_bridge and scanning the resulting PCI bus; since the
struct msi_controller is part of the struct pci_host_bridge and the
struct pci_host_bridge can now be passed to pci_scan_root_bus_bridge()
explicitly, there is no need for a scan interface with a MSI controller
parameter.

With all PCI host controller drivers and platform code relying
on pci_scan_root_bus_msi() converted over to pci_scan_root_bus_bridge()
the pci_scan_root_bus_msi() becomes obsolete and can be removed.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 27 +++++----------------------
 include/linux/pci.h |  4 ----
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5c457c1..bd42ed4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2324,9 +2324,8 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 {
 }
 
-static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
-		int bus, struct pci_ops *ops, void *sysdata,
-		struct list_head *resources, struct msi_controller *msi)
+struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
 	int error;
 	struct pci_host_bridge *bridge;
@@ -2341,7 +2340,6 @@ static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
 	bridge->sysdata = sysdata;
 	bridge->busnr = bus;
 	bridge->ops = ops;
-	bridge->msi = msi;
 
 	error = pci_register_host_bridge(bridge);
 	if (error < 0)
@@ -2353,13 +2351,6 @@ static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
 	kfree(bridge);
 	return NULL;
 }
-
-struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
-{
-	return pci_create_root_bus_msi(parent, bus, ops, sysdata, resources,
-				       NULL);
-}
 EXPORT_SYMBOL_GPL(pci_create_root_bus);
 
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
@@ -2464,9 +2455,8 @@ int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge)
 }
 EXPORT_SYMBOL(pci_scan_root_bus_bridge);
 
-struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata,
-		struct list_head *resources, struct msi_controller *msi)
+struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
 	struct resource_entry *window;
 	bool found = false;
@@ -2479,7 +2469,7 @@ struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
 			break;
 		}
 
-	b = pci_create_root_bus_msi(parent, bus, ops, sysdata, resources, msi);
+	b = pci_create_root_bus(parent, bus, ops, sysdata, resources);
 	if (!b)
 		return NULL;
 
@@ -2497,13 +2487,6 @@ struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
 
 	return b;
 }
-
-struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
-{
-	return pci_scan_root_bus_msi(parent, bus, ops, sysdata, resources,
-				     NULL);
-}
 EXPORT_SYMBOL(pci_scan_root_bus);
 
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 22f549e..31ee3b3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -854,10 +854,6 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
-struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
-				      struct pci_ops *ops, void *sysdata,
-				      struct list_head *resources,
-				      struct msi_controller *msi);
 struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 					     struct pci_ops *ops, void *sysdata,
 					     struct list_head *resources);
-- 
2.10.0
