Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41947 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590AbcHOQv0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Aug 2016 12:51:26 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
Subject: [PATCH 2/6] drivers: pci: host: designware: fix pci_remap_iospace() failure path
Date: Mon, 15 Aug 2016 17:50:42 +0100
Message-Id: <1471279854-11916-3-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1471279854-11916-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1471279854-11916-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On ARM/ARM64 architectures, PCI IO ports are emulated through memory
mapped IO, by reserving a chunk of virtual address space starting at
PCI_IOBASE and by mapping the PCI host bridges memory address space
driving PCI IO cycles to it.

PCI host bridge drivers that enable downstream PCI IO cycles map the
host bridge memory address responding to PCI IO cycles to the fixed
virtual address space through the pci_remap_iospace() API.

This means that if the pci_remap_iospace() function fails, the
corresponding host bridge PCI IO resource must be considered invalid, in
that there is no way for the kernel to actually drive PCI IO
transactions if the memory addresses responding to PCI
IO cycles cannot be mapped into the CPU virtual address space.

The PCI designware host bridge driver does not remove the PCI IO
resource from the host bridge resource windows if the
pci_remap_iospace() call fails; this is an actual bug in that the
PCI host bridge would consider the PCI IO resource valid (and possibly
assign it to downstream devices) even if the kernel was not able
to map the PCI host bridge memory address driving IO cycle to the
CPU virtual address space (ie pci_remap_iospace() failures).

Fix the PCI host bridge driver pci_remap_iospace() failure path, by
destroying the PCI host bridge PCI IO resources retrieved through
firmware when the pci_remap_iospace() function call fails, therefore
preventing the kernel from adding the respective PCI IO resource to the
list of PCI host bridge valid resources, fixing the issue.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Fixes: cbce7900598c ("PCI: designware: Make driver arch-agnostic")
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
---
 drivers/pci/host/pcie-designware.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 12afce1..2a500f2 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -436,7 +436,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct resource *cfg_res;
 	int i, ret;
 	LIST_HEAD(res);
-	struct resource_entry *win;
+	struct resource_entry *win, *tmp;
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
@@ -457,17 +457,20 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		goto error;
 
 	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry(win, &res) {
+	resource_list_for_each_entry_safe(win, tmp, &res) {
 		switch (resource_type(win->res)) {
 		case IORESOURCE_IO:
-			pp->io = win->res;
-			pp->io->name = "I/O";
-			pp->io_size = resource_size(pp->io);
-			pp->io_bus_addr = pp->io->start - win->offset;
-			ret = pci_remap_iospace(pp->io, pp->io_base);
-			if (ret)
+			ret = pci_remap_iospace(win->res, pp->io_base);
+			if (ret) {
 				dev_warn(pp->dev, "error %d: failed to map resource %pR\n",
-					 ret, pp->io);
+					 ret, win->res);
+				resource_list_destroy_entry(win);
+			} else {
+				pp->io = win->res;
+				pp->io->name = "I/O";
+				pp->io_size = resource_size(pp->io);
+				pp->io_bus_addr = pp->io->start - win->offset;
+			}
 			break;
 		case IORESOURCE_MEM:
 			pp->mem = win->res;
-- 
2.6.4

