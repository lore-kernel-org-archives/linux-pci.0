Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [PATCH V7 03/11] pci, of: Move the PCI I/O space management to
 PCI core code.
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <1462893601-8937-4-git-send-email-tn@semihalf.com>
 <CAJZ5v0ge+LGwp=AkPF50H1ZXFA6J5ByazuY7Opc-aLJwWrBNxg@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Sinan Kaya <okaya@codeaurora.org>, jchandra@broadcom.com,
 robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com,
 David Daney <ddaney@caviumnetworks.com>, wangyijing@huawei.com,
 Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>,
 Mark Salter <msalter@redhat.com>, Linux PCI <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
 Jon Masters <jcm@redhat.com>, andrea.gallo@linaro.org, dhdang@apm.com,
 jeremy.linton@arm.com, liudongdong3@huawei.com,
 Christopher Covington <cov@codeaurora.org>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <5732E11A.9090002@semihalf.com>
Date: Wed, 11 May 2016 09:36:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ge+LGwp=AkPF50H1ZXFA6J5ByazuY7Opc-aLJwWrBNxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 10.05.2016 19:59, Rafael J. Wysocki wrote:
> On Tue, May 10, 2016 at 5:19 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
>> No functional changes in this patch.
>>
>> PCI I/O space mapping code does not depend on OF, therefore it can be
>> moved to PCI core code. This way we will be able to use it
>> e.g. in ACPI PCI code.
>>
>> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Liviu Dudau <Liviu.Dudau@arm.com>
>> ---
>>   drivers/of/address.c       | 116 +--------------------------------------------
>>   drivers/pci/pci.c          | 115 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/of_address.h |   9 ----
>>   include/linux/pci.h        |   5 ++
>>   4 files changed, 121 insertions(+), 124 deletions(-)
>>
>> diff --git a/drivers/of/address.c b/drivers/of/address.c
>> index 91a469d..0a553c0 100644
>> --- a/drivers/of/address.c
>> +++ b/drivers/of/address.c
>> @@ -4,6 +4,7 @@
>>   #include <linux/ioport.h>
>>   #include <linux/module.h>
>>   #include <linux/of_address.h>
>> +#include <linux/pci.h>
>>   #include <linux/pci_regs.h>
>>   #include <linux/sizes.h>
>>   #include <linux/slab.h>
>> @@ -673,121 +674,6 @@ const __be32 *of_get_address(struct device_node *dev, int index, u64 *size,
>>   }
>>   EXPORT_SYMBOL(of_get_address);
>>
>> -#ifdef PCI_IOBASE
>> -struct io_range {
>> -       struct list_head list;
>> -       phys_addr_t start;
>> -       resource_size_t size;
>> -};
>> -
>> -static LIST_HEAD(io_range_list);
>> -static DEFINE_SPINLOCK(io_range_lock);
>> -#endif
>> -
>> -/*
>> - * Record the PCI IO range (expressed as CPU physical address + size).
>> - * Return a negative value if an error has occured, zero otherwise
>> - */
>> -int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
>> -{
>> -       int err = 0;
>> -
>> -#ifdef PCI_IOBASE
>> -       struct io_range *range;
>> -       resource_size_t allocated_size = 0;
>> -
>> -       /* check if the range hasn't been previously recorded */
>> -       spin_lock(&io_range_lock);
>> -       list_for_each_entry(range, &io_range_list, list) {
>> -               if (addr >= range->start && addr + size <= range->start + size) {
>> -                       /* range already registered, bail out */
>> -                       goto end_register;
>> -               }
>> -               allocated_size += range->size;
>> -       }
>> -
>> -       /* range not registed yet, check for available space */
>> -       if (allocated_size + size - 1 > IO_SPACE_LIMIT) {
>> -               /* if it's too big check if 64K space can be reserved */
>> -               if (allocated_size + SZ_64K - 1 > IO_SPACE_LIMIT) {
>> -                       err = -E2BIG;
>> -                       goto end_register;
>> -               }
>> -
>> -               size = SZ_64K;
>> -               pr_warn("Requested IO range too big, new size set to 64K\n");
>> -       }
>> -
>> -       /* add the range to the list */
>> -       range = kzalloc(sizeof(*range), GFP_ATOMIC);
>> -       if (!range) {
>> -               err = -ENOMEM;
>> -               goto end_register;
>> -       }
>> -
>> -       range->start = addr;
>> -       range->size = size;
>> -
>> -       list_add_tail(&range->list, &io_range_list);
>> -
>> -end_register:
>> -       spin_unlock(&io_range_lock);
>> -#endif
>> -
>> -       return err;
>> -}
>> -
>> -phys_addr_t pci_pio_to_address(unsigned long pio)
>> -{
>> -       phys_addr_t address = (phys_addr_t)OF_BAD_ADDR;
>> -
>> -#ifdef PCI_IOBASE
>> -       struct io_range *range;
>> -       resource_size_t allocated_size = 0;
>> -
>> -       if (pio > IO_SPACE_LIMIT)
>> -               return address;
>> -
>> -       spin_lock(&io_range_lock);
>> -       list_for_each_entry(range, &io_range_list, list) {
>> -               if (pio >= allocated_size && pio < allocated_size + range->size) {
>> -                       address = range->start + pio - allocated_size;
>> -                       break;
>> -               }
>> -               allocated_size += range->size;
>> -       }
>> -       spin_unlock(&io_range_lock);
>> -#endif
>> -
>> -       return address;
>> -}
>> -
>> -unsigned long __weak pci_address_to_pio(phys_addr_t address)
>> -{
>> -#ifdef PCI_IOBASE
>> -       struct io_range *res;
>> -       resource_size_t offset = 0;
>> -       unsigned long addr = -1;
>> -
>> -       spin_lock(&io_range_lock);
>> -       list_for_each_entry(res, &io_range_list, list) {
>> -               if (address >= res->start && address < res->start + res->size) {
>> -                       addr = address - res->start + offset;
>> -                       break;
>> -               }
>> -               offset += res->size;
>> -       }
>> -       spin_unlock(&io_range_lock);
>> -
>> -       return addr;
>> -#else
>> -       if (address > IO_SPACE_LIMIT)
>> -               return (unsigned long)-1;
>> -
>> -       return (unsigned long) address;
>> -#endif
>> -}
>> -
>>   static int __of_address_to_resource(struct device_node *dev,
>>                  const __be32 *addrp, u64 size, unsigned int flags,
>>                  const char *name, struct resource *r)
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 25e0327..bc0c914 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3021,6 +3021,121 @@ int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
>>   }
>>   EXPORT_SYMBOL(pci_request_regions_exclusive);
>>
>> +#ifdef PCI_IOBASE
>> +struct io_range {
>> +       struct list_head list;
>> +       phys_addr_t start;
>> +       resource_size_t size;
>> +};
>> +
>> +static LIST_HEAD(io_range_list);
>> +static DEFINE_SPINLOCK(io_range_lock);
>> +#endif
>> +
>> +/*
>> + * Record the PCI IO range (expressed as CPU physical address + size).
>> + * Return a negative value if an error has occured, zero otherwise
>> + */
>> +int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
>> +{
>> +       int err = 0;
>> +
>> +#ifdef PCI_IOBASE
>
> I understand that this moves code around, but those in-function
> #ifdefs aren't nice.  Any chance to get rid of them but putting whole
> functions under the #ifdef?
>

This is a __weak implementation, so assuming I would move #ifdef out of 
function I need to provide another empty __weak stub. I do not know 
which solution is more ugly. In any case we can do that cleanup separately.

Tomasz
