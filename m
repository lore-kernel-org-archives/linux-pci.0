Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33670 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbbJFX02 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2015 19:26:28 -0400
Date: Tue, 6 Oct 2015 16:26:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [RFC][PATCH v3 3/3] input: i8042: Avoid resetting controller on
 system suspend/resume
Message-ID: <20151006232625.GI31850@dtor-ws>
References: <10641052.oOBhM6BU9G@vostro.rjw.lan>
 <1927174.T9TA7zgbS1@vostro.rjw.lan>
 <20151006224308.GD31850@dtor-ws>
 <1769930.Ws5UzSBdLV@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1769930.Ws5UzSBdLV@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 07, 2015 at 01:31:44AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, October 06, 2015 03:43:08 PM Dmitry Torokhov wrote:
> > On Wed, Oct 07, 2015 at 01:08:30AM +0200, Rafael J. Wysocki wrote:
> > > On Tuesday, October 06, 2015 03:34:42 PM Dmitry Torokhov wrote:
> > > > On Wed, Oct 07, 2015 at 12:53:49AM +0200, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > 
> > > > > If the upcoming system suspend is not going to be handled by the
> > > > > platform firmware, like in the suspend-to-idle case, it is not
> > > > > necessary to reset the controller in i8042_pm_suspend(), so avoid
> > > > > doing that.
> > > > > 
> > > > > Moreover, if the system resume currently in progress has not been
> > > > > started by the platform firmware, like in the suspend-to-idle case,
> > > > > i8042_controller_resume() need not be called by i8042_pm_resume(),
> > > > > so avoid doing that too in that case.
> > > > > 
> > > > > Additionally, try to catch the event that woke up the system by
> > > > > calling the interrupt handler early during system resume if it has
> > > > > not been started by the platform firmware.
> > > > > 
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >  drivers/input/serio/i8042.c |   15 +++++++++++++--
> > > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > > > 
> > > > > Index: linux-pm/drivers/input/serio/i8042.c
> > > > > ===================================================================
> > > > > --- linux-pm.orig/drivers/input/serio/i8042.c
> > > > > +++ linux-pm/drivers/input/serio/i8042.c
> > > > > @@ -24,6 +24,7 @@
> > > > >  #include <linux/platform_device.h>
> > > > >  #include <linux/i8042.h>
> > > > >  #include <linux/slab.h>
> > > > > +#include <linux/suspend.h>
> > > > >  
> > > > >  #include <asm/io.h>
> > > > >  
> > > > > @@ -1170,7 +1171,8 @@ static int i8042_pm_suspend(struct devic
> > > > >  {
> > > > >  	int i;
> > > > >  
> > > > > -	i8042_controller_reset(true);
> > > > > +	if (pm_suspend_via_firmware())
> > > > > +		i8042_controller_reset(true);
> > > > >  
> > > > >  	/* Set up serio interrupts for system wakeup. */
> > > > >  	for (i = 0; i < I8042_NUM_PORTS; i++) {
> > > > > @@ -1183,6 +1185,14 @@ static int i8042_pm_suspend(struct devic
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +static int i8042_pm_resume_noirq(struct device *dev)
> > > > > +{
> > > > > +	if (!pm_resume_via_firmware())
> > > > > +		i8042_interrupt(0, NULL);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  static int i8042_pm_resume(struct device *dev)
> > > > >  {
> > > > >  	int i;
> > > > > @@ -1199,7 +1209,7 @@ static int i8042_pm_resume(struct device
> > > > >  	 * to bring it in a sane state. (In case of S2D we expect
> > > > >  	 * BIOS to reset the controller for us.)
> > > > >  	 */
> > > > > -	return i8042_controller_resume(true);
> > > > > +	return pm_resume_via_firmware() ? i8042_controller_resume(true) : 0;
> > > > 
> > > > What happens if we were going to suspend via firmware so we reset the
> > > > controller but then we got wakeup condition and we actually did not
> > > > suspend. What pm_resume_via_firmware() will return in this case?
> > > 
> > > It will return 'false'.  Do we need to resume the controller then?
> > 
> > Yes.
> > 
> > >  But I guess
> > > 'false' should be passed to i8042_controller_resume() in that case?
> > 
> > Yes, we do not need to reset the controller in this case, just
> > reactivate multiplexing mode, etc.
> 
> So something like this I suppose:
> 
> ---
>  drivers/input/serio/i8042.c |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/input/serio/i8042.c
> ===================================================================
> --- linux-pm.orig/drivers/input/serio/i8042.c
> +++ linux-pm/drivers/input/serio/i8042.c
> @@ -24,6 +24,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/i8042.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  
>  #include <asm/io.h>
>  
> @@ -1170,7 +1171,8 @@ static int i8042_pm_suspend(struct devic
>  {
>  	int i;
>  
> -	i8042_controller_reset(true);
> +	if (pm_suspend_via_firmware())
> +		i8042_controller_reset(true);
>  
>  	/* Set up serio interrupts for system wakeup. */
>  	for (i = 0; i < I8042_NUM_PORTS; i++) {
> @@ -1183,6 +1185,14 @@ static int i8042_pm_suspend(struct devic
>  	return 0;
>  }
>  
> +static int i8042_pm_resume_noirq(struct device *dev)
> +{
> +	if (!pm_resume_via_firmware())
> +		i8042_interrupt(0, NULL);
> +
> +	return 0;
> +}
> +
>  static int i8042_pm_resume(struct device *dev)
>  {
>  	int i;
> @@ -1199,7 +1209,8 @@ static int i8042_pm_resume(struct device
>  	 * to bring it in a sane state. (In case of S2D we expect
>  	 * BIOS to reset the controller for us.)
>  	 */
> -	return i8042_controller_resume(true);
> +	return pm_suspend_via_firmware() ?
> +		i8042_controller_resume(pm_resume_via_firmware()) : 0;

Hmm, looks right, maybe just be more verbose...

	/*
	 * If firmware was not going to be involved in suspend we did
	 * not restore controller state to whatever it was when we were
	 * booting, so we do not need to do anything.
	 */
	if (!pm_suspend_via_firmware())
		return 0;

	/*
	 * We only need to reset controller if we are resuming after
	 * handing off control to the firmware, otherwise we can
	 * simply restore the mode.
	 */
	do_reset = pm_resume_via_firmware();

	return i8042_controller_resume(do_reset);

>  }
>  
>  static int i8042_pm_thaw(struct device *dev)
> @@ -1223,6 +1234,7 @@ static int i8042_pm_restore(struct devic
>  
>  static const struct dev_pm_ops i8042_pm_ops = {
>  	.suspend	= i8042_pm_suspend,
> +	.resume_noirq	= i8042_pm_resume_noirq,
>  	.resume		= i8042_pm_resume,
>  	.thaw		= i8042_pm_thaw,
>  	.poweroff	= i8042_pm_reset,
> 

-- 
Dmitry
