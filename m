Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:32961 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbeC2IkK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Mar 2018 04:40:10 -0400
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Victor Gu <xigu@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: [PATCH v4 1/6] PCI: aardvark: Introduce an advk_pcie_valid_device() helper
Date: Thu, 29 Mar 2018 10:39:41 +0200
Message-Id: <20180329083946.25970-2-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180329083946.25970-1-thomas.petazzoni@bootlin.com>
References: <20180329083946.25970-1-thomas.petazzoni@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In other to mimic other PCIe host controller drivers, introduce an
advk_pcie_valid_device() helper, used in the configuration read/write
functions.

This patch by itself is not a fix, but it is required for a follow-up
patch that is a fix, hence the Fixes tag and the Cc to stable.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
Changes since v3:
 - Make the new helper return a bool instead of int
Changes since v2:
 - New patch
---
 drivers/pci/host/pci-aardvark.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index b04d37b3c5de..82bff709a4b3 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -430,6 +430,15 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
+static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
+				  int devfn)
+{
+	if (PCI_SLOT(devfn) != 0)
+		return false;
+
+	return true;
+}
+
 static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			     int where, int size, u32 *val)
 {
@@ -437,7 +446,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	u32 reg;
 	int ret;
 
-	if (PCI_SLOT(devfn) != 0) {
+	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -491,7 +500,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	int offset;
 	int ret;
 
-	if (PCI_SLOT(devfn) != 0)
+	if (!advk_pcie_valid_device(pcie, bus, devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (where % size)
-- 
2.14.3
