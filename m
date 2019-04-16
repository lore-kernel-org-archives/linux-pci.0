Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988CEC10F14
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 18:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637FF2087C
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 18:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fdB8wyBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfDPSO3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:14:29 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8408 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfDPSO3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 14:14:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb61b880000>; Tue, 16 Apr 2019 11:14:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 11:14:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 11:14:26 -0700
Received: from [10.25.74.19] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 18:14:21 +0000
Subject: Re: [PATCH V2 14/16] phy: tegra: Add PCIe PIPE2UPHY support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>, <kishon@ti.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <lorenzo.pieralisi@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
 <1554407683-31580-15-git-send-email-vidyas@nvidia.com>
 <20190415153148.GJ29254@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <f8f0ffb4-0d13-cd2a-f993-3b83adeb1375@nvidia.com>
Date:   Tue, 16 Apr 2019 23:44:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415153148.GJ29254@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555438472; bh=T0KtWK2IN/MHQsuf82UODRZ/m/zm/j6jb/LIWaHc6u8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fdB8wyBZrqDhyVjiuHq0SbEZPjqoOqLqMPw7MkzrcInsyZLAWr0oBh2oAQPp8Dn2u
         R50f/C/iF8wf+mMm3m8BLb0pequDk4w9EzUzLZJrB2NoevQskGRXruPoWmlPH8Fm7d
         BlOaMq1NgQGczkXNU6qXO9KmY+3XJzYUnF3x3NHSmiTgTD4YguNqyiOIyGdf69Fqfv
         Z1crToJ8OPrRhSt/5hGVGtSWrohVVm/GxRhGiP6IlrqmOt06709CXWGSiD15T6+qsX
         UkKe7ssObjyy316HZz4b0XF5JpNVlGeSMBEVpmjDvKNw9B0Yo34yT4uD1L039jJBOF
         A8Xl0YtNYlhbw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/15/2019 9:01 PM, Thierry Reding wrote:
> On Fri, Apr 05, 2019 at 01:24:41AM +0530, Vidya Sagar wrote:
>> Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interface
>> with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
>> For each PCIe lane of a controller, there is a P2U unit instantiated at
>> hardware level. This driver provides support for the programming required
>> for each P2U that is going to be used for a PCIe controller.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v1]:
>> * Added COMPILE_TEST in Kconfig
>> * Removed empty phy_ops implementations
>> * Modified code according to DT documentation file modifications
>>
>>   drivers/phy/tegra/Kconfig             |   7 ++
>>   drivers/phy/tegra/Makefile            |   1 +
>>   drivers/phy/tegra/pcie-p2u-tegra194.c | 120 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 128 insertions(+)
>>   create mode 100644 drivers/phy/tegra/pcie-p2u-tegra194.c
>>
>> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
>> index a3b1de953fb7..eb93ee72ecf0 100644
>> --- a/drivers/phy/tegra/Kconfig
>> +++ b/drivers/phy/tegra/Kconfig
>> @@ -6,3 +6,10 @@ config PHY_TEGRA_XUSB
>>   
>>   	  To compile this driver as a module, choose M here: the module will
>>   	  be called phy-tegra-xusb.
>> +
>> +config PHY_TEGRA194_PCIE_P2U
>> +        tristate "NVIDIA Tegra P2U PHY Driver"
>> +        depends on ARCH_TEGRA || COMPILE_TEST
>> +        select GENERIC_PHY
>> +        help
>> +          Enable this to support the P2U (PIPE to UPHY) that is part of Tegra 19x SOCs.
> 
> This should be using tabs for indentation.
Done.

> 
>> diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
>> index 898589238fd9..f85b2c86643d 100644
>> --- a/drivers/phy/tegra/Makefile
>> +++ b/drivers/phy/tegra/Makefile
>> @@ -4,3 +4,4 @@ phy-tegra-xusb-y += xusb.o
>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) += xusb-tegra124.o
>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) += xusb-tegra124.o
>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) += xusb-tegra210.o
>> +obj-$(CONFIG_PHY_TEGRA194_PCIE_P2U) += pcie-p2u-tegra194.o
>> diff --git a/drivers/phy/tegra/pcie-p2u-tegra194.c b/drivers/phy/tegra/pcie-p2u-tegra194.c
>> new file mode 100644
>> index 000000000000..d4df8bfa9979
>> --- /dev/null
>> +++ b/drivers/phy/tegra/pcie-p2u-tegra194.c
>> @@ -0,0 +1,120 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * P2U (PIPE to UPHY) driver for Tegra T194 SoC
>> + *
>> + * Copyright (C) 2019 NVIDIA Corporation.
>> + *
>> + * Author: Vidya Sagar <vidyas@nvidia.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/of.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
>> +#include <linux/of_platform.h>
>> +#include <soc/tegra/bpmp-abi.h>
> 
> It's a good idea to keep these sorted alphabetically. That makes it a
> lot easier to insert new ones in the right place subsequently.
Done.

> 
>> +
>> +#define P2U_PERIODIC_EQ_CTRL_GEN3	0xc0
>> +#define P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN		BIT(0)
>> +#define P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
>> +#define P2U_PERIODIC_EQ_CTRL_GEN4	0xc4
>> +#define P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
>> +
>> +#define P2U_RX_DEBOUNCE_TIME				0xa4
>> +#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK	0xFFFF
> 
> Use consistent case for hexadecimal. All other register definitions use
> lower-case, so this one should, too.
> 
>> +#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL		160
>> +
>> +struct tegra_p2u {
>> +	void __iomem		*base;
> 
> I personally wouldn't bother with the extra padding. A single space is
> enough and avoid extra churn if you ever add something here that doesn't
> fit into the existing padding space.
Done.

> 
>> +};
>> +
>> +static int tegra_p2u_power_on(struct phy *x)
>> +{
>> +	u32 val;
>> +	struct tegra_p2u *phy = phy_get_drvdata(x);
> 
> It's often common to structure these as "reverse christmas tree" so that
> the longest lines go first, followed by shorter lines. Not sure if
> Kishon cares, though.
Done. Took care of this in pcie-tegra194.c as well.

> 
>> +
>> +	val = readl(phy->base + P2U_PERIODIC_EQ_CTRL_GEN3);
>> +	val &= ~P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN;
>> +	val |= P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN;
>> +	writel(val, phy->base + P2U_PERIODIC_EQ_CTRL_GEN3);
>> +
>> +	val = readl(phy->base + P2U_PERIODIC_EQ_CTRL_GEN4);
>> +	val |= P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN;
>> +	writel(val, phy->base + P2U_PERIODIC_EQ_CTRL_GEN4);
>> +
>> +	val = readl(phy->base + P2U_RX_DEBOUNCE_TIME);
>> +	val &= ~P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK;
>> +	val |= P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL;
>> +	writel(val, phy->base + P2U_RX_DEBOUNCE_TIME);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct phy_ops ops = {
>> +	.power_on	= tegra_p2u_power_on,
>> +	.owner		= THIS_MODULE,
>> +};
>> +
>> +static int tegra_p2u_probe(struct platform_device *pdev)
>> +{
>> +	struct tegra_p2u *phy;
>> +	struct phy *generic_phy;
>> +	struct phy_provider *phy_provider;
>> +	struct device *dev = &pdev->dev;
>> +	struct resource *res;
>> +
>> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
>> +	if (!phy)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctl");
>> +	phy->base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(phy->base))
>> +		return PTR_ERR_OR_ZERO(phy->base);
>> +
>> +	platform_set_drvdata(pdev, phy);
>> +
>> +	generic_phy = devm_phy_create(dev, NULL, &ops);
>> +	if (IS_ERR(generic_phy))
>> +		return PTR_ERR_OR_ZERO(generic_phy);
>> +
>> +	phy_set_drvdata(generic_phy, phy);
>> +
>> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +	if (IS_ERR(phy_provider))
>> +		return PTR_ERR_OR_ZERO(phy_provider);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_p2u_remove(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
> 
> I think you can drop this.
I want to make this as a loadable module hence i kep t .remove()
implementation.
  
> 
>> +
>> +static const struct of_device_id tegra_p2u_id_table[] = {
>> +	{
>> +		.compatible = "nvidia,tegra194-p2u",
>> +	},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, tegra_p2u_id_table);
>> +
>> +static struct platform_driver tegra_p2u_driver = {
>> +	.probe		= tegra_p2u_probe,
>> +	.remove		= tegra_p2u_remove,
>> +	.driver		= {
>> +		.name	= "tegra194-p2u",
>> +		.of_match_table = tegra_p2u_id_table,
>> +	},
>> +};
>> +
>> +module_platform_driver(tegra_p2u_driver);
>> +
>> +MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
>> +MODULE_DESCRIPTION("NVIDIA Tegra PIPE_To_UPHY phy driver");
> 
> The driver description is somewhat odd here. Perhaps something like:
> 
> 	"NVIDIA Tegra PIPE to UPHY PHY driver"
> 
> ?
Done.

> 
> Thierry
> 
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.7.4
>>

