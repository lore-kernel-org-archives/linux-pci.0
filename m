Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A35FC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA1120880
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qSKo2SCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfDOOVQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:21:16 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11616 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfDOOVQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 10:21:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb493600000>; Mon, 15 Apr 2019 07:21:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 07:21:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 07:21:15 -0700
Received: from [10.24.70.150] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 14:21:11 +0000
Subject: Re: [PATCH 03/30] PCI: tegra: Move REFCLK pad settings out of
 phy_power_on()
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-4-mmaddireddy@nvidia.com> <20190415110628.GD29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <7eb69509-5a38-2fe4-5aef-9a38ad0accac@nvidia.com>
Date:   Mon, 15 Apr 2019 19:50:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415110628.GD29254@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555338080; bh=EkMm8RGR6tXpn2mrDylmxAI+oiEVk26i50/QcPU456M=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=qSKo2SCR+fIriUtiw2XOX6Ht/WVVhY3Y/E0DFAt9rDzeMh5SI0oR1+jk6jaG0bmCt
         s66li6Jg1KKFYHhPhByPMy6h055fuO2gUB8Tq7Zpqjh617rfBnQ67umFby6T7s1jEO
         h/2xVScWFLAsXVolhHdws0UXDOl5tpQ0fUFc6R+TO7j/2bYf81UZUx5OzebiSOjB2t
         aeCYI+RU8AoTMv3MYfO3/MLnkQORejI8MsPoB7CjpPkLzCsur/DaD1aRrEjHNNvXc9
         rhrl2I/we3Hm0/vqFI9LoIF30eRjm+gb2JyxM9dwRPUFBGfLi/BM0L47RZGY5Ohi/D
         dalN4FeyljAMg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 15-Apr-19 4:36 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:28PM +0530, Manikanta Maddireddy wrote:
>> In Tegra186 PHY programming is done by BPMP-FW, so PHY calls are skipped
>> in driver. REFCLK pad settings are independent of PHY and should be
>> programmed by driver. So move REFCLK pad settings out of phy_power_on().
>> These pad settings tune REFCLK peak to peak amplitude.
>>
>> Fixes: cf5d31801278 ("PCI: tegra: Program PADS_REFCLK_CFG* always, not
>> just on legacy SoCs")
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 20 +++++++++++++-------
>>  1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 0bf270bcea34..a61ce9d475b4 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -852,7 +852,6 @@ static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
>>  static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
>>  {
>>  	struct device *dev = pcie->dev;
>> -	const struct tegra_pcie_soc *soc = pcie->soc;
>>  	struct tegra_pcie_port *port;
>>  	int err;
>>  
>> @@ -878,12 +877,6 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
>>  		}
>>  	}
>>  
>> -	/* Configure the reference clock driver */
>> -	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
>> -
>> -	if (soc->num_ports > 2)
>> -		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
>> -
>>  	return 0;
>>  }
>>  
>> @@ -2092,11 +2085,24 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
>>  	return false;
>>  }
>>  
>> +static void tegra_pcie_apply_pad_settings(struct tegra_pcie *pcie)
>> +{
>> +	const struct tegra_pcie_soc *soc = pcie->soc;
>> +
>> +	/* Configure the reference clock driver */
>> +	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
>> +
>> +	if (soc->num_ports > 2)
>> +		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
>> +}
>> +
>>  static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>>  {
>>  	struct device *dev = pcie->dev;
>>  	struct tegra_pcie_port *port, *tmp;
>>  
>> +	tegra_pcie_apply_pad_settings(pcie);
>> +
>>  	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
>>  		dev_info(dev, "probing port %u, using %u lanes\n",
>>  			 port->index, port->lanes);
> This also seems to move the programming of these registers to a
> different point in time. Was that intentional? If so, please mention it
> in the commit message and describe why that's necessary.
>
> If that was not intentional, it seems like the right place to call this
> would be right after the call to tegra_pcie_enable_controller() in
> tegra_pcie_pm_resume().
>
> Thierry
PCIe pad registers access needs PEX clk and reset enabled, so I moved to
tegra_pcie_enable_ports(). But looking at this carefully I see a pattern
that only per port PCIe register programming is done, however PCIe
pad register spec is for all controller. So the right place would be
tegra_pcie_pm_resume() after enable PEX clk and reset. I will update
in V2
