Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808ADC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5DC20880
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QMNTk93E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfDOO7O (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:59:14 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13083 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfDOO7O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 10:59:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb49c460001>; Mon, 15 Apr 2019 07:59:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 07:59:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 07:59:13 -0700
Received: from [10.24.70.150] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 14:59:09 +0000
Subject: Re: [PATCH 11/30] PCI: tegra: Increase the deskew retry time
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-12-mmaddireddy@nvidia.com> <20190415113918.GL29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <e7a8746e-484a-03b1-bec1-ee026d0651f0@nvidia.com>
Date:   Mon, 15 Apr 2019 20:28:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415113918.GL29254@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555340358; bh=mXoPTgjpwTOa5AGFwBpiA8dIqAH9/xk0DmMm1jYYvyY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=QMNTk93E9cCeUCY5RWSZL1xiIeq6ZwvesqF6FPNqis5t8psoV6+bx71UMJQ37Kmpy
         RVVztBPvOCjme+HzpHnlWujhJC4rWkjBfBhqzBv6cuN5HjiYotqh/tC3Lhz3TiIlay
         QrSAdwblfgaeGMRfC7tSOMA+/rwvdznmOnzJkclabqCv5YI5CCYAjemzSb/k+XSxMy
         pz2r7kvqp61UO2W+b5/kG8Sv6TnToGBCGq5mCLg7z5L3WEBB1ZrWwdZ96QN9Zrs3EA
         V81I2+us2+W0ictFXrHWkB4KAfsl2Be30w0dsoJKaQsYItnsuOSYKeGzBhYMyrmRNI
         DfR6Ctng5K/Xg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 5:09 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:36PM +0530, Manikanta Maddireddy wrote:
>> Some times link speed change from Gen2 to Gen1 fails due to instability
> "Sometimes"
>
>> in deskew logic on lane-0 in Tegra210. Increase the deskew retry time
>> to resolve this issue.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index f785ecae2f6b..9e61da68cfae 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -209,6 +209,10 @@
>>  #define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
>>  #define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
>>  
>> +#define RP_VEND_CTL0	0x00000f44
>> +#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
>> +#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH	(0x9 << 12)
>> +
>>  #define RP_VEND_CTL1	0x00000f48
>>  #define  RP_VEND_CTL1_ERPT	(1 << 13)
>>  
>> @@ -304,6 +308,7 @@ struct tegra_pcie_soc {
>>  	bool force_pca_enable;
>>  	bool program_uphy;
>>  	bool update_clamp_threshold;
>> +	bool program_deskew_time;
>>  	struct {
>>  		struct {
>>  			u32 rp_ectl_2_r1;
>> @@ -615,6 +620,23 @@ static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *port)
>>  	writel(val, port->base + RP_ECTL_6_R2);
>>  }
>>  
>> +static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
>> +{
>> +	const struct tegra_pcie_soc *soc = port->pcie->soc;
>> +	u32 value;
>> +
>> +	/*
>> +	 * Tune deskew retry time to take care of Gen2 -> Gen1
>> +	 * link speed change error in corner cases
>> +	 */
>> +	if (soc->program_deskew_time) {
>> +		value = readl(port->base + RP_VEND_CTL0);
>> +		value &= ~RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK;
>> +		value |= RP_VEND_CTL0_DSK_RST_PULSE_WIDTH;
>> +		writel(value, port->base + RP_VEND_CTL0);
>> +	}
>> +}
>> +
>>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>>  {
>>  	unsigned long ctrl = tegra_pcie_port_get_pex_ctrl(port);
>> @@ -643,6 +665,7 @@ static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>>  	tegra_pcie_enable_rp_features(port);
>>  	if (soc->ectl.enable)
>>  		tegra_pcie_program_ectl_settings(port);
>> +	tegra_pcie_apply_sw_fixup(port);
> Blank line between the above two for readability.
>
> Thierry
I will take care of all the comments in V2

Manikanta
>
>>  }
>>  
>>  static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
>> @@ -2357,6 +2380,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>>  	.force_pca_enable = false,
>>  	.program_uphy = true,
>>  	.update_clamp_threshold = false,
>> +	.program_deskew_time = false,
>>  	.ectl.enable = false,
>>  };
>>  
>> @@ -2382,6 +2406,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>>  	.force_pca_enable = false,
>>  	.program_uphy = true,
>>  	.update_clamp_threshold = false,
>> +	.program_deskew_time = false,
>>  	.ectl.enable = false,
>>  };
>>  
>> @@ -2400,6 +2425,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>>  	.force_pca_enable = false,
>>  	.program_uphy = true,
>>  	.update_clamp_threshold = true,
>> +	.program_deskew_time = false,
>>  	.ectl.enable = false,
>>  };
>>  
>> @@ -2418,6 +2444,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>>  	.force_pca_enable = true,
>>  	.program_uphy = true,
>>  	.update_clamp_threshold = true,
>> +	.program_deskew_time = true,
>>  	.ectl.regs.rp_ectl_2_r1 = 0x0000000f,
>>  	.ectl.regs.rp_ectl_4_r1 = 0x00000067,
>>  	.ectl.regs.rp_ectl_5_r1 = 0x55010000,
>> @@ -2451,6 +2478,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
>>  	.force_pca_enable = false,
>>  	.program_uphy = false,
>>  	.update_clamp_threshold = false,
>> +	.program_deskew_time = false,
>>  	.ectl.enable = false,
>>  };
>>  
>> -- 
>> 2.17.1
>>

