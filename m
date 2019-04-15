Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70309C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5A02147C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NnfnspgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfDOPOj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:14:39 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14149 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDOPOj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:14:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb49fe30001>; Mon, 15 Apr 2019 08:14:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 08:14:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 08:14:38 -0700
Received: from [10.24.70.150] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 15:14:34 +0000
Subject: Re: [PATCH 15/30] PCI: tegra: Fix PLLE powerdown issue due to CLKREQ#
 signal
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-16-mmaddireddy@nvidia.com> <20190415131716.GQ29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <eea30332-9683-9b89-c82d-e5041e36d1f1@nvidia.com>
Date:   Mon, 15 Apr 2019 20:44:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415131716.GQ29254@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555341283; bh=vsQ3C+4ExpFTG/SOW7VAR8aYR6yHTnAcNmL960ANdgE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=NnfnspgFr8riN3P70ThZM6ZD8rp3gSz0dkoh/SOWn/eJ2EytjKyC9VdAX7fzIpkU7
         WJ4sgjBR3g1Oz2Ta4YhiF5Fhm2XHL2qQoEJmhJBh1wXjlXUAT5qCGVS3ndtcpLs4sD
         hG7y6rJ38Y8PaXoZL95CPDxrg7aDjf7D6qDn4C9zigY/+a6XFx7CSdJcJ5XK/ZIAZ4
         3F2/50VTt5dM48zu7yuEuuN0dLMhjAIpSLmLkNSUMvmONeR9blNsNaWNeOTvt0epsm
         kVpV5Ihgf8/wSnJWjBeJLf+QqXbBu1e6p5gGz4IUOBLwZJwHqvbcMN49birxoS1jba
         iBbq6gqL9hm9w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 6:47 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:40PM +0530, Manikanta Maddireddy wrote:
>> Disable controllers which failed to link up and configure CLKREQ# signals
>> of these controllers as GPIO. This is required to avoid CLKREQ# signal of
>> inactive controllers interfering with PLLE powerdown sequence.
>>
>> PCIE_CLKREQ_GPIO bits are defined only in Tegra186, however programming
>> these bits in other SoCs doesn't cause any side effects. Program these
>> bits for all Tegra SoCs to avoid conditional check.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 7e24eac12668..8e5fdc8ce3d6 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -160,6 +160,8 @@
>>  #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_211	(0x1 << 20)
>>  #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_411	(0x2 << 20)
>>  #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_111	(0x2 << 20)
>> +#define  AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO(x)		(1 << ((x) + 29))
>> +#define  AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO_ALL		(0x7 << 29)
>>  
>>  #define AFI_FUSE			0x104
>>  #define  AFI_FUSE_PCIE_T0_GEN2_DIS	(1 << 2)
>> @@ -733,6 +735,15 @@ static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
>>  
>>  	value &= ~AFI_PEX_CTRL_REFCLK_EN;
>>  	afi_writel(port->pcie, value, ctrl);
>> +
>> +	/*
>> +	 * disable PCIe device and set CLKREQ# as gpio
> Did you mean to say "PCIe port"? Also, s/gpio/GPIO/, and you can make
> use of 78 characters. With those changes, the above may just fit on one
> line.
>
> Thierry
I will take care of it in V2.

Manikanta
>
>> +	 * to allow PLLE power down
>> +	 */
>> +	value = afi_readl(port->pcie, AFI_PCIE_CONFIG);
>> +	value |= AFI_PCIE_CONFIG_PCIE_DISABLE(port->index);
>> +	value |= AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO(port->index);
>> +	afi_writel(port->pcie, value, AFI_PCIE_CONFIG);
>>  }
>>  
>>  static void tegra_pcie_port_free(struct tegra_pcie_port *port)
>> @@ -1147,9 +1158,12 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>>  	value = afi_readl(pcie, AFI_PCIE_CONFIG);
>>  	value &= ~AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_MASK;
>>  	value |= AFI_PCIE_CONFIG_PCIE_DISABLE_ALL | pcie->xbar_config;
>> +	value |= AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO_ALL;
>>  
>> -	list_for_each_entry(port, &pcie->ports, list)
>> +	list_for_each_entry(port, &pcie->ports, list) {
>>  		value &= ~AFI_PCIE_CONFIG_PCIE_DISABLE(port->index);
>> +		value &= ~AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO(port->index);
>> +	}
>>  
>>  	afi_writel(pcie, value, AFI_PCIE_CONFIG);
>>  
>> -- 
>> 2.17.1
>>

