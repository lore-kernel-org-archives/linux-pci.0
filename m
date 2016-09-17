Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 17 Sep 2016 15:49:43 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 2/4] PCI: Query platform firmware for device power state
Message-ID: <20160917134943.GA1453@wunner.de>
References: <cover.1472554278.git.lukas@wunner.de>
 <5506823.86CoiunRKu@vostro.rjw.lan>
 <20160914105024.GC1597@wunner.de>
 <1707182.o83Q5WOaET@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1707182.o83Q5WOaET@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 14, 2016 at 03:01:33PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, September 14, 2016 12:50:24 PM Lukas Wunner wrote:
> > On Wed, Sep 14, 2016 at 02:21:30AM +0200, Rafael J. Wysocki wrote:
> > > On Wednesday, August 31, 2016 08:15:18 AM Lukas Wunner wrote:
> > > > +
> > > > +	if (!adev || !acpi_device_power_manageable(adev))
> > > > +		return PCI_UNKNOWN;
> > > > +
> > > > +	if (acpi_device_get_power(adev, &state) || state < ACPI_STATE_D0
> > > > +						|| state > ACPI_STATE_D3_COLD)
> > > 
> > > If the device is power-manageable by ACPI (you've just checked that) and
> > > acpi_device_get_power() returns success (0), the returned state is
> > > guaranteed to be within the boundaries (if it isn't, there is a bug that
> > > needs to be fixed).
> > 
> > No, acpi_device_get_power() can also return ACPI_STATE_UNKNOWN, which has
> > the value 0xff.
> 
> That would be the case without power resources or _PSC, right?

There's this check in acpi_device_get_power():

                else if (result == ACPI_STATE_UNKNOWN)
                        result = psc > ACPI_STATE_D2 ? ACPI_STATE_D3_HOT : psc;

where "result" has been set further up by acpi_power_get_inferred_state().
If acpi_power_get_inferred_state() does return this value and _PSC is
not present (i.e. device->power.flags.explicit_get is not set),
then acpi_device_get_power() would return ACPI_STATE_UNKNOWN.

Also, if the device is not power manageable, has neither power resources
nor _PSC, and its parent has power state ACPI_STATE_UNKNOWN, then this
will be returned.


> > I could add that to state_conv[] above but then I'd have an array with
> > 256 integers on the stack, most of them 0, which I don't want.
> > I could check for != ACPI_STATE_UNKNOWN but checking the boundaries seemed
> > safer.
> 
> Well, I'm not sure in what way it is safer and you get one check instead of
> two. :-)
> 
> > So I maintain that the code is correct.
> 
> It simply contains an redundant check.

Fair enough, I'm only checking for ACPI_STATE_UNKNOWN now.


> > > >  void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
> > > >  {
> > > > -	if (dev->pm_cap) {
> > > > +	if (platform_pci_get_power_state(dev) == PCI_D3cold) {
> > > > +		dev->current_state = PCI_D3cold;
> > > > +	} else if (dev->pm_cap) {
> > > 
> > > Why exactly do you need to change this function?
> > 
> > It would be pointless to add the ->platform_pci_get_power_state
> > hook without using it anywhere, wouldn't it?
> 
> That depends on what you want to do with it next.  Callers may be added in
> separate patches, no problem with that.

I've moved the change of pci_update_current_state() to a separate patch now,
that will also make it easier to revert it, should anything blow up.


> pci_update_current_state() is called in a few places with assumptions that
> need to be re-evaluated to see if they still hold after the changes.  They
> probably do, but then again, these call sites need to be double checked.
> If you did that, then fine.

pci_update_current_state() is called whenever a device is resumed
(both runtime and after system sleep) and after changing its power
state using the platform in pci_platform_power_transition().

With the new patch, pci_update_current_state() will be more accurate
than it is now:  Laptop hybrid graphics which are not platform-power-
manageable (older Optimus/ATPX or current MacBook Pro) will power
down the GPU but its current_state will be D3hot.  That's because
nouveau/radeon call pci_set_power_state(pdev, PCI_D3cold) and the
PCI core will only put it in D3hot due to the lack of platform-power-
manageability.  When the device is resumed, pci_update_current_state()
will now change the current_state from D3hot to D3cold.  I'm actually
seeing this on my MacBook Pro.  When the system is subsequently put
to sleep, direct_complete will still be afforded despite the changed
current_state because of the first patch in this series.  Works like
a charm, I'm curious if this causes issues for others, but I doubt it.


> And if you want to change that logic for PCI, it would be good to change it
> in the same way for acpi_general_pm_domain which has exactly the same
> problem.

Hm, with PCI I can read the PMCSR and detect D3cold by reading the
vendor ID.  For generic ACPI devices, I don't have that so I have
to rely on the accuracy of acpi_device_get_power().  However as
you've pointed out, it might misrepresent D3cold as D3hot, and it
might incorrectly report D0 even though the device is in a different
state.  Is it safe to rely on acpi_device_get_power() then?

Another idea would be to use acpi_device_get_power() for PCI devices
without PM capability.  Then we could do away with the "state"
argument to pci_update_current_state().  This too hinges on the
reliability of acpi_device_get_power() of course.  At least D3cold
can be detected by reading the vendor ID, so we're not reliant on
ACPI for that.  I've even got a commit on my development branch
to make that change, but I can't test it, my machine doesn't have
PCI devices without PM cap.

Thanks,

Lukas
