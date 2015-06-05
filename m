Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33726 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423461AbbFEPIO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2015 11:08:14 -0400
Received: by qkhg32 with SMTP id g32so41889232qkh.0
        for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2015 08:08:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <557144CF.50500@monstr.eu>
References: <20150604195706.17951.85004.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <557144CF.50500@monstr.eu>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 5 Jun 2015 10:07:52 -0500
Message-ID: <CAErSpo5tGnNpXkN1z_rOzA75CatCvOzOHZt9Fwucj1A2DOPsBQ@mail.gmail.com>
Subject: Re: [PATCH] microblaze/PCI: Remove unused declarations
To: Michal Simek <monstr@monstr.eu>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 5, 2015 at 1:42 AM, Michal Simek <monstr@monstr.eu> wrote:
> Hi Bjorn,
>
> On 06/04/2015 09:57 PM, Bjorn Helgaas wrote:
>> The following declarations were copied from powerpc but are unused on
>> microblaze:
>>
>>   struct pci_controller *init_phb_dynamic(struct device_node *dn)
>>   int remove_phb_dynamic(struct pci_controller *phb)
>>   struct pci_dev *of_create_pci_dev(struct device_node *node, ...)
>>   void of_scan_pci_bridge(struct device_node *node, ...)
>>   void of_scan_bus(struct device_node *node, struct pci_bus *bus)
>>   void of_rescan_bus(struct device_node *node, struct pci_bus *bus)
>>
>> Remove them.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  arch/microblaze/include/asm/pci.h |   12 ------------
>>  1 file changed, 12 deletions(-)
>>
>> diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
>> index 468aca8..b6b5b3c 100644
>> --- a/arch/microblaze/include/asm/pci.h
>> +++ b/arch/microblaze/include/asm/pci.h
>> @@ -102,18 +102,6 @@ extern void pcibios_finish_adding_to_bus(struct pci_bus *bus);
>>
>>  extern void pcibios_resource_survey(void);
>>
>> -extern struct pci_controller *init_phb_dynamic(struct device_node *dn);
>> -extern int remove_phb_dynamic(struct pci_controller *phb);
>> -
>> -extern struct pci_dev *of_create_pci_dev(struct device_node *node,
>> -                                     struct pci_bus *bus, int devfn);
>> -
>> -extern void of_scan_pci_bridge(struct device_node *node,
>> -                             struct pci_dev *dev);
>> -
>> -extern void of_scan_bus(struct device_node *node, struct pci_bus *bus);
>> -extern void of_rescan_bus(struct device_node *node, struct pci_bus *bus);
>> -
>>  extern int pci_bus_find_capability(struct pci_bus *bus,
>>                                               unsigned int devfn, int cap);
>>
>>
>
> I think I should ignore this because you have sent another series where
> this patch is included.

Yeah, sorry, I found several other pieces of cruft after sending this
and wanted to group it all together.
