Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bbn0101.outbound.protection.outlook.com ([157.56.111.101]:44140
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932401AbaKMKvi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 13 Nov 2014 05:51:38 -0500
Message-ID: <54648D61.6050704@freescale.com>
Date: Thu, 13 Nov 2014 18:52:17 +0800
From: Lian Minghuan-B31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Lucas Stach <l.stach@pengutronix.de>
CC: Srikanth Thokala <sriku.linux@gmail.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: designware: Add support 4 ATUs assignment
References: <1415682444-24911-1-git-send-email-Minghuan.Lian@freescale.com>
	 <CA+mB=1+4Dzxhbin6z0PUENvjUz-y8bq-K09FXTnSepFvVfe9HQ@mail.gmail.com>
	 <546308DD.40109@freescale.com>
	 <CA+mB=1K=Oyzdb2yfBvPRG9DHi-PFjRPtVS_dY9JMOz6dQog8QQ@mail.gmail.com>
	 <546331E7.5060003@freescale.com>
	 <CA+mB=1KObT9O783SMcvHy8nJGQPnxyKgP332r5bHx-K_D+LhVg@mail.gmail.com>
	 <1415809929.2876.5.camel@pengutronix.de> <546481A3.5050700@freescale.com>
 <1415874015.2420.5.camel@pengutronix.de>
In-Reply-To: <1415874015.2420.5.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lucas,

On 2014年11月13日 18:20, Lucas Stach wrote:
> Am Donnerstag, den 13.11.2014, 18:02 +0800 schrieb Lian Minghuan-B31939:
>> Hi Lucas,
>>
>> Please see my comments inline.
>>
>> Thanks,
>> Minghuan
>>
>> On 2014年11月13日 00:32, Lucas Stach wrote:
>>> Am Mittwoch, den 12.11.2014, 21:53 +0530 schrieb Srikanth Thokala:
>>>> Hi Minghuan,
> [...]
>
>>> Using a smaller type complicates the DT for little to no benefit. I
>>> think it's ok to use u32 here, which is a common standard for integer
>>> values in DT.
>>>
>>> Though this discussion lead me to the question if we even need to have
>>> this property in the DT at all. Isn't this a property that is fixed for
>>> a specific silicon implementation of the DW core? In that case we could
>>> just infer the number of ATUs from the DT compatible, so this should
>>> probably just be added to struct pcie_port and properly initialized by
>>> the SoC glue drivers.
>> [Minghuan]  As far as I know, exynos implements only 2 ATUs, this is why
>> pcie-designware only supports 2 ATU. iMX implements 4 ATUs and LS1021A
>> implements 6 ATUs.
>>
> Right so we don't need an additional property in the DT at all. The
> number of ATUs is fixed for a specific core compatible and can be passed
> in by the respective exynos, imx and ls1021 glue drivers.
>
> You may ask the Keystone and Spear maintainers to get the correct number
> of ATUs for those implementations.
>
> Regards,
> Lucas
[Minghuan] Yes. This a way that specific core driver passes the ATU 
number to
pci-designware. But I perfer to adding dts node for the following reasons:
1. ATU number is hardware attribute, so it can be added to DTS.
2. That pci-designware common code parses the 'num-atus' can avoid every 
specific controller driver to define and pass num-atus, so can reduce 
code size and simplify the specific controller driver implementation.

Thanks,
Minghuan


