Return-Path: <jayachandran.c@broadcom.com>
Return-Path: <jayachandran.c@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <1462893601-8937-9-git-send-email-tn@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com> <1462893601-8937-9-git-send-email-tn@semihalf.com>
From: Jayachandran C <jchandra@broadcom.com>
Date: Sat, 14 May 2016 14:37:45 +0530
Message-ID: <CAKc_7PVz8rgCTqMVuR7g944nonSHExAhx5rNsjiP3J=9LfA99g@mail.gmail.com>
Subject: Re: [PATCH V7 08/11] pci, acpi: Support for ACPI based generic PCI
 host controller
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Rafael Wysocki <rafael@kernel.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, robert.richter@caviumnetworks.com,
	Marcin Wojtas <mw@semihalf.com>, Liviu.Dudau@arm.com,
	David Daney <ddaney@caviumnetworks.com>, Wangyijing <wangyijing@huawei.com>,
	Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>, Mark Salter <msalter@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linaro-acpi@lists.linaro.org,
	Jon Masters <jcm@redhat.com>, Andrea Gallo <andrea.gallo@linaro.org>, Duc Dang <dhdang@apm.com>,
	jeremy.linton@arm.com, liudongdong3@huawei.com,
	Christopher Covington <cov@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 10, 2016 at 8:49 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
> This patch is going to implement generic PCI host controller for
> ACPI world, similar to what pci-host-generic.c driver does for DT world.
>
> All such drivers, which we have seen so far, were implemented within
> arch/ directory since they had some arch assumptions (x86 and ia64).
> However, they all are doing similar thing, so it makes sense to find
> some common code and abstract it into the generic driver.
>
> In order to handle PCI config space regions properly, we define new
> MCFG interface which does sanity checks on MCFG table and keeps its
> root pointer. User is able to lookup MCFG regions based on that root
> pointer and specified domain:bus_start:bus_end touple. We are using
> pci_mmcfg_late_init old prototype to avoid another function name.
>
> The implementation of pci_acpi_scan_root() looks up the MCFG entries
> and sets up a new mapping (regions are not mapped until host controller ask
> for it). Generic PCI functions are used for accessing config space.
> Driver selects PCI_ECAM and uses functions from drivers/pci/ecam.h
> to create and access ECAM mappings.
>
> As mentioned in Kconfig help section, ACPI_PCI_HOST_GENERIC choice
> should be made on a per-architecture basis.

Looking thru the new code, I see a few issues, please see below

> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>  drivers/acpi/Kconfig            |   8 +++
>  drivers/acpi/Makefile           |   1 +
>  drivers/acpi/pci_mcfg.c         |  97 ++++++++++++++++++++++++++
>  drivers/acpi/pci_root_generic.c | 149 ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/ecam.h              |   5 ++
>  include/linux/pci-acpi.h        |   5 ++
>  include/linux/pci.h             |   5 +-
>  7 files changed, 269 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/pci_mcfg.c
>  create mode 100644 drivers/acpi/pci_root_generic.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 183ffa3..44afc76 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -346,6 +346,14 @@ config ACPI_PCI_SLOT
>           i.e., segment/bus/device/function tuples, with physical slots in
>           the system.  If you are unsure, say N.
>
> +config ACPI_PCI_HOST_GENERIC
> +       bool
> +       select PCI_ECAM
> +       help
> +         Select this config option from the architecture Kconfig,
> +         if it is preferred to enable ACPI PCI host controller driver which
> +         has no arch-specific assumptions.
> +
>  config X86_PM_TIMER
>         bool "Power Management Timer Support" if EXPERT
>         depends on X86
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 81e5cbc..627a2b7 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -40,6 +40,7 @@ acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) += processor_pdc.o
>  acpi-y                         += ec.o
>  acpi-$(CONFIG_ACPI_DOCK)       += dock.o
>  acpi-y                         += pci_root.o pci_link.o pci_irq.o
> +obj-$(CONFIG_ACPI_PCI_HOST_GENERIC)    += pci_root_generic.o pci_mcfg.o
>  acpi-y                         += acpi_lpss.o acpi_apd.o
>  acpi-y                         += acpi_platform.o
>  acpi-y                         += acpi_pnp.o
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> new file mode 100644
> index 0000000..373d079
> --- /dev/null
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -0,0 +1,97 @@
> +/*
> + * Copyright (C) 2016 Broadcom
> + *     Author: Jayachandran C <jchandra@broadcom.com>
> + * Copyright (C) 2016 Semihalf
> + *     Author: Tomasz Nowicki <tn@semihalf.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation (the "GPL").
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License version 2 (GPLv2) for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * version 2 (GPLv2) along with this source code.
> + */
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/pci-acpi.h>
> +
> +#define PREFIX "ACPI: "
> +
> +/* Root pointer to the mapped MCFG table */
> +static struct acpi_table_mcfg *mcfg_table;
> +
> +#define MCFG_ENTRIES(mcfg_ptr) (((mcfg_ptr)->header.length -           \
> +                               sizeof(struct acpi_table_mcfg)) /       \
> +                               sizeof(struct acpi_mcfg_allocation))

It would be better if you used static inline function here.

> +static phys_addr_t pci_mcfg_lookup_static(u16 seg, u8 bus_start, u8 bus_end)
> +{
> +       struct acpi_mcfg_allocation *mptr;
> +       int i;
> +
> +       if (!mcfg_table) {
> +               pr_err(PREFIX "MCFG table not available, lookup failed\n");
> +               return -ENXIO;
> +       }
> +
> +       mptr = (struct acpi_mcfg_allocation *) &mcfg_table[1];
> +
> +       /*
> +        * We expect exact match, unless MCFG entry end bus covers more than
> +        * specified by caller.
> +        */
> +       for (i = 0; i < MCFG_ENTRIES(mcfg_table); i++, mptr++) {
> +               if (mptr->pci_segment == seg &&
> +                   mptr->start_bus_number == bus_start &&
> +                   mptr->end_bus_number >= bus_end) {
> +                       return mptr->address;
> +               }
> +       }

There is an issue here, the bus range is obtained if different
ways. If the _CRS has it, this should be fine. But if it is _BBN-0xff
or the default 0-0xff, then I would think taking the MCFG entry end
would be better. This would require updating the bus resource end.

Also (trivial), the braces are not needed.

> +       return -ENXIO;
> +}
> +
> +phys_addr_t pci_mcfg_lookup(struct acpi_device *device, u16 seg,
> +                           struct resource *bus_res)
> +{
> +       phys_addr_t addr;
> +
> +       addr = acpi_pci_root_get_mcfg_addr(device->handle);
> +       if (addr)
> +               return addr;

When you have address from _CBA, you are assuming that the
bus range is also set correctly (from _CRS or as _BBN-0xff). Is
this assumption correct?

(this was discussed earlier)  you are doing the _CBA call again,
I think cleaning up the _CBA, _BBN, _CRS and MCFG based
ECAM area resources and defaults should be a different patch,
which would need changes to pci_root.c. We should use
root->mcfg_addr in this patchset.

> +
> +       return pci_mcfg_lookup_static(seg, bus_res->start, bus_res->end);

There is no need to have a separate function for this, based on by
above comment, you might need to change bus_res, so having it here
would be better.

> +}
> +
> +static __init int pci_mcfg_parse(struct acpi_table_header *header)
> +{
> +       struct acpi_table_mcfg *mcfg;
> +       int n;
> +
> +       if (!header)
> +               return -EINVAL;

This is not needed, the handler is not called if header is NULL

> +
> +       mcfg = (struct acpi_table_mcfg *)header;
> +       n = MCFG_ENTRIES(mcfg);
> +       if (n <= 0 || n > 255) {
> +               pr_err(PREFIX "MCFG has incorrect entries (%d).\n", n);
> +               return -EINVAL;
> +       }
>
> +       mcfg_table = mcfg;

Saving a reference of ACPI mapping seems dangerous, acpi_parse_table
calles early_acpi_os_unmap_memory() after calling handler, which does
not do anything since acpi_gbl_permanent_mmap is set.

I would suggest copying the entries.

> +       pr_info(PREFIX "MCFG table loaded, %d entries detected\n", n);
> +       return 0;
> +}
> +
> +/* Interface called by ACPI - parse and save MCFG table */
> +void __init pci_mmcfg_late_init(void)
> +{
> +       int err = acpi_table_parse(ACPI_SIG_MCFG, pci_mcfg_parse);
> +       if (err)
> +               pr_err(PREFIX "Failed to parse MCFG (%d)\n", err);
> +}


JC.
