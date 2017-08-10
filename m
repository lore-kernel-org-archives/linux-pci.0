Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Zheng, Lv" <lv.zheng@intel.com>
To: Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 3/3] ACPI / scan: Enable GPEs before scanning the
 namespace
Date: Thu, 10 Aug 2017 07:45:44 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CF078E7@SHSMSX101.ccr.corp.intel.com>
References: <12346760.yAFCnkEgf6@aspire.rjw.lan>
 <6344941.kJ2o2XerZ0@aspire.rjw.lan> <20170810051016.GA7953@wunner.de>
In-Reply-To: <20170810051016.GA7953@wunner.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

> From: Lukas Wunner [mailto:lukas@wunner.de]
> Subject: Re: [PATCH 3/3] ACPI / scan: Enable GPEs before scanning the namespace
> 
> On Thu, Aug 10, 2017 at 12:34:23AM +0200, Rafael J. Wysocki wrote:
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -2139,6 +2139,10 @@ int __init acpi_scan_init(void)
> >  			acpi_get_spcr_uart_addr();
> >  	}
> >
> > +	acpi_gpe_apply_masked_gpes();
> > +	acpi_update_all_gpes();
> > +	acpi_ec_ecdt_start();
> > +
> >  	mutex_lock(&acpi_scan_lock);
> >  	/*
> >  	 * Enumerate devices in the ACPI namespace.
> 
> I notice this is called from a subsys_initcall().  We scan the PCI bus
> much earlier in arch/x86/kernel/early-quirks.c and it would be possible
> to identify presence of Thunderbolt host controllers in an early quirk
> (using the method of pci_is_thunderbolt_attached()) and, if found,
> enable their GPEs or all GPEs.

We have 2 choices here:
1. GPE is a part of device enumeration.
   GPE must be enabled one by one after making sure that all related
   bus/devices are powered on.
   But it seems there is no such relationship between GPE and bus/device
   in ACPI spec.
   However if Windows works in this way, we'll regress by applying this
   patch.
2. GPE is not a part of device enumeration.
   Then probably we can even move GPE enabling into
   acip_initialize_objects(), before calling
   acpi_ns_initialize_devices(). As after preparing ACPI namespace,
   _Lxx/_Exx is ready, and ACPI subsystem should be able to handle early
   GPEs.
   And ACPI subsystem's device enumeration starts from
   acpi_ns_initialize_devices().

So this patch should be correct in theory. ;)

Thanks and best regards
Lv

> 
> Just as an aside in case your method doesn't work, I'm not affected by
> this issue being a Mac user... ;-)
> 
> Thanks,
> 
> Lukas
