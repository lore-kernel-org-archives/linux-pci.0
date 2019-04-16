Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9CAC10F14
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 10:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5071220821
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 10:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Hl3AN+yV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfDPKsF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:48:05 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1725 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfDPKsE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 06:48:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb5b2d00004>; Tue, 16 Apr 2019 03:47:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 03:48:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 03:48:03 -0700
Received: from [10.24.192.75] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 10:48:00 +0000
Subject: Re: [PATCH 16/30] PCI: tegra: Program AFI_CACHE* registers only for
 Tegra20
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-17-mmaddireddy@nvidia.com> <20190415132031.GR29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <931047de-ead5-8bdf-cf65-e2d42ecd2b66@nvidia.com>
Date:   Tue, 16 Apr 2019 16:17:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415132031.GR29254@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555411664; bh=VJRYgOQN/GZ6nCMp4XQxK4wJLRG2TcAajmRo8CD/VPI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=Hl3AN+yVPJ6ingdb29oBKtYWOkuebDGYPVZSboCuV28cMy2MQ2At1ANxGdnRxIYVH
         Ut3lciUmfkLYrzszx311aAlwVQLL8ofgYPQWba0ppPv5jLVm0uTjmnH4MQCLEO6UW+
         6sHUMAGaUpL0r0QjLd/27WdjIzVliVwMaMAaCUIWGALyyB/2mBmzGz6WAcQpa6yiAF
         SEI9e6JevFu4zIetg3BukPX7X59LjdyaVYwpBiMODvLiGykUHeV4j1Snylw9VdzACG
         s2979Riba82uHOMnu9wfZtPW4NHtPuP38FWm1l6NGJWNK15eNkKkW++qe0jDzZNLny
         ypjuyyrIWAahw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 6:50 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:41PM +0530, Manikanta Maddireddy wrote:
>> AFI_CACHE* registers are available only in Tegra20, program them only
>> for Tegra20.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 8e5fdc8ce3d6..cdaaf13a9fd7 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -887,6 +887,7 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
>>   */
>>  static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
>>  {
>> +	struct device_node *np = pcie->dev->of_node;
>>  	u32 fpci_bar, size, axi_address;
>>  
>>  	/* Bar 0: type 1 extended configuration space */
>> @@ -927,11 +928,13 @@ static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
>>  	afi_writel(pcie, 0, AFI_AXI_BAR5_SZ);
>>  	afi_writel(pcie, 0, AFI_FPCI_BAR5);
>>  
>> -	/* map all upstream transactions as uncached */
>> -	afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
>> -	afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
>> -	afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
>> -	afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
>> +	if (of_device_is_compatible(np, "nvidia,tegra20-pcie")) {
> At this point we've already matched on that compatible string, so we
> could probably get that information from the SoC structure. Why are
> these registers not available on later chips? How would we mark
> transactions as uncached on later generations of Tegra?
>
> Also, typically writing to non-existing registers on Tegra186 would
> cause an SError exception, but I haven't seen any of those with PCIe
> on Tegra186. So do these really not exist, or are they simply not used?
>
> Thierry

Do you want me to add new soc flag for AFI_CACHE registers?

As per the HW team feedback, upstream requests targeting DRAM would
be marked as cacheable when the address of the request are within the
regions defined by the cache_bar_sz/st registers.
All upstream DRAM requests are marked as non-cacheable from T30 to T210
as the field is not used by MSS. In Tegra186 cacheable requests are
supported by new register AFI_AXCACHE_0*. *
These register definitions are not present in Tegra186 TRM, but
register offsets are accessible, so these are not used.
However Tegra186 simulations traps this register access because
it is not defined in register spec.

Manikanta

>> +		/* map all upstream transactions as uncached */
>> +		afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
>> +		afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
>> +		afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
>> +		afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
>> +	}
>>  
>>  	/* MSI translations are setup only when needed */
>>  	afi_writel(pcie, 0, AFI_MSI_FPCI_BAR_ST);
>> -- 
>> 2.17.1
>>

