Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V3 2/4] phy: phy-exynos-pcie: Add support for Exynos PCIe
 phy
To: Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
        niyas.ahmed@samsung.com, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, kishon@ti.com,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <d28c6643-1f5d-f33e-cecc-d392f7250da1@samsung.com>
Date: Thu, 16 Feb 2017 07:29:34 +0900
MIME-version: 1.0
In-reply-to: <64f04459-c88e-c479-04fb-267e3f3960c6@codeaurora.org>
Content-type: text/plain; charset=windows-1252
References: <20170213082613.19628-1-jh80.chung@samsung.com>
 <CGME20170213082615epcas5p2d6bc5521e68adf71bb64d9eb8262274d@epcas5p2.samsung.com>
 <20170213082613.19628-3-jh80.chung@samsung.com>
 <64f04459-c88e-c479-04fb-267e3f3960c6@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Vivek,

On 02/15/2017 02:24 PM, Vivek Gautam wrote:
> 
> On 02/13/2017 01:56 PM, Jaehoon Chung wrote:
>> This patch adds support for Generic PHY framework about Exynos SoCs.
>> Current Exynos PCIe driver doesn't use the PHY framework.
>> It's making a difficult to upstream the other Exynos variants because of
>> different PHY registers.
>>
>> Move the codes relevant to PHY from Exnyos PCIe driver to PHY Exynos PCIe
>> driver.
>>
>> Signed-off-by: Jaehoon Chung<jh80.chung@samsung.com>
>> Acked-by: Krzysztof Kozlowski<krzk@kernel.org>
>> Reviewed-by: Jingoo Han<jingoohan1@gmail.com>
>> Reviewed-by: Pankaj Dubey<pankaj.dubey@samsung.com>
>> ---
>> Changelog on V3:
>> - Remove the dependency abot PCI_EXYNOS
>> - Adds a depends on COMPILE_TEST
>> - Use the readl_poll_timeout() instead of while()
>> - Fixes const type
>> - Adds MODULE_DESCRIPTION()/LICENCSE()/AUTHOR()
>> - Changes commit message
>>
>> Changelog on V2:
>> - Not include the codes relevant to pci-exynos.
>> - Remove the getting child node.
>>
>>   drivers/phy/Kconfig           |   8 ++
>>   drivers/phy/Makefile          |   1 +
>>   drivers/phy/phy-exynos-pcie.c | 285 ++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 294 insertions(+)
>>   create mode 100644 drivers/phy/phy-exynos-pcie.c
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index e8eb7f2..8659f38 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -331,6 +331,14 @@ config PHY_EXYNOS5_USBDRD
>>         This driver provides PHY interface for USB 3.0 DRD controller
>>         present on Exynos5 SoC series.
>>   +config PHY_EXYNOS_PCIE
>> +    bool "Exynos PCIe PHY driver"
>> +    depends on (ARCH_EXYNOS && OF) || COMPILE_TEST
> 
> this should be other way round if your driver runs only with OF enabled.
>           depends on OF && (ARCH_EXYNOS || COMPILE_TEST)

Will update.

> 
>> +    select GENERIC_PHY
>> +    help
>> +      Enable PCIe PHY support for Exynos SoC series.
>> +      This driver provides PHY interface for Exynos PCIe controller.
>> +
>>   config PHY_PISTACHIO_USB
>>       tristate "IMG Pistachio USB2.0 PHY driver"
>>       depends on MACH_PISTACHIO
>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>> index 65eb2f4..081aeb4 100644
>> --- a/drivers/phy/Makefile
>> +++ b/drivers/phy/Makefile
>> @@ -37,6 +37,7 @@ phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4X12_USB2)    += phy-exynos4x12-usb2.o
>>   phy-exynos-usb2-$(CONFIG_PHY_EXYNOS5250_USB2)    += phy-exynos5250-usb2.o
>>   phy-exynos-usb2-$(CONFIG_PHY_S5PV210_USB2)    += phy-s5pv210-usb2.o
>>   obj-$(CONFIG_PHY_EXYNOS5_USBDRD)    += phy-exynos5-usbdrd.o
>> +obj-$(CONFIG_PHY_EXYNOS_PCIE)    += phy-exynos-pcie.o
>>   obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)    += phy-qcom-apq8064-sata.o
>>   obj-$(CONFIG_PHY_ROCKCHIP_USB) += phy-rockchip-usb.o
>>   obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)    += phy-rockchip-inno-usb2.o
>> diff --git a/drivers/phy/phy-exynos-pcie.c b/drivers/phy/phy-exynos-pcie.c
>> new file mode 100644
>> index 0000000..9ec1855
>> --- /dev/null
>> +++ b/drivers/phy/phy-exynos-pcie.c
>> @@ -0,0 +1,285 @@
>> +/*
>> + * Samsung EXYNOS SoC series PCIe PHY driver
>> + *
>> + * Phy provider for PCIe controller on Exynos SoC series
>> + *
>> + * Copyright (C) 2016 Samsung Electronics Co., Ltd.
> 
> nit: copyright year.

Will do.

Thanks for reviewing.

Best Regards,
Jaehoon Chung

> 
>> + * Jaehoon Chung<jh80.chung@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/regmap.h>
>> +
>> +/* PCIe Purple registers */
>> +#define PCIE_PHY_GLOBAL_RESET        0x000
>> +#define PCIE_PHY_COMMON_RESET        0x004
>> +#define PCIE_PHY_CMN_REG        0x008
>> +#define PCIE_PHY_MAC_RESET        0x00c
>> +#define PCIE_PHY_PLL_LOCKED        0x010
>> +#define PCIE_PHY_TRSVREG_RESET        0x020
>> +#define PCIE_PHY_TRSV_RESET        0x024
>> +
>> +/* PCIe PHY registers */
>> +#define PCIE_PHY_IMPEDANCE        0x004
>> +#define PCIE_PHY_PLL_DIV_0        0x008
>> +#define PCIE_PHY_PLL_BIAS        0x00c
>> +#define PCIE_PHY_DCC_FEEDBACK        0x014
>> +#define PCIE_PHY_PLL_DIV_1        0x05c
>> +#define PCIE_PHY_COMMON_POWER        0x064
>> +#define PCIE_PHY_COMMON_PD_CMN        BIT(3)
>> +#define PCIE_PHY_TRSV0_EMP_LVL        0x084
>> +#define PCIE_PHY_TRSV0_DRV_LVL        0x088
>> +#define PCIE_PHY_TRSV0_RXCDR        0x0ac
>> +#define PCIE_PHY_TRSV0_POWER        0x0c4
>> +#define PCIE_PHY_TRSV0_PD_TSV        BIT(7)
>> +#define PCIE_PHY_TRSV0_LVCC        0x0dc
>> +#define PCIE_PHY_TRSV1_EMP_LVL        0x144
>> +#define PCIE_PHY_TRSV1_RXCDR        0x16c
>> +#define PCIE_PHY_TRSV1_POWER        0x184
>> +#define PCIE_PHY_TRSV1_PD_TSV        BIT(7)
>> +#define PCIE_PHY_TRSV1_LVCC        0x19c
>> +#define PCIE_PHY_TRSV2_EMP_LVL        0x204
>> +#define PCIE_PHY_TRSV2_RXCDR        0x22c
>> +#define PCIE_PHY_TRSV2_POWER        0x244
>> +#define PCIE_PHY_TRSV2_PD_TSV        BIT(7)
>> +#define PCIE_PHY_TRSV2_LVCC        0x25c
>> +#define PCIE_PHY_TRSV3_EMP_LVL        0x2c4
>> +#define PCIE_PHY_TRSV3_RXCDR        0x2ec
>> +#define PCIE_PHY_TRSV3_POWER        0x304
>> +#define PCIE_PHY_TRSV3_PD_TSV        BIT(7)
>> +#define PCIE_PHY_TRSV3_LVCC        0x31c
>> +
>> +struct exynos_pcie_phy_data {
>> +    const struct phy_ops    *ops;
>> +};
>> +
>> +/* For Exynos pcie phy */
>> +struct exynos_pcie_phy {
>> +    const struct exynos_pcie_phy_data *drv_data;
>> +    void __iomem *phy_base;
>> +    void __iomem *blk_base; /* For exynos5440 */
>> +};
>> +
>> +static void exynos_pcie_phy_writel(void __iomem *base, u32 val, u32 offset)
>> +{
>> +    writel(val, base + offset);
>> +}
>> +
>> +static u32 exynos_pcie_phy_readl(void __iomem *base, u32 offset)
>> +{
>> +    return readl(base + offset);
>> +}
>> +
>> +/* For Exynos5440 specific functions */
>> +static int exynos5440_pcie_phy_init(struct phy *phy)
>> +{
>> +    struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
>> +
>> +    /* DCC feedback control off */
>> +    exynos_pcie_phy_writel(ep->phy_base, 0x29, PCIE_PHY_DCC_FEEDBACK);
>> +
>> +    /* set TX/RX impedance */
>> +    exynos_pcie_phy_writel(ep->phy_base, 0xd5, PCIE_PHY_IMPEDANCE);
>> +
>> +    /* set 50Mhz PHY clock */
>> +    exynos_pcie_phy_writel(ep->phy_base, 0x14, PCIE_PHY_PLL_DIV_0);
>> +    exynos_pcie_phy_writel(ep->phy_base, 0x12, PCIE_PHY_PLL_DIV_1);
>> +
>> +    /* set TX Differential output for lane 0 */
>> +    exynos_pcie_phy_writel(ep->phy_base, 0x7f, PCIE_PHY_TRSV0_DRV_LVL);
>> +
>> +    /* set TX Pre-emphasis Level Control for lane 0 to minimum */
>> +    exynos_pcie_phy_writel(ep->phy_base, 0x0, PCIE_PHY_TRSV0_EMP_LVL);
>> +
>> +    /* set RX clock and data recovery bandwidth */
>> +    exynos_pcie_phy_writel(ep->phy_base, 0xe7, PCIE_PHY_PLL_BIAS);
>> +    exynos_pcie_phy_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV0_RXCDR);
>> +    exynos_pcie_phy_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV1_RXCDR);
>> +    exynos_pcie_phy_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV2_RXCDR);
>> +    exynos_pcie_phy_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV3_RXCDR);
>> +
>> +    /* change TX Pre-emphasis Level Control for lanes */
>> +    exynos_pcie_phy_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV0_EMP_LVL);
>> +    exynos_pcie_phy_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV1_EMP_LVL);
>> +    exynos_pcie_phy_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV2_EMP_LVL);
>> +    exynos_pcie_phy_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV3_EMP_LVL);
>> +
>> +    /* set LVCC */
>> +    exynos_pcie_phy_writel(ep->phy_base, 0x20, PCIE_PHY_TRSV0_LVCC);
>> +    exynos_pcie_phy_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV1_LVCC);
>> +    exynos_pcie_phy_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV2_LVCC);
>> +    exynos_pcie_phy_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV3_LVCC);
>> +
>> +    /* pulse for common reset */
>> +    exynos_pcie_phy_writel(ep->blk_base, 1, PCIE_PHY_COMMON_RESET);
>> +    udelay(500);
>> +    exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_COMMON_RESET);
>> +
>> +    return 0;
>> +}
>> +
>> +static int exynos5440_pcie_phy_power_on(struct phy *phy)
>> +{
>> +    struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
>> +    u32 val;
>> +
>> +    exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_COMMON_RESET);
>> +    exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_CMN_REG);
>> +    exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_TRSVREG_RESET);
>> +    exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_TRSV_RESET);
>> +
>> +    val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_COMMON_POWER);
>> +    val &= ~PCIE_PHY_COMMON_PD_CMN;
>> +    exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_COMMON_POWER);
>> +
>> +    val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV0_POWER);
>> +    val &= ~PCIE_PHY_TRSV0_PD_TSV;
>> +    exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV0_POWER);
>> +
>> +    val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV1_POWER);
>> +    val &= ~PCIE_PHY_TRSV1_PD_TSV;
>> +    exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV1_POWER);
>> +
>> +    val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV2_POWER);
>> +    val &= ~PCIE_PHY_TRSV2_PD_TSV;
>> +    exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV2_POWER);
>> +
>> +    val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV3_POWER);
>> +    val &= ~PCIE_PHY_TRSV3_PD_TSV;
>> +    exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV3_POWER);
>> +
>> +    return 0;
>> +}
>> +
>> +static int exynos5440_pcie_phy_power_off(struct phy *phy)
>> +{
>> +    struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
>> +    u32 val;
>> +
>> +    if (readl_poll_timeout(ep->phy_base + PCIE_PHY_PLL_LOCKED, val,
>> +                (val != 0), 1, 500)) {
>> +        dev_err(&phy->dev, "PLL Locked: 0x%x\n", val);
>> +        return -ETIMEDOUT;
>> +    }
>> +
>> +    val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_COMMON_POWER);
>> +    val |= PCIE_PHY_COMMON_PD_CMN;
>> +    exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_COMMON_POWER);
>> +
>> +    val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV0_POWER);
>> +    val |= PCIE_PHY_TRSV0_PD_TSV;
>> +    exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV0_POWER);
>> +
>> +    val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV1_POWER);
>> +    val |= PCIE_PHY_TRSV1_PD_TSV;
>> +    exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV1_POWER);
>> +
>> +    val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV2_POWER);
>> +    val |= PCIE_PHY_TRSV2_PD_TSV;
>> +    exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV2_POWER);
>> +
>> +    val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV3_POWER);
>> +    val |= PCIE_PHY_TRSV3_PD_TSV;
>> +    exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV3_POWER);
>> +
>> +    return 0;
>> +}
>> +
>> +static int exynos5440_pcie_phy_reset(struct phy *phy)
>> +{
>> +    struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
>> +
>> +    exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_MAC_RESET);
>> +    exynos_pcie_phy_writel(ep->blk_base, 1, PCIE_PHY_GLOBAL_RESET);
>> +    exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_GLOBAL_RESET);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct phy_ops exynos5440_phy_ops = {
>> +    .init        = exynos5440_pcie_phy_init,
>> +    .power_on    = exynos5440_pcie_phy_power_on,
>> +    .power_off    = exynos5440_pcie_phy_power_off,
>> +    .reset        = exynos5440_pcie_phy_reset,
>> +    .owner        = THIS_MODULE,
>> +};
>> +
>> +static const struct exynos_pcie_phy_data exynos5440_pcie_phy_data = {
>> +    .ops        = &exynos5440_phy_ops,
>> +};
>> +
>> +static const struct of_device_id exynos_pcie_phy_match[] = {
>> +    {
>> +        .compatible = "samsung,exynos5440-pcie-phy",
>> +        .data = &exynos5440_pcie_phy_data,
>> +    },
>> +    {},
>> +};
>> +MODULE_DEVICE_TABLE(of, exynos_pcie_phy_match);
>> +
>> +static int exynos_pcie_phy_probe(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    struct exynos_pcie_phy *exynos_phy;
>> +    struct phy *generic_phy;
>> +    struct phy_provider *phy_provider;
>> +    struct resource *res;
>> +    const struct exynos_pcie_phy_data *drv_data;
>> +
>> +    drv_data = of_device_get_match_data(dev);
>> +    if (!drv_data)
>> +        return -ENODEV;
>> +
>> +    exynos_phy = devm_kzalloc(dev, sizeof(*exynos_phy), GFP_KERNEL);
>> +    if (!exynos_phy)
>> +        return -ENOMEM;
>> +
>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    exynos_phy->phy_base = devm_ioremap_resource(dev, res);
>> +    if (IS_ERR(exynos_phy->phy_base))
>> +        return PTR_ERR(exynos_phy->phy_base);
>> +
>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +    exynos_phy->blk_base = devm_ioremap_resource(dev, res);
>> +    if (IS_ERR(exynos_phy->phy_base))
>> +        return PTR_ERR(exynos_phy->phy_base);
>> +
>> +    exynos_phy->drv_data = drv_data;
>> +
>> +    generic_phy = devm_phy_create(dev, dev->of_node, drv_data->ops);
>> +    if (IS_ERR(generic_phy)) {
>> +        dev_err(dev, "failed to create PHY\n");
>> +        return PTR_ERR(generic_phy);
>> +    }
>> +
>> +    phy_set_drvdata(generic_phy, exynos_phy);
>> +    phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +
>> +    return PTR_ERR_OR_ZERO(phy_provider);
>> +}
>> +
>> +static struct platform_driver exynos_pcie_phy_driver = {
>> +    .probe    = exynos_pcie_phy_probe,
>> +    .driver = {
>> +        .of_match_table    = exynos_pcie_phy_match,
>> +        .name        = "exynos_pcie_phy",
>> +    }
>> +};
>> +module_platform_driver(exynos_pcie_phy_driver);
>> +
>> +MODULE_DESCRIPTION("Samsung S5P/EXYNOS SoC PCIe PHY driver");
>> +MODULE_AUTHOR("Jaehoon Chung<jh80.chung@samsung.com>");
>> +MODULE_LICENSE("GPL v2");
> 
> rest looks good to me.
> Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> 
