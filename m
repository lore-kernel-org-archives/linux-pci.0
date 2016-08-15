Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41960 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590AbcHOQvb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Aug 2016 12:51:31 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 5/6] drivers: pci: host: common: fix pci_remap_iospace() failure path
Date: Mon, 15 Aug 2016 17:50:45 +0100
Message-Id: <1471279854-11916-6-git-send-email-lorenzo.pieralisi@arm.com>
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

The PCI common host bridge driver does not remove the PCI IO
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
Fixes: 4e64dbe226e7 ("PCI: generic: Expose pci_host_common_probe() for
use by other drivers")
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/pci/host/pci-host-common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index 9d9d34e..61eb4d4 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -29,7 +29,7 @@ static int gen_pci_parse_request_of_pci_ranges(struct device *dev,
 	int err, res_valid = 0;
 	struct device_node *np = dev->of_node;
 	resource_size_t iobase;
-	struct resource_entry *win;
+	struct resource_entry *win, *tmp;
 
 	err = of_pci_get_host_bridge_resources(np, 0, 0xff, resources, &iobase);
 	if (err)
@@ -39,15 +39,17 @@ static int gen_pci_parse_request_of_pci_ranges(struct device *dev,
 	if (err)
 		return err;
 
-	resource_list_for_each_entry(win, resources) {
+	resource_list_for_each_entry_safe(win, tmp, resources) {
 		struct resource *res = win->res;
 
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
 			err = pci_remap_iospace(res, iobase);
-			if (err)
+			if (err) {
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 err, res);
+				resource_list_destroy_entry(win);
+			}
 			break;
 		case IORESOURCE_MEM:
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-- 
2.6.4

