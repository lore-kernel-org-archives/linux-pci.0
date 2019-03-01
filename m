Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CD9C43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 03:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39723218B0
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 03:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cKjhPGt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfCADP3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:15:29 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17478 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfCADP3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2019 22:15:29 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c78a3c90000>; Thu, 28 Feb 2019 19:15:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Feb 2019 19:15:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Feb 2019 19:15:27 -0800
Received: from [10.25.72.36] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 1 Mar
 2019 03:15:23 +0000
Subject: Re: [PATCH] PCI: tegra: Do not allocate MSI target memory
To:     Lucas Stach <dev@lynxeye.de>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <treding@nvidia.com>,
        <swarren@nvidia.com>, <mperttunen@nvidia.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>
References: <1551366004-32547-1-git-send-email-vidyas@nvidia.com>
 <247102e57e067d1477f3260bdeaa3ea011d0f3ed.camel@lynxeye.de>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <8b6f53c4-ac39-40d6-0979-86137236f890@nvidia.com>
Date:   Fri, 1 Mar 2019 08:45:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <247102e57e067d1477f3260bdeaa3ea011d0f3ed.camel@lynxeye.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551410122; bh=TW41oyemMg48UUwOxFuJ6u874h0+Nf0tN7eG03qPnIY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=cKjhPGt77XWVQZEPG4R8oHDTcZUsLlmvA0FOEkcyhHG434DCHDp1FsUFeMY+qjmrT
         bcokLfD0+k3WEHUVauKTzK6l65fyeMT81SxqYGbRmkT1zJwc7YoGKbJecE/I34mSiZ
         DCJA2+OnzYMHayzR9IT3+tdiw7/nIsJ++Rq841wMncvfO+s4cKBeVpH/xzuobR/62q
         eu07G1bsZRS9i1W+BNnnN/iXhg1KhZbQ6Ga6BOEPlGp93qIwfLpPWSqoT5FbEqvY4C
         0zkxs9lJ9/K/K4x1BqKEjxYjxGDpM9ZX9gXUSAWteeqH+ldj90frD79zx4OTzqh12O
         cdtkte57djJIA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/1/2019 12:32 AM, Lucas Stach wrote:
> Am Donnerstag, den 28.02.2019, 20:30 +0530 schrieb Vidya Sagar:
>> The PCI host bridge found on Tegra SoCs doesn't require the MSI target
>> address to be backed by physical system memory. Writes are intercepted
>> within the controller and never make it to the memory pointed to.
>>
>> Since no actual system memory is required, remove the allocation of a
>> single page and hardcode the MSI target address with a special address
>> on a per-SoC basis. Ideally this would be an address to an MMIO memory
>> region (such as where the controller's register are located). However,
>> those addresses don't work reliably across all Tegra generations. The
>> only set of addresses that work consistently are those that point to
>> external memory.
>>
>> This is not ideal, since those addresses could technically be used for
>> DMA and hence be confusing. However, the first page of external memory
>> is unlikely to be used and special enough to avoid confusion.
> So you are trading a slight memory waste of a single page against a
> sporadic (and probably hard to debug) DMA failure if any device happens
> to initiate DMA to the first page of physical memory? That does not
> sound like a good deal...
>
> Also why would the first page of external memory be unlikely to be
> used?
>
> Regards,
> Lucas

We are not wasting single page of memory here and if any device's DMA is 
trying to

access it, it will still go through. Its just that we are using that 
same address for MSI (note that

MSI writes don't go beyond PCIe IP as they get decoded at PCIe IP level 
itself and only an interrupt

goes to CPU) and that might be a bit confusing as same address is used 
as normal memory as well

as MSI target address. Since there can never be any issue with this, 
would you suggest to

remove the last paragraph from commit description?

>> Original base patch was posted by Thierry Reding <treding@nvidia.com>
>> ( http://patchwork.ozlabs.org/patch/848569/ )
>> Current patch removes hardcoding of external RAM starting address instead
>> gets it using memblock_start_of_DRAM() API
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/controller/pci-tegra.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index f4f53d092e00..b33de7c78425 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/irqdomain.h>
>>   #include <linux/kernel.h>
>>   #include <linux/init.h>
>> +#include <linux/memblock.h>
>>   #include <linux/module.h>
>>   #include <linux/msi.h>
>>   #include <linux/of_address.h>
>> @@ -231,9 +232,8 @@ struct tegra_msi {
>>   	struct msi_controller chip;
>>   	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
>>   	struct irq_domain *domain;
>> -	unsigned long pages;
>>   	struct mutex lock;
>> -	u64 phys;
>> +	phys_addr_t phys;
>>   	int irq;
>>   };
>>   
>> @@ -1548,9 +1548,7 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
>>   		goto err;
>>   	}
>>   
>> -	/* setup AFI/FPCI range */
>> -	msi->pages = __get_free_pages(GFP_KERNEL, 0);
>> -	msi->phys = virt_to_phys((void *)msi->pages);
>> +	msi->phys = memblock_start_of_DRAM();
>>   	host->msi = &msi->chip;
>>   
>>   	return 0;
>> @@ -1592,8 +1590,6 @@ static void tegra_pcie_msi_teardown(struct tegra_pcie *pcie)
>>   	struct tegra_msi *msi = &pcie->msi;
>>   	unsigned int i, irq;
>>   
>> -	free_pages(msi->pages, 0);
>> -
>>   	if (msi->irq > 0)
>>   		free_irq(msi->irq, pcie);
>>   
