Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:55733 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbcHGJz5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 7 Aug 2016 05:55:57 -0400
Date: Sun, 7 Aug 2016 11:56:27 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 11/13] PM / sleep: Allow opt-out from runtime resume
 after direct-complete
Message-ID: <20160807095627.GB5679@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
 <9f0713b23baf7c6139a4b476cd9637d96e18cc95.1463134232.git.lukas@wunner.de>
 <10830072.vubE73bdx4@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10830072.vubE73bdx4@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 18, 2016 at 03:18:25PM +0200, Rafael J. Wysocki wrote:
> On Friday, May 13, 2016 01:15:31 PM Lukas Wunner wrote:
> > Since commit aae4518b3124 ("PM / sleep: Mechanism to avoid resuming
> > runtime-suspended devices unnecessarily"), we no longer wake up devices
> > which are already runtime suspended upon entering system sleep
> > ("direct-complete").
> > 
> > However commit 58a1fbbb2ee8 ("PM / PCI / ACPI: Kick devices that might
> > have been reset by firmware") changed this to mandatorily runtime resume
> > such devices after the system is woken.  The motivation was to ensure
> > that devices do not remain in a reset-power-on state after system
> > resume, potentially preventing deep SoC-wide low-power states from being
> > entered on idle.
> > 
> > This is counter-productive for devices of which we know that the
> > mandatory runtime resume is unnecessary.  Thunderbolt on the Mac is a
> > case in point: Runtime resume not just powers up the controller, but
> > multiple adjacent chips, including a 15V boost converter, multiplexers
> > and an eeprom.  Gratuitously powering this up after every system sleep
> > burns a not insignificant amount of energy and needlessly strains the
> > hardware.
> > 
> > Perhaps it would have been better to carry out the mandatory runtime
> > resume only for those devices that actually need it, but at least we
> > should allow an opt-out.
> > 
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> 
> I don't like this patch and especially adding a new dev_pm_ops flag to
> work around something that you're seeing as an issue in the generic ops.
> 
> It is sort of like saying "the generic ops don't work for me, so modify
> them as well as struct dev_pm_ops", but maybe it's better to change the
> PCI bus type to do something different from calling the generic function?
> 
> Or you can add a ->complete callback to your driver that will clear
> power.direct_complete for the device in question.

First of all, the direct_complete flag is marked "Owned by the PM core"
in include/linux/pm.h. So I would have expected that a driver is not
supposed to fudge it.

Second, yes it's possible to make it work by clearing direct_complete
in the ->complete callback, but there's a catch: The device tree is
traversed bottom-up in dpm_complete(). Recall that a Thunderbolt
controller consists of multiple devices and that power control is
governed by its top-most device (upstream bridge). But because we're
going bottom-up, clearing the direct_complete flag must be done by
the bottom-most device (NHI)! So I've got all the power management
stuff nicely separated in functions executed for the upstream bridge,
but a small portion needs to be executed for the NHI. That's ugly.

Normally the device hierarchy is traversed bottom-up during suspend
and top-down during resume. However ->prepare and ->complete do it
the other way round. In the case of ->prepare, this is even documented
in Documentation/power/devices.txt but the reason thereof is not.
Could you explain this please?

Third, I'm irritated by your question "maybe it's better to change the
PCI bus type to do something different from calling the generic function".
What should that be? Under which circumstances can we leave a PCI device
asleep after direct-complete?

I'm generally irritated by commit 58a1fbbb2ee8, it's a significant change
to mandatorily wake all devices, it wastes a not insignificant amount of
energy, yet the reasoning in the commit message sounds vague and handwavy
("There is a concern [...] devices that are most likely to be affected").

Are there clear indications for or against a device requiring a resume?
E.g. the commit message names SoCs, perhaps those can be recognized by
having child devices of certain types?

Thanks,

Lukas

> 
> > ---
> >  drivers/base/power/generic_ops.c | 3 ++-
> >  include/linux/pm.h               | 1 +
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
> > index 07c3c4a..6e88f55 100644
> > --- a/drivers/base/power/generic_ops.c
> > +++ b/drivers/base/power/generic_ops.c
> > @@ -316,7 +316,8 @@ void pm_complete_with_resume_check(struct device *dev)
> >  	 * the sleep state it is going out of and it has never been resumed till
> >  	 * now, resume it in case the firmware powered it up.
> >  	 */
> > -	if (dev->power.direct_complete && pm_resume_via_firmware())
> > +	if (dev->power.direct_complete && pm_resume_via_firmware() &&
> > +	    !dev->power.direct_complete_noresume)
> >  		pm_request_resume(dev);
> >  }
> >  EXPORT_SYMBOL_GPL(pm_complete_with_resume_check);
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index 6a5d654..023de94 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -596,6 +596,7 @@ struct dev_pm_info {
> >  	unsigned int		use_autosuspend:1;
> >  	unsigned int		timer_autosuspends:1;
> >  	unsigned int		memalloc_noio:1;
> > +	unsigned int		direct_complete_noresume:1;
> >  	enum rpm_request	request;
> >  	enum rpm_status		runtime_status;
> >  	int			runtime_error;
> > 
