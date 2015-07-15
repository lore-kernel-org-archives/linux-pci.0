Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40253 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967AbbGORow (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jul 2015 13:44:52 -0400
Date: Wed, 15 Jul 2015 18:44:28 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Robert Richter <rrichter@cavium.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Daney <david.daney@cavium.com>, marc.zyngier@arm.com
Subject: Re: [PATCH 5/5] PCI: Add host drivers for Cavium ThunderX processors.
Message-ID: <20150715174427.GB19480@leverpostej>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
 <1436979285-8177-6-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436979285-8177-6-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

As mentioned in my reply to the cover letter, a DT binding document is
necessary for this.

It looks like many of the properties of your root complex which should
be described (e.g. physical addresses, master IDs as visible to MSI
controllers) are blindly assumed by this driver, and I expect those to
be explicit in the DT. I suspect that means you also need to reconsider
your ACPI description, which needs to express the same information.

Please Cc me on subsequent postings of both the binding and driver.

On Wed, Jul 15, 2015 at 05:54:45PM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/pci/host/Kconfig            |  12 +
>  drivers/pci/host/Makefile           |   2 +
>  drivers/pci/host/pcie-thunder-pem.c | 462 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pcie-thunder.c     | 422 ++++++++++++++++++++++++++++++++
>  4 files changed, 898 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-thunder-pem.c
>  create mode 100644 drivers/pci/host/pcie-thunder.c
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index c132bdd..06e26ad 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -145,4 +145,16 @@ config PCIE_IPROC_BCMA
>           Say Y here if you want to use the Broadcom iProc PCIe controller
>           through the BCMA bus interface
>
> +config PCI_THUNDER_PEM
> +       bool
> +
> +config PCI_THUNDER
> +       bool "Thunder PCIe host controller"
> +       depends on ARM64 || COMPILE_TEST
> +       depends on OF_PCI
> +       select PCI_MSI
> +       select PCI_THUNDER_PEM
> +       help
> +         Say Y here if you want internal PCI support on Thunder SoC.
> +
>  endmenu
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 140d66f..a355155 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -17,3 +17,5 @@ obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
>  obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
>  obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
>  obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
> +obj-$(CONFIG_PCI_THUNDER) += pcie-thunder.o
> +obj-$(CONFIG_PCI_THUNDER_PEM) += pcie-thunder-pem.o
> diff --git a/drivers/pci/host/pcie-thunder-pem.c b/drivers/pci/host/pcie-thunder-pem.c
> new file mode 100644
> index 0000000..7861a8a
> --- /dev/null
> +++ b/drivers/pci/host/pcie-thunder-pem.c
> @@ -0,0 +1,462 @@
> +/*
> + * PCIe host controller driver for Cavium Thunder SOC
> + *
> + * Copyright (C) 2014,2015 Cavium Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +/* #define DEBUG 1 */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <linux/pci.h>
> +#include <linux/irqdomain.h>
> +#include <linux/msi.h>
> +#include <linux/irqchip/arm-gic-v3.h>

This looks very suspicious.

> +
> +#define THUNDER_SLI_S2M_REG_ACC_BASE   0x874001000000ull
> +
> +#define THUNDER_GIC                    0x801000000000ull
> +#define THUNDER_GICD_SETSPI_NSR                0x801000000040ull
> +#define THUNDER_GICD_CLRSPI_NSR                0x801000000048ull

Are these physical addresses related to your GIC?

Given that this is a driver for a "Thunder PCIe host controller", and
not a GIC, this driver has no business poking those registers. If you
need something to happen at the GIC, you must go via the irqchip
infrastructure in order to do so.

Additionally, there shouldn't be any hard-coded physical addresses in
this driver. They should all come from DT (or ACPI). That applies to
_all_ physical addresses in this driver.

> +int thunder_pem_requester_id(struct pci_dev *dev);
> +
> +static atomic_t thunder_pcie_ecam_probed;
> +
> +static u32 pci_requester_id_ecam(struct pci_dev *dev)
> +{
> +       return (((pci_domain_nr(dev->bus) >> 2) << 19) |
> +               ((pci_domain_nr(dev->bus) % 4) << 16) |
> +               (dev->bus->number << 8) | dev->devfn);
> +}
> +
> +static u32 thunder_pci_requester_id(struct pci_dev *dev, u16 alias)
> +{
> +       int ret;
> +
> +       ret = thunder_pem_requester_id(dev);
> +       if (ret >= 0)
> +               return (u32)ret;
> +
> +       return pci_requester_id_ecam(dev);
> +}

Master IDs should be described in IORT with ACPI, and there's ongoing
discussion regarding what to do for DT [1] (I'll be posting updates
shortly).

This shouldn't live in driver code where it's non-standard and hidden
from other subsystems which need it (e.g. KVM).

> +/*
> + * All PCIe devices in Thunder have fixed resources, shouldn't be reassigned.

If this is the case, what's stopping you using the generic PCIe driver
that we already have?

Also isn't pci-probe-only sufficient?

> + * Also claim the device's valid resources to set 'res->parent' hierarchy.
> + */
> +static void pci_dev_resource_fixup(struct pci_dev *dev)
> +{
> +       struct resource *res;
> +       int resno;
> +
> +       /*
> +        * If the ECAM is not yet probed, we must be in a virtual
> +        * machine.  In that case, don't mark things as
> +        * IORESOURCE_PCI_FIXED
> +        */

You always set thunder_pcie_ecam_probed when the driver probes, and I
can't see what that has to do w.r.t. physical vs virtual machines.

What am I missing?

> +       if (!atomic_read(&thunder_pcie_ecam_probed))
> +               return;
> +
> +       for (resno = 0; resno < PCI_NUM_RESOURCES; resno++)
> +               dev->resource[resno].flags |= IORESOURCE_PCI_FIXED;
> +
> +       for (resno = 0; resno < PCI_BRIDGE_RESOURCES; resno++) {
> +               res = &dev->resource[resno];
> +               if (res->parent || !(res->flags & IORESOURCE_MEM))
> +                       continue;
> +               pci_claim_resource(dev, resno);
> +       }
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID,
> +                       pci_dev_resource_fixup);

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354997.html
