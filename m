Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751769AbdFHONP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:13:15 -0400
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
Subject: [RFT PATCH v2 09/42] PCI: Introduce pci_scan_root_bus_bridge()
Date: Thu,  8 Jun 2017 15:13:09 +0100
Message-Id: <20170608141342.2018-10-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current pci_scan_root_bus() interface is made up of two main
code paths:

- pci_create_root_bus()
- pci_scan_child_bus()

pci_create_root_bus() is a wrapper function that allows to create
a struct pci_host_bridge structure, initialize it with the passed
parameters and register it with the kernel.

As the struct pci_host_bridge require additional struct members,
pci_create_root_bus() parameters list has grown in time, making
it unwieldy to add further parameters to it in case the struct
pci_host_bridge gains more members fields to augment its functionality.

Since PCI core code provides functions to allocate struct
pci_host_bridge, instead of forcing the pci_create_root_bus() interface
to add new parameters to cater for new struct pci_host_bridge
functionality, it is more suitable to add an interface in PCI
core code to scan a PCI bus straight from a struct pci_host_bridge
created and customized by each specific PCI host controller driver.

Add a pci_scan_root_bus_bridge() function to allow PCI host controller
drivers to create and initialize struct pci_host_bridge and scan
the resulting bus.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 40 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e3f6965..690f0b3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2426,6 +2426,45 @@ void pci_bus_release_busn_res(struct pci_bus *b)
 			res, ret ? "can not be" : "is");
 }
 
+int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge)
+{
+	struct resource_entry *window;
+	bool found = false;
+	struct pci_bus *b;
+	int max, bus, ret;
+
+	if (!bridge)
+		return -EINVAL;
+
+	resource_list_for_each_entry(window, &bridge->windows)
+		if (window->res->flags & IORESOURCE_BUS) {
+			found = true;
+			break;
+		}
+
+	ret = pci_register_host_bridge(bridge);
+	if (ret < 0)
+		return ret;
+
+	b = bridge->bus;
+	bus = bridge->busnr;
+
+	if (!found) {
+		dev_info(&b->dev,
+		 "No busn resource found for root bus, will use [bus %02x-ff]\n",
+			bus);
+		pci_bus_insert_busn_res(b, bus, 255);
+	}
+
+	max = pci_scan_child_bus(b);
+
+	if (!found)
+		pci_bus_update_busn_res_end(b, max);
+
+	return 0;
+}
+EXPORT_SYMBOL(pci_scan_root_bus_bridge);
+
 struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata,
 		struct list_head *resources, struct msi_controller *msi)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b21308e..72940cc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -862,6 +862,7 @@ struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
 struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 					     struct pci_ops *ops, void *sysdata,
 					     struct list_head *resources);
+int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
 				int busnr);
 void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
-- 
2.10.0
