Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34374 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419AbbJTWQq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Oct 2015 18:16:46 -0400
MIME-Version: 1.0
In-Reply-To: <20151020215714.GI8224@localhost>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	<1444340359-8011-4-git-send-email-yinghai@kernel.org>
	<20151020215714.GI8224@localhost>
Date: Tue, 20 Oct 2015 15:16:45 -0700
Message-ID: <CAE9FiQVC+r=7NrCvwq9+1XVQD9CGf_3+-4VO9kFPSGqMTR5cBw@mail.gmail.com>
Subject: Re: [PATCH v7 03/60] sparc/PCI: Unify pci_register_region()
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 20, 2015 at 2:57 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Oct 08, 2015 at 02:38:22PM -0700, Yinghai Lu wrote:
>> We register regions for legacy and iommu and all have open code.
>>
>> Unify them to pci_register_region() and call it accordingly.
>>
>> +     if (!mem_res->flags)
>>               return;
>>
>> -     p->name = "Video RAM area";
>> -     p->start = mem_res->start + 0xa0000UL;
>> -     p->end = p->start + 0x1ffffUL;
>> -     p->flags = IORESOURCE_BUSY;
>> -     request_resource(mem_res, p);
>> +     mem_rstart = mem_res->start - offset;
>> +     mem_rend = mem_res->end - offset;
>
> This is essentially doing pcibios_bus_to_resource(), except in an
> unnecessarily arch-dependent way.  Can you rework it to use
> pcibios_bus_to_resource()?  I think you'll have to do
> pci_register_legacy_regions() in pci_scan_one_pbm() instead of in
> pci_determine_mem_io_space(), so that you have a struct pci_bus to
> use, but your next patch does that anyway.
>
>>
>> -     p = kzalloc(sizeof(*p), GFP_KERNEL);
>> -     if (!p)
>> +     /* contain checking */
>> +     if (!(mem_rstart <= rstart && mem_rend >= rend))
>>               return;

Difference is here.

pcibios_bus_to_resource() would return resource even region is not contained.

>> +     res->name = name;
>> +     res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>> +     res->start = rstart + offset;
>> +     res->end = rend + offset;
>> +     conflict = request_resource_conflict(mem_res, res);
>> +     if (conflict) {
>> +             printk(KERN_DEBUG "PCI: %s can't claim %s %pR: address conflict with %s %pR\n",
>> +                     pbm->name, res->name, res, conflict->name, conflict);
>> +             kfree(res);
>> +     }

also we will need to get parent resource to use request_resource_conflict.

otherwise we need to use insert_resource(), but that will prevent driver to use
the resource.

        Yinghai
