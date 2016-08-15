Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41958 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590AbcHOQv3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Aug 2016 12:51:29 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 4/6] drivers: pci: host: rcar: fix pci_remap_iospace() failure path
Date: Mon, 15 Aug 2016 17:50:44 +0100
Message-Id: <1471279854-11916-5-git-send-email-lorenzo.pieralisi@arm.com>
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

The PCI rcar host bridge driver does not remove the PCI IO
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
Fixes: 5d2917d469fa ("PCI: rcar: Convert to DT resource parsing API")
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pci/host/pcie-rcar.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 65db7a2..5f7fcc9 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -945,7 +945,7 @@ static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 	resource_size_t iobase;
-	struct resource_entry *win;
+	struct resource_entry *win, *tmp;
 
 	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources, &iobase);
 	if (err)
@@ -955,14 +955,17 @@ static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
 	if (err)
 		goto out_release_res;
 
-	resource_list_for_each_entry(win, &pci->resources) {
+	resource_list_for_each_entry_safe(win, tmp, &pci->resources) {
 		struct resource *res = win->res;
 
 		if (resource_type(res) == IORESOURCE_IO) {
 			err = pci_remap_iospace(res, iobase);
-			if (err)
+			if (err) {
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 err, res);
+
+				resource_list_destroy_entry(win);
+			}
 		}
 	}
 
-- 
2.6.4

