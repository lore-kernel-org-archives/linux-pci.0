Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:57085 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234AbcHDApu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2016 20:45:50 -0400
Date: Thu, 4 Aug 2016 02:45:38 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 10/13] PCI: Avoid going from D3cold to D3hot for
 system sleep
Message-ID: <20160804004538.GA4564@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
 <20160617210924.GA12254@localhost>
 <20160617221407.GB1927@wunner.de>
 <2339231.tBO8VQgPAo@vostro.rjw.lan>
 <20160803122848.GA4415@wunner.de>
 <CAJZ5v0jxQHM=uuvFrpPw0vLbVjF0EQsm=XEZNdtQeYsO0ZobtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0jxQHM=uuvFrpPw0vLbVjF0EQsm=XEZNdtQeYsO0ZobtQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 04, 2016 at 01:50:39AM +0200, Rafael J. Wysocki wrote:
> On Wed, Aug 3, 2016 at 2:28 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Mon, Jul 18, 2016 at 03:39:15PM +0200, Rafael J. Wysocki wrote:
> >> On Saturday, June 18, 2016 12:14:07 AM Lukas Wunner wrote:
> >> > On Fri, Jun 17, 2016 at 04:09:24PM -0500, Bjorn Helgaas wrote:
> >> > > On Fri, May 13, 2016 at 01:15:31PM +0200, Lukas Wunner wrote:
> >> > > > There are devices wich are not power-managed by the platform, yet can be
> >> > > > runtime suspended to D3cold with some other mechanism.  When putting the
> >> > > > system to sleep, we currently handle such devices improperly by trying
> >> > > > to transition them from D3cold to D3hot (the default power state defined
> >> > > > at the beginning of pci_target_state()).  Avoid that.
> >> > > >
> >> > > > An example for devices affected by this are Thunderbolt controllers
> >> > > > built into Macs which can be put into D3cold with nonstandard ACPI
> >> > > > methods.
> >> > > >
> >> > > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> >> > >
> >> > > This needs an ack from Rafael.
> >> > >
> >> > > > ---
> >> > > >  drivers/pci/pci.c | 2 ++
> >> > > >  1 file changed, 2 insertions(+)
> >> > > >
> >> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> > > > index 791dfe7..6af9911 100644
> >> > > > --- a/drivers/pci/pci.c
> >> > > > +++ b/drivers/pci/pci.c
> >> > > > @@ -1943,6 +1943,8 @@ static pci_power_t pci_target_state(struct pci_dev *dev)
> >> > > >                               && !(dev->pme_support & (1 << target_state)))
> >> > > >                                 target_state--;
> >> > > >                 }
> >> > > > +       } else if (dev->current_state == PCI_D3cold) {
> >> > > > +               target_state = PCI_D3cold;
> >> > > >         }
> >> > >
> >> > > This only covers the case of !device_may_wakeup().  So I guess
> >> > > device_may_wakeup() is false for these Thunderbolt controllers.
> >> > > Is there a reason you don't want to do this check for devices that
> >> > > may wakeup?
> >> >
> >> > Fear of breaking things. It would mean that a device would be left in
> >> > D3cold even though it may not be able to signal wakeup from that power
> >> > state.
> >>
> >> Then it should not be put into D3_cold at run time too if it is wakeup-
> >> capable.
> >>
> >> > That's a change of behaviour the consequences of which I cannot
> >> > estimate. Intuitively, I would expect breakage from such a change.
> >>
> >> That would have been the case if the device had been capable of signaling
> >> wakeup from D3_cold at run time, but not from system sleep.  However, that
> >> can only happen when platform_pci_power_manageable() is true AFAICS.
> >>
> >> So I'd change the switch () under the platform_pci_power_manageable() check
> >> to return "state" in the default case and then do
> >>
> >>       return dev->current_state < target_state ? target_state : dev->current_state;
> >>
> >> at the end of the function.
> >
> > That suggestion doesn't seem to be correct because there's another
> > value besides PCI_D3cold which is also greater than PCI_D3hot,
> > namely PCI_UNKNOWN. (If the device is in that state, e.g. after
> > pci_device_remove() has been called, and the system goes to sleep,
> > we'd leave the device as is and not put it into D3hot as we do now.)
> 
> Right, I obviously forgot about PCI_UNKNOWN.
> 
> > I will update this patch with Bjorn's suggestion to also leave the
> > device in D3cold if it is wakeup-capable. The idea is to just change
> > the default state in the first line of the function like this:
> >
> > -       pci_power_t target_state = PCI_D3hot;
> > +       pci_power_t target_state =
> > +               dev->current_state == PCI_D3cold ? PCI_D3cold : PCI_D3hot;
> 
> That should work (even though it is a little clumsy IMO).

Not sure why that is clumsy but happy to use something else if you
have a suggestion?

Thanks,

Lukas
