Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:59554 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755398AbeDFOzn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Apr 2018 10:55:43 -0400
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        Wilson Ding <dingwei@marvell.com>, stable@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 1/6] PCI: aardvark: Fix logic in advk_pcie_{rd,wr}_conf()
Date: Fri,  6 Apr 2018 16:55:31 +0200
Message-Id: <20180406145536.19637-2-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180406145536.19637-1-thomas.petazzoni@bootlin.com>
References: <20180406145536.19637-1-thomas.petazzoni@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Victor Gu <xigu@marvell.com>

The PCI configuration space read/write functions were special casing
the situation where PCI_SLOT(devfn) != 0, and returned
PCIBIOS_DEVICE_NOT_FOUND in this case.

However, while this is what is intended for the root bus, it is not
intended for the child busses, as it prevents discovering devices with
PCI_SLOT(x) != 0. Therefore, we return PCIBIOS_DEVICE_NOT_FOUND only
if we're on the root bus.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Victor Gu <xigu@marvell.com>
Reviewed-by: Wilson Ding <dingwei@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
[Thomas: tweak commit log.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
Changes since v3:
 - Change to no longer depend on the introduction of
   advk_pcie_valid_device(), which we do not want to push to stable.
Changes since v2:
 - The logic has been factorized into a advk_pcie_valid_device()
   helper in a previous patch, so this patch was adjusted accordingly.
---
 drivers/pci/host/pci-aardvark.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index b04d37b3c5de..b72f15c99793 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -437,7 +437,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	u32 reg;
 	int ret;
 
-	if (PCI_SLOT(devfn) != 0) {
+	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -491,7 +491,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	int offset;
 	int ret;
 
-	if (PCI_SLOT(devfn) != 0)
+	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (where % size)
-- 
2.14.3
