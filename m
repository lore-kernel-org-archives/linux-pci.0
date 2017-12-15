Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755530AbdLOU3j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Dec 2017 15:29:39 -0500
Subject: [PATCH] PCI: rockchip: Remove redundant "valid device" check
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Date: Fri, 15 Dec 2017 14:29:35 -0600
Message-ID: <20171215202935.157396.74423.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

In rockchip_pcie_valid_device(), we do the exact same test twice:

  if (bus->number == rockchip->root_bus_nr && dev > 0)
    return 0;
  if (bus->number == rockchip->root_bus_nr && dev > 0)
    return 0;

We only need to do it once, so remove one of them.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rockchip.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 9051c6c8fea4..dd9c7ea69e0b 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -293,10 +293,6 @@ static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
 static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
 				      struct pci_bus *bus, int dev)
 {
-	/* access only one slot on each root port */
-	if (bus->number == rockchip->root_bus_nr && dev > 0)
-		return 0;
-
 	/*
 	 * do not read more than one device on the bus directly attached
 	 * to RC's downstream side.
