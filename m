Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB4BC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D64B217D6
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SYfytYWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfDOPFt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:05:49 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13530 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDOPFt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:05:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb49dd00000>; Mon, 15 Apr 2019 08:05:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 08:05:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 08:05:47 -0700
Received: from [10.24.70.150] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 15:05:40 +0000
Subject: Re: [PATCH 13/30] PCI: tegra: Update flow control threshold in
 Tegra210
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-14-mmaddireddy@nvidia.com> <20190415114703.GO29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <e55e7850-a960-4b36-7b62-f7ed85d3b17f@nvidia.com>
Date:   Mon, 15 Apr 2019 20:35:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415114703.GO29254@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555340752; bh=p1mdhW9TqyZAO4VTQQeGMufwohJ6QhiUp9m6uhvwV+A=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=SYfytYWkfuY2ITiqo/lC7kBE86U6VmSDIbF0fmiUR5LRHyunL8y8L3kH5e3vXkltI
         NGg8MRH7wrFNWz460qCz//Br723BgieAYkboLxo5MYKqLVbqkdXACEMUtjW2gsLsEl
         1rj+oy6YvPpkqPbpO72NqUlNbgvqm4ZksQZI3tGT28Qj65VkaxZ5sEYq/oWRJVcBY+
         5foLPugP+nDvA1U8HXyqZPxOBE8PUW21GF9q5mPgu8RE1HsBWMcGBO79huARnN349X
         k7BGsPPRqYbDQbKXDy8TxO7d233o9HUYpkKLHxXapPfCouWcXloVr99kmz9KQ9xide
         sxXZuSwyUZuZg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 5:17 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:38PM +0530, Manikanta Maddireddy wrote:
>> Recommended update FC threshold in Tegra210 is 0x60 for best performance
>> of x1 link. Setting this to 0x60 provides the best balance between number
>> of UpdateFC and read data sent over the link.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
> Looks to me like part of this patch ended up in 12/30?
>
> Thierry
Ok, I will squash 12/30 & 13/30 and clearly mentioned what it means for T124 and T210
in commit message.
>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index b74408eeb367..7dc728cc5f51 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -319,6 +319,7 @@ struct tegra_pcie_soc {
>>  	bool update_clamp_threshold;
>>  	bool program_deskew_time;
>>  	bool raw_violation_fixup;
>> +	bool update_fc_threshold;
>>  	struct {
>>  		struct {
>>  			u32 rp_ectl_2_r1;
>> @@ -662,6 +663,13 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
>>  		value |= soc->update_fc_val;
>>  		writel(value, port->base + RP_VEND_XP);
>>  	}
>> +
>> +	if (soc->update_fc_threshold) {
>> +		value = readl(port->base + RP_VEND_XP);
>> +		value &= ~RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK;
>> +		value |= soc->update_fc_val;
>> +		writel(value, port->base + RP_VEND_XP);
>> +	}
>>  }
>>  
>>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>> @@ -2409,6 +2417,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>>  	.update_clamp_threshold = false,
>>  	.program_deskew_time = false,
>>  	.raw_violation_fixup = false,
>> +	.update_fc_threshold = false,
>>  	.ectl.enable = false,
>>  };
>>  
>> @@ -2436,6 +2445,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>>  	.update_clamp_threshold = false,
>>  	.program_deskew_time = false,
>>  	.raw_violation_fixup = false,
>> +	.update_fc_threshold = false,
>>  	.ectl.enable = false,
>>  };
>>  
>> @@ -2458,6 +2468,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>>  	.update_clamp_threshold = true,
>>  	.program_deskew_time = false,
>>  	.raw_violation_fixup = true,
>> +	.update_fc_threshold = false,
>>  	.ectl.enable = false,
>>  };
>>  
>> @@ -2468,6 +2479,8 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
>>  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
>>  	.pads_refclk_cfg0 = 0x90b890b8,
>> +	/* FC threshold is bit[25:18] */
>> +	.update_fc_val = 0x01800000,
>>  	.has_pex_clkreq_en = true,
>>  	.has_pex_bias_ctrl = true,
>>  	.has_intr_prsnt_sense = true,
>> @@ -2478,6 +2491,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>>  	.update_clamp_threshold = true,
>>  	.program_deskew_time = true,
>>  	.raw_violation_fixup = false,
>> +	.update_fc_threshold = true,
>>  	.ectl.regs.rp_ectl_2_r1 = 0x0000000f,
>>  	.ectl.regs.rp_ectl_4_r1 = 0x00000067,
>>  	.ectl.regs.rp_ectl_5_r1 = 0x55010000,
>> @@ -2513,6 +2527,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
>>  	.update_clamp_threshold = false,
>>  	.program_deskew_time = false,
>>  	.raw_violation_fixup = false,
>> +	.update_fc_threshold = false,
>>  	.ectl.enable = false,
>>  };
>>  
>> -- 
>> 2.17.1
>>

