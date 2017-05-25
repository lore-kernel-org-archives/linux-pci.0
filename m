Return-Path: <SRS0=/K38=47=rock-chips.com=shawn.lin@kernel.org>
Return-Path: <SRS0=/K38=47=rock-chips.com=shawn.lin@kernel.org>
Subject: Re: [PATCH v3] PCI: use IDA to manage domain number if not getting it
 from DT
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1495525511-202465-1-git-send-email-shawn.lin@rock-chips.com>
 <20170524223027.GA7958@bhelgaas-glaptop.roam.corp.google.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Brian Norris <briannorris@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <5a9f53fc-d0e3-4701-6640-e8a34cf95c06@rock-chips.com>
Date: Thu, 25 May 2017 08:38:20 +0800
MIME-Version: 1.0
In-Reply-To: <20170524223027.GA7958@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2017/5/25 6:30, Bjorn Helgaas wrote:
> Hi Shawn,
>
> On Tue, May 23, 2017 at 03:45:11PM +0800, Shawn Lin wrote:

[...]

>> +		domain = pci_get_new_domain_nr(bus);
>
> These comments and logic are too complicated for my puny brain.  Much of
> this was pre-existing, of course.  Surely there's a simpler way?

yup, I think we could simplify the code.

>
> 1) If we're using ACPI, every host bridge must have a _SEG method, and it
> supplies the domain.  We ignore any bridge without _SEG.
>
> 2) If we're using DT, every host bridge must supply "linux,pci-domain", and
> it supplies the domain.  We ignore any bridge without "linux,pci-domain".
>
> 3) Otherwise, we always use IDA.

I plan to create a new function to allocate domain number using IDA as
then we don't touch the logic of of_pci_bus_find_domain_nr, and the
name of of_pci_bus_find_domain_nr explicitly say that the domain number
comes from DT.

Then I could put the condition check inside the pci_bus_find_domain_nr
as your suggested.


Does it looks ok to you?

>
>>  	} else {
>>  		dev_err(parent, "Node %s has inconsistent \"linux,pci-domain\" property in DT\n",

[...]

>>  		pci_remove_bus_device(child);
>> +
>> +	pci_put_old_domain_nr(bus);
>
> In your current patch, ida_domain defaults to true, and it is only set
> to false in of_pci_bus_find_domain_nr(), which is only called when
> ACPI is disabled.  Therefore, ida_domain will be true when we're using
> ACPI, and I think pci_put_old_domain_nr() will erroneously remove
> domains from tha IDA.
>

woops, I forgot to check the ACPI cases.

>>  	pci_remove_bus(bus);
>>  	host_bridge->bus = NULL;
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 33c2b0b..9296e31 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1445,13 +1445,17 @@ static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>>   * configuration space.
>>   */
>>  #ifdef CONFIG_PCI_DOMAINS
>> +extern struct ida __domain_nr;
>>  extern int pci_domains_supported;
>> -int pci_get_new_domain_nr(void);
>> +int pci_get_new_domain_nr(struct pci_bus *bus);
>> +void pci_put_old_domain_nr(struct pci_bus *bus);
>>  #else
>>  enum { pci_domains_supported = 0 };
>>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>>  static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
>> -static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>> +static inline int pci_get_new_domain_nr(struct pci_bus *bus)
>> +{ return -ENOSYS; }
>> +static inline void pci_put_old_domain_nr(struct pci_bus *bus) { }
>>  #endif /* CONFIG_PCI_DOMAINS */
>>
>>  /*
>> --
>> 1.9.1
>>
>>
>
>
>
