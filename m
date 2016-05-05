Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [PATCH V6 07/13] PCI: Provide common functions for ECAM mapping
To: Jayachandran C <jchandra@broadcom.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-8-git-send-email-tn@semihalf.com>
 <20160428214749.GF25125@localhost>
 <CAKc_7PUJQsUrCuOg1iafZ9amANk=E9eu0MrF=UOrVEVbseMz2w@mail.gmail.com>
 <CAKc_7PXG5QxaN=b0oZA7E=a-LhSg0q+FqmaVhViYnRfK4Z8jfQ@mail.gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
 Hanjun Guo <hanjun.guo@linaro.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
 robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
 Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>,
 Wangyijing <wangyijing@huawei.com>, Suravee.Suthikulpanit@amd.com,
 msalter@redhat.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
 Jon Masters <jcm@redhat.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <572B22BE.3010501@semihalf.com>
Date: Thu, 5 May 2016 12:38:54 +0200
MIME-Version: 1.0
In-Reply-To: <CAKc_7PXG5QxaN=b0oZA7E=a-LhSg0q+FqmaVhViYnRfK4Z8jfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 05.05.2016 11:24, Jayachandran C wrote:
> On Fri, Apr 29, 2016 at 1:31 PM, Jayachandran C <jchandra@broadcom.com> wrote:
>> On Fri, Apr 29, 2016 at 3:17 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Fri, Apr 15, 2016 at 07:06:42PM +0200, Tomasz Nowicki wrote:
>>>> From: Jayachandran C <jchandra@broadcom.com>
>>>>
>>>> Add config option PCI_GENERIC_ECAM and file drivers/pci/ecam.c to
>>>> provide generic functions for accessing memory mapped PCI config space.
>>>>
>>>> The API is defined in drivers/pci/ecam.h and is written to replace the
>>>> API in drivers/pci/host/pci-host-common.h. The file defines a new
>>>> 'struct pci_config_window' to hold the information related to a PCI
>>>> config area and its mapping. This structure is expected to be used as
>>>> sysdata for controllers that have ECAM based mapping.
>>>>
>>>> Helper functions are provided to setup the mapping, free the mapping
>>>> and to implement the map_bus method in 'struct pci_ops'
>>>
>>> Spec reference: PCI Express Base Specification, rev 3.0, sec 7.2.2.
>>>
>>>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>>>> ---
>>>>   drivers/pci/Kconfig  |   3 ++
>>>>   drivers/pci/Makefile |   2 +
>>>>   drivers/pci/ecam.c   | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>   drivers/pci/ecam.h   |  61 +++++++++++++++++++++++
>>>>   4 files changed, 203 insertions(+)
>>>>   create mode 100644 drivers/pci/ecam.c
>>>>   create mode 100644 drivers/pci/ecam.h
>>>>
>>>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>>> index 209292e..e930d62 100644
>>>> --- a/drivers/pci/Kconfig
>>>> +++ b/drivers/pci/Kconfig
>>>> @@ -83,6 +83,9 @@ config HT_IRQ
>>>>   config PCI_ATS
>>>>        bool
>>>>
>>>> +config PCI_GENERIC_ECAM
>>>> +     bool
>>>
>>> "PCI_ECAM" is enough, I think.  It's defined by and required by the
>>> spec unless there's some arch-specific interface.  Plus, if I
>>
>> Ok. Looking at the comments I think I have to take out generic from
>> all the names - will do this in next version.
>>
>>> understand correctly, this infrastructure supports non-generic ECAM
>>> implementations as well, since the caller supplies "struct
>>> pci_generic_ecam_ops *ops".
>>
>> Yes, the idea was to support ECAM with quirks (and CAM) on both
>> 32 and 64 bit, otherwise it would be too trivial to have a separate
>> implementation.
>>
>>>>   config PCI_IOV
>>>>        bool "PCI IOV support"
>>>>        depends on PCI
>>>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>>>> index 2154092..810aec8 100644
>>>> --- a/drivers/pci/Makefile
>>>> +++ b/drivers/pci/Makefile
>>>> @@ -55,6 +55,8 @@ obj-$(CONFIG_PCI_SYSCALL) += syscall.o
>>>>
>>>>   obj-$(CONFIG_PCI_STUB) += pci-stub.o
>>>>
>>>> +obj-$(CONFIG_PCI_GENERIC_ECAM) += ecam.o
>>>> +
>>>>   obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>>>>
>>>>   obj-$(CONFIG_OF) += of.o
>>>> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
>>>> new file mode 100644
>>>> index 0000000..ff04c01
>>>> --- /dev/null
>>>> +++ b/drivers/pci/ecam.c
>>>> @@ -0,0 +1,137 @@
>>>> +/*
>>>> + * Copyright 2016 Broadcom
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License, version 2, as
>>>> + * published by the Free Software Foundation (the "GPL").
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful, but
>>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>> + * General Public License version 2 (GPLv2) for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU General Public License
>>>> + * version 2 (GPLv2) along with this source code.
>>>> + */
>>>> +
>>>> +#include <linux/device.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/pci.h>
>>>> +#include <linux/slab.h>
>>>> +
>>>> +#include "ecam.h"
>>>> +
>>>> +/*
>>>> + * On 64 bit systems, we do a single ioremap for the whole config space
>>>> + * since we have enough virtual address range available. On 32 bit, do an
>>>> + * ioremap per bus.
>>>> + */
>>>> +static const bool per_bus_mapping = !config_enabled(CONFIG_64BIT);
>>>> +
>>>> +/*
>>>> + * Create a PCI config space window
>>>> + *  - reserve mem region
>>>> + *  - alloc struct pci_config_window with space for all mappings
>>>> + *  - ioremap the config space
>>>> + */
>>>> +struct pci_config_window *pci_generic_ecam_create(struct device *dev,
>>>> +                             phys_addr_t addr, u8 bus_start, u8 bus_end,
>>>
>>> Can you take pointers to struct resources here instead of addr,
>>> bus_start, and bus_end?  The caller probably has them already, and
>>> then you could add a useful printk like:
>>>
>>>    dev_info(dev, "ECAM for %pR at %pR\n", busn_res, mmio_res);
>>>
>>> Would have to be careful about the struct resource lifetimes though.
>>
>> Yes, I had thought of this. The reason I did not go down that path was
>> that we are using request_mem_region() which takes the address
>> and creates a resource .internally.
>>
>> Beyond that, as you noted, the ownership and lifetime is slightly
>> more complex. Either the calling code has to allocate the
>> resource and handoff, or the ecam code has to make a copy of
>> the resource. I would go with copy since it is much more simple
>> to use.
>>
>> Since resource based API seems to be preferred, I will switch
>> to passing bus and mmio resource and will use
>> request_resource_conflict() to allocate the ECAM mem region,
>>
>>> If you had the MMIO resource here, you could also do the range
>>> checking you currently have in gen_pci_init() here instead, so all
>>> callers could benefit.
>>
>> Ok.
>>
>>>> +                             struct pci_generic_ecam_ops *ops)
>>>> +{
>>>> +     struct pci_config_window *cfg;
>>>> +     unsigned int bus_shift, bus_range, bsz, mapsz;
>>>> +     int i, nidx;
>>>> +     int err = -ENOMEM;
>>>> +
>>>> +     if (bus_end < bus_start)
>>>> +             return ERR_PTR(-EINVAL);
>>>> +
>>>> +     bus_shift = ops->bus_shift;
>>>> +     bus_range = bus_end - bus_start + 1;
>>>> +     bsz = 1 << bus_shift;
>>>> +     nidx = per_bus_mapping ? bus_range : 1;
>>>> +     mapsz = per_bus_mapping ? bsz : bus_range * bsz;
>>>> +     cfg = kzalloc(sizeof(*cfg) + nidx * sizeof(cfg->win[0]), GFP_KERNEL);
>>>> +     if (!cfg)
>>>> +             return ERR_PTR(-ENOMEM);
>>>> +
>>>> +     cfg->bus_start = bus_start;
>>>> +     cfg->bus_end = bus_end;
>>>> +     cfg->ops = ops;
>>>> +
>>>> +     if (!request_mem_region(addr, bus_range * bsz, "Configuration Space"))
>>>> +             goto err_exit;
>>>> +
>>>> +     /* cfgaddr has to be set after request_mem_region */
>>>> +     cfg->cfgaddr = addr;
>>>> +
>>>> +     for (i = 0; i < nidx; i++) {
>>>> +             cfg->win[i] = ioremap(addr + i * mapsz, mapsz);
>>>> +             if (!cfg->win[i])
>>>> +                     goto err_exit;
>>>> +     }
>>>> +
>>>> +     if (cfg->ops->init) {
>>>> +             err = cfg->ops->init(dev, cfg);
>>>> +             if (err)
>>>> +                     goto err_exit;
>>>> +     }
>>>> +     return cfg;
>>>> +
>>>> +err_exit:
>>>> +     pci_generic_ecam_free(cfg);
>>>> +     return ERR_PTR(err);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Free a config space mapping
>>>> + */
>>>
>>> Superfluous comment.
>>
>> Ok, will trim comments to keep the ones that are useful.
>>
>>>> +void pci_generic_ecam_free(struct pci_config_window *cfg)
>>>> +{
>>>> +     unsigned int bus_range;
>>>> +     int i, nidx;
>>>> +
>>>> +     bus_range = cfg->bus_end - cfg->bus_start + 1;
>>>> +     nidx = per_bus_mapping ? bus_range : 1;
>>>> +     for (i = 0; i < nidx; i++)
>>>> +             if (cfg->win[i])
>>>> +                     iounmap(cfg->win[i]);
>>>> +     if (cfg->cfgaddr)
>>>> +             release_mem_region(cfg->cfgaddr,
>>>> +                                bus_range << cfg->ops->bus_shift);
>>>> +     kfree(cfg);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Function to implement the pci_ops ->map_bus method
>>>> + */
>>>> +void __iomem *pci_generic_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>>>> +                                    int where)
>>>> +{
>>>> +     struct pci_config_window *cfg = bus->sysdata;
>>>
>>> I don't really like the use of bus->sysdata here, because sysdata is
>>> explicitly arch-specific.
>>>
>>> But I guess we're in a bind right now: it'd be nice to save the cfg
>>> pointer in struct pci_host_bridge, but you have to call
>>> pci_generic_ecam_create() before the struct pci_host_bridge has been
>>> allocated, and you have to pass the pointer into pci_scan_root_bus(),
>>> and there's no generic way to do that yet.
>>>
>>> So I guess this will have to do for now.
>>
>> I could call the structure pci_ecam_sysdata instead of pci_config_window
>> to make it clear that it is to be used as sysdata for ECAM based PCI host
>> controllers.
>>
>> The current push (at least on ARM/ARM64) seems to be to make
>> bus->sysdata controller specific and avoid arch specific sysdata.
>>
>>>> +     unsigned int devfn_shift = cfg->ops->bus_shift - 8;
>>>> +     unsigned int busn = bus->number;
>>>> +     void __iomem *base;
>>>> +
>>>> +     if (busn < cfg->bus_start || busn > cfg->bus_end)
>>>> +             return NULL;
>>>> +
>>>> +     busn -= cfg->bus_start;
>>>> +     if (per_bus_mapping)
>>>> +             base = cfg->win[busn];
>>>> +     else
>>>> +             base = cfg->win[0] + (busn << cfg->ops->bus_shift);
>>>> +     return base + (devfn << devfn_shift) + where;
>>>> +}
>>>> +
>>>> +/* default ECAM ops */
>>>> +struct pci_generic_ecam_ops pci_generic_ecam_default_ops = {
>>>
>>> Using both "generic" and "default" seems overkill.  Maybe just:
>>>
>>>    struct pci_ecam_ops pci_generic_ecam_ops = { ... ?
>>
>> Ok.
>>
>>>> +     .bus_shift      = 20,
>>>> +     .pci_ops                = {
>>>> +             .map_bus        = pci_generic_ecam_map_bus,
>>>> +             .read           = pci_generic_config_read,
>>>> +             .write          = pci_generic_config_write,
>>>> +     }
>>>> +};
>>>> diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
>>>> new file mode 100644
>>>> index 0000000..34c0aba
>>>> --- /dev/null
>>>> +++ b/drivers/pci/ecam.h
>>>> @@ -0,0 +1,61 @@
>>>> +/*
>>>> + * Copyright 2016 Broadcom
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License, version 2, as
>>>> + * published by the Free Software Foundation (the "GPL").
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful, but
>>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>> + * General Public License version 2 (GPLv2) for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU General Public License
>>>> + * version 2 (GPLv2) along with this source code.
>>>> + */
>>>> +#ifndef DRIVERS_PCI_ECAM_H
>>>> +#define DRIVERS_PCI_ECAM_H
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +/*
>>>> + * struct to hold pci ops and bus shift of the config window
>>>> + * for a PCI controller.
>>>> + */
>>>> +struct pci_config_window;
>>>> +struct pci_generic_ecam_ops {
>>>
>>> "struct pci_ecam_ops"
>>
>> Ok.
>>
>>>> +     unsigned int                    bus_shift;
>>>> +     struct pci_ops                  pci_ops;
>>>> +     int                             (*init)(struct device *,
>>>> +                                             struct pci_config_window *);
>>>> +};
>>>> +
>>>> +/*
>>>> + * struct to hold the mappings of a config space window. This
>>>> + * will be allocated with enough entries in win[] to hold all
>>>> + * the mappings for the bus range.
>>>> + */
>>>> +struct pci_config_window {
>>>> +     phys_addr_t                     cfgaddr;
>>>> +     u16                             domain;
>>>> +     u8                              bus_start;
>>>> +     u8                              bus_end;
>>>> +     void                            *priv;
>>>> +     struct pci_generic_ecam_ops     *ops;
>>>> +     void __iomem                    *win[0];
>>>> +};
>>>> +
>>>> +/* create and free for pci_config_window */
>>>
>>> Superfluous comment.
>>>
>>>> +struct pci_config_window *pci_generic_ecam_create(struct device *dev,
>>>> +                             phys_addr_t addr, u8 bus_start, u8 bus_end,
>>>> +                             struct pci_generic_ecam_ops *ops);
>>>> +void pci_generic_ecam_free(struct pci_config_window *cfg);
>>>
>>> "pci_ecam_create" and "pci_ecam_free"?  I suspect you're going to call
>>> these for flavors of ECAM that are definitely not "generic".
>>>
>>>> +/* map_bus when ->sysdata is an instance of pci_config_window */
>>>> +void __iomem *pci_generic_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>>>> +                                    int where);
>>>> +/* default ECAM ops, bus shift 20, generic read and write */
>>>> +extern struct pci_generic_ecam_ops pci_generic_ecam_default_ops;
>>>> +
>>>> +#endif
>>
>> Thanks for the review. The ECAM patchset can be merged separately
>> if you do not want to tie it the ACPI changes.
>>
>> Please let me know how you want to proceed. Depending on that, I will
>> either post it as a separate patchset or ask Tomasz to pick up my
>> changes and post the ACPI patchset. again.
>
> I have made the changes suggested here, and added one more
> change to move from 'void __iomem *win[0]' to a union for
> pci_config_window so that it can be embedded in other structures[1].
>
> The changes are at https://github.com/jchandra-brcm/linux branch
> arm64-acpi-pci-v4 so that Tomasz can add it to v7 of the ACPI/PCI
> patches. I am not posting the changes here to avoid the impression
> that there are clashing ACPI/PCI patchsets.
>
> The branch also has an example patch for ACPI generic PCI root
> using the new ECAM code. This also has the simpler domain
> setting code for ACPI as well as fix for the ECAM address
> calculation which came up during the earlier discussion.
>
> JC.
> [1] Minor API changes will be needed for embedding now.
>      This change will make it easier to merge with Arnd's host bridge
>      changes when that goes in.
>

Thanks JC!

Tomasz
