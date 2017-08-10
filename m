Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47109 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753157AbdHJQQM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2017 12:16:12 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: Re: [PATCH 2/3] ACPICA: Make it possible to enable runtime GPEs earlier
Date: Thu, 10 Aug 2017 18:07:53 +0200
Message-ID: <3742420.ImyUv4XNlU@aspire.rjw.lan>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CF06700@SHSMSX101.ccr.corp.intel.com>
References: <12346760.yAFCnkEgf6@aspire.rjw.lan> <51836747.M49Hy56X72@aspire.rjw.lan> <1AE640813FDE7649BE1B193DEA596E886CF06700@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, August 10, 2017 3:52:05 AM CEST Zheng, Lv wrote:
> Hi, Rafael
> 
> For this patch, I have a concern.
> 
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Subject: [PATCH 2/3] ACPICA: Make it possible to enable runtime GPEs earlier
> > 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Runtime GPEs have corresponding _Lxx/_Exx methods and are enabled
> > automatically during the initialization of the ACPI subsystem through
> > acpi_update_all_gpes() with the assumption that acpi_setup_gpe_for_wake()
> > will be called in advance for all of the GPEs pointed to by _PRW
> > objects in the namespace that may be affected by acpi_update_all_gpes().
> > That is, acpi_ev_initialize_gpe_block() can only be called for a GPE
> > block after acpi_setup_gpe_for_wake() has been called for all of the
> > _PRW (wakeup) GPEs in it.
> > 
> > The platform firmware on some systems, however, expects GPEs to be
> > enabled before the enumeration of devices which is when
> > acpi_setup_gpe_for_wake() is called and that goes against the above
> > assumption.
> > 
> > For this reason, introduce a new flag to be set by
> > acpi_ev_initialize_gpe_block() when automatically enabling a GPE
> > to indicate to acpi_setup_gpe_for_wake() that it needs to drop the
> > reference to the GPE coming from acpi_ev_initialize_gpe_block()
> > and modify acpi_setup_gpe_for_wake() accordingly.  These changes
> > allow acpi_setup_gpe_for_wake() and acpi_ev_initialize_gpe_block()
> > to be invoked in any order.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/acpica/evgpeblk.c |    2 ++
> >  drivers/acpi/acpica/evxfgpe.c  |    8 ++++++++
> >  include/acpi/actypes.h         |    3 ++-
> >  3 files changed, 12 insertions(+), 1 deletion(-)
> > 
> > Index: linux-pm/drivers/acpi/acpica/evgpeblk.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/acpica/evgpeblk.c
> > +++ linux-pm/drivers/acpi/acpica/evgpeblk.c
> > @@ -496,6 +496,8 @@ acpi_ev_initialize_gpe_block(struct acpi
> >  				continue;
> >  			}
> > 
> > +			gpe_event_info->flags |= ACPI_GPE_AUTO_ENABLED;
> > +
> >  			if (event_status & ACPI_EVENT_FLAG_STATUS_SET) {
> >  				ACPI_INFO(("GPE 0x%02X active on init",
> >  					   gpe_number));
> > Index: linux-pm/include/acpi/actypes.h
> > ===================================================================
> > --- linux-pm.orig/include/acpi/actypes.h
> > +++ linux-pm/include/acpi/actypes.h
> > @@ -783,7 +783,7 @@ typedef u32 acpi_event_status;
> >   *   |  | | |  +-- Type of dispatch:to method, handler, notify, or none
> >   *   |  | | +----- Interrupt type: edge or level triggered
> >   *   |  | +------- Is a Wake GPE
> > - *   |  +--------- Is GPE masked by the software GPE masking mechanism
> > + *   |  +--------- Has been enabled automatically at init time
> >   *   +------------ <Reserved>
> >   */
> >  #define ACPI_GPE_DISPATCH_NONE          (u8) 0x00
> > @@ -799,6 +799,7 @@ typedef u32 acpi_event_status;
> >  #define ACPI_GPE_XRUPT_TYPE_MASK        (u8) 0x08
> > 
> >  #define ACPI_GPE_CAN_WAKE               (u8) 0x10
> > +#define ACPI_GPE_AUTO_ENABLED           (u8) 0x20
> > 
> >  /*
> >   * Flags for GPE and Lock interfaces
> > Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
> > +++ linux-pm/drivers/acpi/acpica/evxfgpe.c
> > @@ -435,6 +435,14 @@ acpi_setup_gpe_for_wake(acpi_handle wake
> >  		 */
> >  		gpe_event_info->flags =
> >  		    (ACPI_GPE_DISPATCH_NOTIFY | ACPI_GPE_LEVEL_TRIGGERED);
> > +	} else if (gpe_event_info->flags & ACPI_GPE_AUTO_ENABLED) {
> > +		/*
> > +		 * A reference to this GPE has been added during the GPE block
> > +		 * initialization, so drop it now to prevent the GPE from being
> > +		 * permanently enabled and clear its ACPI_GPE_AUTO_ENABLED flag.
> > +		 */
> > +		(void)acpi_ev_remove_gpe_reference(gpe_event_info);
> > +		gpe_event_info->flags &= ~ACPI_GPE_AUTO_ENABLED;
> 
> The problem is if the GPE is shared, how can we know decrement reference
> once can sufficiently convert it into wakeup dispatcher owned GPE?

Even if it is shared, the current code will not enable it if it sees
ACPI_GPE_CAN_WAKE set.

We can change that logic, but that should be a separate patch IMO and
this is not related to the problem at hand.

Thanks,
Rafael
