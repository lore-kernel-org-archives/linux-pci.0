Return-Path: <SRS0=xyCL=RH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB24EC43381
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 05:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6BB20815
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 05:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="q9yLIqsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfCDFjC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:39:02 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19032 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfCDFjC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Mar 2019 00:39:02 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7cb9f40000>; Sun, 03 Mar 2019 21:39:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 03 Mar 2019 21:39:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 03 Mar 2019 21:39:00 -0800
Received: from [10.24.47.162] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Mar
 2019 05:38:57 +0000
Subject: Re: [PATCH] PCI: tegra: Do not allocate MSI target memory
To:     Lucas Stach <dev@lynxeye.de>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <treding@nvidia.com>,
        <swarren@nvidia.com>, <mperttunen@nvidia.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>
References: <1551366004-32547-1-git-send-email-vidyas@nvidia.com>
 <247102e57e067d1477f3260bdeaa3ea011d0f3ed.camel@lynxeye.de>
 <8b6f53c4-ac39-40d6-0979-86137236f890@nvidia.com>
 <d0e83ca1648a3ec80c01bc5e6708286f9d891580.camel@lynxeye.de>
 <6ee0919a-504f-ae76-5995-a9eae505ef90@nvidia.com>
 <91fbda5d299b29d8516cfdd7c1f72a4b34797e82.camel@lynxeye.de>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <6ae28571-0110-5122-ed2a-392bbb3edfda@nvidia.com>
Date:   Mon, 4 Mar 2019 11:08:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <91fbda5d299b29d8516cfdd7c1f72a4b34797e82.camel@lynxeye.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551677940; bh=SVpWvS14tB/SYivejhdXiNpuHqHT1IXuX8hHkmTpUF0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=q9yLIqsS0tTheQQsapoObeu+1xj904yZ3yzZft1IITL+R5LNO1OqRaj+E5PDZJF8l
         vaq30MUteBB6OT+ZAPpI8TVYNdHTcXtmBWrTRLogxGaXJKhDC/f05HIG76JYjMdyj4
         7Hs3V+lSc7jFV0zedS1kYLtnkUyZgxw9LSaD4S6zZbza1lD+I27JousaAiUcClz0NO
         M0FreTAgnmIa9MANYGxTgKfH4/vSAjfP+ITtg80n3zenp6RXQc+h1Db3/UV6cXmQTH
         xL4GjWIYdQ6cuaFvIhqePJj1DUkdMSRdq3hPdYnB74zPtJdGSoiO8zNTiUDu4peijM
         nQhRKJdtlyaKA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/2/2019 7:52 PM, Lucas Stach wrote:
> Am Samstag, den 02.03.2019, 08:20 +0530 schrieb Vidya Sagar:
>> On 3/1/2019 8:26 PM, Lucas Stach wrote:
>>> Am Freitag, den 01.03.2019, 08:45 +0530 schrieb Vidya Sagar:
>>>> On 3/1/2019 12:32 AM, Lucas Stach wrote:
>>>>> Am Donnerstag, den 28.02.2019, 20:30 +0530 schrieb Vidya Sagar:
>>>>>> The PCI host bridge found on Tegra SoCs doesn't require the MSI target
>>>>>> address to be backed by physical system memory. Writes are intercepted
>>>>>> within the controller and never make it to the memory pointed to.
>>>>>>
>>>>>> Since no actual system memory is required, remove the allocation of a
>>>>>> single page and hardcode the MSI target address with a special address
>>>>>> on a per-SoC basis. Ideally this would be an address to an MMIO memory
>>>>>> region (such as where the controller's register are located). However,
>>>>>> those addresses don't work reliably across all Tegra generations. The
>>>>>> only set of addresses that work consistently are those that point to
>>>>>> external memory.
>>>>>>
>>>>>> This is not ideal, since those addresses could technically be used for
>>>>>> DMA and hence be confusing. However, the first page of external memory
>>>>>> is unlikely to be used and special enough to avoid confusion.
>>>>> So you are trading a slight memory waste of a single page against a
>>>>> sporadic (and probably hard to debug) DMA failure if any device happens
>>>>> to initiate DMA to the first page of physical memory? That does not
>>>>> sound like a good deal...
>>>>>
>>>>> Also why would the first page of external memory be unlikely to be
>>>>> used?
>>>>>
>>>>> Regards,
>>>>> Lucas
>>>> We are not wasting single page of memory here and if any device's DMA is
>>>> trying to access it, it will still go through. Its just that we are using that
>>>> same address for MSI (note that MSI writes don't go beyond PCIe IP as they get
>>>> decoded at PCIe IP level itself and only an interrupt
>>>> goes to CPU) and that might be a bit confusing as same address is used
>>>> as normal memory as well as MSI target address. Since there can never be any
>>>> issue with this would you suggest to remove the last paragraph from commit
>>>> description?
>>> How does the core distinguish between a normal DMA memory write and a
>>> MSI? If I remember the PCIe spec correctly, there aren't any
>>> differences between the two besides the target address.
>>>
>>> So if you now set a non-reserved region of memory to decode as a MSI at
>>> the PCIe host controller level, wouldn't this lead to normal DMA
>>> transactions to this address being wrongfully turned into an MSI and
>>> the write not reaching the targeted location?
>>>
>>> Regards,
>>> Lucas
>> You are correct that core cannot distinguish between a normal DMA memory and
>> MSI. In that case, the only way I see is to alloc memory using
>> dma_alloc_coherent()
>> and use the IOVA as the MSI target address. That way, a page gets
>> reserved (in a way wasted
>> also as the MSI writes don't really make it to RAM) and there won't be
>> any address
>> overlaps with normal DMA writes. I'll push a patch for it.
> At that point it's no longer different from the current code, which
> simply reserves a single page of memory and uses its address as the MSI
> target address.
But, I think there is still one issue with the current code base. Since 
what is used as
MSI target address is the physical address equivalent of the memory page 
being reserved,
there is a chance that some IOVA might become equal to this physical 
address there by
making PCIe IP to raise an MSI interrupt instead of forwarding the write 
to memory.
Do you agree with this?
> So in conclusion this change should just be dropped.
>
> Regards,
> Lucas
>

