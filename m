Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Joao Pinto <jpinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 Pratyush Anand <pratyush.anand@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/3] pci: pcie-designware: add support for external MSI
 controller
Date: Tue, 30 Aug 2016 14:57:09 +0200
Message-Id: <1472561830-20932-3-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Kumar Gala <galak@codeaurora.org>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Shadi Ammouri <shadi@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The Designware PCIe controllers have a built-in MSI controller, which is
already supported by the existing. However, in some situations, it might
be a better choice to use an external MSI controller, especially when it
provides a higher number of MSI interrupts than the built-in one.

Therefore, this commit extends the pcie-designware driver to support the
"msi-parent" DT property, already used by other drivers. It contains a
phandle pointing to the external MSI controller to be used.

Following this commit, the pcie-designware code supports three
possibilities, in this order:

 1. If msi-parent is provided, then the MSI controller pointed by this
    property is used.

 2. Otherwise, and if no ->msi_host_init() function is provided by the
    platform-specific "glue", then the built-in MSI controller of the
    Designware controller is used.

 3. Otherwise, the ->msi_host_init() function of the platform-specific
    "glue" is used to do some additional initialization, but it's still
    the built-in MSI controller that is used.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pcie-designware.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 12afce1..1e18a85 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -437,6 +437,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	int i, ret;
 	LIST_HEAD(res);
 	struct resource_entry *win;
+	struct msi_controller *msi = NULL;
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
@@ -525,10 +526,21 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pp->lanes = 0;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		if (!pp->ops->msi_host_init) {
+		if (of_find_property(pp->dev->of_node, "msi-parent", NULL)) {
+			struct device_node *msi_node;
+
+			msi_node = of_parse_phandle(pp->dev->of_node,
+						    "msi-parent", 0);
+			if (!msi_node)
+				return -ENODEV;
+
+			msi = of_pci_find_msi_chip_by_node(msi_node);
+		} else if (!pp->ops->msi_host_init) {
+			msi = &dw_pcie_msi_chip;
+			msi->dev = pp->dev;
 			pp->irq_domain = irq_domain_add_linear(pp->dev->of_node,
 						MAX_MSI_IRQS, &msi_domain_ops,
-						&dw_pcie_msi_chip);
+						msi);
 			if (!pp->irq_domain) {
 				dev_err(pp->dev, "irq domain init failed\n");
 				ret = -ENXIO;
@@ -538,7 +550,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			for (i = 0; i < MAX_MSI_IRQS; i++)
 				irq_create_mapping(pp->irq_domain, i);
 		} else {
-			ret = pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
+			msi = &dw_pcie_msi_chip;
+			msi->dev = pp->dev;
+			ret = pp->ops->msi_host_init(pp, msi);
 			if (ret < 0)
 				goto error;
 		}
@@ -550,9 +564,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	pp->root_bus_nr = pp->busn->start;
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
-					    &dw_pcie_ops, pp, &res,
-					    &dw_pcie_msi_chip);
-		dw_pcie_msi_chip.dev = pp->dev;
+					    &dw_pcie_ops, pp, &res, msi);
 	} else
 		bus = pci_scan_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
 					pp, &res);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
