Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 2/4] PCI: Query platform firmware for device power state
Date: Wed, 14 Sep 2016 23:36:40 +0200
Message-ID: <9274580.osmZYI2u5K@vostro.rjw.lan>
In-Reply-To: <2423504.PN3SurRX7i@vostro.rjw.lan>
References: <cover.1472554278.git.lukas@wunner.de> <1707182.o83Q5WOaET@vostro.rjw.lan> <2423504.PN3SurRX7i@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 14, 2016 06:47:40 PM Rafael J. Wysocki wrote:
> On Wednesday, September 14, 2016 03:01:33 PM Rafael J. Wysocki wrote:
> > On Wednesday, September 14, 2016 12:50:24 PM Lukas Wunner wrote:
> > > On Wed, Sep 14, 2016 at 02:21:30AM +0200, Rafael J. Wysocki wrote:
> > > > On Wednesday, August 31, 2016 08:15:18 AM Lukas Wunner wrote:
> > > > > Usually the most accurate way to determine a PCI device's power state is
> > > > > to read its PM Control & Status Register.  There are two cases however
> > > > > when this is not an option:  If the device doesn't have the PM
> > > > > capability at all, or if it is in D3cold.
> > > > > 
> > > > > In D3cold, reading from config space typically results in a fabricated
> > > > > "all ones" response.  But in D3hot, the two bits representing the power
> > > > > state in the PMCSR are *also* set to 1.  Thus D3hot and D3cold are not
> > > > > discernible by just reading the PMCSR.
> > > > > 
> > > > > A (supposedly) reliable way to detect D3cold is to query the platform
> > > > > firmware for its opinion on the device's power state.  To this end,
> > > > > add a ->get_power callback to struct pci_platform_pm_ops, and an
> > > > > implementation to acpi_pci_platform_pm.  (The only pci_platform_pm_ops
> > > > > existing so far).
> > > > > 
> > > > > Amend pci_update_current_state() to query the platform firmware before
> > > > > reading the PMCSR.
> > > > > 
> > > > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > > > ---
> > > > >  drivers/pci/pci-acpi.c | 23 +++++++++++++++++++++++
> > > > >  drivers/pci/pci.c      | 21 ++++++++++++++++-----
> > > > >  drivers/pci/pci.h      |  3 +++
> > > > >  3 files changed, 42 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > > > index 9a033e8..89f2707 100644
> > > > > --- a/drivers/pci/pci-acpi.c
> > > > > +++ b/drivers/pci/pci-acpi.c
> > > > > @@ -452,6 +452,28 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> > > > >  	return error;
> > > > >  }
> > > > >  
> > > > > +static pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
> > > > > +{
> > > > > +	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> > > > > +	static const pci_power_t state_conv[] = {
> > > > > +		[ACPI_STATE_D0]      = PCI_D0,
> > > > > +		[ACPI_STATE_D1]      = PCI_D1,
> > > > > +		[ACPI_STATE_D2]      = PCI_D2,
> > > > > +		[ACPI_STATE_D3_HOT]  = PCI_D3hot,
> > > > > +		[ACPI_STATE_D3_COLD] = PCI_D3cold,
> > > > > +	};
> > > > > +	int state;
> > > > 
> > > > ACPI_STATE_D3_HOT and ACPI_STATE_D3_COLD were introduced in ACPI 4.0.  For
> > > > systems predating that, ACPI_STATE_D3_HOT is the deepest state returned by
> > > > acpi_device_get_power().
> > > 
> > > Would it be possible to detect the ACPI spec version the platform
> > > firmware conforms to, and amend acpi_device_get_power() to return
> > > ACPI_STATE_D3_COLD if the device is in D3?
> > > 
> > > Then we could avoid the unnecessary runtime resume after direct_complete
> > > also for these older machines.
> > 
> > Well, please see below.
> > 
> > > Can the revision in the FADT (offset 8) be used as a proxy?
> > > => E.g. the old Clevo B7130 has revision 3 in the FADT and uses
> > >    a _DSM and _PS3 to put the discrete GPU in D3cold:
> > >    https://github.com/Lekensteyn/acpi-stuff/tree/master/dsl/Clevo_B7130
> > > => Whereas the newer Clevo P651RA has revision 5 in the FADT and uses
> > >    _PR3 to put the discrete GPU in D3cold:
> > >    https://github.com/Lekensteyn/acpi-stuff/tree/master/dsl/Clevo_P651RA
> > > 
> > > However the FADT revision was already 4 in the ACPI 3.0 spec,
> > > so we can only use it to discern ACPI 2.0 vs 3.0, not 3.0 vs 4.0,
> > > which is what we'd actually want.  And there's a comment in
> > > acpica/tbfadt.c that "The FADT revision value is unreliable."
> > > 
> > > Do you know of a better way to discern ACPI 3.0 vs 4.0?
> > 
> > I'm not sure if there is a reliable way to be honest.
> > 
> > Also even if the FADT etc tells you something, there's no guarantee that AML
> > actually follows that.
> > 
> > In fact, whether or not acpi_device_get_power() will ever return D3cold
> > for a device depends on whether or not _PR3 is there.  If it's not there,
> > the deepest state returned will be D3hot in any case.
> > 
> > So I'm not sure how useful that is in the context of D3cold detection?
> 
> There is more to this.
> 
> In fact, we can't really trust _PSC too, because in some ACPI tables it is
> implemented to always return 0 (seriously).
> 
> For this reason, I think the way to go would be to use something like
> acpi_device_update_power() to ensure that the device really is in the
> state we think it is in.

Actually, it may be sufficient to simply check if the device is in any
state different from D0 and leave it alone if that's the case.

For that, acpi_device_update_power() should be good enough and the PCI
native part would be simpler too I think.

Thanks,
Rafael

