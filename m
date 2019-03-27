Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB5BC43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 12:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A432087C
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 12:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gHCvm+Du"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfC0M07 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:26:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1670 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfC0M07 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 08:26:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b6c150000>; Wed, 27 Mar 2019 05:27:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 27 Mar 2019 05:26:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 27 Mar 2019 05:26:58 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 12:26:51 +0000
Subject: Re: [PATCH 10/10] arm64: Add Tegra194 PCIe driver to defconfig
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
 <1553613207-3988-11-git-send-email-vidyas@nvidia.com>
 <a0491042-2f24-4ba8-754b-ba3959b77d6f@nvidia.com>
 <44d7ff1d-c317-6ba2-86c0-981a6356ee9e@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c5ca34fe-4290-d9b7-cda3-23b4a11ec5d8@nvidia.com>
Date:   Wed, 27 Mar 2019 12:26:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <44d7ff1d-c317-6ba2-86c0-981a6356ee9e@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553689621; bh=5qtjykd+Yy2wGhSpgzMIji4/i7wjv6QL+hQjLrgf6K0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gHCvm+Du6RzTKZnrekGcsOZP7e5IJt5sRvYFTLqdtliVM7hYzCEDfZqEZs0PtSUkw
         9kExzTe5b5XFXY+6mbH5RdDB/VQDY2XhWzJjHXZBvVnkhmp0HVfrXj2PDHhEHn5Eek
         YveunIKKF1RdHkMzBl0poWPsEL03Y2dcQfNIuK8Ve5QcWii+A4jk88zrJqvO6dULvi
         rCK6wvy9/SQKQ144wmWLNS2VADcRYaOt9isCbNLcWE1a+bVMgP6WI7avYekgUnDL2x
         Ois3vUu+HzYNfL2o8gC9mODFqRsFd5i6ln4zh/nzkJQOQ+ZRFhzM+WBaN7EqrRp7kG
         2LNrEvx5UBwog==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 27/03/2019 10:12, Vidya Sagar wrote:
> On 3/27/2019 3:38 PM, Jon Hunter wrote:
>>
>> On 26/03/2019 15:13, Vidya Sagar wrote:
>>> Add PCIe host controller driver for DesignWare core based
>>> PCIe controller IP present in Tegra194.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>> =C2=A0 arch/arm64/configs/defconfig | 1 +
>>> =C2=A0 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
>>> index 2d9c39033c1a..2ddea5c4e87d 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -87,6 +87,7 @@ CONFIG_PCIE_QCOM=3Dy
>>> =C2=A0 CONFIG_PCIE_ARMADA_8K=3Dy
>>> =C2=A0 CONFIG_PCIE_KIRIN=3Dy
>>> =C2=A0 CONFIG_PCIE_HISI_STB=3Dy
>>> +CONFIG_PCIE_TEGRA194=3Dy
>>> =C2=A0 CONFIG_ARM64_VA_BITS_48=3Dy
>>> =C2=A0 CONFIG_SCHED_MC=3Dy
>>> =C2=A0 CONFIG_NUMA=3Dy
>>
>> Maybe building as a module is more appropriate here as I am not sure
>> that anyone else will want this built-in and it is not critical to
>> booting AFAIK.
> Since the DesignWare core framework doesn't yet have support for making
> this
> as a module, I added it as a built-in driver. I'll switch it to a module
> once support is available.

Ah I see. We often get reports/patches if a driver has a removal
function but is defined in the Kconfig to only support being built-in.

Does the designware core just need to export some symbols to support it
being a module? If so it maybe worth adding these as part of the series
to see if it is acceptable, otherwise it might not get done and there is
no point us supporting it as a module.

Cheers
Jon

--=20
nvpublic
