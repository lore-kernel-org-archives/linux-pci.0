Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41944 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590AbcHOQvX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Aug 2016 12:51:23 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/6] drivers: pci: host: aardvark: fix pci_remap_iospace() failure path
Date: Mon, 15 Aug 2016 17:50:41 +0100
Message-Id: <1471279854-11916-2-git-send-email-lorenzo.pieralisi@arm.com>
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

The PCI aardvark host bridge driver does not remove the PCI IO
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
Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-aardvark.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index ef9893f..4f5e567 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -848,7 +848,7 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
 	int err, res_valid = 0;
 	struct device *dev = &pcie->pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct resource_entry *win;
+	struct resource_entry *win, *tmp;
 	resource_size_t iobase;
 
 	INIT_LIST_HEAD(&pcie->resources);
@@ -862,7 +862,7 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
 	if (err)
 		goto out_release_res;
 
-	resource_list_for_each_entry(win, &pcie->resources) {
+	resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
 		struct resource *res = win->res;
 
 		switch (resource_type(res)) {
@@ -874,9 +874,11 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
 					     lower_32_bits(res->start),
 					     OB_PCIE_IO);
 			err = pci_remap_iospace(res, iobase);
-			if (err)
+			if (err) {
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 err, res);
+				resource_list_destroy_entry(win);
+			}
 			break;
 		case IORESOURCE_MEM:
 			advk_pcie_set_ob_win(pcie, 0,
-- 
2.6.4

