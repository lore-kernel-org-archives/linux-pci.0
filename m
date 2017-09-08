Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41944 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbdIHJx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2017 05:53:59 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Nadav Haklai <nadavh@marvell.com>, Hanna Hawa <hannah@marvell.com>,
        Yehuda Yitschak <yehuday@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        stable@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/7] PCI: aardvark: fix logic in PCI configuration read/write functions
Date: Fri,  8 Sep 2017 11:53:42 +0200
Message-Id: <20170908095348.16578-2-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20170908095348.16578-1-thomas.petazzoni@free-electrons.com>
References: <20170908095348.16578-1-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Victor Gu <xigu@marvell.com>

The PCI configuration space read/write functions were special casing
the situation where PCI_SLOT(devfn) != 0, and returned
PCIBIOS_DEVICE_NOT_FOUND in this case.

However, will this is what is intended for the root bus, it is not
intended for the child busses, as it prevents discovering devices with
PCI_SLOT(x) != 0. Therefore, we return PCIBIOS_DEVICE_NOT_FOUND only
if we're on the root bus.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Victor Gu <xigu@marvell.com>
Reviewed-by: Wilson Ding <dingwei@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
[Thomas: tweak commit log.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-aardvark.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 5fb9b620ac78..582d75f864e3 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -441,7 +441,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	u32 reg;
 	int ret;
 
-	if (PCI_SLOT(devfn) != 0) {
+	if ((bus->number == pcie->root_bus_nr) && (PCI_SLOT(devfn) != 0)) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -495,7 +495,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	int offset;
 	int ret;
 
-	if (PCI_SLOT(devfn) != 0)
+	if ((bus->number == pcie->root_bus_nr) && (PCI_SLOT(devfn) != 0))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (where % size)
-- 
2.13.5
