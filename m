Return-Path: <rjwysocki@gmail.com>
Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1462893601-8937-9-git-send-email-tn@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
	<1462893601-8937-9-git-send-email-tn@semihalf.com>
Date: Tue, 10 May 2016 20:18:42 +0200
Message-ID: <CAJZ5v0jTLGs1J_YXnAEa901hPHaupQeF1EFH_LGK47qadrYONw@mail.gmail.com>
Subject: Re: [PATCH V7 08/11] pci, acpi: Support for ACPI based generic PCI
 host controller
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com,
	David Daney <ddaney@caviumnetworks.com>, wangyijing@huawei.com,
	Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>, Mark Salter <msalter@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Jon Masters <jcm@redhat.com>, andrea.gallo@linaro.org,
	dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com,
	Christopher Covington <cov@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 10, 2016 at 5:19 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
> This patch is going to implement generic PCI host controller for
> ACPI world, similar to what pci-host-generic.c driver does for DT world.
>
> All such drivers, which we have seen so far, were implemented within
> arch/ directory since they had some arch assumptions (x86 and ia64).
> However, they all are doing similar thing, so it makes sense to find
> some common code and abstract it into the generic driver.

Does it mean x86 and ia64 will now be able to use this code too?

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

If that code really is generic and there will be more than one
architecture using it ever, I think it'll be better for the
architectures that don't use it to set something like
ARCH_ACPI_PCI_HOST and whoever doesn't set that will use the generic
thing.  That'd be more logical at least IMO.

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

If that is a new file (and I'm totally unconvinced about the need for
it), can we simply define a pr_fmt() here as all messages in it seem
to be printed by the pr_* functions?
