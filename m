Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 3/4] PCI: Avoid unnecessary resume after direct-complete
Date: Wed, 14 Sep 2016 15:14:37 +0200
Message-ID: <1922917.c92rJWRLH6@vostro.rjw.lan>
In-Reply-To: <20160914095640.GB1597@wunner.de>
References: <cover.1472554278.git.lukas@wunner.de> <2963851.chF2hIakqz@vostro.rjw.lan> <20160914095640.GB1597@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 14, 2016 11:56:40 AM Lukas Wunner wrote:
> On Wed, Sep 14, 2016 at 02:50:13AM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, August 31, 2016 08:15:18 AM Lukas Wunner wrote:
> > > Commit 58a1fbbb2ee8 ("PM / PCI / ACPI: Kick devices that might have been
> > > reset by firmware") added a runtime resume for devices that were runtime
> > > suspended when the system entered sleep.
> > > 
> > > The motivation was that devices might be in a reset-power-on state after
> > > waking from system sleep, so their power state as perceived by Linux
> > > (stored in pci_dev->current_state) would no longer reflect reality.
> > > By resuming such devices, we allow them to return to a low-power state
> > > via autosuspend and also bring their current_state in sync with reality.
> > > 
> > > However for devices that are *not* in a reset-power-on state, doing an
> > > unconditional resume wastes energy.  A more refined approach is called
> > > for which issues a runtime resume only if the power state after
> > > direct-complete is shallower than it was before. To achieve this, update
> > > the device's current_state by querying the platform firmware and reading
> > > its PMCSR.
> > > 
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > ---
> > >  drivers/pci/pci-driver.c | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > index e39a67c..fd4b9c4 100644
> > > --- a/drivers/pci/pci-driver.c
> > > +++ b/drivers/pci/pci-driver.c
> > > @@ -684,8 +684,19 @@ static int pci_pm_prepare(struct device *dev)
> > >  
> > >  static void pci_pm_complete(struct device *dev)
> > >  {
> > > -	pci_dev_complete_resume(to_pci_dev(dev));
> > > -	pm_complete_with_resume_check(dev);
> > > +	struct pci_dev *pci_dev = to_pci_dev(dev);
> > > +
> > > +	pci_dev_complete_resume(pci_dev);
> > > +	pm_generic_complete(dev);
> > > +
> > > +	/* Resume device if platform firmware has put it in reset-power-on */
> > > +	if (dev->power.direct_complete && pm_resume_via_firmware()) {
> > > +		pci_power_t pre_sleep_state = pci_dev->current_state;
> > > +
> > > +		pci_update_current_state(pci_dev, pci_dev->current_state);
> > 
> > I'm not sure if this can be made reliable enough for all of the systems out
> > there (including the pre-ACPI-4.0 ones and so on).  I'm a bit concerned that
> > we'll uncover firmware issues and such by doing this.
> > 
> > How much of a problem the existing code is in practice?
> 
> Where's your ambition?  Do you want your power management to be as good
> as Apple's or are you going to waste energy for fear of uncovering
> firmware bugs?

That's not about my ambition or lack thereof, but about avoiding introducing
regressions on systems that are not Apple because of the ambition to be as
good as Apple.

And I'm not even talking about this particular piece of code, but about the
other code that calls pci_update_current_state().

> I first tried to solve this only for Thunderbolt by opting out of the
> mandatory resume after direct_complete.  It worked, but it was ugly.
> 
> (I have to clear the direct_complete flag in the ->complete hook, but
> the device tree is walked bottom-up during ->complete, and since the
> Thunderbolt controller exposes multiple devices, I have to clear the
> flag for all devices from the bottom-most device, which is the NHI.
> And all the rest of the s/r code lives on the top-most device, which
> is the upstream bridge.)
> 
> You suggested in your e-mail of July 18: "maybe it's better to change
> the PCI bus type to do something different from calling the generic
> function?"
> 
> So there, I did what you suggested and tried to fix it not just for
> Thunderbolt but for everyone.
> 
> And you're still not happy.
> 
> *sigh*

Sorry for disappointing you.

I have concerns, so I talk about them.  Is that wrong?  If so, what's wrong
about it?

My time goes into that as well, mind you.

> If on pre ACPI 4.0 systems, the device state is incorrectly reported
> as D3hot although the device is still in D3cold, the device will be
> runtime resumed to D0, just as it is now.  In other words, the benefit
> of avoiding an unnecessary runtime resume after direct_complete is
> only granted if the platform firmware reports the device state
> correctly.

OK

Which as I said in the other message I've just sent, if you use
acpi_device_get_power() for that, it will only report D3cold if (a) the device
has a _PR3 and (b) the power resources configuration in there indicates D3cold.

Does that cover the Thunderbolt case even?

Thanks,
Rafael

