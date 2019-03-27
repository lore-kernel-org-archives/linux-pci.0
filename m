Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB44CC43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 10:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785DB20700
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 10:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QZnKuQ42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfC0KM5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:12:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3627 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfC0KM5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 06:12:57 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b4ca30002>; Wed, 27 Mar 2019 03:12:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 27 Mar 2019 03:12:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 27 Mar 2019 03:12:56 -0700
Received: from [10.24.47.154] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 10:12:44 +0000
Subject: Re: [PATCH 10/10] arm64: Add Tegra194 PCIe driver to defconfig
To:     Jon Hunter <jonathanh@nvidia.com>, <bhelgaas@google.com>,
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
 <1553613207-3988-11-git-send-email-vidyas@nvidia.com>
 <a0491042-2f24-4ba8-754b-ba3959b77d6f@nvidia.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <44d7ff1d-c317-6ba2-86c0-981a6356ee9e@nvidia.com>
Date:   Wed, 27 Mar 2019 15:42:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a0491042-2f24-4ba8-754b-ba3959b77d6f@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553681571; bh=q0w7xv5B3iVJwel4fEU0DFth5diQoA+o7LlUSyXGUm0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QZnKuQ42UtuDY/QhJ1LHkU0uCevVUcMXXMWsy6cdDuYdSfjKw0X58fZLfAs1/VsSC
         MPwW+mnexCjeUonrkyGoZuRBViojlu9DEzM4eA6XeKxdmaWVbaQDifUojeSxd8zzdU
         WtfL9ld1+/SNP5dSYAkgKLjbAbc1fCtyQI/bUcxI8JLfAzscCfNb9cT40jGNdyBnTS
         2bid1mkwh7mpSYNbw+K5PGKOyvz1pPki45TlIxGOW1eZg21JeZPffsvPidcc1M6PW2
         DufOU/rIRuAdYHSWGD/gGJJ30Xs5iiOcvAc6XmNeQRy8eiNCX760NzCV4aFaII8+bd
         PvOFXMgcjxT9A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/27/2019 3:38 PM, Jon Hunter wrote:
> 
> On 26/03/2019 15:13, Vidya Sagar wrote:
>> Add PCIe host controller driver for DesignWare core based
>> PCIe controller IP present in Tegra194.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 2d9c39033c1a..2ddea5c4e87d 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -87,6 +87,7 @@ CONFIG_PCIE_QCOM=y
>>   CONFIG_PCIE_ARMADA_8K=y
>>   CONFIG_PCIE_KIRIN=y
>>   CONFIG_PCIE_HISI_STB=y
>> +CONFIG_PCIE_TEGRA194=y
>>   CONFIG_ARM64_VA_BITS_48=y
>>   CONFIG_SCHED_MC=y
>>   CONFIG_NUMA=y
> 
> Maybe building as a module is more appropriate here as I am not sure
> that anyone else will want this built-in and it is not critical to
> booting AFAIK.
Since the DesignWare core framework doesn't yet have support for making this
as a module, I added it as a built-in driver. I'll switch it to a module
once support is available.

> 
> Cheers
> Jon
> 

