Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 6 Jun 2017 09:55:53 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>, rafael@kernel.org
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
Message-ID: <20170606085553.GA20085@red-moon>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495712248-5232-6-git-send-email-gabriele.paoloni@huawei.com>
 <20170530132408.GA2556@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E40A7B677@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40A7B677@FRAEML521-MBX.china.huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gab, Rafael,

On Wed, May 31, 2017 at 10:24:47AM +0000, Gabriele Paoloni wrote:

[...]

> > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > > index e39ec7b..37dd23c 100644
> > > --- a/drivers/acpi/scan.c
> > > +++ b/drivers/acpi/scan.c
> > > @@ -2035,6 +2035,7 @@ int __init acpi_scan_init(void)
> > >  	acpi_int340x_thermal_init();
> > >  	acpi_amba_init();
> > >  	acpi_watchdog_init();
> > > +	acpi_indirectio_scan_init();

Unfortunately this is becoming a pattern and we are ending up
with a static ordering of "subsystems" init (even though for this
LPC series it is just the Hisilicon driver that requires this call)
and I am not sure I see any way of avoiding it. I think that's always
been the case in x86, with fewer subsystems/kernel paths to care
about, I wanted to flag this up though to check your opinion since
I am not sure this is the right direction we are taking.

I also think that relying on _DEP to build any dependency is not
entirely a) usable (owing to legacy bindings and previous _DEP misuse)
and b) compliant with ACPI bindings given that _DEP has to be used
for operation regions only.

Thoughts ?

Thanks,
Lorenzo

> > >  	acpi_scan_add_handler(&generic_device_handler);
> > >
> > > diff --git a/include/acpi/acpi_indirect_pio.h
> > b/include/acpi/acpi_indirect_pio.h
> > > new file mode 100644
> > > index 0000000..efc5c43
> > > --- /dev/null
> > > +++ b/include/acpi/acpi_indirect_pio.h
> > > @@ -0,0 +1,24 @@
> > > +/*
> > > + * ACPI support for indirect-PIO bus.
> > > + *
> > > + * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
> > > + * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > > + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + */
> > > +
> > > +#ifndef _ACPI_INDIRECT_PIO_H
> > > +#define _ACPI_INDIRECT_PIO_H
> > > +
> > > +struct indirect_pio_device_desc {
> > > +	void *pdata; /* device relevant info data */
> > > +	int (*pre_setup)(struct acpi_device *adev, void *pdata);
> > > +};
> > > +
> > > +int acpi_set_logic_pio_resource(struct device *child,
> > > +		struct device *hostdev);
> > > +
> > > +#endif
> > > --
> > > 2.7.4
> > >
> > >
