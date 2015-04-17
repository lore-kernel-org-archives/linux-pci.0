Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:9680 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362AbbDQQHl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2015 12:07:41 -0400
Message-ID: <55312FBE.10302@broadcom.com>
Date: Fri, 17 Apr 2015 09:07:26 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
CC: Hauke Mehrtens <hauke@hauke-m.de>, <linux-pci@vger.kernel.org>,
	<zajec5@gmail.com>, <florian@openwrt.org>, <peter.senna@gmail.com>,
	"Scott Branden" <sbranden@broadcom.com>
Subject: Re: [RFC] PCI: BCM5301X: add PCIe2 driver for BCM5301X SoCs
References: <1415470392-28229-1-git-send-email-hauke@hauke-m.de> <545E8AA2.6050301@hauke-m.de> <11068573.lefhT3BUSj@wuerfel> <4575399.moLzVD0xqT@wuerfel>
In-Reply-To: <4575399.moLzVD0xqT@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 4/17/2015 7:09 AM, Arnd Bergmann wrote:
> (reviving an old thread)
> 
> On Sunday 09 November 2014 21:27:40 Arnd Bergmann wrote:
>>
>>>>> +  /*
>>>>> +   * Inbound address translation setup
>>>>> +   * Northstar only maps up to 128 MiB inbound, DRAM could be up to 1 GiB.
>>>>> +   *
>>>>> +   * For now allow access to entire DRAM, assuming it is less than 128MiB,
>>>>> +   * otherwise DMA bouncing mechanism may be required.
>>>>> +   * Also consider DMA mask to limit DMA physical address
>>>>> +   */
>>>>> +  /* 64-bit LE regs, write low word, high is 0 at reset */
>>>>> +  bcma_write32(bdev, BCMA_CORE_PCIE2_FUNC0_IMAP1, PHYS_OFFSET | 0x1);
>>>>> +  bcma_write32(bdev, BCMA_CORE_PCIE2_IARR1_LOWER,
>>>>> +                     PHYS_OFFSET | ((SZ_128M >> 20) & 0xff));
>>>>
>>>> Maybe I should bully you into enabling swiotlb on arm32 
>>>
>>> This sounds complicated, I hope I can avoid it. 
>>
>> I'd really hope that it's not that hard. We basically just need a copy of
>> coherent_swiotlb_dma_ops/noncoherent_swiotlb_dma_ops from arm64 and
>> use those on bcma devices, with the right dma_mask set.
> 
> Peter Senna has tested this on bcm4708a0 (Buffalo WZR-1750DHP) and found
> that all RAM is DMA capable, as tested with CONFIG_VMSPLIT_1G. Could
> the code comment here be incorrect, or is it possible that it was fixed
> in later chip versions?
> 
> If this works, using CONFIG_VMSPLIT_1G should result in noticeably
> better I/O performance on this chip.
> 
> I have created a patch that lets him simulate the broken behavior on his
> machine, so he can work on implementing swiotlb, but it would certainly
> be best to understand which machines are really affected.
> 
> Note that the driver that was merged as drivers/pci/host/pcie-iproc.c
> does not seem to touch the BCMA_CORE_PCIE2_IARR1_LOWER (offset 0xd08)
> register, and presumably the power-on default for this register
> maps all of RAM correctly.

That appears to be the case for Cygnus and NS+ but I just realized I
should not make this assumption since this is going to be the driver for
a lot of other iProc based chips. I need to check with our ASIC team on
limitation of PCIe on each chip on inbound mapping and do more
investigation and experiment myself.

Also note I won't have time to work on this in the short-term, but I
will eventually get to it.

Thanks,

Ray

> 
> 	Arnd
> 
