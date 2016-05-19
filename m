Return-Path: <mbrugger@suse.com>
Return-Path: <mbrugger@suse.com>
Subject: Re: [PATCH V7 08/11] pci, acpi: Support for ACPI based generic PCI
 host controller
To: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org, arnd@arndb.de,
 will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
 hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
 jchandra@broadcom.com
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <1462893601-8937-9-git-send-email-tn@semihalf.com>
Cc: jcm@redhat.com, linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
 dhdang@apm.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
 jeremy.linton@arm.com, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com,
 cov@codeaurora.org, Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
 wangyijing@huawei.com, mw@semihalf.com, andrea.gallo@linaro.org,
 linux-arm-kernel@lists.infradead.org, liudongdong3@huawei.com
From: Matthias Brugger <mbrugger@suse.com>
Message-ID: <573DF039.5040405@suse.com>
Date: Thu, 19 May 2016 18:56:25 +0200
MIME-Version: 1.0
In-Reply-To: <1462893601-8937-9-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 10/05/16 17:19, Tomasz Nowicki wrote:
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
>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>   drivers/acpi/Kconfig            |   8 +++
>   drivers/acpi/Makefile           |   1 +
>   drivers/acpi/pci_mcfg.c         |  97 ++++++++++++++++++++++++++
>   drivers/acpi/pci_root_generic.c | 149 ++++++++++++++++++++++++++++++++++++++++
>   drivers/pci/ecam.h              |   5 ++
>   include/linux/pci-acpi.h        |   5 ++
>   include/linux/pci.h             |   5 +-
>   7 files changed, 269 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/acpi/pci_mcfg.c
>   create mode 100644 drivers/acpi/pci_root_generic.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 183ffa3..44afc76 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -346,6 +346,14 @@ config ACPI_PCI_SLOT
>   	  i.e., segment/bus/device/function tuples, with physical slots in
>   	  the system.  If you are unsure, say N.
>
> +config ACPI_PCI_HOST_GENERIC
> +	bool
> +	select PCI_ECAM
> +	help
> +	  Select this config option from the architecture Kconfig,
> +	  if it is preferred to enable ACPI PCI host controller driver which
> +	  has no arch-specific assumptions.
> +
>   config X86_PM_TIMER
>   	bool "Power Management Timer Support" if EXPERT
>   	depends on X86
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 81e5cbc..627a2b7 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -40,6 +40,7 @@ acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) += processor_pdc.o
>   acpi-y				+= ec.o
>   acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
>   acpi-y				+= pci_root.o pci_link.o pci_irq.o
> +obj-$(CONFIG_ACPI_PCI_HOST_GENERIC)	+= pci_root_generic.o pci_mcfg.o
>   acpi-y				+= acpi_lpss.o acpi_apd.o
>   acpi-y				+= acpi_platform.o
>   acpi-y				+= acpi_pnp.o
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> new file mode 100644
> index 0000000..373d079
> --- /dev/null
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -0,0 +1,97 @@
> +/*
> + * Copyright (C) 2016 Broadcom
> + *	Author: Jayachandran C <jchandra@broadcom.com>
> + * Copyright (C) 2016 Semihalf
> + * 	Author: Tomasz Nowicki <tn@semihalf.com>
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
> +#define PREFIX	"ACPI: "
> +
> +/* Root pointer to the mapped MCFG table */
> +static struct acpi_table_mcfg *mcfg_table;
> +
> +#define MCFG_ENTRIES(mcfg_ptr)	(((mcfg_ptr)->header.length -		\
> +				sizeof(struct acpi_table_mcfg)) /	\
> +				sizeof(struct acpi_mcfg_allocation))
> +
> +static phys_addr_t pci_mcfg_lookup_static(u16 seg, u8 bus_start, u8 bus_end)
> +{
> +	struct acpi_mcfg_allocation *mptr;
> +	int i;
> +
> +	if (!mcfg_table) {
> +		pr_err(PREFIX "MCFG table not available, lookup failed\n");
> +		return -ENXIO;
> +	}
> +
> +	mptr = (struct acpi_mcfg_allocation *) &mcfg_table[1];
> +
> +	/*
> +	 * We expect exact match, unless MCFG entry end bus covers more than
> +	 * specified by caller.
> +	 */
> +	for (i = 0; i < MCFG_ENTRIES(mcfg_table); i++, mptr++) {
> +		if (mptr->pci_segment == seg &&
> +		    mptr->start_bus_number == bus_start &&
> +		    mptr->end_bus_number >= bus_end) {
> +			return mptr->address;
> +		}
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +phys_addr_t pci_mcfg_lookup(struct acpi_device *device, u16 seg,
> +			    struct resource *bus_res)
> +{
> +	phys_addr_t addr;
> +
> +	addr = acpi_pci_root_get_mcfg_addr(device->handle);
> +	if (addr)
> +		return addr;
> +
> +	return pci_mcfg_lookup_static(seg, bus_res->start, bus_res->end);
> +}
> +
> +static __init int pci_mcfg_parse(struct acpi_table_header *header)
> +{
> +	struct acpi_table_mcfg *mcfg;
> +	int n;
> +
> +	if (!header)
> +		return -EINVAL;

Maybe that's bike shedding, but acpi_table_parse already checks that the 
table passed to the handler exists, so this is redundant.

Regards,
Matthias
