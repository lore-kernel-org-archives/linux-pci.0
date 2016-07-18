Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 10/13] PCI: Avoid going from D3cold to D3hot for system sleep
Date: Mon, 18 Jul 2016 15:39:15 +0200
Message-ID: <2339231.tBO8VQgPAo@vostro.rjw.lan>
In-Reply-To: <20160617221407.GB1927@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de> <20160617210924.GA12254@localhost> <20160617221407.GB1927@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Saturday, June 18, 2016 12:14:07 AM Lukas Wunner wrote:
> On Fri, Jun 17, 2016 at 04:09:24PM -0500, Bjorn Helgaas wrote:
> > On Fri, May 13, 2016 at 01:15:31PM +0200, Lukas Wunner wrote:
> > > There are devices wich are not power-managed by the platform, yet can be
> > 
> > s/wich/which/
> 
> Oops.
> 
> > 
> > > runtime suspended to D3cold with some other mechanism.  When putting the
> > > system to sleep, we currently handle such devices improperly by trying
> > > to transition them from D3cold to D3hot (the default power state defined
> > > at the beginning of pci_target_state()).  Avoid that.
> > > 
> > > An example for devices affected by this are Thunderbolt controllers
> > > built into Macs which can be put into D3cold with nonstandard ACPI
> > > methods.
> > > 
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > 
> > This needs an ack from Rafael.
> > 
> > Naive question: why is the default target_state PCI_D3hot?
> 
> No idea. :-)

Because D3_hot is the deepest state you can *program* the device to go into
unless the platform can cut off power from it.

> > 
> > > ---
> > >  drivers/pci/pci.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 791dfe7..6af9911 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -1943,6 +1943,8 @@ static pci_power_t pci_target_state(struct pci_dev *dev)
> > >  			      && !(dev->pme_support & (1 << target_state)))
> > >  				target_state--;
> > >  		}
> > > +	} else if (dev->current_state == PCI_D3cold) {
> > > +		target_state = PCI_D3cold;
> > >  	}
> > 
> > This only covers the case of !device_may_wakeup().  So I guess
> > device_may_wakeup() is false for these Thunderbolt controllers.
> 
> Correct. device_may_wakeup() is defined in include/linux/pm_wakeup.h as:
> dev->power.can_wakeup && !!dev->power.wakeup
> 
> The first one, dev->power.can_wakeup is true because PME is claimed to be
> supported for all power states in the PMC register, so pci_pm_init() calls
> device_set_wakeup_capable(&dev->dev, true):
>   Capabilities: [80] Power Management version 3
>     Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
>     Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
> 
> The second one, dev->power.wakeup is false because device_wakeup_enable()
> is never called.
> 
> 
> > Is there a reason you don't want to do this check for devices that
> > may wakeup?
> 
> Fear of breaking things. It would mean that a device would be left in
> D3cold even though it may not be able to signal wakeup from that power
> state.

Then it should not be put into D3_cold at run time too if it is wakeup-capable.

> That's a change of behaviour the consequences of which I cannot
> estimate. Intuitively, I would expect breakage from such a change.

That would have been the case if the device had been capable of signaling
wakeup from D3_cold at run time, but not from system sleep.  However, that
can only happen when platform_pci_power_manageable() is true AFAICS.

So I'd change the switch () under the platform_pci_power_manageable() check to
return "state" in the default case and then do

	return dev->current_state < target_state ? target_state : dev->current_state;

at the end of the function.

Thanks,
Rafael
