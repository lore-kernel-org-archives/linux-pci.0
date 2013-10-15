Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:58519 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759539Ab3JOQHG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2013 12:07:06 -0400
From: Marek Vasut <marex@denx.de>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 6/6] PCI: designware: Fix DT resource retrieval
Date: Tue, 15 Oct 2013 18:06:40 +0200
Message-Id: <1381853200-5534-7-git-send-email-marex@denx.de>
In-Reply-To: <1381853200-5534-1-git-send-email-marex@denx.de>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The resource retrieval from the DT was not done right. This resulted
in bogus values in the IO/MEM window configuration. I re-used the code
implementation from pci-tegra.c to do the resource retrieval correctly.

This in turn resulted in very strange behavior on two different kinds
of setup:

Setup #1:                             ,-------> Intel i210 (igb driver)
           i.MX6 root port -----> PCIe switch
                                      `-------> Empty slot

Setup #2:                             ,-------> Marvell Yukon (sky2 driver)
           i.MX6 root port -----> PCIe switch
                                      `-------> Empty slot

Both setups expressed the same behavior. The system booted and the
ethernet controllers were properly detected. After the controllers
were configured and just after they reported "Ethernet Link Up", the
entire system froze. It is now clear this happened because the resources
were incorrectly configured, which in turn means the iATU was also not
configured correctly.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <lznuaa@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sean Cross <xobs@kosagi.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/host/pcie-designware.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 5d183ae..97c5951 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -370,6 +370,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	struct device_node *np = pp->dev->of_node;
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
+	struct resource res;
 	u32 val;
 
 	struct irq_domain *irq_domain;
@@ -381,28 +382,22 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 
 	/* Get the I/O and memory ranges from DT */
 	for_each_of_pci_range(&parser, &range) {
-		unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
+		of_pci_range_to_resource(&range, np, &res);
+		unsigned long restype = res.flags & IORESOURCE_TYPE_BITS;
 		if (restype == IORESOURCE_IO) {
-			of_pci_range_to_resource(&range, np, &pp->io);
+			memcpy(&pp->io, &res, sizeof(res));
 			pp->io.name = "I/O";
-			pp->io.start = max_t(resource_size_t,
-					     PCIBIOS_MIN_IO,
-					     range.pci_addr + global_io_offset);
-			pp->io.end = min_t(resource_size_t,
-					   IO_SPACE_LIMIT,
-					   range.pci_addr + range.size
-					   + global_io_offset);
 			pp->config.io_size = resource_size(&pp->io);
 			pp->config.io_bus_addr = range.pci_addr;
 		}
 		if (restype == IORESOURCE_MEM) {
-			of_pci_range_to_resource(&range, np, &pp->mem);
+			memcpy(&pp->mem, &res, sizeof(res));
 			pp->mem.name = "MEM";
 			pp->config.mem_size = resource_size(&pp->mem);
 			pp->config.mem_bus_addr = range.pci_addr;
 		}
 		if (restype == 0) {
-			of_pci_range_to_resource(&range, np, &pp->cfg);
+			memcpy(&pp->cfg, &res, sizeof(res));
 			pp->config.cfg0_size = resource_size(&pp->cfg)/2;
 			pp->config.cfg1_size = resource_size(&pp->cfg)/2;
 		}
-- 
1.8.4.rc3

