Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:33622 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751109Ab3LKJj4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 04:39:56 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Arnd Bergmann <arnd@arndb.de>, Marek Vasut <marex@denx.de>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	<spear-devel@list.st.com>
Subject: [PATCH 08/12] pcie: designware: Fix IO transfers
Date: Wed, 11 Dec 2013 15:08:33 +0530
Message-ID: <6b4282b9e793ec89ba0c20f3362d41f6133a8132.1386752447.git.mohit.kumar@st.com>
In-Reply-To: <cover.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@st.com>

pp->io_base which is the input of the outbound IO address translation
unit should be the cpu address, it was programmed wrongly to realio
address.

We should pass global_io_offset rather than sys->io_offset to
pci_ioremap_io, so we map the new window into the first available spot
in the Linux view of the I/O space.

We must also pass cpu address instead  of realio address to
pci_ioremap_io.

This patch fixes above issue. It has been tested with Lecroy PTC in AIC
mode and Pericom PI7C9X2G303EL PCIe switch, which does not work
otherwise.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Tested-by: Mohit Kumar <mohit.kumar@st.com>
Tested-by: Tim Harvey <tharvey@gateworks.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-pci@vger.kernel.org
Cc: spear-devel@list.st.com
---
 drivers/pci/host/pcie-designware.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index be6ce30..071ebc0 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -378,6 +378,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 					   + global_io_offset);
 			pp->config.io_size = resource_size(&pp->io);
 			pp->config.io_bus_addr = range.pci_addr;
+			pp->io_base = range.cpu_addr;
 		}
 		if (restype == IORESOURCE_MEM) {
 			of_pci_range_to_resource(&range, np, &pp->mem);
@@ -403,7 +404,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 
 	pp->cfg0_base = pp->cfg.start;
 	pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
-	pp->io_base = pp->io.start;
 	pp->mem_base = pp->mem.start;
 
 	pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
@@ -573,7 +573,6 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	return ret;
 }
 
-
 static int dw_pcie_valid_config(struct pcie_port *pp,
 				struct pci_bus *bus, int dev)
 {
@@ -667,7 +666,7 @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
 
 	if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
 		sys->io_offset = global_io_offset - pp->config.io_bus_addr;
-		pci_ioremap_io(sys->io_offset, pp->io.start);
+		pci_ioremap_io(global_io_offset, pp->io_base);
 		global_io_offset += SZ_64K;
 		pci_add_resource_offset(&sys->resources, &pp->io,
 					sys->io_offset);
-- 
1.7.0.1

