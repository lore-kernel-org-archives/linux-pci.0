Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC9C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029D72146E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="R0eB5S1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfDOO6X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:58:23 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13044 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfDOO6X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 10:58:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb49c120000>; Mon, 15 Apr 2019 07:58:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 07:58:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 07:58:21 -0700
Received: from [10.24.70.150] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 14:58:17 +0000
Subject: Re: [PATCH 10/30] PCI: tegra: Enable PCIe xclk clock clamping
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-11-mmaddireddy@nvidia.com> <20190415113703.GK29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <3c8a87b2-b9cb-791c-788c-33dfa0db9a97@nvidia.com>
Date:   Mon, 15 Apr 2019 20:28:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415113703.GK29254@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555340307; bh=Tu3KKhoJay12sPWtj6g0AlO89i7goDtz5amb2P+ERWw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=R0eB5S1NWqdTvL0sqCqwuN1nknwS34vGAd7iQLgpcjLglK0t/SzMd1lhibLT76pYJ
         ZQ4UK3f9nmXISVntuJKTd0mqY43qUtVFlmBIqgtZJjpQ6YGd5E7OC++h6/c1GxVvB5
         lgY/qXFAhXxfAv8NFmsYksBEA4s6x/jZkS3x3X9adwaJJMcpTKDcyb6H62ixN9MmTl
         OSl7d799cYpJNLCwAgXmSKuVhSz5O+WbfoiCAQBDL5ckGtbdGD5FDxBObd7d49XOmv
         vZzgphh2lIE1rtSWKEblerYMVsozIEWADVthliTXPcYfJSRbGQl8lNzVi2daERhb5x
         Egc0cw2ZFw7qQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 5:07 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:35PM +0530, Manikanta Maddireddy wrote:
>> Enable xclk clock clamping when entering L1. Clamp threshold will
>> determine the time spent waiting for clock module to turn on xclk after
>> signalling it. Default threshold value in Tegra124 and 210 is not enough
> Perhaps spell out Tegra210.
>
>> to turn ON xlck clock. Increase the clamp threshold to meet the clock
> s/ON/on/, s/xlck/xclk/
>
>> module timing in Tegra124 and 210, default threshold value is sufficient
> Spell out Tegra210. Also, maybe make the part after the , a separate
> sentence? And maybe also mention Tegra20 and Tegra30.
>
> Thierry
>
>> in Tegra186.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 28 ++++++++++++++++++++++++++--
>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index e40df52e46a7..f785ecae2f6b 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -219,8 +219,14 @@
>>  #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
>>  
>>  #define RP_PRIV_MISC	0x00000fe0
>> -#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT (0xe << 0)
>> -#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT (0xf << 0)
>> +#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT		(0xe << 0)
>> +#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT		(0xf << 0)
>> +#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK	(0x7f << 16)
>> +#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD		(0xf << 16)
>> +#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE		(1 << 23)
>> +#define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK	(0x7f << 24)
>> +#define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD		(0xf << 24)
>> +#define  RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE		(1 << 31)
>>  
>>  #define RP_LINK_CONTROL_STATUS			0x00000090
>>  #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
>> @@ -297,6 +303,7 @@ struct tegra_pcie_soc {
>>  	bool has_gen2;
>>  	bool force_pca_enable;
>>  	bool program_uphy;
>> +	bool update_clamp_threshold;
>>  	struct {
>>  		struct {
>>  			u32 rp_ectl_2_r1;
>> @@ -528,6 +535,7 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
>>  
>>  static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
>>  {
>> +	const struct tegra_pcie_soc *soc = port->pcie->soc;
>>  	u32 value;
>>  
>>  	/* Enable AER capability */
>> @@ -548,6 +556,17 @@ static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
>>  	value = readl(port->base + RP_VEND_XP_BIST);
>>  	value |= RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE;
>>  	writel(value, port->base + RP_VEND_XP_BIST);
>> +
>> +	value = readl(port->base + RP_PRIV_MISC);
>> +	value |= RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE;
>> +	value |= RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE;
>> +	if (soc->update_clamp_threshold) {
> Blank line between the above two.
>
>> +		value &= ~(RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK |
>> +				RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK);
>> +		value |= RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD |
>> +			RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD;
>> +	}
>> +	writel(value, port->base + RP_PRIV_MISC);
> Ditto.
>
> Thierry
I will take care of all the comments in V2

Manikanta
>>  }
>>  
>>  static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *port)
>> @@ -2337,6 +2356,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>>  	.has_gen2 = false,
>>  	.force_pca_enable = false,
>>  	.program_uphy = true,
>> +	.update_clamp_threshold = false,
>>  	.ectl.enable = false,
>>  };
>>  
>> @@ -2361,6 +2381,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>>  	.has_gen2 = false,
>>  	.force_pca_enable = false,
>>  	.program_uphy = true,
>> +	.update_clamp_threshold = false,
>>  	.ectl.enable = false,
>>  };
>>  
>> @@ -2378,6 +2399,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>>  	.has_gen2 = true,
>>  	.force_pca_enable = false,
>>  	.program_uphy = true,
>> +	.update_clamp_threshold = true,
>>  	.ectl.enable = false,
>>  };
>>  
>> @@ -2395,6 +2417,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>>  	.has_gen2 = true,
>>  	.force_pca_enable = true,
>>  	.program_uphy = true,
>> +	.update_clamp_threshold = true,
>>  	.ectl.regs.rp_ectl_2_r1 = 0x0000000f,
>>  	.ectl.regs.rp_ectl_4_r1 = 0x00000067,
>>  	.ectl.regs.rp_ectl_5_r1 = 0x55010000,
>> @@ -2427,6 +2450,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
>>  	.has_gen2 = true,
>>  	.force_pca_enable = false,
>>  	.program_uphy = false,
>> +	.update_clamp_threshold = false,
>>  	.ectl.enable = false,
>>  };
>>  
>> -- 
>> 2.17.1
>>

