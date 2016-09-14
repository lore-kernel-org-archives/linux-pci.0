Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 2/4] PCI: Query platform firmware for device power state
Date: Wed, 14 Sep 2016 15:01:33 +0200
Message-ID: <1707182.o83Q5WOaET@vostro.rjw.lan>
In-Reply-To: <20160914105024.GC1597@wunner.de>
References: <cover.1472554278.git.lukas@wunner.de> <5506823.86CoiunRKu@vostro.rjw.lan> <20160914105024.GC1597@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 14, 2016 12:50:24 PM Lukas Wunner wrote:
> On Wed, Sep 14, 2016 at 02:21:30AM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, August 31, 2016 08:15:18 AM Lukas Wunner wrote:
> > > Usually the most accurate way to determine a PCI device's power state is
> > > to read its PM Control & Status Register.  There are two cases however
> > > when this is not an option:  If the device doesn't have the PM
> > > capability at all, or if it is in D3cold.
> > > 
> > > In D3cold, reading from config space typically results in a fabricated
> > > "all ones" response.  But in D3hot, the two bits representing the power
> > > state in the PMCSR are *also* set to 1.  Thus D3hot and D3cold are not
> > > discernible by just reading the PMCSR.
> > > 
> > > A (supposedly) reliable way to detect D3cold is to query the platform
> > > firmware for its opinion on the device's power state.  To this end,
> > > add a ->get_power callback to struct pci_platform_pm_ops, and an
> > > implementation to acpi_pci_platform_pm.  (The only pci_platform_pm_ops
> > > existing so far).
> > > 
> > > Amend pci_update_current_state() to query the platform firmware before
> > > reading the PMCSR.
> > > 
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > ---
> > >  drivers/pci/pci-acpi.c | 23 +++++++++++++++++++++++
> > >  drivers/pci/pci.c      | 21 ++++++++++++++++-----
> > >  drivers/pci/pci.h      |  3 +++
> > >  3 files changed, 42 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > index 9a033e8..89f2707 100644
> > > --- a/drivers/pci/pci-acpi.c
> > > +++ b/drivers/pci/pci-acpi.c
> > > @@ -452,6 +452,28 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> > >  	return error;
> > >  }
> > >  
> > > +static pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
> > > +{
> > > +	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> > > +	static const pci_power_t state_conv[] = {
> > > +		[ACPI_STATE_D0]      = PCI_D0,
> > > +		[ACPI_STATE_D1]      = PCI_D1,
> > > +		[ACPI_STATE_D2]      = PCI_D2,
> > > +		[ACPI_STATE_D3_HOT]  = PCI_D3hot,
> > > +		[ACPI_STATE_D3_COLD] = PCI_D3cold,
> > > +	};
> > > +	int state;
> > 
> > ACPI_STATE_D3_HOT and ACPI_STATE_D3_COLD were introduced in ACPI 4.0.  For
> > systems predating that, ACPI_STATE_D3_HOT is the deepest state returned by
> > acpi_device_get_power().
> 
> Would it be possible to detect the ACPI spec version the platform
> firmware conforms to, and amend acpi_device_get_power() to return
> ACPI_STATE_D3_COLD if the device is in D3?
> 
> Then we could avoid the unnecessary runtime resume after direct_complete
> also for these older machines.

Well, please see below.

> Can the revision in the FADT (offset 8) be used as a proxy?
> => E.g. the old Clevo B7130 has revision 3 in the FADT and uses
>    a _DSM and _PS3 to put the discrete GPU in D3cold:
>    https://github.com/Lekensteyn/acpi-stuff/tree/master/dsl/Clevo_B7130
> => Whereas the newer Clevo P651RA has revision 5 in the FADT and uses
>    _PR3 to put the discrete GPU in D3cold:
>    https://github.com/Lekensteyn/acpi-stuff/tree/master/dsl/Clevo_P651RA
> 
> However the FADT revision was already 4 in the ACPI 3.0 spec,
> so we can only use it to discern ACPI 2.0 vs 3.0, not 3.0 vs 4.0,
> which is what we'd actually want.  And there's a comment in
> acpica/tbfadt.c that "The FADT revision value is unreliable."
> 
> Do you know of a better way to discern ACPI 3.0 vs 4.0?

I'm not sure if there is a reliable way to be honest.

Also even if the FADT etc tells you something, there's no guarantee that AML
actually follows that.

In fact, whether or not acpi_device_get_power() will ever return D3cold
for a device depends on whether or not _PR3 is there.  If it's not there,
the deepest state returned will be D3hot in any case.

So I'm not sure how useful that is in the context of D3cold detection?

> > 
> > > +
> > > +	if (!adev || !acpi_device_power_manageable(adev))
> > > +		return PCI_UNKNOWN;
> > > +
> > > +	if (acpi_device_get_power(adev, &state) || state < ACPI_STATE_D0
> > > +						|| state > ACPI_STATE_D3_COLD)
> > 
> > If the device is power-manageable by ACPI (you've just checked that) and
> > acpi_device_get_power() returns success (0), the returned state is guaranteed
> > to be within the boundaries (if it isn't, there is a bug that needs to be
> > fixed).
> 
> No, acpi_device_get_power() can also return ACPI_STATE_UNKNOWN, which has
> the value 0xff.

That would be the case without power resources or _PSC, right?

> I could add that to state_conv[] above but then I'd have
> an array with 256 integers on the stack, most of them 0, which I don't want.
> I could check for != ACPI_STATE_UNKNOWN but checking the boundaries seemed
> safer.

Well, I'm not sure in what way it is safer and you get one check instead of
two. :-)

> So I maintain that the code is correct.

It simply contains an redundant check.

> > 
> > > +		return PCI_UNKNOWN;
> > > +
> > > +	return state_conv[state];
> > > +}
> > > +
> > >  static bool acpi_pci_can_wakeup(struct pci_dev *dev)
> > >  {
> > >  	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> > > @@ -534,6 +556,7 @@ static bool acpi_pci_need_resume(struct pci_dev *dev)
> > >  static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
> > >  	.is_manageable = acpi_pci_power_manageable,
> > >  	.set_state = acpi_pci_set_power_state,
> > > +	.get_state = acpi_pci_get_power_state,
> > >  	.choose_state = acpi_pci_choose_state,
> > >  	.sleep_wake = acpi_pci_sleep_wake,
> > >  	.run_wake = acpi_pci_run_wake,
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 72a9d3a..e52e3d4 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -552,8 +552,9 @@ static const struct pci_platform_pm_ops *pci_platform_pm;
> > >  
> > >  int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
> > >  {
> > > -	if (!ops->is_manageable || !ops->set_state || !ops->choose_state ||
> > > -	    !ops->sleep_wake || !ops->run_wake || !ops->need_resume)
> > > +	if (!ops->is_manageable || !ops->set_state  || !ops->get_state ||
> > > +	    !ops->choose_state  || !ops->sleep_wake || !ops->run_wake  ||
> > > +	    !ops->need_resume)
> > >  		return -EINVAL;
> > >  	pci_platform_pm = ops;
> > >  	return 0;
> > > @@ -570,6 +571,11 @@ static inline int platform_pci_set_power_state(struct pci_dev *dev,
> > >  	return pci_platform_pm ? pci_platform_pm->set_state(dev, t) : -ENOSYS;
> > >  }
> > >  
> > > +static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
> > > +{
> > > +	return pci_platform_pm ? pci_platform_pm->get_state(dev) : PCI_UNKNOWN;
> > > +}
> > > +
> > >  static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
> > >  {
> > >  	return pci_platform_pm ?
> > > @@ -701,14 +707,19 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
> > >  }
> > >  
> > >  /**
> > > - * pci_update_current_state - Read PCI power state of given device from its
> > > - *                            PCI PM registers and cache it
> > > + * pci_update_current_state - Read power state of given device and cache it
> > >   * @dev: PCI device to handle.
> > >   * @state: State to cache in case the device doesn't have the PM capability
> > > + *
> > > + * The power state is read from the PMCSR register, which however is
> > > + * inaccessible in D3cold. The platform firmware is therefore queried first
> > > + * to detect accessibility of the register.
> > >   */
> > >  void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
> > >  {
> > > -	if (dev->pm_cap) {
> > > +	if (platform_pci_get_power_state(dev) == PCI_D3cold) {
> > > +		dev->current_state = PCI_D3cold;
> > > +	} else if (dev->pm_cap) {
> > 
> > Why exactly do you need to change this function?
> 
> It would be pointless to add the ->platform_pci_get_power_state
> hook without using it anywhere, wouldn't it?

That depends on what you want to do with it next.  Callers may be added in
separate patches, no problem with that.

> I am adding this here so that I can call pci_update_current_state()
> in patch [3/4] to compare the device's state after system sleep with
> the one before, and be able to discern D3hot and D3cold properly
> (as explained in the commit message above).
> 
> That said, I need to amend the patch to remove this portion in
> pci_update_current_state():
> 
>                 if (dev->current_state == PCI_D3cold)
>                         return;
> 
> because otherwise we'd never try to read the PMCSR if the firmware
> says the device is in <= D3hot.

pci_update_current_state() is called in a few places with assumptions that need
to be re-evaluated to see if they still hold after the changes.  They probably
do, but then again, these call sites need to be double checked.  If you did
that, then fine.

But I would say that (a) the next patch will add detection of the real
post-resume power state of "direct_complete" devices and it will use
pci_update_current_state() for that (to be consistent with the rest of
the code), so (b) pci_update_current_state() needs to ask ACPI about its
view on the power state of the device for this purpose.

And if you want to change that logic for PCI, it would be good to change it
in the same way for acpi_general_pm_domain which has exactly the same problem.

Thanks,
Rafael

