Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Subject: [RFT PATCH v2 03/42] drivers: pci: host: ftpci100: convert IRQ
 masking to raw PCI config accessors
Date: Thu,  8 Jun 2017 15:13:03 +0100
Message-Id: <20170608141342.2018-4-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Murali Karicheri <m-karicheri2@ti.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Simon Horman <horms@verge.net.au>,
 Roy Zang <tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Current ftpci100 driver host bridge controller driver requires struct
pci_bus to be created in order to mask and clear IRQs using standard
PCI bus config accessors.

This struct pci_bus dependency is fictitious and burdens the driver
with unneeded constraints (eg to use separate APIs to create and scan
the root bus).

Add PCI raw config space accessors to PCIe ftpci100 driver and remove the
fictitious struct pci_bus dependency.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pci/host/pci-ftpci100.c | 44 ++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index d26501c..1c1fd60 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -204,17 +204,13 @@ static int faraday_pci_read_config(struct pci_bus *bus, unsigned int fn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int faraday_pci_write_config(struct pci_bus *bus, unsigned int fn,
-				    int config, int size, u32 value)
+static int faraday_raw_pci_write_config(struct faraday_pci *p, int bus_number,
+					 unsigned int fn, int config, int size,
+					 u32 value)
 {
-	struct faraday_pci *p = bus->sysdata;
 	int ret = PCIBIOS_SUCCESSFUL;
 
-	dev_dbg(&bus->dev,
-		"[write] slt: %.2d, fnc: %d, cnf: 0x%.2X, val (%d bytes): 0x%.8X\n",
-		PCI_SLOT(fn), PCI_FUNC(fn), config, size, value);
-
-	writel(PCI_CONF_BUS(bus->number) |
+	writel(PCI_CONF_BUS(bus_number) |
 			PCI_CONF_DEVICE(PCI_SLOT(fn)) |
 			PCI_CONF_FUNCTION(PCI_FUNC(fn)) |
 			PCI_CONF_WHERE(config) |
@@ -238,6 +234,19 @@ static int faraday_pci_write_config(struct pci_bus *bus, unsigned int fn,
 	return ret;
 }
 
+static int faraday_pci_write_config(struct pci_bus *bus, unsigned int fn,
+				    int config, int size, u32 value)
+{
+	struct faraday_pci *p = bus->sysdata;
+
+	dev_dbg(&bus->dev,
+		"[write] slt: %.2d, fnc: %d, cnf: 0x%.2X, val (%d bytes): 0x%.8X\n",
+		PCI_SLOT(fn), PCI_FUNC(fn), config, size, value);
+
+	return faraday_raw_pci_write_config(p, bus->number, fn, config, size,
+					    value);
+}
+
 static struct pci_ops faraday_pci_ops = {
 	.read	= faraday_pci_read_config,
 	.write	= faraday_pci_write_config,
@@ -496,17 +505,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	val |= PCI_COMMAND_MEMORY;
 	val |= PCI_COMMAND_MASTER;
 	writel(val, p->base + PCI_CTRL);
-
-	list_splice_init(&res, &host->windows);
-	ret = pci_register_host_bridge(host);
-	if (ret) {
-		dev_err(dev, "failed to register host: %d\n", ret);
-		return ret;
-	}
-	p->bus = host->bus;
-
 	/* Mask and clear all interrupts */
-	faraday_pci_write_config(p->bus, 0, FARADAY_PCI_CTRL2 + 2, 2, 0xF000);
+	faraday_raw_pci_write_config(p, 0, 0, FARADAY_PCI_CTRL2 + 2, 2, 0xF000);
 	if (variant->cascaded_irq) {
 		ret = faraday_pci_setup_cascaded_irq(p);
 		if (ret) {
@@ -519,6 +519,14 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	list_splice_init(&res, &host->windows);
+	ret = pci_register_host_bridge(host);
+	if (ret) {
+		dev_err(dev, "failed to register host: %d\n", ret);
+		return ret;
+	}
+	p->bus = host->bus;
+
 	pci_scan_child_bus(p->bus);
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 	pci_bus_assign_resources(p->bus);
-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
