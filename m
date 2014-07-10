Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:47595 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaGJH1E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jul 2014 03:27:04 -0400
Received: by mail-pd0-f174.google.com with SMTP id y10so10257848pdj.5
        for <linux-pci@vger.kernel.org>; Thu, 10 Jul 2014 00:27:03 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arnd@linaro.org, olof@lixom.net
Cc: linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com,
	b.zolnierkie@samsung.com, bhelgaas@google.com, mark@nicholnet.com,
	linux-pci@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V9 0/7] ARM: SPEAr13xx: Add PCIe support
Date: Thu, 10 Jul 2014 12:56:31 +0530
Message-Id: <cover.1404976058.git.viresh.kumar@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds PCIe support for ARM based ST Microelectronics SPEAr13xx SoCs.

V8 was here: https://lkml.org/lkml/2014/4/15/260 and just before being pulled by
Olof this happened: https://lkml.org/lkml/2014/7/9/641.

An detailed look at the patches make it clear why Olof was unhappy.
Patches weren't in right order, groups, etc..

So, this is an attempt to fix all those issues. Pushed here:
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git spear/pcie-support-v9

V7->V8:
- Reorder, regroup patches.
- Improve logs and cc lists.
- And below diff to make checkpatch happy (generated with --word-diff),
  shouldn't have any functional impact.

Please let me know if someone still have objections to this set as I would be
sending a pull request tomorrow.

---------x---------------x-------------

diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
index 77bebae..fa5f2bb 100644
--- a/arch/arm/boot/dts/spear1310.dtsi
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -30,7 +30,7 @@
		};

		miphy0: miphy@eb800000 {
			compatible =[-"st,miphy",-] "st,spear1310-miphy";
			reg = <0xeb800000 0x4000>;
			misc = <&misc>;
			phy-id = <0>;
@@ -39,7 +39,7 @@
		};

		miphy1: miphy@eb804000 {
			compatible =[-"st,miphy",-] "st,spear1310-miphy";
			reg = <0xeb804000 0x4000>;
			misc = <&misc>;
			phy-id = <1>;
@@ -48,7 +48,7 @@
		};

		miphy2: miphy@eb808000 {
			compatible =[-"st,miphy",-] "st,spear1310-miphy";
			reg = <0xeb808000 0x4000>;
			misc = <&misc>;
			phy-id = <2>;
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index 0d8fe32f..e71df0f 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -32,7 +32,7 @@
		};

		miphy0: miphy@eb800000 {
			compatible =[-"st,miphy",-] "st,spear1340-miphy";
			reg = <0xeb800000 0x4000>;
			misc = <&misc>;
			#phy-cells = <1>;
diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index 5f06166f..3f3c0f1 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -11,6 +11,8 @@
 * warranty of any kind, whether express or implied.
 */

{+#define pr_fmt(fmt) "SPEAr1340: " fmt+}

#include <linux/of_platform.h>
#include <asm/mach/arch.h>
#include "generic.h"
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 9d4874a..a6fc332 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -176,21 +176,21 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
	 */
	if (spear13xx_pcie->is_gen1) {
		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCAP, 4,
				 &val);
		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
					  PCI_EXP_LNKCAP, 4, val);
		}

		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCTL2, 4,
				 &val);
		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
					  PCI_EXP_LNKCTL2, 4, val);
		}
	}

@@ -280,7 +280,7 @@ static int add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
		return -ENODEV;
	}
	ret = devm_request_irq(dev, pp->irq, spear13xx_pcie_irq_handler,
			       IRQF_SHARED, "spear1340-pcie", pp);
	if (ret) {
		dev_err(dev, "failed to request irq %d\n", pp->irq);
		return ret;
@@ -307,8 +307,7 @@ static int __init spear13xx_pcie_probe(struct platform_device *pdev)
	struct resource *dbi_base;
	int ret;

	spear13xx_pcie = devm_kzalloc(dev, sizeof(*spear13xx_pcie), GFP_KERNEL);
	if (!spear13xx_pcie) {
		dev_err(dev, "no memory for SPEAr13xx pcie\n");
		return -ENOMEM;
diff --git a/drivers/phy/phy-spear1310-miphy.c b/drivers/phy/phy-spear1310-miphy.c
index dc0b97a..c58c869 100644
--- a/drivers/phy/phy-spear1310-miphy.c
+++ b/drivers/phy/phy-spear1310-miphy.c
@@ -117,8 +117,8 @@ static int spear1310_miphy_pcie_init(struct spear1310_miphy_priv *priv)
	u32 val;

	regmap_update_bits(priv->misc, SPEAR1310_PCIE_MIPHY_CFG_1,
			   SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK,
			   SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE);

	switch (priv->id) {
	case 0:
@@ -135,7 +135,7 @@ static int spear1310_miphy_pcie_init(struct spear1310_miphy_priv *priv)
	}

	regmap_update_bits(priv->misc, SPEAR1310_PCIE_SATA_CFG,
			   SPEAR1310_PCIE_CFG_MASK(priv->id), val);

	return 0;
}
@@ -143,10 +143,10 @@ static int spear1310_miphy_pcie_init(struct spear1310_miphy_priv *priv)
static int spear1310_miphy_pcie_exit(struct spear1310_miphy_priv *priv)
{
	regmap_update_bits(priv->misc, SPEAR1310_PCIE_SATA_CFG,
			   SPEAR1310_PCIE_CFG_MASK(priv->id), 0);

	regmap_update_bits(priv->misc, SPEAR1310_PCIE_MIPHY_CFG_1,
			   SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK, 0);

	return 0;
}
@@ -186,7 +186,7 @@ static struct phy_ops spear1310_miphy_ops = {
};

static struct phy *spear1310_miphy_xlate(struct device *dev,
					 struct of_phandle_args *args)
{
	struct spear1310_miphy_priv *priv = dev_get_drvdata(dev);

diff --git a/drivers/phy/phy-spear1340-miphy.c b/drivers/phy/phy-spear1340-miphy.c
index e06e944..5e39231 100644
--- a/drivers/phy/phy-spear1340-miphy.c
+++ b/drivers/phy/phy-spear1340-miphy.c
@@ -92,18 +92,19 @@ struct spear1340_miphy_priv {
static int spear1340_miphy_sata_init(struct spear1340_miphy_priv *priv)
{
	regmap_update_bits(priv->misc, SPEAR1340_PCIE_SATA_CFG,
			   SPEAR1340_PCIE_SATA_CFG_MASK,
			   SPEAR1340_SATA_CFG_VAL);
	regmap_update_bits(priv->misc, SPEAR1340_PCIE_MIPHY_CFG,
			   SPEAR1340_PCIE_MIPHY_CFG_MASK,
			   SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK);
	/* Switch on sata power domain */
	regmap_update_bits(priv->misc, SPEAR1340_PCM_CFG,
			   SPEAR1340_PCM_CFG_SATA_POWER_EN,
			   SPEAR1340_PCM_CFG_SATA_POWER_EN);
	msleep(20);
	/* Disable PCIE SATA Controller reset */
	regmap_update_bits(priv->misc, SPEAR1340_PERIP1_SW_RST,
			   SPEAR1340_PERIP1_SW_RSATA, 0);
	msleep(20);

	return 0;
@@ -112,18 +113,18 @@ static int spear1340_miphy_sata_init(struct spear1340_miphy_priv *priv)
static int spear1340_miphy_sata_exit(struct spear1340_miphy_priv *priv)
{
	regmap_update_bits(priv->misc, SPEAR1340_PCIE_SATA_CFG,
			   SPEAR1340_PCIE_SATA_CFG_MASK, 0);
	regmap_update_bits(priv->misc, SPEAR1340_PCIE_MIPHY_CFG,
			   SPEAR1340_PCIE_MIPHY_CFG_MASK, 0);

	/* Enable PCIE SATA Controller reset */
	regmap_update_bits(priv->misc, SPEAR1340_PERIP1_SW_RST,
			   SPEAR1340_PERIP1_SW_RSATA,
			   SPEAR1340_PERIP1_SW_RSATA);
	msleep(20);
	/* Switch off sata power domain */
	regmap_update_bits(priv->misc, SPEAR1340_PCM_CFG,
			   SPEAR1340_PCM_CFG_SATA_POWER_EN, 0);
	msleep(20);

	return 0;
@@ -132,10 +133,11 @@ static int spear1340_miphy_sata_exit(struct spear1340_miphy_priv *priv)
static int spear1340_miphy_pcie_init(struct spear1340_miphy_priv *priv)
{
	regmap_update_bits(priv->misc, SPEAR1340_PCIE_MIPHY_CFG,
			   SPEAR1340_PCIE_MIPHY_CFG_MASK,
			   SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE);
	regmap_update_bits(priv->misc, SPEAR1340_PCIE_SATA_CFG,
			   SPEAR1340_PCIE_SATA_CFG_MASK,
			   SPEAR1340_PCIE_CFG_VAL);

	return 0;
}
@@ -143,9 +145,9 @@ static int spear1340_miphy_pcie_init(struct spear1340_miphy_priv *priv)
static int spear1340_miphy_pcie_exit(struct spear1340_miphy_priv *priv)
{
	regmap_update_bits(priv->misc, SPEAR1340_PCIE_MIPHY_CFG,
			   SPEAR1340_PCIE_MIPHY_CFG_MASK, 0);
	regmap_update_bits(priv->misc, SPEAR1340_PCIE_SATA_CFG,
			   SPEAR1340_PCIE_SATA_CFG_MASK, 0);

	return 0;
}
@@ -213,10 +215,10 @@ static int spear1340_miphy_resume(struct device *dev)
#endif

static SIMPLE_DEV_PM_OPS(spear1340_miphy_pm_ops, spear1340_miphy_suspend,
			 spear1340_miphy_resume);

static struct phy *spear1340_miphy_xlate(struct device *dev,
					 struct of_phandle_args *args)
{
	struct spear1340_miphy_priv *priv = dev_get_drvdata(dev);


---------x---------------x-----------

Mohit Kumar (1):
  ARM: SPEAr13xx: Update defconfigs

Pratyush Anand (6):
  pcie: Add designware wrapper driver for SPEAr13xx
  phy: Add drivers for PCIe and SATA phy on SPEAr13xx
  ARM: SPEAr13xx: Fix pcie clock name
  ARM: SPEAr13xx: Fix static mapping table
  ARM: SPEAr13xx: Add bindings and dt node for misc block
  ARM: SPEAr13xx: Add pcie and miphy DT nodes

 .../devicetree/bindings/arm/spear-misc.txt         |   9 +
 .../devicetree/bindings/pci/spear13xx-pcie.txt     |  14 +
 .../devicetree/bindings/phy/st-spear1310-miphy.txt |  12 +
 .../devicetree/bindings/phy/st-spear1340-miphy.txt |  11 +
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/spear1310-evb.dts                |   4 +
 arch/arm/boot/dts/spear1310.dtsi                   |  93 ++++-
 arch/arm/boot/dts/spear1340-evb.dts                |   4 +
 arch/arm/boot/dts/spear1340.dtsi                   |  30 +-
 arch/arm/boot/dts/spear13xx.dtsi                   |   9 +-
 arch/arm/configs/spear13xx_defconfig               |  16 +
 arch/arm/mach-spear/Kconfig                        |   4 +
 arch/arm/mach-spear/include/mach/spear.h           |   4 +-
 arch/arm/mach-spear/spear1340.c                    | 125 +------
 arch/arm/mach-spear/spear13xx.c                    |   2 +-
 drivers/clk/spear/spear1310_clock.c                |   6 +-
 drivers/clk/spear/spear1340_clock.c                |   2 +-
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-spear13xx.c                  | 405 +++++++++++++++++++++
 drivers/phy/Kconfig                                |  12 +
 drivers/phy/Makefile                               |   2 +
 drivers/phy/phy-spear1310-miphy.c                  | 274 ++++++++++++++
 drivers/phy/phy-spear1340-miphy.c                  | 302 +++++++++++++++
 24 files changed, 1218 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/spear-misc.txt
 create mode 100644 Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/st-spear1340-miphy.txt
 create mode 100644 drivers/pci/host/pcie-spear13xx.c
 create mode 100644 drivers/phy/phy-spear1310-miphy.c
 create mode 100644 drivers/phy/phy-spear1340-miphy.c

-- 
2.0.0.rc2

