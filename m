Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:61359 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661AbaFCOsI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jun 2014 10:48:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <damm@opensource.se>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [PATCH v3] of/irq: provide more wrappers for !CONFIG_OF
Date: Tue, 03 Jun 2014 16:47:41 +0200
Message-ID: <16771871.sfJG2itVJN@wuerfel>
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
pci/host/pcie-rcar.c: In function 'pci_dma_range_parser_init':
pci/host/pcie-rcar.c:875:2: error: implicit declaration of function 'of_n_addr_cells' [-Werror=implicit-function-declaration]

As pointed out by Ben Dooks and Geert Uytterhoeven, this is actually
supposed to build fine, which we can achieve if we make the
declaration of of_irq_parse_and_map_pci conditional on CONFIG_OF
and provide an empty inline function otherwise, as we do for
a lot of other of interfaces.

This lets us build the rcar_pci driver again without CONFIG_OF
for build testing. All platforms using this driver select OF,
so this doesn't change anything for the users.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Magnus Damm <damm@opensource.se>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org
----

This replaces "[PATCH v2] of/irq: provide int of_irq_parse_and_map_pci
wrapper", since now the same driver requires additional interfaces.
We still want to be able to build the driver with CONFIG_OF disabled,
but now we need three functions instead of just one.

Rob, Grant, can you apply this as a bug fix, or provide comments?

diff --git a/include/linux/of.h b/include/linux/of.h
index 196b34c..7c29e6c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -511,6 +511,9 @@ static inline struct device_node *of_get_cpu_node(int cpu,
 	return NULL;
 }
 
+static inline int of_n_addr_cells(struct device_node *np) { return 0; }
+static inline int of_n_size_cells(struct device_node *np) { return 0; }
+
 static inline int of_property_read_u64(const struct device_node *np,
 				       const char *propname, u64 *out_value)
 {
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 1a1f5ff..dde3a4a 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -6,14 +6,44 @@
 
 struct pci_dev;
 struct of_phandle_args;
-int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq);
-int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
-
 struct device_node;
+
+#ifdef CONFIG_OF
+int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq);
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
+int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
+#else
+static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
+{
+	return 0;
+}
+
+static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
+					     unsigned int devfn)
+{
+	return NULL;
+}
+
+static inline int of_pci_get_devfn(struct device_node *np)
+{
+	return -EINVAL;
+}
+
+static inline int
+of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return 0;
+}
+
+static inline int
+of_pci_parse_bus_range(struct device_node *node, struct resource *res)
+{
+	return -EINVAL;
+}
+#endif
 
 #if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
 int of_pci_msi_chip_add(struct msi_chip *chip);

