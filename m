Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB4C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A23320843
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kx8cfptX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfDWJ1x (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:27:53 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7473 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfDWJ1x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 05:27:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbeda940000>; Tue, 23 Apr 2019 02:27:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 02:27:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 02:27:51 -0700
Received: from [10.24.192.64] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:27:48 +0000
Subject: Re: [PATCH 13/30] PCI: tegra: Update flow control threshold in
 Tegra210
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-14-mmaddireddy@nvidia.com> <20190415114703.GO29254@ulmo>
 <e55e7850-a960-4b36-7b62-f7ed85d3b17f@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <cb1c70a9-39e7-b8f1-d47b-b0e374a016f4@nvidia.com>
Date:   Tue, 23 Apr 2019 14:57:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e55e7850-a960-4b36-7b62-f7ed85d3b17f@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556011668; bh=9tC/9KSgujvVxVseH+8miLnZWMjp6DlE28eeTkBx27Q=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=kx8cfptXMtKQmOG4LcR3XcwMCm8T55dlbjLhnOubMV2QSJcd7mcz9sKwU4F1D76I+
         S1WW3bdV/45Hb2AcQg5VYcVq95mxOIKP4LH1c5OeiYjMaOSUnNY+w9lP4JJqEQ9Vxq
         MAkr+gH2inX+8kzkE5jnADex+ALNU1dhKEAqhsYACzphIRVA2ZJBwLxBfMfe5oru5D
         IVkQPECIcxmDz7k17IQRVdVOvubiX3J/1clcNNl1OMGTQAvYK603Ck78vdLA8/w/K8
         +UTwkstZ7BaC8HDmwHY+K4P2WgfRQvI7ZKVsZSMhJKXZjUc/slRSippk8HD/LiHdNl
         UUaFBoG6eLuxw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 8:35 PM, Manikanta Maddireddy wrote:
>
> On 15-Apr-19 5:17 PM, Thierry Reding wrote:
>> On Thu, Apr 11, 2019 at 10:33:38PM +0530, Manikanta Maddireddy wrote:
>>> Recommended update FC threshold in Tegra210 is 0x60 for best performance
>>> of x1 link. Setting this to 0x60 provides the best balance between number
>>> of UpdateFC and read data sent over the link.
>>>
>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>> ---
>>>  drivers/pci/controller/pci-tegra.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>> Looks to me like part of this patch ended up in 12/30?
>>
>> Thierry
> Ok, I will squash 12/30 & 13/30 and clearly mentioned what it means for T124 and T210
> in commit message.

12/30 and 13/30 are fixing two independent issues, so I couldn't merge these
two patches. However I am providing more details in commit log in V2, please
take a look at V2 and let me know if you have different opinion.

Manikanta

>>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>>> index b74408eeb367..7dc728cc5f51 100644
>>> --- a/drivers/pci/controller/pci-tegra.c
>>> +++ b/drivers/pci/controller/pci-tegra.c
>>> @@ -319,6 +319,7 @@ struct tegra_pcie_soc {
>>>  	bool update_clamp_threshold;
>>>  	bool program_deskew_time;
>>>  	bool raw_violation_fixup;
>>> +	bool update_fc_threshold;
>>>  	struct {
>>>  		struct {
>>>  			u32 rp_ectl_2_r1;
>>> @@ -662,6 +663,13 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
>>>  		value |= soc->update_fc_val;
>>>  		writel(value, port->base + RP_VEND_XP);
>>>  	}
>>> +
>>> +	if (soc->update_fc_threshold) {
>>> +		value = readl(port->base + RP_VEND_XP);
>>> +		value &= ~RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK;
>>> +		value |= soc->update_fc_val;
>>> +		writel(value, port->base + RP_VEND_XP);
>>> +	}
>>>  }
>>>  
>>>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>>> @@ -2409,6 +2417,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>>>  	.update_clamp_threshold = false,
>>>  	.program_deskew_time = false,
>>>  	.raw_violation_fixup = false,
>>> +	.update_fc_threshold = false,
>>>  	.ectl.enable = false,
>>>  };
>>>  
>>> @@ -2436,6 +2445,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>>>  	.update_clamp_threshold = false,
>>>  	.program_deskew_time = false,
>>>  	.raw_violation_fixup = false,
>>> +	.update_fc_threshold = false,
>>>  	.ectl.enable = false,
>>>  };
>>>  
>>> @@ -2458,6 +2468,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>>>  	.update_clamp_threshold = true,
>>>  	.program_deskew_time = false,
>>>  	.raw_violation_fixup = true,
>>> +	.update_fc_threshold = false,
>>>  	.ectl.enable = false,
>>>  };
>>>  
>>> @@ -2468,6 +2479,8 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>>>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
>>>  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
>>>  	.pads_refclk_cfg0 = 0x90b890b8,
>>> +	/* FC threshold is bit[25:18] */
>>> +	.update_fc_val = 0x01800000,
>>>  	.has_pex_clkreq_en = true,
>>>  	.has_pex_bias_ctrl = true,
>>>  	.has_intr_prsnt_sense = true,
>>> @@ -2478,6 +2491,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>>>  	.update_clamp_threshold = true,
>>>  	.program_deskew_time = true,
>>>  	.raw_violation_fixup = false,
>>> +	.update_fc_threshold = true,
>>>  	.ectl.regs.rp_ectl_2_r1 = 0x0000000f,
>>>  	.ectl.regs.rp_ectl_4_r1 = 0x00000067,
>>>  	.ectl.regs.rp_ectl_5_r1 = 0x55010000,
>>> @@ -2513,6 +2527,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
>>>  	.update_clamp_threshold = false,
>>>  	.program_deskew_time = false,
>>>  	.raw_violation_fixup = false,
>>> +	.update_fc_threshold = false,
>>>  	.ectl.enable = false,
>>>  };
>>>  
>>> -- 
>>> 2.17.1
>>>

