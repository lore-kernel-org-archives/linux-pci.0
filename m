Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [PATCH V8 5/9] pci, acpi: add acpi hook to assign domain number.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-6-git-send-email-tn@semihalf.com>
 <20160608001559.GD4759@localhost>
Cc: arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
 rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com,
 okaya@codeaurora.org, jchandra@broadcom.com,
 robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com,
 ddaney@caviumnetworks.com, wangyijing@huawei.com,
 Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org,
 dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com,
 cov@codeaurora.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <5757F19F.6020200@semihalf.com>
Date: Wed, 8 Jun 2016 12:21:19 +0200
MIME-Version: 1.0
In-Reply-To: <20160608001559.GD4759@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 08.06.2016 02:15, Bjorn Helgaas wrote:
> Hi Tomasz,
>
> On Mon, May 30, 2016 at 05:14:18PM +0200, Tomasz Nowicki wrote:
>> PCI core code provides a config option (CONFIG_PCI_DOMAINS_GENERIC)
>> that allows assigning the PCI bus domain number generically by
>> relying on device tree bindings, and falling back to a simple counter
>> when the respective DT properties (ie "linux,pci-domain") are not
>> specified in the host bridge device tree node.
>>
>> In a similar way, when a system is booted through ACPI, architectures
>> that are selecting CONFIG_PCI_DOMAINS_GENERIC (ie ARM64) require kernel
>> hooks to retrieve the domain number so that the PCI bus domain number
>> set-up can be handled seamlessly with DT and ACPI in generic core code
>> when CONFIG_PCI_DOMAINS_GENERIC is selected.
>>
>> Since currently it is not possible to retrieve a pointer to the PCI
>> host bridge ACPI device backing the host bridge from core PCI code
>> (which would allow retrieving the domain number in an arch agnostic
>> way through the ACPI _SEG method), an arch specific ACPI hook has to
>> be declared and implemented by all arches that rely on
>> CONFIG_PCI_DOMAINS_GENERIC to retrieve the domain number and set it
>> up in core PCI code.
>>
>> For the aforementioned reasons, this patch introduces a dummy
>> acpi_pci_bus_domain_nr() hook in preparation for per-arch implementation
>> of the same to retrieve the domain number on a per-arch basis when
>> the system boots through ACPI.
>>
>> For the sake of code clarity the current code implementing generic
>> domain number assignment (ie pci_bus_assign_domain_nr(), selected by
>> CONFIG_PCI_DOMAINS_GENERIC) is reshuffled so that the code implementing
>> the DT domain assignment function is stubbed out into a corresponding
>> helper, so that DT and ACPI functions are clearly separated in
>> preparation for arches acpi_pci_bus_domain_nr() implementations.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> ---
>>   drivers/pci/pci.c   | 11 +++++++++--
>>   include/linux/pci.h |  1 +
>>   2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index eb431b5..2b52178 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -7,6 +7,7 @@
>>    *	Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
>>    */
>>
>> +#include <linux/acpi.h>
>>   #include <linux/kernel.h>
>>   #include <linux/delay.h>
>>   #include <linux/init.h>
>> @@ -4941,7 +4942,7 @@ int pci_get_new_domain_nr(void)
>>   }
>>
>>   #ifdef CONFIG_PCI_DOMAINS_GENERIC
>> -void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>> +static int of_pci_bus_domain_nr(struct device *parent)
>
> Can we do a little cleanup before this patch?
>
>    - pci_bus_assign_domain_nr() is only used inside drivers/pci, so
>      maybe we move the prototype to drivers/pci/pci.h?

pci_bus_assign_domain_nr() goes with pci_domain_nr() as an option for 
CONFIG_PCI_DOMAINS_GENERIC. pci_domain_nr() is used commonly outside 
drivers/pci so we would need to split these calls then, thus personally 
I think it would be better to keep both in inclue/linux/pci.h

>
>    - I don't really like the style of calling a function that
>      internally assigns bus->domain_nr.  Could we do something like
>      this instead?
>
>      int pci_bus_domain_nr(...)
>      {
>        ...
>        return domain;
>      }
>
>      ... pci_create_root_bus(...)
>      {
>        ...
>        b->domain_nr = pci_bus_domain_nr(...);


We can. I do not see much difference between pci_bus_domain_nr() and 
pci_domain_nr() which we already have so how about calling it 
pci_bus_find_domain_nr instead? Lorenzo, any strong preference for it?

>
> That would be two new patches, if this makes sense.
>
> And this patch would only rename pci_bus_assign_domain_nr() to
> of_pci_bus_domain_nr() and add the pci_bus_domain_nr() wrapper.

Giving that we would keep prototypes in inclue/linux/pci.h

1. First patch would rename pci_bus_assign_domain_nr() to 
pci_bus_find_domain_nr() and it would return domain number so that we 
could do:
      ... pci_create_root_bus(...)
      {
        ...
        b->domain_nr = pci_bus_domain_nr(...);
        ...
      }

2. Second patch would transform pci_bus_find_domain_nr() to be the 
wrapper for of_pci_bus_domain_nr()

3. Third patch would add stub definition, the ARM64 definition and the 
new call acpi_pci_bus_domain_nr() in pci_bus_find_domain_nr() wrapper.

Does this plan sound reasonable?

>
>>   {
>>   	static int use_dt_domains = -1;
>>   	int domain = -1;
>> @@ -4985,7 +4986,13 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>>   		domain = -1;
>>   	}
>>
>> -	bus->domain_nr = domain;
>> +	return domain;
>> +}
>> +
>> +void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>> +{
>> +	bus->domain_nr = acpi_disabled ? of_pci_bus_domain_nr(parent) :
>> +					 acpi_pci_bus_domain_nr(bus);
>>   }
>>   #endif
>>   #endif
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 12349de..bba4053 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1390,6 +1390,7 @@ static inline int pci_domain_nr(struct pci_bus *bus)
>>   {
>>   	return bus->domain_nr;
>>   }
>> +static inline int acpi_pci_bus_domain_nr(struct pci_bus *bus) { return -1; }
>
> I would split the addition of acpi_pci_bus_domain_nr() to a separate
> patch and include the ARM64 definition in that same patch.  That patch
> would only add this stub definition, the ARM64 definition, and the new
> call in pci_bus_domain_nr().

OK

Thanks,
Tomasz
