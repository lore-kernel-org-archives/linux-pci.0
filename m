Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9396AC43387
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 23:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053A2206A2
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 23:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeLNXdn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:33:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59734 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbeLNXdn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 18:33:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6227EBD;
        Fri, 14 Dec 2018 15:33:42 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 201D33F59C;
        Fri, 14 Dec 2018 15:33:40 -0800 (PST)
Subject: Re: [PATCH v9 6/6] PCI: Stub out pci_request_acs() when CONFIG_PCI is
 not set
To:     Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>
References: <20181214163319.27479-1-okaya@kernel.org>
 <20181214163319.27479-7-okaya@kernel.org> <20181214222601.GH20725@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c4c4151c-131b-9a97-257a-c4ffb2589b61@arm.com>
Date:   Fri, 14 Dec 2018 23:33:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181214222601.GH20725@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2018-12-14 10:26 pm, Bjorn Helgaas wrote:
> [+cc Lorenzo, Robin, Logan]
> 
> On Fri, Dec 14, 2018 at 04:33:19PM +0000, Sinan Kaya wrote:
>> ACPI IORT table code relies on pci_request_acs() to be present. Define
>> a stub function when CONFI_PCI is not set.
> 
> This doesn't seem like the simplest approach to me, but I probably
> don't understand what's going on in IORT.
> 
> It looks like *all* of iort_enable_acs() (the caller of
> pci_request_acs()) is PCI-specific; at least, the whole thing is
> wrapped in a test for ACPI_IORT_NODE_PCI_ROOT_COMPLEX.  So the whole
> function could be wrapped in #ifdef CONFIG_PCI.
> 
> Here's the caller of iort_enable_acs():
> 
>    iort_init_platform_devices
>      acs_enabled = false
>      for (i = 0; i < iort->node_count; i++) {
>        if (!acs_enabled)
>          acs_enabled = iort_enable_acs(iort_node);
> 
> It seems like the acs_enabled state could be encapsulated inside
> iort_enable_acs().

It could, but with the tiny disadvantage of having to allocate static 
storage for it to maintain the "don't bother checking if we want ACS if 
we've already requested it once" logic for multiple root complexes.

> Today pci_request_acs() is a system-wide thing, but I don't know why
> that's the case.  Isn't it conceivable that different PCI hierarchies
> could have different ACS policies, e.g., because of P2P DMA or
> something?

I can certainly imagine systems using entirely separate PCI domains for, 
say, expansion slots vs. on-board/on-chip devices, where the former may 
be expected to be assigned to VMs or userspace drivers and the latter 
only ever controlled by the host kernel. Not forcing ACS overhead upon 
the "non-virtualisable" (or "trusted" vs. "untrusted") domain could 
perhaps be beneficial in some cases.

> Bottom line, pci_request_acs() is being called from what looks like
> PCI-specific code in IORT, and it would make more sense to me to prune
> out that code in IORT than to make a stub pci_request_acs().

Agreed - without CONFIG_PCI the whole of iort_enable_acs() may as well 
be stubbed out, because it won't achieve anything anyway. The 
implication is that if we have a root complex whose inbound DMA is 
controlled by an SMMU, we should enable ACS to make VFIO useful (or in 
case we want to enforce strict DMA isolation in general), but if Linux 
is never going to touch any PCI devices there's no point even looking at 
the RC node(s). TBH I'm pretty dubious about having IORT at all without 
PCI, but I suppose there could potentially be embedded SoCs which have 
an ITS and platform MSIs, or use an SMMU for their video/display 
subsystem, and for some reason demand ACPI-based firmware.

Robin.

>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>> ---
>>   include/linux/pci.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 51a5a5217667..f0f2f55ea93c 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -2101,7 +2101,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
>>   	return NULL;
>>   }
>>   
>> +#ifdef CONFIG_PCI
>>   void pci_request_acs(void);
>> +#else
>> +static inline void pci_request_acs(void) {}
>> +#endif
>>   bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
>>   bool pci_acs_path_enabled(struct pci_dev *start,
>>   			  struct pci_dev *end, u16 acs_flags);
>> -- 
>> 2.19.0
>>
