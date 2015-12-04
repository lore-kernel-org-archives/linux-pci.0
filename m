Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"tn@semihalf.com" <tn@semihalf.com>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Wangyijing <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [RFC PATCH 1/2] PCI/ACPI: Add ACPI support for non ECAM Host
 Bridge Controllers
Date: Fri, 4 Dec 2015 12:47:37 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1EBE3E80@lhreml503-mbs>
References: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com>
 <1449155999-220955-2-git-send-email-gabriele.paoloni@huawei.com>
 <20151203175826.GB2935@red-moon>
In-Reply-To: <20151203175826.GB2935@red-moon>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo, many thanks for your review.

> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: 03 December 2015 17:58
> To: Gabriele Paoloni
> Cc: bhelgaas@google.com; arnd@arndb.de; will.deacon@arm.com;
> catalin.marinas@arm.com; hanjun.guo@linaro.org; Liviu.Dudau@arm.com;
> tn@semihalf.com; jiang.liu@linux.intel.com; tglx@linutronix.de; Wangyijing;
> linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linaro-
> acpi@lists.linaro.org; Wangzhou (B); liudongdong (C); xuwei (O); Liguozhu
> (Kenneth)
> Subject: Re: [RFC PATCH 1/2] PCI/ACPI: Add ACPI support for non ECAM Host
> Bridge Controllers
> 
> Hi Gab,
> 
> On Thu, Dec 03, 2015 at 11:19:58PM +0800, Gabriele Paoloni wrote:
> 
> [...]
> 
> > +void acpi_arm64_quirks(void)
> > +{
> > +	int i = 0;
> > +
> > +	while (quirks_array[i]) {
> > +		acpi_scan_add_handler(quirks_array[i]);
> > +		i++;
> > +	}
> > +
> > +}
> 
> This code is not arm64 specific, and this is part of a wider complaint
> I have about this patchset and PCI/ACPI code I see in general.

Mmmm Ok, I just followed the fashion used by pci_acpi_crs_quirks()...
so I agree that it is not strictly related with the ARM64 ip but
are quirks for PCI controllers integrated with ARM64 ip...

However if we can spot a better place for the quirks I am happier

> 
> > +
> > +/*
> > + * pci_ops specified by vendors that are not
> > + * ECAM compliant
> > + */
> > +struct pci_ops *vendor_specific_ops;
> > +
> > +/* function to set vendor specific ops */
> > +void set_quirk_pci_ops(struct pci_ops *quirk_ops)
> > +{
> > +	vendor_specific_ops = quirk_ops;
> > +}
> > +
> > +/* function to unset vendor specific ops */
> > +void unset_quirk_pci_ops(void)
> > +{
> > +	vendor_specific_ops = NULL;
> > +}
> > +
> >  /* Root bridge scanning */
> >  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> >  {
> > @@ -253,6 +291,9 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root
> *root)
> >  		return NULL;
> >  	}
> >
> > +	if (vendor_specific_ops)
> > +		acpi_pci_root_ops.pci_ops = vendor_specific_ops;
> 
> You are relying on the scan handlers calling ordering here, which as far
> as I know depends on the ACPI tables layout, this is not acceptable,

Yes you're right

> we need to find a more robust implementation.

Can't we use the "_DEP" object to set a dependency between "Device (PCI0)" 
and "Device (RC0)" (I am referring to the ACPI object example in patch 2/2)?

> 
> Let's first rewind a bit though, to summarize:
> 
> 1) we need a way to configure a "generic host controller" with host
>    controller specific config methods (ie ECAM, even though is a PCI
>    standard it is not standard enough for some designers)

Yes

> 2) we keep the generic "PNP0A03" matching to declare a host bridge and
>    related resources (?). Maybe we can have an HID matching the
>    "real" device (eg "HISI0081" and related DSD) and a CID set to "PNP0A03" ?
>    I do not want to end up with two device objects in the ACPI tables.

Mmmm I don't see what's wrong with our approach of having 
"Device (RC0)" for the specific host bridge HW and "Device (PCI0)"
for the generic one...

> 
> I think that all this code belongs in:
> 
> drivers/pci/host/pci-host-generic.c
> 
> and the quirks scan should be done _within_ the pci_acpi_scan_root()
> that should be placed in drivers/pci/host/pci-host-generic.c (ACPI probe
> path, to be created) so that, if quirks for config space have to be applied
> they are applied there before calling acpi_pci_root_create() so that
> ordering is guaranteed.
> 
> I will put together a proposal to define the way we specify HID and
> related DSD properties for PCI host controllers and send it to
> the ACPI working group for review.

Mmmm...what about instead using DMI decode to know which host bridge 
controller lives in the HW (and therefore calling the respective quirk)?
So there would be no change to ACPI specs, am I right?

> 
> Second, I am against merging _any_ ACPI/PCI code for arm64 before we
> define a way for the kernel to detect if resources should be reassigned
> or just claimed as they are, as set-up by BIOS.
> 
> The current approach, that relies on initcalls (and that's horrible) and
> that reassigns everything by default has to be overhauled to match
> what x86 does, which is sensible to me (tries to claim, and for
> resources that fail, it reassigns).
> 
> I will give this more thought and send a proposal to the ACPI working
> group for review, so that we make this part of the specs before any
> PCI/ACPI code for ARM64 gets close to the mainline kernel.
> 
> Comments welcome.
> 
> Thanks,
> Lorenzo
> 
> > +
> >  	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, info, root);
> >
> >  	/* After the PCI-E bus has been walked and all devices discovered,
> > diff --git a/arch/arm64/kernel/pci_quirks.h b/arch/arm64/kernel/pci_quirks.h
> > new file mode 100644
> > index 0000000..27055ff
> > --- /dev/null
> > +++ b/arch/arm64/kernel/pci_quirks.h
> > @@ -0,0 +1,24 @@
> > +/*
> > + * PCIe host controller declarations for ACPI quirks
> > + *
> > + * Copyright (C) 2015 HiSilicon Co., Ltd. http://www.hisilicon.com
> > + *
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef PCI_QUIRKS_H
> > +#define PCI_QUIRKS_H
> > +
> > +/* declarations of vendor specific quirks */
> > +extern struct acpi_scan_handler pci_root_hisi_handler;
> > +
> > +/* function to set vendor specific ops */
> > +void set_quirk_pci_ops(struct pci_ops *quirk_ops);
> > +
> > +/* function to unset vendor specific ops */
> > +void unset_quirk_pci_ops(void);
> > +
> > +#endif /*PCI_QUIRKS_H*/
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index e682dc6..ff362bb3d 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -863,5 +863,9 @@ void __init acpi_pci_root_init(void)
> >  		return;
> >
> >  	pci_acpi_crs_quirks();
> > +
> > +	/* Call quirks for non ECAM ARM64 Host Brdge controllers */
> > +	acpi_arm64_quirks();
> > +
> >  	acpi_scan_add_handler_with_hotplug(&pci_root_handler, "pci_root");
> >  }
> > diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> > index 29c6912..17f4a37 100644
> > --- a/include/acpi/acpi_drivers.h
> > +++ b/include/acpi/acpi_drivers.h
> > @@ -99,6 +99,12 @@ void pci_acpi_crs_quirks(void);
> >  static inline void pci_acpi_crs_quirks(void) { }
> >  #endif
> >
> > +#ifdef CONFIG_ARM64
> > +void acpi_arm64_quirks(void);
> > +#else
> > +static inline void acpi_arm64_quirks(void) { }
> > +#endif
> > +
> >  /* ------------------------------------------------------------------------
> --
> >                                      Processor
> >     ------------------------------------------------------------------------
> -- */
> > --
> > 1.9.1
> >
