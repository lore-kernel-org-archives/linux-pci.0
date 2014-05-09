Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:61073 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbaEIJD3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 May 2014 05:03:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <damm@opensource.se>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [PATCH v2] of/irq: provide int of_irq_parse_and_map_pci wrapper
Date: Fri, 09 May 2014 11:03:11 +0200
Message-ID: <5744457.bgUFy9g0ST@wuerfel>
In-Reply-To: <1399624119.4833.3.camel@weser.hi.pengutronix.de>
References: <4527717.yJh2gX3xCP@wuerfel> <1399624119.4833.3.camel@weser.hi.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci-rcar driver is enabled for compile tests, and this has
now shown that the driver cannot build without CONFIG_OF,
following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
interrupt mapping when possible":

drivers/built-in.o: In function `rcar_pci_map_irq':
:(.text+0x1cc7c): undefined reference to `of_irq_parse_and_map_pci'

As pointed out by Ben Dooks and Geert Uytterhoeven, this is actually
supposed to build fine, which we can achieve if we make the
declaration of of_irq_parse_and_map_pci conditional on CONFIG_OF
and provide an empty inline function otherwise, as we do for
a lot of other of interfaces.

This lets us build the rcar_pci driver again without CONFIG_OF
for build testing. All platforms using this driver select OF,
so this doesn't change anything for the users.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Magnus Damm <damm@opensource.se>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org
---
v2: clarified commit text.

diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 1a1f5ff..1e29bf4 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -7,13 +7,18 @@
 struct pci_dev;
 struct of_phandle_args;
 int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq);
-int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 
 struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
+#ifdef CONFIG_OF
+int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
+#else
+static inline int
+of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin) { return 0; }
+#endif
 
 #if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
 int of_pci_msi_chip_add(struct msi_chip *chip);

