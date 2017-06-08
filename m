Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751536AbdFHOMv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 10:12:51 -0400
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
Subject: [RFT PATCH v2 04/42] PCI: Initialize bridge release function at bridge allocation
Date: Thu,  8 Jun 2017 15:13:04 +0100
Message-Id: <20170608141342.2018-5-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of pci_register_host_bridge() kernel interface
allows PCI host controller drivers to create the struct pci_host_bridge
object, initialize it and register it with the kernel so that its
corresponding PCI bus can be scanned and its devices probed.

The host bridge device release function pci_release_host_bridge_dev is a
static function common for all struct pci_host_bridge allocated objects,
so in its current form cannot be used by PCI host bridge controllers
drivers to initialize the allocated struct pci_host_bridge, which
leaves struct pci_host_bridge devices release function uninitialized.

Since pci_release_host_bridge_dev is a function common to all PCI
host bridge objects, initialize it in pci_alloc_host_bridge() (ie
common host bridge allocation interface) so that all struct
pci_host_bridge objects have their release function initialized by
default at allocation time, removing the need for exporting the
common pci_release_host_bridge_dev function to other compilation
units.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 19c8950..586d83d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -531,6 +531,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	bridge->dev.release = pci_release_host_bridge_dev;
 
 	return bridge;
 }
@@ -2310,7 +2311,6 @@ static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
 		return NULL;
 
 	bridge->dev.parent = parent;
-	bridge->dev.release = pci_release_host_bridge_dev;
 
 	list_splice_init(resources, &bridge->windows);
 	bridge->sysdata = sysdata;
-- 
2.10.0
