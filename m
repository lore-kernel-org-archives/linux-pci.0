Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Pratyush Anand <panand@redhat.com>
To: dongbo4@huawei.com, bhelgaas@google.com, jingoohan1@gmail.com
Cc: linux-pci@vger.kernel.org,
	Pratyush Anand <pratyush.anand@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
	DEVICE TREE BINDINGS), Joao Pinto <jpinto@synopsys.com>,
	linux-kernel@vger.kernel.org (open list),
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/2] pcie/designware: Keep viewport fixed for IO transaction if num_viewport > 2
Date: Mon,  4 Jul 2016 21:44:42 +0530
Message-Id: <687a0706f69f6ebea047441aba5231113fd0c898.1467647958.git.panand@redhat.com>
In-Reply-To: <cover.1467647958.git.panand@redhat.com>
References: <cover.1467647958.git.panand@redhat.com>
In-Reply-To: <cover.1467647958.git.panand@redhat.com>
References: <cover.1467647958.git.panand@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@gmail.com>

Most of the platform have 3 or more viewports. We do not need to share
viewport for such platform between IO and CFG. Assign viewport 2 to IO
transactions in such cases.

Signed-off-by: Pratyush Anand <pratyush.anand@gmail.com>
Tested-by: Dong Bo <dongbo4@huawei.com>
---
 .../devicetree/bindings/pci/designware-pcie.txt    |  3 +++
 drivers/pci/host/pcie-designware.c                 | 26 ++++++++++++++++------
 drivers/pci/host/pcie-designware.h                 |  1 +
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 6c5322c55411..a72b7ecb80ee 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -17,6 +17,8 @@ Required properties:
 - num-lanes: number of lanes to use
 
 Optional properties:
+- num-viewport: number of view port configured in hardware. If a platform
+  does not specify it then driver will consider num-viewport as 2.
 - num-lanes: number of lanes to use (this property should be specified unless
   the link is brought already up in BIOS)
 - reset-gpio: gpio pin number of power good signal
@@ -44,4 +46,5 @@ Example configuration:
 		interrupts = <25>, <24>;
 		#interrupt-cells = <1>;
 		num-lanes = <1>;
+		num-viewport = <3>;
 	};
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index aafd766546f3..4c17c02ad72b 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -51,6 +51,7 @@
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
 #define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
+#define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
 #define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
 #define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
 #define PCIE_ATU_CR1			0x904
@@ -521,6 +522,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		pp->lanes = 0;
 
+	ret = of_property_read_u32(np, "num-viewport", &pp->num_viewport);
+	if (ret)
+		pp->num_viewport = 2;
+
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		if (!pp->ops->msi_host_init) {
 			pp->irq_domain = irq_domain_add_linear(pp->dev->of_node,
@@ -603,9 +608,10 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				  type, cpu_addr,
 				  busdev, cfg_size);
 	ret = dw_pcie_cfg_read(va_cfg_base + where, size, val);
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-				  PCIE_ATU_TYPE_IO, pp->io_base,
-				  pp->io_bus_addr, pp->io_size);
+	if (pp->num_viewport <= 2)
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+					  PCIE_ATU_TYPE_IO, pp->io_base,
+					  pp->io_bus_addr, pp->io_size);
 
 	return ret;
 }
@@ -640,9 +646,10 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				  type, cpu_addr,
 				  busdev, cfg_size);
 	ret = dw_pcie_cfg_write(va_cfg_base + where, size, val);
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-				  PCIE_ATU_TYPE_IO, pp->io_base,
-				  pp->io_bus_addr, pp->io_size);
+	if (pp->num_viewport <= 2)
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+					  PCIE_ATU_TYPE_IO, pp->io_base,
+					  pp->io_bus_addr, pp->io_size);
 
 	return ret;
 }
@@ -778,10 +785,15 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * uses its own address translation component rather than ATU, so
 	 * we should not program the ATU here.
 	 */
-	if (!pp->ops->rd_other_conf)
+	if (!pp->ops->rd_other_conf) {
 		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
+		if (pp->num_viewport > 2)
+			dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX2,
+						  PCIE_ATU_TYPE_IO, pp->io_base,
+						  pp->io_bus_addr, pp->io_size);
+	}
 
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
 
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index f437f9b5be04..61f479dd181d 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -49,6 +49,7 @@ struct pcie_port {
 	struct resource		*busn;
 	int			irq;
 	u32			lanes;
+	u32			num_viewport;
 	struct pcie_host_ops	*ops;
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
-- 
2.5.5
