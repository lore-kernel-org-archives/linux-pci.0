Return-Path: <SRS0=AoHJ=7R=rock-chips.com=shawn.lin@kernel.org>
Return-Path: <SRS0=AoHJ=7R=rock-chips.com=shawn.lin@kernel.org>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5] PCI: use IDA to manage domain number if not getting it
 from DT
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1498523473-157373-1-git-send-email-shawn.lin@rock-chips.com>
 <20170811211738.GH17039@bhelgaas-glaptop.roam.corp.google.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <10d14bca-660a-4d0b-1885-c873c4725028@rock-chips.com>
Date: Tue, 15 Aug 2017 15:01:48 +0800
MIME-Version: 1.0
In-Reply-To: <20170811211738.GH17039@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=gbk; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2017/8/12 5:17, Bjorn Helgaas wrote:
> [+cc Lorenzo, resending because I fat-fingered the cc line and subject]
> 
> On Tue, Jun 27, 2017 at 08:31:13AM +0800, Shawn Lin wrote:
>> If not getting domain number from DT, the domain number will
>> keep increasing once doing unbind/bind RC drivers. This could
>> introduce pointless tree view of lspci as shows below:
>>
>> -+-[0001:00]---00.0-[01]----00.0
>>    \-[0000:00]-
>>
>> The more test we do, the lengthier it would be. The more serious
>> issue is that if attaching two hierarchies for two different domains
>> belonging to two root bridges, so when doing unbind/bind test for one
>> of them and keep the other, then the domain number would finally
>> overflow and make the two hierarchies of devices share the some domain
>> number but actually they shouldn't. So it looks like we need to invent
>> a new indexing ID mechanism to manage domain number. This patch
>> introduces idr to achieve our purpose.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> The "use_dt_domains" logic in of_pci_bus_find_domain_nr() is fairly
> obtuse.  I *think*, now that we have pci_scan_root_bus_bridge() due to
> Lorenzo's excellent work, the time is ripe for moving the domain
> number from arch-specific places into struct pci_host_bridge.
> 
> I suspect that will end up simplifying the CONFIG_PCI_DOMAINS vs
> CONFIG_PCI_DOMAINS_GENERIC situation, and I wonder whether it might
> enable some simplification of of_pci_bus_find_domain_nr() as well,
> which in turn, might make *this* patch simpler.
> 
> This isn't that big a patch to begin with, so I could apply it as-is
> and we could do more domain cleanup later.  It's just that it's
> intertwined with the PCI_DOMAINS #ifdefs and maybe there's an
> opportunity to make this story more readable if those are out of the
> way.  Any thoughts?

That sounds good to me that aftering add IDA domain, we could start
considering moving domain number from arch-specific places into the
bridge code and may be could also finally remove the macro
CONFIG_PCI_DOMAIN* both?

> 
>> ---
>>
>> Changes in v5:
>> - fix Bjorn's comments for v3 as actually I didn't address his comments
>>    for v3 when posted my v4.
>>    v3: https://patchwork.kernel.org/patch/9742003/
>>    For ACPI case, we never use DT or IDA to get domain numbers and
>>    acpi_pci_bus_find_domain_nr would return the proper value we need
>>    whether _SEG exist or not. For DT or IDA, we hope bridges use one of
>>    them consistently, and this is actually what the pre-existing code
>>    did. So I remove ida_domain now since it complicated the logic of the
>>    code and we could just make use_dt_domains global instead to slightly
>>    achieve our purpose.
>>
>> Changes in v4:
>> - make domain_nr depends on CONFIG_PCI_DOMAINS instead of
>> CONFIG_PCI_DOMAINS_GENERIC.
>>
>> Changes in v3:
>> - make ida_domain a system-wide property and check it in the code to
>> combine with use_dt_domains. Also update the comment there.
>>
>> Changes in v2:
>> - add a remove wrapper
>> - rename use_dt_domains to ida_domain and set this bit
>> in pci_get_new_domain_nr and test it in the remove wrapper.
>>
>>   drivers/pci/pci.c    | 13 ++++++++++---
>>   drivers/pci/remove.c |  2 ++
>>   include/linux/pci.h  |  7 +++++--
>>   3 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b58a6b3..9953eaf 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/delay.h>
>>   #include <linux/dmi.h>
>> +#include <linux/idr.h>
>>   #include <linux/init.h>
>>   #include <linux/of.h>
>>   #include <linux/of_pci.h>
>> @@ -5305,17 +5306,23 @@ static void pci_no_domains(void)
>>   }
>>   
>>   #ifdef CONFIG_PCI_DOMAINS
>> -static atomic_t __domain_nr = ATOMIC_INIT(-1);
>> +static DEFINE_IDA(__domain_nr);
>>   
>>   int pci_get_new_domain_nr(void)
>>   {
>> -	return atomic_inc_return(&__domain_nr);
>> +	return ida_simple_get(&__domain_nr, 0, sizeof(u64), GFP_KERNEL);
>> +}
>> +
>> +static int use_dt_domains = -1;
>> +void pci_put_domain_nr(struct pci_bus *bus)
>> +{
>> +	if (acpi_disabled && use_dt_domains != 1)
>> +		ida_simple_remove(&__domain_nr, bus->domain_nr);
>>   }
>>   
>>   #ifdef CONFIG_PCI_DOMAINS_GENERIC
>>   static int of_pci_bus_find_domain_nr(struct device *parent)
>>   {
>> -	static int use_dt_domains = -1;
>>   	int domain = -1;
>>   
>>   	if (parent)
>> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
>> index 73a03d3..01dd1b4 100644
>> --- a/drivers/pci/remove.c
>> +++ b/drivers/pci/remove.c
>> @@ -157,6 +157,8 @@ void pci_remove_root_bus(struct pci_bus *bus)
>>   	list_for_each_entry_safe(child, tmp,
>>   				 &bus->devices, bus_list)
>>   		pci_remove_bus_device(child);
>> +
>> +	pci_put_domain_nr(bus);
>>   	pci_remove_bus(bus);
>>   	host_bridge->bus = NULL;
>>   
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 18cc70a..d6be9596 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -523,7 +523,7 @@ struct pci_bus {
>>   	unsigned char	primary;	/* number of primary bridge */
>>   	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
>>   	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
>> -#ifdef CONFIG_PCI_DOMAINS_GENERIC
>> +#ifdef CONFIG_PCI_DOMAINS
>>   	int		domain_nr;
>>   #endif
>>   
>> @@ -1466,11 +1466,14 @@ static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>>   #ifdef CONFIG_PCI_DOMAINS
>>   extern int pci_domains_supported;
>>   int pci_get_new_domain_nr(void);
>> +void pci_put_domain_nr(struct pci_bus *bus);
>>   #else
>>   enum { pci_domains_supported = 0 };
>>   static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>>   static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
>> -static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>> +static inline int pci_get_new_domain_nr(void)
>> +{ return -ENOSYS; }
>> +static inline void pci_put_domain_nr(struct pci_bus *bus) { }
>>   #endif /* CONFIG_PCI_DOMAINS */
>>   
>>   /*
>> -- 
>> 1.9.1
>>
>>
> 
> 
> 
