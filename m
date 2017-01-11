Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:51718 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdAKAhA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2017 19:37:00 -0500
Subject: Re: [PATCH] ACPI/PCI: Fix bus range comparation in pci_mcfg_lookup
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1483513206-113046-1-git-send-email-wangzhou1@hisilicon.com>
 <58730600.3080802@hisilicon.com>
 <CAJZ5v0iv99MB=Eyw=-s=9RhtxhogTNwk0TdLY=gO46GYsRhZqg@mail.gmail.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tomasz Nowicki <tn@semihalf.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        <xuwei5@hisilicon.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <58757DFD.40108@hisilicon.com>
Date: Wed, 11 Jan 2017 08:36:13 +0800
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iv99MB=Eyw=-s=9RhtxhogTNwk0TdLY=gO46GYsRhZqg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/1/10 5:45, Rafael J. Wysocki wrote:
> On Mon, Jan 9, 2017 at 4:39 AM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
>> On 2017/1/4 15:00, Zhou Wang wrote:
>>> The configuration data provided by an MCFG region (ie PCI segment and
>>> bus range) may span multiple host bridges.
>>>
>>> Current code in pci_mcfg_lookup() carries out an exact match of host
>>> bridge bus range start value against the MCFG region(s) bus range start
>>> value which would cause configurations like the following:
>>>
>>> MCFG region:
>>>       bus range: 0x00~0xff.
>>>       segment: 0.
>>>
>>> PCI host bridges configuration (segment numbers and bus ranges):
>>>       host bridge 1:
>>>               bus range: 0x00~0x1f.
>>>               segment: 0.
>>>       host bridge 2:
>>>               bus range: 0x20~0x4f.
>>>               segment: 0.
>>>
>>> to fail, in that the bus range start value for host bridge 2 does
>>> not match the bus range start value of the respective MCFG region.
>>>
>>> Relax the bus range check in pci_mcfg_lookup() to cater for
>>> PCI configurations with multiple host bridges sharing the same
>>> MCFG region.
>>>
>>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>>> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
>>> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> ---
>>>  drivers/acpi/pci_mcfg.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>>> index a6a4cea..2944353 100644
>>> --- a/drivers/acpi/pci_mcfg.c
>>> +++ b/drivers/acpi/pci_mcfg.c
>>> @@ -195,11 +195,10 @@ int pci_mcfg_lookup(struct acpi_pci_root *root, struct resource *cfgres,
>>>               goto skip_lookup;
>>>
>>>       /*
>>> -      * We expect exact match, unless MCFG entry end bus covers more than
>>> -      * specified by caller.
>>> +      * We expect the range in bus_res in the coverage of MCFG bus range.
>>>        */
>>>       list_for_each_entry(e, &pci_mcfg_list, list) {
>>> -             if (e->segment == seg && e->bus_start == bus_res->start &&
>>> +             if (e->segment == seg && e->bus_start <= bus_res->start &&
>>>                   e->bus_end >= bus_res->end) {
>>>                       root->mcfg_addr = e->addr;
>>>               }
>>>
>>
>> Hi Rafael,
>>
>> Could you please look into this patch if you have time?
> 
> Well, it makes sense to me, but this is PCI, so Bjorn has to decide here.
> 
> Thanks,
> Rafael

Many thanks for looking into this patch!

Hi Bjorn,

Please look at this patch if you have time :)

Thanks,
Zhou

> 
> .
> 

