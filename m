Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0114.outbound.protection.outlook.com ([207.46.100.114]:65266
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754966AbaIQC0O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 16 Sep 2014 22:26:14 -0400
Message-ID: <541961E3.909@freescale.com>
Date: Wed, 17 Sep 2014 10:26:43 +0000
From: Lian Minghuan-B31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Scott Wood <scottwood@freescale.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	"Yoder Stuart-B08248" <stuart.yoder@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 3/3] PCI: Layerscape: Add Layerscape PCIe driver
References: <1410469741-11634-1-git-send-email-Minghuan.Lian@freescale.com>
 <1410841159.24184.491.camel@snotra.buserror.net>
 <54187590.4070101@freescale.com> <201409161833.53176.arnd@arndb.de>
In-Reply-To: <201409161833.53176.arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On 2014年09月16日 16:33, Arnd Bergmann wrote:
> On Tuesday 16 September 2014, Lian Minghuan-B31939 wrote:
>>>>>> +          ranges = <0x81000000 0x0 0x00000000 0x40 0x10000000 0x0 0x00010000   /* downstream I/O */
>>>>>> +                    0x82000000 0x0 0x00000000 0x41 0x00000000 0x1 0x00000000>; /* non-prefetchable memory */
>>>>> Are these ranges hardcoded in the SoC, or are they the result of iATU
>>>>> settings?  If the latter, who configures it and why no prefetchable
>>>>> region?
>>>> [Minghuan] 400000_0000 - 480000_0000 is hardcode assigned to PEX1.
>>>> I separates from this 32 region  1M for IO, 4G for non-prefetchable memory.
>>>> 4G is the max size iATU supported.
>>>> IO and memory region will be set to iATU by pci-designware.c
>>>> Because both powerpc and imx do not set prefechable memory,
>>>> so  I do not assign prefetchable memory either.
>>> If there's spare room in the addres space for a prefetchable region, why
>>> not make one, regardless of what PPC and IMX do?
>>>
>>> FWIW, I believe that ARMv8 can make better use of a prefetchable region
>>> due to the "gathering" storage attribute, so even if you don't use one
>>> on LS1021A consider using one on ARMv8-based LS chips.
>> [Minghuan] Ok, I will add 4G prefetchable memory region.
> I guess that means you still can't support devices that require 64-bit
> BARs, right? 4GB may be too small for some devices.
>
> Do I read this right that you could have multiple adjacent 4GB areas
> but are limited on registers to set up these areas?
[Minghuan] Yes, an iATU supports up to 4GB in size. We can create 
multiple iATU
to cover a region larger than 4G.
> 	Arnd

