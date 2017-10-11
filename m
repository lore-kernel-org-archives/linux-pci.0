Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: v3-semi: print resources using %pR format string
Date: Wed, 11 Oct 2017 16:02:09 +0200
Message-Id: <20171011140224.3770968-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A resource_size_t can be 32 or 64 bit on arm32, causing a number
of warnings for incorrect format strings:

In file included from include/linux/printk.h:327:0,
                 from include/linux/kernel.h:13,
                 from include/linux/interrupt.h:5,
                 from drivers/pci/host/pci-v3-semi.c:19:
drivers/pci/host/pci-v3-semi.c: In function 'v3_pci_setup_resource':
drivers/pci/host/pci-v3-semi.c:536:4: error: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'phys_addr_t {aka long long unsigned int}' [-Werror=format=]
    "I/O window start %08x, bus addr %08x, size %08x\n",
drivers/pci/host/pci-v3-semi.c:536:4: error: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]

The best way to print this instead is to pass the resource itself
to printk as a pointerm, using the special '%pR' format string
for pretty-printing the range.

For the bus address, we use %pap, respectively.

Fixes: 132d10e24ff3 ("PCI: v3-semi: Add V3 Semiconductor PCI host driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pci-v3-semi.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pci-v3-semi.c b/drivers/pci/host/pci-v3-semi.c
index a544d722aef1..02f6e1e3a421 100644
--- a/drivers/pci/host/pci-v3-semi.c
+++ b/drivers/pci/host/pci-v3-semi.c
@@ -532,10 +532,8 @@ static int v3_pci_setup_resource(struct v3_pci *v3,
 		io->name = "V3 PCI I/O";
 		v3->io_mem = io_base;
 		v3->io_bus_addr = io->start - win->offset;
-		dev_dbg(dev,
-			"I/O window start %08x, bus addr %08x, size %08x\n",
-			v3->io_mem, v3->io_bus_addr,
-			resource_size(io));
+		dev_dbg(dev, "I/O window %pR, bus addr %pap\n",
+			io, &v3->io_bus_addr);
 		ret = pci_remap_iospace(io, io_base);
 		if (ret) {
 			dev_warn(dev,
@@ -556,9 +554,8 @@ static int v3_pci_setup_resource(struct v3_pci *v3,
 			mem->name = "V3 PCI PRE-MEM";
 			v3->pre_mem = mem->start;
 			v3->pre_bus_addr = mem->start - win->offset;
-			dev_dbg(dev, "PREFETCHABLE MEM window start %08x, bus addr %08x, size %08x\n",
-				v3->pre_mem, v3->pre_bus_addr,
-				resource_size(mem));
+			dev_dbg(dev, "PREFETCHABLE MEM window %pR, bus addr %pap\n",
+				mem, &v3->pre_bus_addr);
 			if (resource_size(mem) != SZ_256M) {
 				dev_err(dev, "prefetchable memory range is not 256MB\n");
 				return -EINVAL;
@@ -582,10 +579,8 @@ static int v3_pci_setup_resource(struct v3_pci *v3,
 			mem->name = "V3 PCI NON-PRE-MEM";
 			v3->non_pre_mem = mem->start;
 			v3->non_pre_bus_addr = mem->start - win->offset;
-			dev_dbg(dev,
-				"NON-PREFETCHABLE MEM window start %08x, bus addr %08x, size %08x\n",
-				v3->non_pre_mem, v3->non_pre_bus_addr,
-				resource_size(mem));
+			dev_dbg(dev, "NON-PREFETCHABLE MEM window %pR, bus addr %pap\n",
+				mem, &v3->non_pre_bus_addr);
 			if (resource_size(mem) != SZ_256M) {
 				dev_err(dev,
 					"non-prefetchable memory range is not 256MB\n");
@@ -602,7 +597,7 @@ static int v3_pci_setup_resource(struct v3_pci *v3,
 		}
 		break;
 	case IORESOURCE_BUS:
-		dev_dbg(dev, "BUS %d\n", win->res->start);
+		dev_dbg(dev, "BUS %pR\n", win->res);
 		host->busnr = win->res->start;
 		break;
 	default:
@@ -781,9 +776,8 @@ static int v3_pci_probe(struct platform_device *pdev)
 	 * as the physical memory we've remapped it from.
 	 */
 	if (readl(v3->base + V3_LB_IO_BASE) != (regs->start >> 16))
-		dev_err(dev, "V3_LB_IO_BASE = %08x but device is @%08x\n",
-			readl(v3->base + V3_LB_IO_BASE),
-			regs->start);
+		dev_err(dev, "V3_LB_IO_BASE = %08x but device is @%pR\n",
+			readl(v3->base + V3_LB_IO_BASE), regs);
 
 	/* Configuration space is 16MB directly mapped */
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-- 
2.9.0
