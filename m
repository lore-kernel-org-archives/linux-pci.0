Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V6 09/13] pci, acpi: Support for ACPI based generic PCI
 host controller
To: Jayachandran C <jchandra@broadcom.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-10-git-send-email-tn@semihalf.com>
 <CAKc_7PXLbX+wxesGVKni7tkKPUbfo7AgfPNxA+Uc25ctOWRk=Q@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>,
	Wangyijing <wangyijing@huawei.com>,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org, Jon Masters <jcm@redhat.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <57189824.7080908@semihalf.com>
Date: Thu, 21 Apr 2016 11:06:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAKc_7PXLbX+wxesGVKni7tkKPUbfo7AgfPNxA+Uc25ctOWRk=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20.04.2016 21:12, Jayachandran C wrote:
> On Fri, Apr 15, 2016 at 10:36 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
>> This patch is going to implement generic PCI host controller for
>> ACPI world, similar to what pci-host-generic.c driver does for DT world.
>>
>> All such drivers, which we have seen so far, were implemented within
>> arch/ directory since they had some arch assumptions (x86 and ia64).
>> However, they all are doing similar thing, so it makes sense to find
>> some common code and abstract it into the generic driver.
>>
>> In order to handle PCI config space regions properly, we define new
>> MCFG interface which parses MCFG table and keep its entries
>> in a list. New pci_mcfg_init call is defined so that we do not depend
>> on PCI_MMCONFIG. Regions are not mapped until host bridge ask for it.
>>
>> The implementation of pci_acpi_scan_root() looks up the saved MCFG entries
>> and sets up a new mapping. Generic PCI functions are used for
>> accessing config space. Driver selects PCI_GENERIC_ECAM and uses functions
>> from drivers/pci/ecam.h to create and access ECAM mappings.
>>
>> As mentioned in Kconfig help section, ACPI_PCI_HOST_GENERIC choice
>> should be made on a per-architecture basis.
>>
>> This patch is heavily based on the updated version from Jayachandran C:
>> https://lkml.org/lkml/2016/4/11/908
>> git: https://github.com/jchandra-brcm/linux/ (arm64-acpi-pci-v3)
>
> This is a little bit unusual because I had not posted the v3 patch
> to the mailing list yet, but you posted a variant of it The git repository
> should not be in the commit comment because it is a temporary location.

We all agree this too important for everybody to delay this series. So 
main motivation is to keep all discussion&patches within one unified 
series. I would like to finally find direction we need to go. Stating 
another discussion based on my previous patch set v5 confused people, 
they do no know who is driving this. Again, lets cooperate to move it 
forward within one patch set.

I agree with you we need maintainers to join this discussion.

>
> There are some changes here I don't agree with. I think it will be
> better if you can post a version without the quirk handling and with
> some of the suggestions below.

The next version will not have quirk handling part. Regarding your 
comments, please see below.

>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>> ---
>>   drivers/acpi/Kconfig        |   8 ++
>>   drivers/acpi/Makefile       |   1 +
>>   drivers/acpi/bus.c          |   1 +
>>   drivers/acpi/pci_gen_host.c | 231 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci.h         |   6 ++
>>   5 files changed, 247 insertions(+)
>>   create mode 100644 drivers/acpi/pci_gen_host.c
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 183ffa3..70272c5 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -346,6 +346,14 @@ config ACPI_PCI_SLOT
>>            i.e., segment/bus/device/function tuples, with physical slots in
>>            the system.  If you are unsure, say N.
>>
>> +config ACPI_PCI_HOST_GENERIC
>> +       bool
>> +       select PCI_GENERIC_ECAM
>> +       help
>> +         Select this config option from the architecture Kconfig,
>> +         if it is preferred to enable ACPI PCI host controller driver which
>> +         has no arch-specific assumptions.
>> +
>>   config X86_PM_TIMER
>>          bool "Power Management Timer Support" if EXPERT
>>          depends on X86
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 81e5cbc..b12fa64 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -40,6 +40,7 @@ acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) += processor_pdc.o
>>   acpi-y                         += ec.o
>>   acpi-$(CONFIG_ACPI_DOCK)       += dock.o
>>   acpi-y                         += pci_root.o pci_link.o pci_irq.o
>> +obj-$(CONFIG_ACPI_PCI_HOST_GENERIC)    += pci_gen_host.o
>>   acpi-y                         += acpi_lpss.o acpi_apd.o
>>   acpi-y                         += acpi_platform.o
>>   acpi-y                         += acpi_pnp.o
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index c068c82..803a1d7 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1107,6 +1107,7 @@ static int __init acpi_init(void)
>>          }
>>
>>          pci_mmcfg_late_init();
>> +       pci_mcfg_init();
>
> Please see below.
>
>>          acpi_scan_init();
>>          acpi_ec_init();
>>          acpi_debugfs_init();
>> diff --git a/drivers/acpi/pci_gen_host.c b/drivers/acpi/pci_gen_host.c
>> new file mode 100644
>> index 0000000..fd360b5
>> --- /dev/null
>> +++ b/drivers/acpi/pci_gen_host.c
>> @@ -0,0 +1,231 @@
>> +/*
>
> You seem to have removed the copyright line, this is not proper, you
> should probably add your copyright line if you think your changes are
> significant.

I rather forgot to add copyright here, I will fix it.

>
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License, version 2, as
>> + * published by the Free Software Foundation (the "GPL").
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License version 2 (GPLv2) for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * version 2 (GPLv2) along with this source code.
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +#include <linux/pci-acpi.h>
>> +#include <linux/sfi_acpi.h>
>> +#include <linux/slab.h>
>> +
>> +#include "../pci/ecam.h"
>> +
>> +#define PREFIX "ACPI: "
>> +
>> +/* Structure to hold entries from the MCFG table */
>> +struct mcfg_entry {
>> +       struct list_head        list;
>> +       phys_addr_t             addr;
>> +       u16                     segment;
>> +       u8                      bus_start;
>> +       u8                      bus_end;
>> +};
>> +
>> +/* List to save mcfg entries */
>> +static LIST_HEAD(pci_mcfg_list);
>> +static DEFINE_MUTEX(pci_mcfg_lock);
>
> There is no need to use a list or lock here, I had used an
> array and that is sufficient since it is not modified after it
> is filled initially.

ACPI PCI driver supports hot plug/removal, I want to avoid races using 
this lock. I decided to use list because I do ECAM mapping on demand. 
See below for more details.

>
>> +/* ACPI info for generic ACPI PCI controller */
>> +struct acpi_pci_generic_root_info {
>> +       struct acpi_pci_root_info       common;
>> +       struct pci_config_window        *cfg;   /* config space mapping */
>> +};
>> +
>> +/* Find the entry in mcfg list which contains range bus_start */
>> +static struct mcfg_entry *pci_mcfg_lookup(u16 seg, u8 bus_start)
>> +{
>> +       struct mcfg_entry *e;
>> +
>> +       list_for_each_entry(e, &pci_mcfg_list, list) {
>> +               if (e->segment == seg &&
>> +                   e->bus_start <= bus_start && bus_start <= e->bus_end)
>> +                       return e;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +
>> +/*
>> + * Lookup the bus range for the domain in MCFG, and set up config space
>> + * mapping.
>> + */
>> +static int pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root,
>> +                                      struct acpi_pci_generic_root_info *ri)
>> +{
>> +       u16 seg = root->segment;
>> +       u8 bus_start = root->secondary.start;
>> +       u8 bus_end = root->secondary.end;
>> +       struct pci_config_window *cfg;
>> +       struct mcfg_entry *e;
>> +       phys_addr_t addr;
>> +       int err = 0;
>> +
>> +       mutex_lock(&pci_mcfg_lock);
>> +       e = pci_mcfg_lookup(seg, bus_start);
>> +       if (!e) {
>> +               addr = acpi_pci_root_get_mcfg_addr(root->device->handle);
>
> The acpi_pci_root_get_mcfg_addr() is already called in pci_root.c, doing
> it again here is unnecessary.

I put it here as per Bjorn's request, see:
https://lkml.org/lkml/2016/3/4/946

If this is not valid any more, I can easily remove it.

>
> I think you can have a function to pick up addr, bus_start, bus_end given
> a domain from either MCFG or using _CBA method, but I think that
> should be done in pci_root.c in a separate patch.
>
>> +               if (addr == 0) {
>> +                       pr_err(PREFIX"%04x:%02x-%02x bus range error\n",
>> +                              seg, bus_start, bus_end);
>> +                       err = -ENOENT;
>> +                       goto err_out;
>> +               }
>> +       } else {
>> +               if (bus_start != e->bus_start) {
>> +                       pr_err("%04x:%02x-%02x bus range mismatch %02x\n",
>> +                              seg, bus_start, bus_end, e->bus_start);
>> +                       err = -EINVAL;
>> +                       goto err_out;
>> +               } else if (bus_end != e->bus_end) {
>> +                       pr_warn("%04x:%02x-%02x bus end mismatch %02x\n",
>> +                               seg, bus_start, bus_end, e->bus_end);
>> +                       bus_end = min(bus_end, e->bus_end);
>> +               }
>> +               addr = e->addr;
>> +       }
>> +
>> +       cfg = pci_generic_ecam_create(&root->device->dev, addr, bus_start,
>> +                                     bus_end, &pci_generic_ecam_default_ops);
>> +       if (IS_ERR(cfg)) {
>> +               err = PTR_ERR(cfg);
>> +               pr_err("%04x:%02x-%02x error %d mapping CAM\n", seg,
>> +                       bus_start, bus_end, err);
>> +               goto err_out;
>> +       }
>
> You seem to have moved all the config space mapping to this
> point. Intel seems to do the mapping when they read MCFG for the
> entries, and I had followed that model, and that avoids having another
> array/list to save the values.

See:
https://lkml.org/lkml/2016/3/3/921

I agree with Bjorn here, we should map it whenever we need this instead 
of mapping all MCFG entries just in case. Also, I see other advantages:
1. We can always use valid "dev" for pci_generic_ecam_create call, what 
you can't do when you use pci_generic_ecam_create during MCFG parsing.
2. No need for special handling for entries coming from _CBA, the path 
is the same for MCFG and _CBA. We do not have to remember that only _CBA 
related entries have to be unmapped.

>
>> +       cfg->domain = seg;
>> +       ri->cfg = cfg;
>> +err_out:
>> +       mutex_unlock(&pci_mcfg_lock);
>> +       return err;
>> +}
>> +
>> +/* release_info: free resrouces allocated by init_info */
>> +static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
>> +{
>> +       struct acpi_pci_generic_root_info *ri;
>> +
>> +       ri = container_of(ci, struct acpi_pci_generic_root_info, common);
>> +       pci_generic_ecam_free(ri->cfg);
>> +       kfree(ri);
>> +}
>> +
>> +static struct acpi_pci_root_ops acpi_pci_root_ops = {
>> +       .release_info = pci_acpi_generic_release_info,
>> +};
>> +
>> +/* Interface called from ACPI code to setup PCI host controller */
>> +struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>> +{
>> +       int node = acpi_get_node(root->device->handle);
>> +       struct acpi_pci_generic_root_info *ri;
>> +       struct pci_bus *bus, *child;
>> +       int err;
>> +
>> +       ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
>> +       if (!ri)
>> +               return NULL;
>> +
>> +       err = pci_acpi_setup_ecam_mapping(root, ri);
>> +       if (err)
>> +               return NULL;
>> +
>> +       acpi_pci_root_ops.pci_ops = &ri->cfg->ops->pci_ops;
>> +       bus = acpi_pci_root_create(root, &acpi_pci_root_ops, &ri->common,
>> +                                  ri->cfg);
>> +       if (!bus)
>> +               return NULL;
>> +
>> +       pci_bus_size_bridges(bus);
>> +       pci_bus_assign_resources(bus);
>> +
>> +       list_for_each_entry(child, &bus->children, node)
>> +               pcie_bus_configure_settings(child);
>> +
>> +       return bus;
>> +}
>> +
>> +/* handle MCFG table entries */
>> +static __init int pci_mcfg_parse(struct acpi_table_header *header)
>> +{
>> +       struct acpi_table_mcfg *mcfg;
>> +       struct acpi_mcfg_allocation *mptr;
>> +       struct mcfg_entry *e, *arr;
>> +       int i, n;
>> +
>> +       if (!header)
>> +               return -EINVAL;
>> +
>> +       mcfg = (struct acpi_table_mcfg *)header;
>> +       mptr = (struct acpi_mcfg_allocation *) &mcfg[1];
>> +       n = (header->length - sizeof(*mcfg)) / sizeof(*mptr);
>> +       if (n <= 0 || n > 255) {
>> +               pr_err(PREFIX " MCFG has incorrect entries (%d).\n", n);
>> +               return -EINVAL;
>> +       }
>> +
>> +       arr = kcalloc(n, sizeof(*arr), GFP_KERNEL);
>> +       if (!arr)
>> +               return -ENOMEM;
>
> Here you already have an array which is also connected as a linked
> list which is unnecessary.

The array is to avoid complicated error handling in case the allocation 
for some of element would failed. I can rework this to allocate each 
element separately or to use array but the code is simpler now. As 
explained above (on demand mapping), I would like to keep list/array 
with MCFG entries (I preferred list).

>
>> +       for (i = 0, e = arr; i < n; i++, mptr++, e++) {
>> +               e->segment = mptr->pci_segment;
>> +               e->addr =  mptr->address;
>> +               e->bus_start = mptr->start_bus_number;
>> +               e->bus_end = mptr->end_bus_number;
>> +               list_add(&e->list, &pci_mcfg_list);
>> +               pr_info(PREFIX
>> +                       "MCFG entry for domain %04x [bus %02x-%02x] (base %pa)\n",
>> +                       e->segment, e->bus_start, e->bus_end, &e->addr);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/* Interface called by ACPI - parse and save MCFG table */
>> +void __init pci_mcfg_init(void)
>> +{
>> +       int err = acpi_table_parse(ACPI_SIG_MCFG, pci_mcfg_parse);
>> +       if (err)
>> +               pr_err(PREFIX "Failed to parse MCFG (%d)\n", err);
>> +       else if (list_empty(&pci_mcfg_list))
>> +               pr_info(PREFIX "No valid entries in MCFG table.\n");
>> +       else {
>> +               struct mcfg_entry *e;
>> +               int i = 0;
>> +               list_for_each_entry(e, &pci_mcfg_list, list)
>> +                       i++;
>> +               pr_info(PREFIX "MCFG table loaded, %d entries\n", i);
>> +       }
>> +}
>> +
>> +/* Raw operations, works only for MCFG entries with an associated bus */
>> +int raw_pci_read(unsigned int domain, unsigned int busn, unsigned int devfn,
>> +                int reg, int len, u32 *val)
>> +{
>> +       struct pci_bus *bus = pci_find_bus(domain, busn);
>> +
>> +       if (!bus)
>> +               return PCIBIOS_DEVICE_NOT_FOUND;
>> +       return bus->ops->read(bus, devfn, reg, len, val);
>> +}
>> +
>> +int raw_pci_write(unsigned int domain, unsigned int busn, unsigned int devfn,
>> +                 int reg, int len, u32 val)
>> +{
>> +       struct pci_bus *bus = pci_find_bus(domain, busn);
>> +
>> +       if (!bus)
>> +               return PCIBIOS_DEVICE_NOT_FOUND;
>> +       return bus->ops->write(bus, devfn, reg, len, val);
>> +}
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index df1f33d..c0422ea 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1729,6 +1729,12 @@ static inline void pci_mmcfg_early_init(void) { }
>>   static inline void pci_mmcfg_late_init(void) { }
>>   #endif
>>
>> +#ifdef CONFIG_ACPI_PCI_HOST_GENERIC
>> +void __init pci_mcfg_init(void);
>> +#else
>> +static inline void pci_mcfg_init(void) { return; }
>> +#endif
>
> You can still use the function pci_mmcfg_late_init() if
> PCI_MMCONFIG or ACPI_PCI_HOST_GENERIC is defined
>

OK

-#ifdef CONFIG_PCI_MMCONFIG
+#if defined(CONFIG_PCI_MMCONFIG) || defined(ACPI_PCI_HOST_GENERIC)
void __init pci_mmcfg_early_init(void);
void __init pci_mmcfg_late_init(void);
#else
static inline void pci_mmcfg_early_init(void) { }
static inline void pci_mmcfg_late_init(void) { }
#endif

is that what you mean?

Tomasz
