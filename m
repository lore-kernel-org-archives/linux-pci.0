Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403F9C4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 10:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F6420700
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 10:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Roc9/Cu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfDCKpm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:45:42 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15033 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDCKpm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 06:45:42 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca48ec90000>; Wed, 03 Apr 2019 03:45:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 03 Apr 2019 03:45:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 03 Apr 2019 03:45:39 -0700
Received: from [10.24.47.153] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Apr
 2019 10:45:28 +0000
Subject: Re: [PATCH 08/10] phy: tegra: Add PCIe PIPE2UPHY support
To:     Kishon Vijay Abraham I <kishon@ti.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <lorenzo.pieralisi@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <tiwai@suse.de>, <spujar@nvidia.com>, <skomatineni@nvidia.com>,
        <liviu.dudau@arm.com>, <krzk@kernel.org>, <heiko@sntech.de>,
        <horms+renesas@verge.net.au>, <olof@lixom.net>,
        <maxime.ripard@bootlin.com>, <andy.gross@linaro.org>,
        <bjorn.andersson@linaro.org>, <jagan@amarulasolutions.com>,
        <enric.balletbo@collabora.com>, <ezequiel@collabora.com>,
        <stefan.wahren@i2se.com>, <marc.w.gonzalez@free.fr>,
        <l.stach@pengutronix.de>, <tpiepho@impinj.com>,
        <hayashi.kunihiko@socionext.com>, <yue.wang@amlogic.com>,
        <shawn.lin@rock-chips.com>, <xiaowei.bao@nxp.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-9-git-send-email-vidyas@nvidia.com>
 <ee9bba31-c9ac-9275-6f55-f71fea1a33a0@ti.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <e60c1bb8-2b30-50b0-4864-6e0db8797b2c@nvidia.com>
Date:   Wed, 3 Apr 2019 16:15:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ee9bba31-c9ac-9275-6f55-f71fea1a33a0@ti.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554288329; bh=2rDD13vcqNe6H9rexd9hQKL8XXUaWlZ3ghK7y4rKxPU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Roc9/Cu8Agy3eWRRqUwqcNvWxRsjjloYcAW0YP4asu4FTYOWqwSUGXEM0v041yU+R
         0wh8Ovweo3xRBZme8wSrAohcgbRmtDjUX0iB5bIOJIPiZfyqPfwE0R+p6DSyA2skWz
         Sn00xxfnuhJtd7mskmSFrKqU7L0rM0litxumvL9i7u0j/zSVbkxJhfbokLB0HeIVbc
         EXYoIH4V3tW8dQZyLLE5pbxENfS+PMDsmlt/s2uYir4u4nLHonHiupIQUmt1uPbAZd
         Rn+XPvndEm7/piK15Ng29ePx6j8dya9Xoqp+9D/uHZPrePNjpCRKpItVFYpKdqjXvS
         2Ar2SgaVv9UmQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/3/2019 1:35 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 26/03/19 8:43 PM, Vidya Sagar wrote:
>> Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interface
>> with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
>> For each PCIe lane of a controller, there is a P2U unit instantiated at
>> hardware level. This driver provides support for the programming required
>> for each P2U that is going to be used for a PCIe controller.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/phy/tegra/Kconfig             |   7 ++
>>   drivers/phy/tegra/Makefile            |   1 +
>>   drivers/phy/tegra/pcie-p2u-tegra194.c | 138 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 146 insertions(+)
>>   create mode 100644 drivers/phy/tegra/pcie-p2u-tegra194.c
>>
>> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
>> index a3b1de953fb7..1460c060fa70 100644
>> --- a/drivers/phy/tegra/Kconfig
>> +++ b/drivers/phy/tegra/Kconfig
>> @@ -6,3 +6,10 @@ config PHY_TEGRA_XUSB
>>   
>>   	  To compile this driver as a module, choose M here: the module will
>>   	  be called phy-tegra-xusb.
>> +
>> +config PHY_TEGRA194_PCIE_P2U
>> +        tristate "NVIDIA Tegra P2U PHY Driver"
>> +        depends on ARCH_TEGRA
> 
> COMPILE_TEST
Done.

>> +        select GENERIC_PHY
>> +        help
>> +          Enable this to support the P2U (PIPE to UPHY) that is part of Tegra 19x SOCs.
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
>> index 000000000000..bb2412ec4765
>> --- /dev/null
>> +++ b/drivers/phy/tegra/pcie-p2u-tegra194.c
>> @@ -0,0 +1,138 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * P2U (PIPE to UPHY) driver for Tegra T194 SoC
>> + *
>> + * Copyright (C) 2018 NVIDIA Corporation.
> 
> 2019
Done.

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
>> +
>> +#define P2U_PERIODIC_EQ_CTRL_GEN3	0xc0
>> +#define P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN		BIT(0)
>> +#define P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
>> +#define P2U_PERIODIC_EQ_CTRL_GEN4	0xc4
>> +#define P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
>> +
>> +#define P2U_RX_DEBOUNCE_TIME				0xa4
>> +#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK	0xFFFF
>> +#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL		160
>> +
>> +struct tegra_p2u {
>> +	void __iomem		*base;
>> +};
>> +
>> +static int tegra_p2u_power_off(struct phy *x)
>> +{
>> +	return 0;
> 
> Empty phy_ops are not required.
Done.

>> +}
>> +
>> +static int tegra_p2u_power_on(struct phy *x)
>> +{
>> +	u32 val;
>> +	struct tegra_p2u *phy = phy_get_drvdata(x);
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
> 
> This looks more like a init configuration rather than power on.
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_p2u_init(struct phy *x)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int tegra_p2u_exit(struct phy *x)
>> +{
>> +	return 0;
>> +}
> 
> Empty functions are not required.
Done.

>> +
>> +static const struct phy_ops ops = {
>> +	.init		= tegra_p2u_init,
>> +	.exit		= tegra_p2u_exit,
>> +	.power_on	= tegra_p2u_power_on,
>> +	.power_off	= tegra_p2u_power_off,
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
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "base");
>> +	phy->base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(phy->base))
>> +		return PTR_ERR(phy->base);
>> +
>> +	platform_set_drvdata(pdev, phy);
>> +
>> +	generic_phy = devm_phy_create(dev, NULL, &ops);
>> +	if (IS_ERR(generic_phy))
>> +		return PTR_ERR(generic_phy);
>> +
>> +	phy_set_drvdata(generic_phy, phy);
>> +
>> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +	if (IS_ERR(phy_provider))
>> +		return PTR_ERR(phy_provider);
>> +
> 
> return PTR_ERR_OR_ZERO(phy_provider);
Done.

>> +	return 0;
>> +}
>> +
>> +static int tegra_p2u_remove(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
> 
> not required.
I think this is still required as this driver can be made as a module right?

> 
> Thanks
> Kishon
> 

