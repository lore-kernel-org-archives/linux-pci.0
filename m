Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ffaf1c82-3738-86fd-8bc9-f76299f99a79@huawei.com>
References: <1518543933-22456-1-git-send-email-john.garry@huawei.com>
 <1518543933-22456-5-git-send-email-john.garry@huawei.com> <20180213225721.GA22219@xps13.dannf>
 <ffaf1c82-3738-86fd-8bc9-f76299f99a79@huawei.com>
From: dann frazier <dann.frazier@canonical.com>
Date: Wed, 14 Feb 2018 09:05:08 -0700
Message-ID: <CALdTtnuWw_Ao_veyd1syO+2af4g1h+WCn+LD3iO3JqBV1bA9Tg@mail.gmail.com>
Subject: Re: [PATCH v13 4/9] PCI: Apply the new generic I/O management on PCI
 IO hosts
To: John Garry <john.garry@huawei.com>
Cc: mika.westerberg@linux.intel.com,
        Rafael Wysocki <rafael@kernel.org>, lorenzo.pieralisi@arm.com,
        rjw@rjwysocki.net, Hanjun Guo <hanjun.guo@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>, olof@lixom.net,
        andy.shevchenko@gmail.com, robh@kernel.org, joe@perches.com,
        benh@kernel.crashing.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linuxarm@huawei.com, Corey Minyard <minyard@acm.org>,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 14, 2018 at 8:42 AM, John Garry <john.garry@huawei.com> wrote:
> On 13/02/2018 22:57, dann frazier wrote:
>>
>> On Wed, Feb 14, 2018 at 01:45:28AM +0800, John Garry wrote:
>>>
>>> From: Zhichang Yuan <yuanzhichang@hisilicon.com>
>>>
>>> After introducing the new generic I/O space management in logic pio, the
>>> original PCI MMIO relevant helpers need to be updated based on the new
>>> interfaces.
>>> This patch adapts the corresponding code to match the changes introduced
>>> by logic pio.
>>>
>>> Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>        #earlier draft
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>>
>> I saw that Bjorn Acked this back in v6, but it seems like the code in
>> pci.c was reworked a bit for v7 onwards and I didn't see a follow-up
>> review (apologies if I just missed it). In which case, maybe his Ack
>> should have the "#earlier draft" tag as well?
>>
>
> Hi Dann,
>
> I see Bjorn acked again later on in the series, here:
> https://lkml.org/lkml/2017/5/26/612

Yep, you're right, sorry for missing that :)

>
>>> ---
>>>  drivers/pci/pci.c        | 95
>>> +++++++++---------------------------------------
>>>  include/asm-generic/io.h |  2 +-
>>>  2 files changed, 18 insertions(+), 79 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 07290a3..8aa5c54 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -22,6 +22,7 @@
>>>  #include <linux/spinlock.h>
>>>  #include <linux/string.h>
>>>  #include <linux/log2.h>
>>> +#include <linux/logic_pio.h>
>>>  #include <linux/pci-aspm.h>
>>>  #include <linux/pm_wakeup.h>
>>>  #include <linux/interrupt.h>
>>> @@ -3440,17 +3441,6 @@ int pci_request_regions_exclusive(struct pci_dev
>>> *pdev, const char *res_name)
>>>  }
>>>  EXPORT_SYMBOL(pci_request_regions_exclusive);
>>>
>>> -#ifdef PCI_IOBASE
>>> -struct io_range {
>>> -       struct list_head list;
>>> -       phys_addr_t start;
>>> -       resource_size_t size;
>>> -};
>>> -
>>> -static LIST_HEAD(io_range_list);
>>> -static DEFINE_SPINLOCK(io_range_lock);
>>> -#endif
>>> -
>>>  /*
>>>   * Record the PCI IO range (expressed as CPU physical address + size).
>>>   * Return a negative value if an error has occured, zero otherwise
>>> @@ -3458,51 +3448,28 @@ struct io_range {
>>>  int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t
>>> addr,
>>>                         resource_size_t size)
>>>  {
>>> -       int err = 0;
>>> -
>>> +       int ret = 0;
>>>  #ifdef PCI_IOBASE
>>> -       struct io_range *range;
>>> -       resource_size_t allocated_size = 0;
>>> -
>>> -       /* check if the range hasn't been previously recorded */
>>> -       spin_lock(&io_range_lock);
>>> -       list_for_each_entry(range, &io_range_list, list) {
>>> -               if (addr >= range->start && addr + size <= range->start +
>>> size) {
>>> -                       /* range already registered, bail out */
>>> -                       goto end_register;
>>> -               }
>>> -               allocated_size += range->size;
>>> -       }
>>> +       struct logic_pio_hwaddr *range;
>>>
>>> -       /* range not registed yet, check for available space */
>>> -       if (allocated_size + size - 1 > IO_SPACE_LIMIT) {
>>> -               /* if it's too big check if 64K space can be reserved */
>>> -               if (allocated_size + SZ_64K - 1 > IO_SPACE_LIMIT) {
>>> -                       err = -E2BIG;
>>> -                       goto end_register;
>>> -               }
>>> -
>>> -               size = SZ_64K;
>>> -               pr_warn("Requested IO range too big, new size set to
>>> 64K\n");
>>> -       }
>>> +       if (!size || addr + size < addr)
>>> +               return -EINVAL;
>>>
>>> -       /* add the range to the list */
>>>         range = kzalloc(sizeof(*range), GFP_ATOMIC);
>>> -       if (!range) {
>>> -               err = -ENOMEM;
>>> -               goto end_register;
>>> -       }
>>> +       if (!range)
>>> +               return -ENOMEM;
>>>
>>> -       range->start = addr;
>>> +       range->fwnode = fwnode;
>>>         range->size = size;
>>> +       range->hw_start = addr;
>>> +       range->flags = PIO_CPU_MMIO;
>>>
>>> -       list_add_tail(&range->list, &io_range_list);
>>> -
>>> -end_register:
>>> -       spin_unlock(&io_range_lock);
>>> +       ret = logic_pio_register_range(range);
>>> +       if (ret)
>>> +               kfree(range);
>>>  #endif
>>>
>>> -       return err;
>>> +       return ret;
>>>  }
>>>
>>>  phys_addr_t pci_pio_to_address(unsigned long pio)
>>> @@ -3510,21 +3477,10 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
>>>         phys_addr_t address = (phys_addr_t)OF_BAD_ADDR;
>>>
>>>  #ifdef PCI_IOBASE
>>> -       struct io_range *range;
>>> -       resource_size_t allocated_size = 0;
>>> -
>>> -       if (pio > IO_SPACE_LIMIT)
>>> +       if (pio >= MMIO_UPPER_LIMIT)
>>>                 return address;
>>>
>>> -       spin_lock(&io_range_lock);
>>> -       list_for_each_entry(range, &io_range_list, list) {
>>> -               if (pio >= allocated_size && pio < allocated_size +
>>> range->size) {
>>> -                       address = range->start + pio - allocated_size;
>>> -                       break;
>>> -               }
>>> -               allocated_size += range->size;
>>> -       }
>>> -       spin_unlock(&io_range_lock);
>>> +       address = logic_pio_to_hwaddr(pio);
>>>  #endif
>>>
>>>         return address;
>>> @@ -3533,25 +3489,8 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
>>>  unsigned long __weak pci_address_to_pio(phys_addr_t address)
>>>  {
>>>  #ifdef PCI_IOBASE
>>> -       struct io_range *res;
>>> -       resource_size_t offset = 0;
>>> -       unsigned long addr = -1;
>>> -
>>> -       spin_lock(&io_range_lock);
>>> -       list_for_each_entry(res, &io_range_list, list) {
>>> -               if (address >= res->start && address < res->start +
>>> res->size) {
>>> -                       addr = address - res->start + offset;
>>> -                       break;
>>> -               }
>>> -               offset += res->size;
>>> -       }
>>> -       spin_unlock(&io_range_lock);
>>> -
>>> -       return addr;
>>> +       return logic_pio_trans_cpuaddr(address);
>>>  #else
>>> -       if (address > IO_SPACE_LIMIT)
>>> -               return (unsigned long)-1;
>>> -
>>
>>
>> Why is this check now safe to drop in the !PCI_IOBASE case?
>
>
> So I have been studying the (long) patchset history and I don't see the
> reason for removing this check, and I think it can be reinstated.
>
> The address and pio are analogous here, and pio should not exceed the IO
> space limit, so just a safety check.

Sounds good.

 -dann

>>
>>   -dann
>>
>>>         return (unsigned long) address;
>>>  #endif
>>>  }
>>> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
>>> index b7996a79..5a59931 100644
>>> --- a/include/asm-generic/io.h
>>> +++ b/include/asm-generic/io.h
>>> @@ -901,7 +901,7 @@ static inline void iounmap(void __iomem *addr)
>>>  #define ioport_map ioport_map
>>>  static inline void __iomem *ioport_map(unsigned long port, unsigned int
>>> nr)
>>>  {
>
>
> Thanks,
> John
>
>>> -       return PCI_IOBASE + (port & IO_SPACE_LIMIT);
>>> +       return PCI_IOBASE + (port & MMIO_UPPER_LIMIT);
>>>  }
>>>  #endif
>>>
>>
>> .
>>
>
>
