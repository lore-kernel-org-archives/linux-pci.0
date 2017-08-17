Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:52846 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751851AbdHQC0L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Aug 2017 22:26:11 -0400
From: "Zheng, Lv" <lv.zheng@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 3/3] ACPI / scan: Enable GPEs before scanning the
 namespace
Date: Thu, 17 Aug 2017 02:25:52 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CF0BC6D@SHSMSX101.ccr.corp.intel.com>
References: <12346760.yAFCnkEgf6@aspire.rjw.lan>
 <6344941.kJ2o2XerZ0@aspire.rjw.lan>
 <1AE640813FDE7649BE1B193DEA596E886CF0AFE3@SHSMSX101.ccr.corp.intel.com>
 <1868898.NJio3FymBZ@aspire.rjw.lan>
In-Reply-To: <1868898.NJio3FymBZ@aspire.rjw.lan>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Rafael

> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Subject: Re: [PATCH 3/3] ACPI / scan: Enable GPEs before scanning the namespace
> 
> On Tuesday, August 15, 2017 4:12:24 AM CEST Zheng, Lv wrote:
> > Hi, Rafael
> >
> > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of
> Rafael J.
> > > Wysocki
> > > Subject: [PATCH 3/3] ACPI / scan: Enable GPEs before scanning the namespace
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > On some systems the platform firmware expects GPEs to be enabled
> > > before the enumeration of devices and if that expectation is not
> > > met, the systems in question may not boot in some situations.
> > >
> > > For this reason, change the initialization ordering of the ACPI
> > > subsystem to make it enable GPEs before scanning the namespace
> > > for the first time in order to enumerate devices.
> > >
> > > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/acpi/scan.c |    8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > Index: linux-pm/drivers/acpi/scan.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/acpi/scan.c
> > > +++ linux-pm/drivers/acpi/scan.c
> > > @@ -2139,6 +2139,10 @@ int __init acpi_scan_init(void)
> > >  			acpi_get_spcr_uart_addr();
> > >  	}
> > >
> > > +	acpi_gpe_apply_masked_gpes();
> > > +	acpi_update_all_gpes();
> > > +	acpi_ec_ecdt_start();
> > > +
> >
> > Just for your information.
> > A recent internal bug reveals that acpi_ec_ecdt_start() should only be
> > invoked after the enumeration (acpi_ec_add()) for now.
> > The function contains logics that need to be altered by acpi_ec_add().
> >
> > So it seems we can only do less aggressive change by moving the GPE
> > related 2 lines up.
> 
> OK, done.
> 
> Please check my linux-next branch and see if that's what it should be.

I confirmed.
And refreshed my EC regression fix on top of that with v2 tagged in the subjects.

Thanks and best regards
Lv
