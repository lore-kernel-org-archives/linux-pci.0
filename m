Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36500 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbcHAHRv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2016 03:17:51 -0400
Received: by mail-pf0-f195.google.com with SMTP id y134so9820415pfg.3
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2016 00:17:50 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH] PCI: tegra: Remove stray call to pci_ioremap_io()
Date: Mon,  1 Aug 2016 09:05:39 +0200
Message-Id: <20160801070539.24779-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

This was introduced by an unfortunate interaction between commits
45c64b6ac4ef ("PCI: tegra: Request host bridge window resources with
core function") and e6e9f471f5fe ("PCI: tegra: Use generic
pci_remap_iospace() rather than ARM32-specific one").

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 2544937620a5..6de0757b11e4 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -621,8 +621,6 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	if (err < 0)
 		return err;
 
-	pci_ioremap_io(pcie->pio.start, pcie->io.start);
-
 	pci_add_resource_offset(&sys->resources, &pcie->pio, sys->io_offset);
 	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
 	pci_add_resource_offset(&sys->resources, &pcie->prefetch,
-- 
2.9.0

