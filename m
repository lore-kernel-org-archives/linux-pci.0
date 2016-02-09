Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37524 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbcBIOwh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 09:52:37 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 2/3] PCI: tegra: Track bus -> CPU mapping
Date: Tue,  9 Feb 2016 15:52:32 +0100
Message-Id: <1455029553-9460-2-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1455029553-9460-1-git-send-email-thierry.reding@gmail.com>
References: <1455029553-9460-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Track the offsets of the bus -> CPU mapping for I/O and memory. This is
cosmetic for current Tegra chips because the offset is always 0. But to
properly support legacy use-cases, like VGA, this would be needed so
that PCI bus addresses can be relocated.

While at it, also request the I/O resource both in physical memory and
I/O space to make /proc/iomem consistent, as well as add the I/O region
to the list of host bridge resources.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 82d7ad3a1c3a..f6fc54b48606 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -281,6 +281,11 @@ struct tegra_pcie {
 	struct resource prefetch;
 	struct resource busn;
 
+	struct {
+		resource_size_t mem;
+		resource_size_t io;
+	} offset;
+
 	struct clk *pex_clk;
 	struct clk *afi_clk;
 	struct clk *pll_e;
@@ -614,6 +619,17 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	struct tegra_pcie *pcie = sys_to_pcie(sys);
 	int err;
 
+	sys->mem_offset = pcie->offset.mem;
+	sys->io_offset = pcie->offset.io;
+
+	err = devm_request_resource(pcie->dev, &pcie->all, &pcie->io);
+	if (err < 0)
+		return err;
+
+	err = devm_request_resource(pcie->dev, &ioport_resource, &pcie->pio);
+	if (err < 0)
+		return err;
+
 	err = devm_request_resource(pcie->dev, &pcie->all, &pcie->mem);
 	if (err < 0)
 		return err;
@@ -622,6 +638,7 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	if (err)
 		return err;
 
+	pci_add_resource_offset(&sys->resources, &pcie->pio, sys->io_offset);
 	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
 	pci_add_resource_offset(&sys->resources, &pcie->prefetch,
 				sys->mem_offset);
@@ -1729,6 +1746,9 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 
 		switch (res.flags & IORESOURCE_TYPE_BITS) {
 		case IORESOURCE_IO:
+			/* Track the bus -> CPU I/O mapping offset. */
+			pcie->offset.io = res.start - range.pci_addr;
+
 			memcpy(&pcie->pio, &res, sizeof(res));
 			pcie->pio.name = np->full_name;
 
@@ -1749,6 +1769,14 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 			break;
 
 		case IORESOURCE_MEM:
+			/*
+			 * Track the bus -> CPU memory mapping offset. This
+			 * assumes that the prefetchable and non-prefetchable
+			 * regions will be the last of type IORESOURCE_MEM in
+			 * the ranges property.
+			 * */
+			pcie->offset.mem = res.start - range.pci_addr;
+
 			if (res.flags & IORESOURCE_PREFETCH) {
 				memcpy(&pcie->prefetch, &res, sizeof(res));
 				pcie->prefetch.name = "prefetchable";
-- 
2.7.1

