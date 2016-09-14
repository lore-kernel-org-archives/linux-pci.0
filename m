Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:34689 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760944AbcINKuK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2016 06:50:10 -0400
Date: Wed, 14 Sep 2016 12:50:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 2/4] PCI: Query platform firmware for device power state
Message-ID: <20160914105024.GC1597@wunner.de>
References: <cover.1472554278.git.lukas@wunner.de>
 <ee1e8bbc387594877162ef09acb5027444ac8f9a.1472554278.git.lukas@wunner.de>
 <5506823.86CoiunRKu@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5506823.86CoiunRKu@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 14, 2016 at 02:21:30AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, August 31, 2016 08:15:18 AM Lukas Wunner wrote:
> > Usually the most accurate way to determine a PCI device's power state is
> > to read its PM Control & Status Register.  There are two cases however
> > when this is not an option:  If the device doesn't have the PM
> > capability at all, or if it is in D3cold.
> > 
> > In D3cold, reading from config space typically results in a fabricated
> > "all ones" response.  But in D3hot, the two bits representing the power
> > state in the PMCSR are *also* set to 1.  Thus D3hot and D3cold are not
> > discernible by just reading the PMCSR.
> > 
> > A (supposedly) reliable way to detect D3cold is to query the platform
> > firmware for its opinion on the device's power state.  To this end,
> > add a ->get_power callback to struct pci_platform_pm_ops, and an
> > implementation to acpi_pci_platform_pm.  (The only pci_platform_pm_ops
> > existing so far).
> > 
> > Amend pci_update_current_state() to query the platform firmware before
> > reading the PMCSR.
> > 
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> >  drivers/pci/pci-acpi.c | 23 +++++++++++++++++++++++
> >  drivers/pci/pci.c      | 21 ++++++++++++++++-----
> >  drivers/pci/pci.h      |  3 +++
> >  3 files changed, 42 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index 9a033e8..89f2707 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -452,6 +452,28 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> >  	return error;
> >  }
> >  
> > +static pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
> > +{
> > +	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> > +	static const pci_power_t state_conv[] = {
> > +		[ACPI_STATE_D0]      = PCI_D0,
> > +		[ACPI_STATE_D1]      = PCI_D1,
> > +		[ACPI_STATE_D2]      = PCI_D2,
> > +		[ACPI_STATE_D3_HOT]  = PCI_D3hot,
> > +		[ACPI_STATE_D3_COLD] = PCI_D3cold,
> > +	};
> > +	int state;
> 
> ACPI_STATE_D3_HOT and ACPI_STATE_D3_COLD were introduced in ACPI 4.0.  For
> systems predating that, ACPI_STATE_D3_HOT is the deepest state returned by
> acpi_device_get_power().

Would it be possible to detect the ACPI spec version the platform
firmware conforms to, and amend acpi_device_get_power() to return
ACPI_STATE_D3_COLD if the device is in D3?

Then we could avoid the unnecessary runtime resume after direct_complete
also for these older machines.

Can the revision in the FADT (offset 8) be used as a proxy?
=> E.g. the old Clevo B7130 has revision 3 in the FADT and uses
   a _DSM and _PS3 to put the discrete GPU in D3cold:
   https://github.com/Lekensteyn/acpi-stuff/tree/master/dsl/Clevo_B7130
=> Whereas the newer Clevo P651RA has revision 5 in the FADT and uses
   _PR3 to put the discrete GPU in D3cold:
   https://github.com/Lekensteyn/acpi-stuff/tree/master/dsl/Clevo_P651RA

However the FADT revision was already 4 in the ACPI 3.0 spec,
so we can only use it to discern ACPI 2.0 vs 3.0, not 3.0 vs 4.0,
which is what we'd actually want.  And there's a comment in
acpica/tbfadt.c that "The FADT revision value is unreliable."

Do you know of a better way to discern ACPI 3.0 vs 4.0?

> 
> > +
> > +	if (!adev || !acpi_device_power_manageable(adev))
> > +		return PCI_UNKNOWN;
> > +
> > +	if (acpi_device_get_power(adev, &state) || state < ACPI_STATE_D0
> > +						|| state > ACPI_STATE_D3_COLD)
> 
> If the device is power-manageable by ACPI (you've just checked that) and
> acpi_device_get_power() returns success (0), the returned state is guaranteed
> to be within the boundaries (if it isn't, there is a bug that needs to be
> fixed).

No, acpi_device_get_power() can also return ACPI_STATE_UNKNOWN, which has
the value 0xff.  I could add that to state_conv[] above but then I'd have
an array with 256 integers on the stack, most of them 0, which I don't want.
I could check for != ACPI_STATE_UNKNOWN but checking the boundaries seemed
safer. So I maintain that the code is correct.

> 
> > +		return PCI_UNKNOWN;
> > +
> > +	return state_conv[state];
> > +}
> > +
> >  static bool acpi_pci_can_wakeup(struct pci_dev *dev)
> >  {
> >  	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> > @@ -534,6 +556,7 @@ static bool acpi_pci_need_resume(struct pci_dev *dev)
> >  static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
> >  	.is_manageable = acpi_pci_power_manageable,
> >  	.set_state = acpi_pci_set_power_state,
> > +	.get_state = acpi_pci_get_power_state,
> >  	.choose_state = acpi_pci_choose_state,
> >  	.sleep_wake = acpi_pci_sleep_wake,
> >  	.run_wake = acpi_pci_run_wake,
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 72a9d3a..e52e3d4 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -552,8 +552,9 @@ static const struct pci_platform_pm_ops *pci_platform_pm;
> >  
> >  int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
> >  {
> > -	if (!ops->is_manageable || !ops->set_state || !ops->choose_state ||
> > -	    !ops->sleep_wake || !ops->run_wake || !ops->need_resume)
> > +	if (!ops->is_manageable || !ops->set_state  || !ops->get_state ||
> > +	    !ops->choose_state  || !ops->sleep_wake || !ops->run_wake  ||
> > +	    !ops->need_resume)
> >  		return -EINVAL;
> >  	pci_platform_pm = ops;
> >  	return 0;
> > @@ -570,6 +571,11 @@ static inline int platform_pci_set_power_state(struct pci_dev *dev,
> >  	return pci_platform_pm ? pci_platform_pm->set_state(dev, t) : -ENOSYS;
> >  }
> >  
> > +static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
> > +{
> > +	return pci_platform_pm ? pci_platform_pm->get_state(dev) : PCI_UNKNOWN;
> > +}
> > +
> >  static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
> >  {
> >  	return pci_platform_pm ?
> > @@ -701,14 +707,19 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
> >  }
> >  
> >  /**
> > - * pci_update_current_state - Read PCI power state of given device from its
> > - *                            PCI PM registers and cache it
> > + * pci_update_current_state - Read power state of given device and cache it
> >   * @dev: PCI device to handle.
> >   * @state: State to cache in case the device doesn't have the PM capability
> > + *
> > + * The power state is read from the PMCSR register, which however is
> > + * inaccessible in D3cold. The platform firmware is therefore queried first
> > + * to detect accessibility of the register.
> >   */
> >  void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
> >  {
> > -	if (dev->pm_cap) {
> > +	if (platform_pci_get_power_state(dev) == PCI_D3cold) {
> > +		dev->current_state = PCI_D3cold;
> > +	} else if (dev->pm_cap) {
> 
> Why exactly do you need to change this function?

It would be pointless to add the ->platform_pci_get_power_state
hook without using it anywhere, wouldn't it?

I am adding this here so that I can call pci_update_current_state()
in patch [3/4] to compare the device's state after system sleep with
the one before, and be able to discern D3hot and D3cold properly
(as explained in the commit message above).

That said, I need to amend the patch to remove this portion in
pci_update_current_state():

                if (dev->current_state == PCI_D3cold)
                        return;

because otherwise we'd never try to read the PMCSR if the firmware
says the device is in <= D3hot.

Thanks,

Lukas

> 
> >  		u16 pmcsr;
> >  
> >  		/*
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 9730c47..01d5206 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -42,6 +42,8 @@ int pci_probe_reset_function(struct pci_dev *dev);
> >   *
> >   * @set_state: invokes the platform firmware to set the device's power state
> >   *
> > + * @get_state: queries the platform firmware for a device's current power state
> > + *
> >   * @choose_state: returns PCI power state of given device preferred by the
> >   *                platform; to be used during system-wide transitions from a
> >   *                sleeping state to the working state and vice versa
> > @@ -62,6 +64,7 @@ int pci_probe_reset_function(struct pci_dev *dev);
> >  struct pci_platform_pm_ops {
> >  	bool (*is_manageable)(struct pci_dev *dev);
> >  	int (*set_state)(struct pci_dev *dev, pci_power_t state);
> > +	pci_power_t (*get_state)(struct pci_dev *dev);
> >  	pci_power_t (*choose_state)(struct pci_dev *dev);
> >  	int (*sleep_wake)(struct pci_dev *dev, bool enable);
> >  	int (*run_wake)(struct pci_dev *dev, bool enable);
> > 
