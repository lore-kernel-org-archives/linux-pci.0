Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:59578 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755442AbeDFOzo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Apr 2018 10:55:44 -0400
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
        Wilson Ding <dingwei@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 5/6] PCI: aardvark: Introduce an advk_pcie_valid_device() helper
Date: Fri,  6 Apr 2018 16:55:35 +0200
Message-Id: <20180406145536.19637-6-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180406145536.19637-1-thomas.petazzoni@bootlin.com>
References: <20180406145536.19637-1-thomas.petazzoni@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In other to mimic other PCIe host controller drivers, introduce an
advk_pcie_valid_device() helper, used in the configuration read/write
functions.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
Changes since v4:
 - Move later into the series, so that it doesn't need to be pushed as
   a fix for stable.
Changes since v3:
 - Make the new helper return a bool instead of int
Changes since v2:
 - New patch
---
 drivers/pci/host/pci-aardvark.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 9abf549631b4..69c4fd50947e 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -431,6 +431,15 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
+static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
+				  int devfn)
+{
+	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
+		return false;
+
+	return true;
+}
+
 static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			     int where, int size, u32 *val)
 {
@@ -438,7 +447,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	u32 reg;
 	int ret;
 
-	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0) {
+	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -492,7 +501,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	int offset;
 	int ret;
 
-	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
+	if (!advk_pcie_valid_device(pcie, bus, devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (where % size)
-- 
2.14.3
