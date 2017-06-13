Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "brian.starkey@arm.com" <brian.starkey@arm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        John Garry <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>
Subject: RE: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
 devices before scanning
Date: Tue, 13 Jun 2017 07:24:01 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40AAB7FC@FRAEML521-MBX.china.huawei.com>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495712248-5232-6-git-send-email-gabriele.paoloni@huawei.com>
 <20170530132408.GA2556@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E40A7B677@FRAEML521-MBX.china.huawei.com>
 <20170606085553.GA20085@red-moon> <20170612155700.GA31930@red-moon>
In-Reply-To: <20170612155700.GA31930@red-moon>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo, Rafael

> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: 12 June 2017 16:57
> To: Gabriele Paoloni; rafael@kernel.org; Rafael J. Wysocki; Mika
> Westerberg
> Cc: catalin.marinas@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> frowand.list@gmail.com; bhelgaas@google.com; arnd@arndb.de; linux-arm-
> kernel@lists.infradead.org; mark.rutland@arm.com;
> brian.starkey@arm.com; olof@lixom.net; benh@kernel.crashing.org; linux-
> kernel@vger.kernel.org; linux-acpi@vger.kernel.org; Linuxarm; linux-
> pci@vger.kernel.org; minyard@acm.org; John Garry; xuwei (O)
> Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
> devices before scanning
> 
> [+Mika]
> 
> Gab, Rafael,
> 
> On Tue, Jun 06, 2017 at 09:55:53AM +0100, Lorenzo Pieralisi wrote:
> > Hi Gab, Rafael,
> >
> > On Wed, May 31, 2017 at 10:24:47AM +0000, Gabriele Paoloni wrote:
> >
> > [...]
> >
> > > > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > > > > index e39ec7b..37dd23c 100644
> > > > > --- a/drivers/acpi/scan.c
> > > > > +++ b/drivers/acpi/scan.c
> > > > > @@ -2035,6 +2035,7 @@ int __init acpi_scan_init(void)
> > > > >  	acpi_int340x_thermal_init();
> > > > >  	acpi_amba_init();
> > > > >  	acpi_watchdog_init();
> > > > > +	acpi_indirectio_scan_init();
> >
> > Unfortunately this is becoming a pattern and we are ending up
> > with a static ordering of "subsystems" init (even though for this
> > LPC series it is just the Hisilicon driver that requires this call)
> > and I am not sure I see any way of avoiding it. I think that's always
> > been the case in x86, with fewer subsystems/kernel paths to care
> > about, I wanted to flag this up though to check your opinion since
> > I am not sure this is the right direction we are taking.
> >
> > I also think that relying on _DEP to build any dependency is not
> > entirely a) usable (owing to legacy bindings and previous _DEP
> misuse)
> > and b) compliant with ACPI bindings given that _DEP has to be used
> > for operation regions only.
> 
> I had a more in-depth look at this series and from my understanding
> the problem are the following to manage the LPC bindings in ACPI.
> 
> (1) Child devices of an LPC controller require special handling when
>     filling their resources (ie they need to be translated - in DT
>     that's guaranteed by the "isa" binding, in ACPI it has to be
>     done by new code)

Correct, LPC resources need to be translated in a virtual IO port
address space.
We cannot strictly follow the ISA bindings as the LPC host does not
define a mapping (through the "range" property) between a CPU address
range and an LPC address range.
Instead LPC has got his own bus accessors; therefore the bus address
range that LPC operates on is directly mapped into the IO port address
range and the IO in/out standard accessors (include/asm-generic/io.h)
are redefined to use the LPC accessors for the virtual IO port address
range that corresponds to LPC. 

> (2) In DT systems, LPC child devices are created by the LPC bus
>     controller driver through an of_platform_populate() call with
>     the LPC controller node as the fwnode root. For ACPI to work
>     the same way there must be a way to prevent LPC children to
>     be enumerated in acpi_default_enumeration() something like
>     I2C does (and then the LPC driver would enumerate its children as
>     DT does)

Correct.

> 
> I am not sure how (1) and (2) can be managed with current ACPI bindings
> and kernel code - I suspect it may be done by mirroring what's done
> for I2C but I am not sure, that's why I CC'ed Mika (ie the LPC adapter
> is matched as a platform device and it takes care of enumerating its
> children - problem though is preventing enumeration from core ACPI
> code).

Yes my idea was to have a scan handler that enumerate the children devices
and translate its addresses filling dev->resources[] and at the same time
we can modify acpi_default_enumeration() to check acpi_device_enumerated()
before continuing with device enumeration...?

Many thanks
Gab

> 
> I will let Gabriele and Hisilicon guys chime in if I missed something,
> which is likely, please let me know your opinion on how this code
> can be made functional on ACPI systems - it is uncharted territory.
> 
> Thank you !
> Lorenzo
> 
> >
> > Thoughts ?
> >
> > Thanks,
> > Lorenzo
> >
> > > > >  	acpi_scan_add_handler(&generic_device_handler);
> > > > >
> > > > > diff --git a/include/acpi/acpi_indirect_pio.h
> > > > b/include/acpi/acpi_indirect_pio.h
> > > > > new file mode 100644
> > > > > index 0000000..efc5c43
> > > > > --- /dev/null
> > > > > +++ b/include/acpi/acpi_indirect_pio.h
> > > > > @@ -0,0 +1,24 @@
> > > > > +/*
> > > > > + * ACPI support for indirect-PIO bus.
> > > > > + *
> > > > > + * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
> > > > > + * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > > > > + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
> > > > > + *
> > > > > + * This program is free software; you can redistribute it
> and/or
> > > > modify
> > > > > + * it under the terms of the GNU General Public License
> version 2 as
> > > > > + * published by the Free Software Foundation.
> > > > > + */
> > > > > +
> > > > > +#ifndef _ACPI_INDIRECT_PIO_H
> > > > > +#define _ACPI_INDIRECT_PIO_H
> > > > > +
> > > > > +struct indirect_pio_device_desc {
> > > > > +	void *pdata; /* device relevant info data */
> > > > > +	int (*pre_setup)(struct acpi_device *adev, void *pdata);
> > > > > +};
> > > > > +
> > > > > +int acpi_set_logic_pio_resource(struct device *child,
> > > > > +		struct device *hostdev);
> > > > > +
> > > > > +#endif
> > > > > --
> > > > > 2.7.4
> > > > >
> > > > >
