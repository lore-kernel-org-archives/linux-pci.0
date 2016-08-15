Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41963 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590AbcHOQvc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Aug 2016 12:51:32 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH 6/6] drivers: pci: host: tegra: fix pci_remap_iospace() failure path
Date: Mon, 15 Aug 2016 17:50:46 +0100
Message-Id: <1471279854-11916-7-git-send-email-lorenzo.pieralisi@arm.com>
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

The PCI tegra host bridge driver adds the PCI IO resource retrieved
from firmware to the host bridge resource windows even if the
pci_remap_iospace() call fails; this is an actual bug in that the PCI
host bridge would consider the PCI IO resource valid (and possibly
assign it to downstream devices) even if the kernel was not able to map
the PCI host bridge memory address driving IO cycle to the CPU virtual
address space (ie pci_remap_iospace() failures).

Add the PCI host bridge driver pci_remap_iospace() failure path and
do not add the corresponding PCI host bridge PCI IO resources
retrieved through firmware when the pci_remap_iospace() function
call fails, fixing the issue.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Fixes: e6e9f471f5fe ("PCI: tegra: Use generic pci_remap_iospace() rather than ARM32-specific one")
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 6de0757..8c2590d 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -621,7 +621,11 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	if (err < 0)
 		return err;
 
-	pci_add_resource_offset(&sys->resources, &pcie->pio, sys->io_offset);
+	err = pci_remap_iospace(&pcie->pio, pcie->io.start);
+	if (!err)
+		pci_add_resource_offset(&sys->resources, &pcie->pio,
+					sys->io_offset);
+
 	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
 	pci_add_resource_offset(&sys->resources, &pcie->prefetch,
 				sys->mem_offset);
@@ -631,7 +635,6 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	if (err < 0)
 		return err;
 
-	pci_remap_iospace(&pcie->pio, pcie->io.start);
 	return 1;
 }
 
-- 
2.6.4

