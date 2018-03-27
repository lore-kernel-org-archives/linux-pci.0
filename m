Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:52104 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbeC0OJW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Mar 2018 10:09:22 -0400
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        stable@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v3 3/6] PCI: aardvark: set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
Date: Tue, 27 Mar 2018 16:08:09 +0200
Message-Id: <20180327140819.23501-4-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180327140819.23501-1-thomas.petazzoni@bootlin.com>
References: <20180327140819.23501-1-thomas.petazzoni@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Victor Gu <xigu@marvell.com>

When setting the PIO_ADDR_LS register during a configuration read, we
were properly passing the device number, function number and register
number, but not the bus number, causing issues when reading the
configuration of PCIe devices.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Victor Gu <xigu@marvell.com>
Reviewed-by: Wilson Ding <dingwei@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
[Thomas: tweak commit log.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Changes since v2:
 - Drop PCIE_BDF() macro, since it's no longer used. Noticed by Bjorn
   Helgaas.
---
 drivers/pci/host/pci-aardvark.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index be140dc7109b..4affbf1b826b 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -172,8 +172,6 @@
 #define PCIE_CONFIG_WR_TYPE0			0xa
 #define PCIE_CONFIG_WR_TYPE1			0xb
 
-/* PCI_BDF shifts 8bit, so we need extra 4bit shift */
-#define PCIE_BDF(dev)				(dev << 4)
 #define PCIE_CONF_BUS(bus)			(((bus) & 0xff) << 20)
 #define PCIE_CONF_DEV(dev)			(((dev) & 0x1f) << 15)
 #define PCIE_CONF_FUNC(fun)			(((fun) & 0x7)	<< 12)
@@ -465,7 +463,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	advk_writel(pcie, reg, PIO_CTRL);
 
 	/* Program the address registers */
-	reg = PCIE_BDF(devfn) | PCIE_CONF_REG(where);
+	reg = PCIE_CONF_ADDR(bus->number, devfn, where);
 	advk_writel(pcie, reg, PIO_ADDR_LS);
 	advk_writel(pcie, 0, PIO_ADDR_MS);
 
-- 
2.14.3
