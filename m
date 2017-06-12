Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 12 Jun 2017 16:57:00 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>, rafael@kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
Message-ID: <20170612155700.GA31930@red-moon>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495712248-5232-6-git-send-email-gabriele.paoloni@huawei.com>
 <20170530132408.GA2556@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E40A7B677@FRAEML521-MBX.china.huawei.com>
 <20170606085553.GA20085@red-moon>
MIME-Version: 1.0
In-Reply-To: <20170606085553.GA20085@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "minyard@acm.org" <minyard@acm.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 John Garry <john.garry@huawei.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
 "olof@lixom.net" <olof@lixom.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "brian.starkey@arm.com" <brian.starkey@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+Mika]

Gab, Rafael,

On Tue, Jun 06, 2017 at 09:55:53AM +0100, Lorenzo Pieralisi wrote:
> Hi Gab, Rafael,
> 
> On Wed, May 31, 2017 at 10:24:47AM +0000, Gabriele Paoloni wrote:
> 
> [...]
> 
> > > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > > > index e39ec7b..37dd23c 100644
> > > > --- a/drivers/acpi/scan.c
> > > > +++ b/drivers/acpi/scan.c
> > > > @@ -2035,6 +2035,7 @@ int __init acpi_scan_init(void)
> > > >  	acpi_int340x_thermal_init();
> > > >  	acpi_amba_init();
> > > >  	acpi_watchdog_init();
> > > > +	acpi_indirectio_scan_init();
> 
> Unfortunately this is becoming a pattern and we are ending up
> with a static ordering of "subsystems" init (even though for this
> LPC series it is just the Hisilicon driver that requires this call)
> and I am not sure I see any way of avoiding it. I think that's always
> been the case in x86, with fewer subsystems/kernel paths to care
> about, I wanted to flag this up though to check your opinion since
> I am not sure this is the right direction we are taking.
> 
> I also think that relying on _DEP to build any dependency is not
> entirely a) usable (owing to legacy bindings and previous _DEP misuse)
> and b) compliant with ACPI bindings given that _DEP has to be used
> for operation regions only.

I had a more in-depth look at this series and from my understanding
the problem are the following to manage the LPC bindings in ACPI.

(1) Child devices of an LPC controller require special handling when
    filling their resources (ie they need to be translated - in DT
    that's guaranteed by the "isa" binding, in ACPI it has to be
    done by new code)
(2) In DT systems, LPC child devices are created by the LPC bus
    controller driver through an of_platform_populate() call with
    the LPC controller node as the fwnode root. For ACPI to work
    the same way there must be a way to prevent LPC children to
    be enumerated in acpi_default_enumeration() something like
    I2C does (and then the LPC driver would enumerate its children as
    DT does)

I am not sure how (1) and (2) can be managed with current ACPI bindings
and kernel code - I suspect it may be done by mirroring what's done
for I2C but I am not sure, that's why I CC'ed Mika (ie the LPC adapter
is matched as a platform device and it takes care of enumerating its
children - problem though is preventing enumeration from core ACPI code).

I will let Gabriele and Hisilicon guys chime in if I missed something,
which is likely, please let me know your opinion on how this code
can be made functional on ACPI systems - it is uncharted territory.

Thank you !
Lorenzo

> 
> Thoughts ?
> 
> Thanks,
> Lorenzo
> 
> > > >  	acpi_scan_add_handler(&generic_device_handler);
> > > >
> > > > diff --git a/include/acpi/acpi_indirect_pio.h
> > > b/include/acpi/acpi_indirect_pio.h
> > > > new file mode 100644
> > > > index 0000000..efc5c43
> > > > --- /dev/null
> > > > +++ b/include/acpi/acpi_indirect_pio.h
> > > > @@ -0,0 +1,24 @@
> > > > +/*
> > > > + * ACPI support for indirect-PIO bus.
> > > > + *
> > > > + * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
> > > > + * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > > > + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or
> > > modify
> > > > + * it under the terms of the GNU General Public License version 2 as
> > > > + * published by the Free Software Foundation.
> > > > + */
> > > > +
> > > > +#ifndef _ACPI_INDIRECT_PIO_H
> > > > +#define _ACPI_INDIRECT_PIO_H
> > > > +
> > > > +struct indirect_pio_device_desc {
> > > > +	void *pdata; /* device relevant info data */
> > > > +	int (*pre_setup)(struct acpi_device *adev, void *pdata);
> > > > +};
> > > > +
> > > > +int acpi_set_logic_pio_resource(struct device *child,
> > > > +		struct device *hostdev);
> > > > +
> > > > +#endif
> > > > --
> > > > 2.7.4
> > > >
> > > >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
