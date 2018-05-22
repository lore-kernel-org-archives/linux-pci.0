Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0045.outbound.protection.outlook.com ([104.47.32.45]:20016
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751245AbeEVJJl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 May 2018 05:09:41 -0400
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
Subject: [PATCH 4/4] PCI: cadence: Add Power Management ops for host and EP
Date: Tue, 22 May 2018 09:09:39 +0000
Message-ID: <SN6PR07MB4512B50F80E6DF4AB457A728D8940@SN6PR07MB4512.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alan Douglas <adouglas@cadence.com>

These PM ops will enable/disable the optional PHYs if present.  The
AXI link-down register in the host driver is now cleared in
cdns_pci_map_bus since the link-down bit will be set if the PHY has
been disabled.  It is not cleared when enabling the PHY, since the
link will not yet be up.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/cadence/pcie-cadence-ep.c   |  1 +
 drivers/pci/cadence/pcie-cadence-host.c |  3 +++
 drivers/pci/cadence/pcie-cadence.c      | 30 +++++++++++++++++++++++++++++=
+
 drivers/pci/cadence/pcie-cadence.h      |  4 ++++
 4 files changed, 38 insertions(+)

diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pc=
ie-cadence-ep.c
index 2581caf..e74b8a4 100644
--- a/drivers/pci/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/cadence/pcie-cadence-ep.c
@@ -554,6 +554,7 @@ static struct platform_driver cdns_pcie_ep_driver =3D {
 	.driver =3D {
 		.name =3D "cdns-pcie-ep",
 		.of_match_table =3D cdns_pcie_ep_of_match,
+		.pm	=3D &cdns_pcie_pm_ops,
 	},
 	.probe =3D cdns_pcie_ep_probe,
 	.shutdown =3D cdns_pcie_ep_shutdown,
diff --git a/drivers/pci/cadence/pcie-cadence-host.c b/drivers/pci/cadence/=
pcie-cadence-host.c
index 7536926a..a8b5eda 100644
--- a/drivers/pci/cadence/pcie-cadence-host.c
+++ b/drivers/pci/cadence/pcie-cadence-host.c
@@ -61,6 +61,8 @@ static void __iomem *cdns_pci_map_bus(struct pci_bus *bus=
, unsigned int devfn,
 	/* Check that the link is up */
 	if (!(cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE) & 0x1))
 		return NULL;
+	/* Clear AXI link-down status */
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_LINKDOWN, 0x0);
=20
 	/* Update Output registers for AXI region 0. */
 	addr0 =3D CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
@@ -360,6 +362,7 @@ static struct platform_driver cdns_pcie_host_driver =3D=
 {
 	.driver =3D {
 		.name =3D "cdns-pcie-host",
 		.of_match_table =3D cdns_pcie_host_of_match,
+		.pm	=3D &cdns_pcie_pm_ops,
 	},
 	.probe =3D cdns_pcie_host_probe,
 	.shutdown =3D cdns_pcie_shutdown,
diff --git a/drivers/pci/cadence/pcie-cadence.c b/drivers/pci/cadence/pcie-=
cadence.c
index 681609a..7a34780 100644
--- a/drivers/pci/cadence/pcie-cadence.c
+++ b/drivers/pci/cadence/pcie-cadence.c
@@ -217,3 +217,33 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns=
_pcie *pcie)
=20
 	return ret;
 }
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
index b342c80..ae6bf2a 100644
--- a/drivers/pci/cadence/pcie-cadence.h
+++ b/drivers/pci/cadence/pcie-cadence.h
@@ -166,6 +166,9 @@
 #define CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar) \
 	(CDNS_PCIE_AT_BASE + 0x0804 + (bar) * 0x0008)
=20
+/* AXI link down register */
+#define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
+
 enum cdns_pcie_rp_bar {
 	RP_BAR0,
 	RP_BAR1,
@@ -314,5 +317,6 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *=
pcie, u32 r);
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+extern const struct dev_pm_ops cdns_pcie_pm_ops;
=20
 #endif /* _PCIE_CADENCE_H */
--=20
2.2.2
