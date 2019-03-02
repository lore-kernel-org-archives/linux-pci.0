Return-Path: <SRS0=jK/a=RF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8985C10F03
	for <linux-pci@archiver.kernel.org>; Sat,  2 Mar 2019 02:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76F820840
	for <linux-pci@archiver.kernel.org>; Sat,  2 Mar 2019 02:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kKPl3TTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfCBCug (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 21:50:36 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5374 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCBCug (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Mar 2019 21:50:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c79ef830000>; Fri, 01 Mar 2019 18:50:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 Mar 2019 18:50:34 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 01 Mar 2019 18:50:34 -0800
Received: from [10.25.72.51] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 2 Mar
 2019 02:50:30 +0000
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
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <6ee0919a-504f-ae76-5995-a9eae505ef90@nvidia.com>
Date:   Sat, 2 Mar 2019 08:20:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <d0e83ca1648a3ec80c01bc5e6708286f9d891580.camel@lynxeye.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551495043; bh=RGKdLpwk5MmOcVrrZBG1QBpyweFaZ5wvvfCFDuts+zw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=kKPl3TTxa4xZhUyoCTOMNANf6965J0MG+eTwc5FVTv7KLGLrISi8qBlC5iycRDW3h
         KovxjqOeVt1b5z5YnVskgpCsfjMzH12GpxNBUp5I6nT3F5qPcxWsR1ftxv91u/FzFe
         8n6wiK9H2uhX9pkAQ1S2kP6dZ8O4v2vVA7rU3D+TX850HWt4Z/s/BF2Guyo6Sc669p
         ywYPSzR5FCYC/A/48/AdZn8+HRCBPTq/vd4+4JEnU4cy4Kc6BpfSVAAgSB7rHjpx9W
         f/fJVXyGorxd0PbgHI102nFTUkAp7BGHJpWd2UnSNtRQQyZ3YCfIgk3UJhx87vtVBk
         g20w6BlrZ48tA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/1/2019 8:26 PM, Lucas Stach wrote:
> Am Freitag, den 01.03.2019, 08:45 +0530 schrieb Vidya Sagar:
>> On 3/1/2019 12:32 AM, Lucas Stach wrote:
>>> Am Donnerstag, den 28.02.2019, 20:30 +0530 schrieb Vidya Sagar:
>>>> The PCI host bridge found on Tegra SoCs doesn't require the MSI target
>>>> address to be backed by physical system memory. Writes are intercepted
>>>> within the controller and never make it to the memory pointed to.
>>>>
>>>> Since no actual system memory is required, remove the allocation of a
>>>> single page and hardcode the MSI target address with a special address
>>>> on a per-SoC basis. Ideally this would be an address to an MMIO memory
>>>> region (such as where the controller's register are located). However,
>>>> those addresses don't work reliably across all Tegra generations. The
>>>> only set of addresses that work consistently are those that point to
>>>> external memory.
>>>>
>>>> This is not ideal, since those addresses could technically be used for
>>>> DMA and hence be confusing. However, the first page of external memory
>>>> is unlikely to be used and special enough to avoid confusion.
>>> So you are trading a slight memory waste of a single page against a
>>> sporadic (and probably hard to debug) DMA failure if any device happens
>>> to initiate DMA to the first page of physical memory? That does not
>>> sound like a good deal...
>>>
>>> Also why would the first page of external memory be unlikely to be
>>> used?
>>>
>>> Regards,
>>> Lucas
>> We are not wasting single page of memory here and if any device's DMA is
>> trying to access it, it will still go through. Its just that we are using that
>> same address for MSI (note that MSI writes don't go beyond PCIe IP as they get
>> decoded at PCIe IP level itself and only an interrupt
>> goes to CPU) and that might be a bit confusing as same address is used
>> as normal memory as well as MSI target address. Since there can never be any
>> issue with this would you suggest to remove the last paragraph from commit
>> description?
> How does the core distinguish between a normal DMA memory write and a
> MSI? If I remember the PCIe spec correctly, there aren't any
> differences between the two besides the target address.
>
> So if you now set a non-reserved region of memory to decode as a MSI at
> the PCIe host controller level, wouldn't this lead to normal DMA
> transactions to this address being wrongfully turned into an MSI and
> the write not reaching the targeted location?
>
> Regards,
> Lucas

You are correct that core cannot distinguish between a normal DMA memory and
MSI. In that case, the only way I see is to alloc memory using 
dma_alloc_coherent()
and use the IOVA as the MSI target address. That way, a page gets 
reserved (in a way wasted
also as the MSI writes don't really make it to RAM) and there won't be 
any address
overlaps with normal DMA writes. I'll push a patch for it.

Thanks,
Vidya Sagar

