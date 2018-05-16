Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0062.outbound.protection.outlook.com ([104.47.34.62]:63537
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751595AbeEPNGI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 May 2018 09:06:08 -0400
From: Alan Douglas <adouglas@cadence.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: [PATCH] pci: cadence: Host and EP driver updates for PHY and power
 management
Date: Wed, 16 May 2018 13:06:05 +0000
Message-ID: <SN6PR07MB451229DF639238CD7F15FDCFD8920@SN6PR07MB4512.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alan Douglas <adouglas@cadence.com>

This patch is based on next branch in Bjorn Helgaas' linux-pci git reposito=
ry.

Allow optional list of generic PHYs to be provided via DTS for cadence RP a=
nd EP drivers.
Added power management ops which will enable/disable these PHYs. =20
Corrected parameters for cdns_pcie_writel function, value to be written had=
 too=20
small width.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |    4 +
 .../bindings/pci/cdns,cdns-pcie-host.txt           |    5 +
 drivers/pci/cadence/pcie-cadence-ep.c              |   15 +++-
 drivers/pci/cadence/pcie-cadence-host.c            |   36 ++++++-
 drivers/pci/cadence/pcie-cadence.c                 |  123 ++++++++++++++++=
++++
 drivers/pci/cadence/pcie-cadence.h                 |   13 ++-
 6 files changed, 193 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt b/=
Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
index 9a30523..e40c635 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
@@ -9,6 +9,8 @@ Required properties:
=20
 Optional properties:
 - max-functions: Maximum number of functions that can be configured (defau=
lt 1).
+- phys: From PHY bindings: List of Generic PHY phandles.
+- phy-names:  List of names to identify the PHY.
=20
 Example:
=20
@@ -19,4 +21,6 @@ pcie@fc000000 {
 	reg-names =3D "reg", "mem";
 	cdns,max-outbound-regions =3D <16>;
 	max-functions =3D /bits/ 8 <8>;
+	phys =3D <&ep_phy0 &ep_phy1>;
+	phy-names =3D "pcie-lane0","pcie-lane1";
 };
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt =
b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
index 20a33f3..13be218 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
@@ -24,6 +24,8 @@ Optional properties:
   translations (default 32)
 - vendor-id: The PCI vendor ID (16 bits, default is design dependent)
 - device-id: The PCI device ID (16 bits, default is design dependent)
+- phys: From PHY bindings: List of Generic PHY phandles.
+- phy-names:  List of names to identify the PHY.
=20
 Example:
=20
@@ -57,4 +59,7 @@ pcie@fb000000 {
 	interrupt-map-mask =3D <0x0 0x0 0x0  0x7>;
=20
 	msi-parent =3D <&its_pci>;
+
+	phys =3D <&pcie_phy0>;
+	phy-names =3D "pcie-phy";
 };
diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pc=
ie-cadence-ep.c
index 3d8283e..e74b8a4 100644
--- a/drivers/pci/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/cadence/pcie-cadence-ep.c
@@ -439,6 +439,7 @@ static int cdns_pcie_ep_probe(struct platform_device *p=
dev)
 	struct pci_epc *epc;
 	struct resource *res;
 	int ret;
+	int phy_count;
=20
 	ep =3D devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
 	if (!ep)
@@ -472,6 +473,12 @@ static int cdns_pcie_ep_probe(struct platform_device *=
pdev)
 	if (!ep->ob_addr)
 		return -ENOMEM;
=20
+	ret =3D cdns_pcie_init_phy(dev, pcie);
+	if (ret) {
+		dev_err(dev, "failed to init phy\n");
+		return ret;
+	}
+	platform_set_drvdata(pdev, pcie);
 	pm_runtime_enable(dev);
 	ret =3D pm_runtime_get_sync(dev);
 	if (ret < 0) {
@@ -520,6 +527,10 @@ static int cdns_pcie_ep_probe(struct platform_device *=
pdev)
=20
  err_get_sync:
 	pm_runtime_disable(dev);
+	cdns_pcie_disable_phy(pcie);
+	phy_count =3D pcie->phy_count;
+	while (phy_count--)
+		device_link_del(pcie->link[phy_count]);
=20
 	return ret;
 }
@@ -527,6 +538,7 @@ static int cdns_pcie_ep_probe(struct platform_device *p=
dev)
 static void cdns_pcie_ep_shutdown(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
+	struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
 	int ret;
=20
 	ret =3D pm_runtime_put_sync(dev);
@@ -535,13 +547,14 @@ static void cdns_pcie_ep_shutdown(struct platform_dev=
ice *pdev)
=20
 	pm_runtime_disable(dev);
=20
-	/* The PCIe controller can't be disabled. */
+	cdns_pcie_disable_phy(pcie);
 }
=20
 static struct platform_driver cdns_pcie_ep_driver =3D {
 	.driver =3D {
 		.name =3D "cdns-pcie-ep",
 		.of_match_table =3D cdns_pcie_ep_of_match,
+		.pm	=3D &cdns_pcie_pm_ops,
 	},
 	.probe =3D cdns_pcie_ep_probe,
 	.shutdown =3D cdns_pcie_ep_shutdown,
diff --git a/drivers/pci/cadence/pcie-cadence-host.c b/drivers/pci/cadence/=
pcie-cadence-host.c
index a4ebbd3..992ebe2 100644
--- a/drivers/pci/cadence/pcie-cadence-host.c
+++ b/drivers/pci/cadence/pcie-cadence-host.c
@@ -37,7 +37,6 @@ struct cdns_pcie_rc {
 	u16			vendor_id;
 	u16			device_id;
 };
-
 static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int de=
vfn,
 				      int where)
 {
@@ -46,6 +45,7 @@ struct cdns_pcie_rc {
 	struct cdns_pcie *pcie =3D &rc->pcie;
 	unsigned int busn =3D bus->number;
 	u32 addr0, desc0;
+	u32 link_status;
=20
 	if (busn =3D=3D rc->bus_range->start) {
 		/*
@@ -58,6 +58,11 @@ struct cdns_pcie_rc {
=20
 		return pcie->reg_base + (where & 0xfff);
 	}
+	/* Check that the link is up. Clear AXI link-down status  */
+	link_status =3D cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE);
+	if (!(link_status & 0x1))
+		return NULL;
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_LINKDOWN, 0x0);
=20
 	/* Update Output registers for AXI region 0. */
 	addr0 =3D CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
@@ -239,6 +244,7 @@ static int cdns_pcie_host_probe(struct platform_device =
*pdev)
 	struct cdns_pcie *pcie;
 	struct resource *res;
 	int ret;
+	int phy_count;
=20
 	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*rc));
 	if (!bridge)
@@ -290,6 +296,13 @@ static int cdns_pcie_host_probe(struct platform_device=
 *pdev)
 	}
 	pcie->mem_res =3D res;
=20
+	ret =3D cdns_pcie_init_phy(dev, pcie);
+	if (ret) {
+		dev_err(dev, "failed to init phy\n");
+		return ret;
+	}
+	platform_set_drvdata(pdev, pcie);
+
 	pm_runtime_enable(dev);
 	ret =3D pm_runtime_get_sync(dev);
 	if (ret < 0) {
@@ -322,15 +335,36 @@ static int cdns_pcie_host_probe(struct platform_devic=
e *pdev)
=20
  err_get_sync:
 	pm_runtime_disable(dev);
+	cdns_pcie_disable_phy(pcie);
+	phy_count =3D pcie->phy_count;
+	while (phy_count--)
+		device_link_del(pcie->link[phy_count]);
=20
 	return ret;
 }
=20
+static void cdns_pcie_shutdown(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D pm_runtime_put_sync(dev);
+	if (ret < 0)
+		dev_dbg(dev, "pm_runtime_put_sync failed\n");
+
+	pm_runtime_disable(dev);
+	cdns_pcie_disable_phy(pcie);
+}
+
+
 static struct platform_driver cdns_pcie_host_driver =3D {
 	.driver =3D {
 		.name =3D "cdns-pcie-host",
 		.of_match_table =3D cdns_pcie_host_of_match,
+		.pm	=3D &cdns_pcie_pm_ops,
 	},
 	.probe =3D cdns_pcie_host_probe,
+	.shutdown =3D cdns_pcie_shutdown,
 };
 builtin_platform_driver(cdns_pcie_host_driver);
diff --git a/drivers/pci/cadence/pcie-cadence.c b/drivers/pci/cadence/pcie-=
cadence.c
index 138d113..7a34780 100644
--- a/drivers/pci/cadence/pcie-cadence.c
+++ b/drivers/pci/cadence/pcie-cadence.c
@@ -124,3 +124,126 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie=
 *pcie, u32 r)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), 0);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), 0);
 }
+
+void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
+{
+	int i =3D pcie->phy_count;
+
+	while (i--) {
+		phy_power_off(pcie->phy[i]);
+		phy_exit(pcie->phy[i]);
+	}
+}
+
+int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
+{
+	int ret;
+	int i;
+
+	for (i =3D 0; i < pcie->phy_count; i++) {
+		ret =3D phy_init(pcie->phy[i]);
+		if (ret < 0)
+			goto err_phy;
+
+		ret =3D phy_power_on(pcie->phy[i]);
+		if (ret < 0) {
+			phy_exit(pcie->phy[i]);
+			goto err_phy;
+		}
+	}
+
+	return 0;
+
+err_phy:
+	while (--i >=3D 0) {
+		phy_power_off(pcie->phy[i]);
+		phy_exit(pcie->phy[i]);
+	}
+
+	return ret;
+}
+
+int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
+{
+	struct device_node *np =3D dev->of_node;
+	int phy_count;
+	struct phy **phy;
+	struct device_link **link;
+	int i;
+	int ret;
+	const char *name;
+
+	phy_count =3D of_property_count_strings(np, "phy-names");
+	if (phy_count < 1) {
+		dev_err(dev, "no phy-names.  PHY will not be initialized\n");
+		pcie->phy_count =3D 0;
+		return 0;
+	}
+
+	phy =3D devm_kzalloc(dev, sizeof(*phy) * phy_count, GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	link =3D devm_kzalloc(dev, sizeof(*link) * phy_count, GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
+	for (i =3D 0; i < phy_count; i++) {
+		of_property_read_string_index(np, "phy-names", i, &name);
+		phy[i] =3D devm_phy_get(dev, name);
+		if (IS_ERR(phy))
+			return PTR_ERR(phy);
+
+		link[i] =3D device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
+		if (!link[i]) {
+			ret =3D -EINVAL;
+			goto err_link;
+		}
+	}
+
+	pcie->phy_count =3D phy_count;
+	pcie->phy =3D phy;
+	pcie->link =3D link;
+
+	ret =3D  cdns_pcie_enable_phy(pcie);
+	if (ret)
+		goto err_link;
+
+	return 0;
+
+err_link:
+	while (--i >=3D 0)
+		device_link_del(link[i]);
+
+	return ret;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int cdns_pcie_suspend_noirq(struct device *dev)
+{
+	struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
+
+	cdns_pcie_disable_phy(pcie);
+
+	return 0;
+}
+
+static int cdns_pcie_resume_noirq(struct device *dev)
+{
+	struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D cdns_pcie_enable_phy(pcie);
+	if (ret) {
+		dev_err(dev, "failed to enable phy\n");
+		return ret;
+	}
+
+	return 0;
+}
+#endif
+
+const struct dev_pm_ops cdns_pcie_pm_ops =3D {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
+				      cdns_pcie_resume_noirq)
+};
diff --git a/drivers/pci/cadence/pcie-cadence.h b/drivers/pci/cadence/pcie-=
cadence.h
index 4bb2733..ae6bf2a 100644
--- a/drivers/pci/cadence/pcie-cadence.h
+++ b/drivers/pci/cadence/pcie-cadence.h
@@ -8,6 +8,7 @@
=20
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/phy/phy.h>
=20
 /*
  * Local Management Registers
@@ -165,6 +166,9 @@
 #define CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar) \
 	(CDNS_PCIE_AT_BASE + 0x0804 + (bar) * 0x0008)
=20
+/* AXI link down register */
+#define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
+
 enum cdns_pcie_rp_bar {
 	RP_BAR0,
 	RP_BAR1,
@@ -229,6 +233,9 @@ struct cdns_pcie {
 	struct resource		*mem_res;
 	bool			is_rc;
 	u8			bus;
+	int			phy_count;
+	struct phy		**phy;
+	struct device_link	**link;
 };
=20
 /* Register access */
@@ -279,7 +286,7 @@ static inline void cdns_pcie_ep_fn_writew(struct cdns_p=
cie *pcie, u8 fn,
 }
=20
 static inline void cdns_pcie_ep_fn_writel(struct cdns_pcie *pcie, u8 fn,
-					  u32 reg, u16 value)
+					  u32 reg, u32 value)
 {
 	writel(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
 }
@@ -307,5 +314,9 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struc=
t cdns_pcie *pcie, u8 fn,
 						  u32 r, u64 cpu_addr);
=20
 void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
+void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
+int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
+int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+extern const struct dev_pm_ops cdns_pcie_pm_ops;
=20
 #endif /* _PCIE_CADENCE_H */
--=20
1.7.1
