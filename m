Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55164 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbdHJIXm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Aug 2017 04:23:42 -0400
Date: Thu, 10 Aug 2017 11:23:38 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lv Zheng <lv.zheng@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: Re: [PATCH 3/3] ACPI / scan: Enable GPEs before scanning the
 namespace
Message-ID: <20170810082338.GL2369@lahna.fi.intel.com>
References: <12346760.yAFCnkEgf6@aspire.rjw.lan>
 <6344941.kJ2o2XerZ0@aspire.rjw.lan>
 <20170810051016.GA7953@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170810051016.GA7953@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 10, 2017 at 07:10:16AM +0200, Lukas Wunner wrote:
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

I don't think we want to differentiate between Thunderbolt controller
and anything else. Point here is that we need to enable GPEs in the same
order than Windows does (before PCI scan) to be on the path that is at
least somehow tested.

> Just as an aside in case your method doesn't work, I'm not affected by
> this issue being a Mac user... ;-)

;-)
