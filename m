Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4FA22208.6070003@huawei.com>
References: <1333988568-11282-1-git-send-email-jiang.liu@huawei.com>
 <1333988568-11282-4-git-send-email-jiang.liu@huawei.com> <CAErSpo4S9V8fUJcbBHL4CPGzcVW768KiGsALdG78xD85feEvKw@mail.gmail.com>
 <4FA22208.6070003@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 3 May 2012 10:34:14 -0600
Message-ID: <CAErSpo5R3-FQT9LmiPLmsTUrwxvASaWQUdEVpOqvLQ6Qme_g_Q@mail.gmail.com>
Subject: Re: [PATCH V2 3/6] PCI, x86: use RCU list to protect mmconfig list
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Keping Chen <chenkeping@huawei.com>, x86@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 3, 2012 at 12:13 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
> Hi Bjorn,
>        Thanks for your comments!
>        I have thought about using pci_config_lock to serialize
> access to the pci_mmcfg_list, but that may hurt MMCFG on x86_64
> systems because mmconfig_64.c supports concurrent access to
> the MMCFG space without holding the pci_config_lock. So I use
> RCU to avoid possible performance penalty for x86_64 systems.

Oh, right.  I only looked at mmconfig_32.c, which uses the lock, and
assumed _64.c was the same.  I think you're right to avoid introducing
locking where we didn't have it before.

>        There are two mechanisms to protect list_add_sorted()
> from concurrent updates. The first case is, list_add_sorted()
> may be called without holding any lock for serialization at
> early booting stages because the system is still in single-threaded
> mode. The second case is, pci_config_lock is used to serialize
> concurrent modification to the pci_mmcfg_list if list_add_sorted()
> is called at runtime.
>        The first case is cover by this patch, and the second case
> is covered by "[PATCH V2 5/6] PCI, x86: introduce
> pci_mmconfig_insert()/delete() for PCI root bridge hotplug".

How hard would it be to convert the first (early boot) mechanism to
use the second mechanism?  It'd be nicer if there were only one path
that we use both places, even if it means the early boot path acquires
a lock that is technically unnecessary.

> On 2012-5-3 6:31, Bjorn Helgaas wrote:
>>
>> On Mon, Apr 9, 2012 at 10:22 AM, Jiang Liu<liuj97@gmail.com>  wrote:
>>>
>>> Use RCU list to protect mmconfig list from dynamic change
>>> when supporting PCI host bridge hotplug.
>>
>>
>> I'm not convinced this is safe.  But I'm not an RCU expert, so maybe
>> you can convince me :)
>>
>> Documentation/RCU/checklist.txt says the update code still requires
>> mutual exclusion, and I don't see any in list_add_sorted() or its
>> callers.
>>
>> MMCONFIG accesses are already protected by the pci_config_lock
>> spinlock, so I don't think the performance advantages of RCU really
>> gain us anything in this situation.
>>
>> It would definitely be simpler to just hold pci_config_lock while
>> updating and searching the pci_mmcfg_list, but if there are issues
>> with that, you can educate me about what they are and why this RCU
>> code is correct.
>>
>> Bjorn
>>
>>> Signed-off-by: Jiang Liu<jiang.liu@huawei.com>
>>> ---
>>>  arch/x86/pci/mmconfig-shared.c |   11 ++++++-----
>>>  arch/x86/pci/mmconfig_32.c     |   13 +++++++++++--
>>>  arch/x86/pci/mmconfig_64.c     |   13 +++++++++++--
>>>  3 files changed, 28 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/x86/pci/mmconfig-shared.c
>>> b/arch/x86/pci/mmconfig-shared.c
>>> index 5e2cd2a..3bcc361 100644
>>> --- a/arch/x86/pci/mmconfig-shared.c
>>> +++ b/arch/x86/pci/mmconfig-shared.c
>>> @@ -17,6 +17,7 @@
>>>  #include<linux/bitmap.h>
>>>  #include<linux/dmi.h>
>>>  #include<linux/slab.h>
>>> +#include<linux/rculist.h>
>>>  #include<asm/e820.h>
>>>  #include<asm/pci_x86.h>
>>>  #include<asm/acpi.h>
>>> @@ -45,20 +46,20 @@ static __init void free_all_mmcfg(void)
>>>                pci_mmconfig_remove(cfg);
>>>  }
>>>
>>> -static __init void list_add_sorted(struct pci_mmcfg_region *new)
>>> +static __devinit void list_add_sorted(struct pci_mmcfg_region *new)
>>>  {
>>>        struct pci_mmcfg_region *cfg;
>>>
>>>        /* keep list sorted by segment and starting bus number */
>>> -       list_for_each_entry(cfg,&pci_mmcfg_list, list) {
>>> +       list_for_each_entry_rcu(cfg,&pci_mmcfg_list, list) {
>>>
>>>                if (cfg->segment>  new->segment ||
>>>                    (cfg->segment == new->segment&&
>>>                     cfg->start_bus>= new->start_bus)) {
>>> -                       list_add_tail(&new->list,&cfg->list);
>>> +                       list_add_tail_rcu(&new->list,&cfg->list);
>>>                        return;
>>>                }
>>>        }
>>> -       list_add_tail(&new->list,&pci_mmcfg_list);
>>> +       list_add_tail_rcu(&new->list,&pci_mmcfg_list);
>>>  }
>>>
>>>  static __devinit struct pci_mmcfg_region *pci_mmconfig_alloc(int
>>> segment,
>>> @@ -111,7 +112,7 @@ struct pci_mmcfg_region *pci_mmconfig_lookup(int
>>> segment, int bus)
>>>  {
>>>        struct pci_mmcfg_region *cfg;
>>>
>>> -       list_for_each_entry(cfg,&pci_mmcfg_list, list)
>>> +       list_for_each_entry_rcu(cfg,&pci_mmcfg_list, list)
>>>
>>>                if (cfg->segment == segment&&
>>>                    cfg->start_bus<= bus&&  bus<= cfg->end_bus)
>>>
>>>                        return cfg;
>>> diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
>>> index 5372e86..5dad04a 100644
>>> --- a/arch/x86/pci/mmconfig_32.c
>>> +++ b/arch/x86/pci/mmconfig_32.c
>>> @@ -11,6 +11,7 @@
>>>
>>>  #include<linux/pci.h>
>>>  #include<linux/init.h>
>>> +#include<linux/rcupdate.h>
>>>  #include<asm/e820.h>
>>>  #include<asm/pci_x86.h>
>>>  #include<acpi/acpi.h>
>>> @@ -60,9 +61,12 @@ err:         *value = -1;
>>>                return -EINVAL;
>>>        }
>>>
>>> +       rcu_read_lock();
>>>        base = get_base_addr(seg, bus, devfn);
>>> -       if (!base)
>>> +       if (!base) {
>>> +               rcu_read_unlock();
>>>                goto err;
>>> +       }
>>>
>>>        raw_spin_lock_irqsave(&pci_config_lock, flags);
>>>
>>> @@ -80,6 +84,7 @@ err:          *value = -1;
>>>                break;
>>>        }
>>>        raw_spin_unlock_irqrestore(&pci_config_lock, flags);
>>> +       rcu_read_unlock();
>>>
>>>        return 0;
>>>  }
>>> @@ -93,9 +98,12 @@ static int pci_mmcfg_write(unsigned int seg, unsigned
>>> int bus,
>>>        if ((bus>  255) || (devfn>  255) || (reg>  4095))
>>>                return -EINVAL;
>>>
>>> +       rcu_read_lock();
>>>        base = get_base_addr(seg, bus, devfn);
>>> -       if (!base)
>>> +       if (!base) {
>>> +               rcu_read_unlock();
>>>                return -EINVAL;
>>> +       }
>>>
>>>        raw_spin_lock_irqsave(&pci_config_lock, flags);
>>>
>>> @@ -113,6 +121,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned
>>> int bus,
>>>                break;
>>>        }
>>>        raw_spin_unlock_irqrestore(&pci_config_lock, flags);
>>> +       rcu_read_unlock();
>>>
>>>        return 0;
>>>  }
>>> diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
>>> index 915a493..acc48c5 100644
>>> --- a/arch/x86/pci/mmconfig_64.c
>>> +++ b/arch/x86/pci/mmconfig_64.c
>>> @@ -9,6 +9,7 @@
>>>  #include<linux/init.h>
>>>  #include<linux/acpi.h>
>>>  #include<linux/bitmap.h>
>>> +#include<linux/rcupdate.h>
>>>  #include<asm/e820.h>
>>>  #include<asm/pci_x86.h>
>>>
>>> @@ -34,9 +35,12 @@ err:         *value = -1;
>>>                return -EINVAL;
>>>        }
>>>
>>> +       rcu_read_lock();
>>>        addr = pci_dev_base(seg, bus, devfn);
>>> -       if (!addr)
>>> +       if (!addr) {
>>> +               rcu_read_unlock();
>>>                goto err;
>>> +       }
>>>
>>>        switch (len) {
>>>        case 1:
>>> @@ -49,6 +53,7 @@ err:          *value = -1;
>>>                *value = mmio_config_readl(addr + reg);
>>>                break;
>>>        }
>>> +       rcu_read_unlock();
>>>
>>>        return 0;
>>>  }
>>> @@ -62,9 +67,12 @@ static int pci_mmcfg_write(unsigned int seg, unsigned
>>> int bus,
>>>        if (unlikely((bus>  255) || (devfn>  255) || (reg>  4095)))
>>>                return -EINVAL;
>>>
>>> +       rcu_read_lock();
>>>        addr = pci_dev_base(seg, bus, devfn);
>>> -       if (!addr)
>>> +       if (!addr) {
>>> +               rcu_read_unlock();
>>>                return -EINVAL;
>>> +       }
>>>
>>>        switch (len) {
>>>        case 1:
>>> @@ -77,6 +85,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned
>>> int bus,
>>>                mmio_config_writel(addr + reg, value);
>>>                break;
>>>        }
>>> +       rcu_read_unlock();
>>>
>>>        return 0;
>>>  }
>>> --
>>> 1.7.5.4
>>>
>>
>> .
>>
>
>
