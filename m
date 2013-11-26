Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:44271 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933Ab3KZSDE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Nov 2013 13:03:04 -0500
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH RESEND v3 2/2] PCI: mvebu - Support a bridge with no IO port window
Date: Tue, 26 Nov 2013 11:02:55 -0700
Message-Id: <1385488975-27694-4-git-send-email-jgunthorpe@obsidianresearch.com>
In-Reply-To: <1385488975-27694-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1385488975-27694-1-git-send-email-jgunthorpe@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make pcie-io-aperture and the IO port MBUS ID in ranges optional.
If not provided the bridge reports to Linux that IO space mapping is
not supported and refuses to configure an IO mbus window.

This allows both complete disable (do not specify pcie-io-aperture) and
per-port disable (do not specify a IO target ranges entry for the port)

Most PCIE devices these days do not require IO support to function,
so having an option to disable it in the driver is useful.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c | 63 ++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 20 deletions(-)

Bjorn, this is now ready to go for the next merge window.
Can you take it through your tree? Thanks

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 6fde82b..ef8691a 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -150,6 +150,11 @@ static inline u32 mvebu_readl(struct mvebu_pcie_port *port, u32 reg)
 	return readl(port->base + reg);
 }
 
+static inline bool mvebu_has_ioport(struct mvebu_pcie_port *port)
+{
+	return port->io_target != -1 && port->io_attr != -1;
+}
+
 static bool mvebu_pcie_link_up(struct mvebu_pcie_port *port)
 {
 	return !(mvebu_readl(port, PCIE_STAT_OFF) & PCIE_STAT_LINK_DOWN);
@@ -314,6 +319,12 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 		return;
 	}
 
+	if (!mvebu_has_ioport(port)) {
+		dev_WARN(&port->pcie->pdev->dev,
+			 "Attempt to set IO when IO is disabled\n");
+		return;
+	}
+
 	/*
 	 * We read the PCI-to-PCI bridge emulated registers, and
 	 * calculate the base address and size of the address decoding
@@ -428,9 +439,12 @@ static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
 		break;
 
 	case PCI_IO_BASE:
-		*value = (bridge->secondary_status << 16 |
-			  bridge->iolimit          <<  8 |
-			  bridge->iobase);
+		if (!mvebu_has_ioport(port))
+			*value = bridge->secondary_status << 16;
+		else
+			*value = (bridge->secondary_status << 16 |
+				  bridge->iolimit          <<  8 |
+				  bridge->iobase);
 		break;
 
 	case PCI_MEMORY_BASE:
@@ -495,6 +509,9 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
 	{
 		u32 old = bridge->command;
 
+		if (!mvebu_has_ioport(port))
+			value &= ~PCI_COMMAND_IO;
+
 		bridge->command = value & 0xffff;
 		if ((old ^ bridge->command) & PCI_COMMAND_IO)
 			mvebu_pcie_handle_iobase_change(port);
@@ -665,7 +682,9 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
 	struct mvebu_pcie *pcie = sys_to_pcie(sys);
 	int i;
 
-	pci_add_resource_offset(&sys->resources, &pcie->realio, sys->io_offset);
+	if (resource_size(&pcie->realio) != 0)
+		pci_add_resource_offset(&sys->resources, &pcie->realio,
+					sys->io_offset);
 	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
 	pci_add_resource(&sys->resources, &pcie->busn);
 
@@ -766,12 +785,17 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
 #define DT_CPUADDR_TO_ATTR(cpuaddr)   (((cpuaddr) >> 48) & 0xFF)
 
 static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
-			      unsigned long type, int *tgt, int *attr)
+			      unsigned long type,
+			      unsigned int *tgt,
+			      unsigned int *attr)
 {
 	const int na = 3, ns = 2;
 	const __be32 *range;
 	int rlen, nranges, rangesz, pna, i;
 
+	*tgt = -1;
+	*attr = -1;
+
 	range = of_get_property(np, "ranges", &rlen);
 	if (!range)
 		return -EINVAL;
@@ -841,16 +865,15 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	}
 
 	mvebu_mbus_get_pcie_io_aperture(&pcie->io);
-	if (resource_size(&pcie->io) == 0) {
-		dev_err(&pdev->dev, "invalid I/O aperture size\n");
-		return -EINVAL;
-	}
 
-	pcie->realio.flags = pcie->io.flags;
-	pcie->realio.start = PCIBIOS_MIN_IO;
-	pcie->realio.end = min_t(resource_size_t,
-				  IO_SPACE_LIMIT,
-				  resource_size(&pcie->io));
+	if (resource_size(&pcie->io) != 0) {
+		pcie->realio.flags = pcie->io.flags;
+		pcie->realio.start = PCIBIOS_MIN_IO;
+		pcie->realio.end = min_t(resource_size_t,
+					 IO_SPACE_LIMIT,
+					 resource_size(&pcie->io));
+	} else
+		pcie->realio = pcie->io;
 
 	/* Get the bus range */
 	ret = of_pci_parse_bus_range(np, &pcie->busn);
@@ -909,12 +932,12 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		ret = mvebu_get_tgt_attr(np, port->devfn, IORESOURCE_IO,
-					 &port->io_target, &port->io_attr);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "PCIe%d.%d: cannot get tgt/attr for io window\n",
-				port->port, port->lane);
-			continue;
+		if (resource_size(&pcie->io) != 0)
+			mvebu_get_tgt_attr(np, port->devfn, IORESOURCE_IO,
+					   &port->io_target, &port->io_attr);
+		else {
+			port->io_target = -1;
+			port->io_attr = -1;
 		}
 
 		port->reset_gpio = of_get_named_gpio_flags(child,
-- 
1.8.1.2

