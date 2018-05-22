Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0042.outbound.protection.outlook.com ([104.47.34.42]:36496
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751060AbeEVJG2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 May 2018 05:06:28 -0400
From: Alan Douglas <adouglas@cadence.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: [PATCH v2 2/4] PCI: cadence: Add generic PHY support to host and EP
 drivers
Date: Tue, 22 May 2018 09:06:26 +0000
Message-ID: <SN6PR07MB4512B35B884093D58EE5EA9AD8940@SN6PR07MB4512.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alan Douglas <adouglas@cadence.com>

If PHYs are present, they will be initialized and enabled in driver probe,
and disabled in driver shutdown.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/cadence/pcie-cadence-ep.c   | 14 ++++-
 drivers/pci/cadence/pcie-cadence-host.c | 31 +++++++++++
 drivers/pci/cadence/pcie-cadence.c      | 93 +++++++++++++++++++++++++++++=
++++
 drivers/pci/cadence/pcie-cadence.h      |  7 +++
 4 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pc=
ie-cadence-ep.c
index 3d8283e..2581caf 100644
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
@@ -535,7 +547,7 @@ static void cdns_pcie_ep_shutdown(struct platform_devic=
e *pdev)
=20
 	pm_runtime_disable(dev);
=20
-	/* The PCIe controller can't be disabled. */
+	cdns_pcie_disable_phy(pcie);
 }
=20
 static struct platform_driver cdns_pcie_ep_driver =3D {
diff --git a/drivers/pci/cadence/pcie-cadence-host.c b/drivers/pci/cadence/=
pcie-cadence-host.c
index a4ebbd3..7536926a 100644
--- a/drivers/pci/cadence/pcie-cadence-host.c
+++ b/drivers/pci/cadence/pcie-cadence-host.c
@@ -58,6 +58,9 @@ static void __iomem *cdns_pci_map_bus(struct pci_bus *bus=
, unsigned int devfn,
=20
 		return pcie->reg_base + (where & 0xfff);
 	}
+	/* Check that the link is up */
+	if (!(cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE) & 0x1))
+		return NULL;
=20
 	/* Update Output registers for AXI region 0. */
 	addr0 =3D CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
@@ -239,6 +242,7 @@ static int cdns_pcie_host_probe(struct platform_device =
*pdev)
 	struct cdns_pcie *pcie;
 	struct resource *res;
 	int ret;
+	int phy_count;
=20
 	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*rc));
 	if (!bridge)
@@ -290,6 +294,13 @@ static int cdns_pcie_host_probe(struct platform_device=
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
@@ -322,15 +333,35 @@ static int cdns_pcie_host_probe(struct platform_devic=
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
 	},
 	.probe =3D cdns_pcie_host_probe,
+	.shutdown =3D cdns_pcie_shutdown,
 };
 builtin_platform_driver(cdns_pcie_host_driver);
diff --git a/drivers/pci/cadence/pcie-cadence.c b/drivers/pci/cadence/pcie-=
cadence.c
index 138d113..681609a 100644
--- a/drivers/pci/cadence/pcie-cadence.c
+++ b/drivers/pci/cadence/pcie-cadence.c
@@ -124,3 +124,96 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie =
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
diff --git a/drivers/pci/cadence/pcie-cadence.h b/drivers/pci/cadence/pcie-=
cadence.h
index ed336cc..b342c80 100644
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
@@ -229,6 +230,9 @@ struct cdns_pcie {
 	struct resource		*mem_res;
 	bool			is_rc;
 	u8			bus;
+	int			phy_count;
+	struct phy		**phy;
+	struct device_link	**link;
 };
=20
 /* Register access */
@@ -307,5 +311,8 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struc=
t cdns_pcie *pcie, u8 fn,
 						  u32 r, u64 cpu_addr);
=20
 void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
+void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
+int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
+int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
=20
 #endif /* _PCIE_CADENCE_H */
--=20
2.2.2
