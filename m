Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFC PATCH] ACPI/PCI: Fix bus range comparation in
 pci_mcfg_lookup
To: Tomasz Nowicki <tn@semihalf.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jayachandran C <jchandra@broadcom.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        jorn Helgaas <bhelgaas@google.com>
References: <1482397663-98715-1-git-send-email-wangzhou1@hisilicon.com>
 <b3d00da9-cd88-cd43-370c-b10d93944024@semihalf.com>
CC: <liudongdong3@huawei.com>, <gabriele.paoloni@huawei.com>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <586B69BE.7050009@hisilicon.com>
Date: Tue, 3 Jan 2017 17:07:10 +0800
MIME-Version: 1.0
In-Reply-To: <b3d00da9-cd88-cd43-370c-b10d93944024@semihalf.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/1/3 14:39, Tomasz Nowicki wrote:
> On 22.12.2016 10:07, Zhou Wang wrote:
>> Multiple PCIe host bridges may exists in one PCIe segment. So bus range for each
>> host bridge should be in the coverage of bus range of related PCIe segment.
>>
>> This patch will support this kind of scenario:
>>
>> MCFG:
>>     bus range: 0x00~0xff.
>>     segment: 0.
>> DSDT:
>>     host bridge 1:
>>         bus range: 0x00~0x1f.
>>         segment: 0.
>>     host bridge 2:
>>         bus range: 0x20~0x4f.
>>         segment: 0.
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> ---
>>  drivers/acpi/pci_mcfg.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index b5b376e..46a3e32 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -40,11 +40,10 @@ phys_addr_t pci_mcfg_lookup(u16 seg, struct resource *bus_res)
>>      struct mcfg_entry *e;
>>
>>      /*
>> -     * We expect exact match, unless MCFG entry end bus covers more than
>> -     * specified by caller.
>> +     * We expect the range in bus_res in the coverage of MCFG bus range.
>>       */
>>      list_for_each_entry(e, &pci_mcfg_list, list) {
>> -        if (e->segment == seg && e->bus_start == bus_res->start &&
>> +        if (e->segment == seg && e->bus_start <= bus_res->start &&
>>              e->bus_end >= bus_res->end)
>>              return e->addr;
>>      }
>>
> 
> Looks good to me.
> 
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>

Hi Tomasz,

Thanks for your review.

Regards,
Zhou

> 
> Thanks,
> Tomasz
> 
> .
> 

