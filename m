Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342FBC43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 10:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014742146E
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 10:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PV+r7LD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbfC0KIL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:08:11 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11856 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731668AbfC0KIL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 06:08:11 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b4b8d0000>; Wed, 27 Mar 2019 03:08:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 27 Mar 2019 03:08:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 27 Mar 2019 03:08:10 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 10:08:02 +0000
Subject: Re: [PATCH 09/10] PCI: tegra: Add Tegra194 PCIe support
To:     Vidya Sagar <vidyas@nvidia.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <kishon@ti.com>,
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
 <1553613207-3988-10-git-send-email-vidyas@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <96674380-a171-9c68-2030-564f15b88474@nvidia.com>
Date:   Wed, 27 Mar 2019 10:07:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553613207-3988-10-git-send-email-vidyas@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553681293; bh=yVfPNrpHUuRP5h5BgHdsbFsV5TxeYP9iJmoMAxHKrJk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PV+r7LD1KZxBnS4SBMrNrWCNR/3KVp2pM0UxyMCdNMuY7H//CeNSfE2XJ0H26/CNa
         Btk0EyxU1IZaSINhzSKtouoafZn7SybTYIQvTNL/fxC9b0igZ8JBmvxuYiRPN4rTpL
         bdK8yGAJa4ARyToUWa3/l5E7a1Hfe9GJDIlz4NAqsHWAFglE9zG4pnYlVzaw7BHzSH
         AINf/gnOIvWZifgz3FA2XOIYsl6YtKntlUy9EJmbwc9EPR1xouH36BxhI81n9Tl/OZ
         H3HF4lATK2rWoSAeaMPmj+cc9q4Z8dCLpSqi8VJGTv8GQ7SgyDGGEKN5cCuBWSpDX2
         DnnmAMnJazTnQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 26/03/2019 15:13, Vidya Sagar wrote:
> Add support for Synopsys DesignWare core IP based PCIe host controller
> present in Tegra194 SoC.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/Kconfig         |   10 +
>  drivers/pci/controller/dwc/Makefile        |    1 +
>  drivers/pci/controller/dwc/pcie-tegra194.c | 1862 ++++++++++++++++++++++++++++
>  3 files changed, 1873 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-tegra194.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 6ea74b1c0d94..d80f2d77892a 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -213,4 +213,14 @@ config PCIE_UNIPHIER
>  	  Say Y here if you want PCIe controller support on UniPhier SoCs.
>  	  This driver supports LD20 and PXs3 SoCs.
>  
> +config PCIE_TEGRA194
> +	bool "NVIDIA Tegra (T194) PCIe controller"
> +	depends on TEGRA_BPMP && (ARCH_TEGRA || COMPILE_TEST)
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	select PHY_TEGRA194_PCIE_P2U
> +	help
> +	  Say Y here if you want support for DesignWare core based PCIe host
> +	  controller found in NVIDIA Tegra T194 SoC.
> +

Don't we want tristate here? You have a removal function.

Cheers
Jon

-- 
nvpublic
