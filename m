Return-Path: <rjwysocki@gmail.com>
Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20160804081446.GA4576@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de> <20160617210924.GA12254@localhost>
 <20160617221407.GB1927@wunner.de> <2339231.tBO8VQgPAo@vostro.rjw.lan>
 <20160803122848.GA4415@wunner.de> <CAJZ5v0jxQHM=uuvFrpPw0vLbVjF0EQsm=XEZNdtQeYsO0ZobtQ@mail.gmail.com>
 <20160804004538.GA4564@wunner.de> <CAJZ5v0h55MCiSzJz_weEGX7nUsy_TLumssyoXz=f2_b0h_BkQQ@mail.gmail.com>
 <20160804081446.GA4576@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Aug 2016 17:30:47 +0200
Message-ID: <CAJZ5v0hPbeaUotiFxg_BbkS86HEz=u0ThkdwJju5WyXOuDgd6A@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] PCI: Avoid going from D3cold to D3hot for system sleep
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 4, 2016 at 10:14 AM, Lukas Wunner <lukas@wunner.de> wrote:
> On Thu, Aug 04, 2016 at 03:07:56AM +0200, Rafael J. Wysocki wrote:
>> On Thu, Aug 4, 2016 at 2:45 AM, Lukas Wunner <lukas@wunner.de> wrote:
>> > On Thu, Aug 04, 2016 at 01:50:39AM +0200, Rafael J. Wysocki wrote:
>> >> On Wed, Aug 3, 2016 at 2:28 PM, Lukas Wunner <lukas@wunner.de> wrote:
>> >> > On Mon, Jul 18, 2016 at 03:39:15PM +0200, Rafael J. Wysocki wrote:
>> >> >> On Saturday, June 18, 2016 12:14:07 AM Lukas Wunner wrote:
>> >> >> > On Fri, Jun 17, 2016 at 04:09:24PM -0500, Bjorn Helgaas wrote:
>> >> >> > > On Fri, May 13, 2016 at 01:15:31PM +0200, Lukas Wunner wrote:
>> >> >> > > > There are devices wich are not power-managed by the platform, yet can be
>> >> >> > > > runtime suspended to D3cold with some other mechanism.  When putting the
>> >> >> > > > system to sleep, we currently handle such devices improperly by trying
>> >> >> > > > to transition them from D3cold to D3hot (the default power state defined
>> >> >> > > > at the beginning of pci_target_state()).  Avoid that.
>> >> >> > > >
>> >> >> > > > An example for devices affected by this are Thunderbolt controllers
>> >> >> > > > built into Macs which can be put into D3cold with nonstandard ACPI
>> >> >> > > > methods.
>> >> >> > > >
>> >> >> > > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
>> >> >> > > > ---
>> >> >> > > >  drivers/pci/pci.c | 2 ++
>> >> >> > > >  1 file changed, 2 insertions(+)
>> >> >> > > >
>> >> >> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> >> >> > > > index 791dfe7..6af9911 100644
>> >> >> > > > --- a/drivers/pci/pci.c
>> >> >> > > > +++ b/drivers/pci/pci.c
>> >> >> > > > @@ -1943,6 +1943,8 @@ static pci_power_t pci_target_state(struct pci_dev *dev)
>> >> >> > > >                               && !(dev->pme_support & (1 << target_state)))
>> >> >> > > >                                 target_state--;
>> >> >> > > >                 }
>> >> >> > > > +       } else if (dev->current_state == PCI_D3cold) {
>> >> >> > > > +               target_state = PCI_D3cold;
>> >> >> > > >         }
>> >> >> > >
>> >> > I will update this patch with Bjorn's suggestion to also leave the
>> >> > device in D3cold if it is wakeup-capable. The idea is to just change
>> >> > the default state in the first line of the function like this:
>> >> >
>> >> > -       pci_power_t target_state = PCI_D3hot;
>> >> > +       pci_power_t target_state =
>> >> > +               dev->current_state == PCI_D3cold ? PCI_D3cold : PCI_D3hot;
>> >>
>> >> That should work (even though it is a little clumsy IMO).
>> >
>> > Not sure why that is clumsy but happy to use something else if you
>> > have a suggestion?
>>
>> The clumsy thing is that we'd take the target_state as D3cold only if
>> the device already was in that state.
>>
>> Otherwise, we'd take D3hot as the target state for the same device,
>> which doesn't seem particularly consistent to me.
>>
>> Not that I have better ideas ATM, but then the current code works for
>> my use cases. :-)
>
> The goal is to afford direct-complete to devices which are not power-
> manageable by the platform but can still be runtime suspended to D3cold.

Well, this is a bit misleading.

According to the PCI spec there are two ways to put a device into
D3cold: either by putting its bus into B3 (which for PCIe means
turning the link off IIRC) which happens when the bridge goes into
D3hot, or through the platform.

You aren't talking about any of those cases, though, so we go outside
of the spec here.

> Right now we wake those devices up from D3cold to D3hot before going to
> sleep, which is a waste of energy and prolongs the suspend sequence
> (waking up the Thunderbolt controller takes 2 seconds).

Understood.

> The de facto standard to power manage such devices seems to be with
> dev_pm_domain_set(). That's what vga_switcheroo does and I'll move
> to that as well for v3 of this series.

OK

> I could add a "bool can_power_off" to struct dev_pm_domain.

I'm not sure if dev_pm_domain is the right level.  The "can_power_off"
thing would be sort of specific to your particular use case.

Say you have something like

struct pci_pm_domain {
        struct dev_pm_domain pd;
        ...
};

> Then I could change pci_target_state() like this:
>
>         pci_power_t target_state = PCI_D3hot;
>
>         if (platform_pci_power_manageable(dev)) {
>                 [...]
> +       } else if (dev->dev.pm_domain && dev->dev.pm_domain.can_power_off) {

so you can do something like

          } else if (dev->dev.pm_domain) {
                    struct pci_pm_domain *pci_pd =
to_pci_pm_domain(dev->dev.pm_domain);

                    ....
          } else if [...]

and it may be a bit more PCI-oriented without expanding generic data types.

> +               target_state = PCI_D3cold;
>         } else if [...]
>
> Another idea would be to add a ->choose_state hook to dev_pm_domain,
> but that would have to return a PCI-specific power state, so we'd be
> in clumsy territory again.

Right.

> Thoughts?

Essentially, the PCI PM code needs to be told that there is a way to
put the device into D3cold by non-standard means.  There are a couple
of ways to do that (a new flag in struct pci_dev, the above, probably
more), but in any case it needs to be clear that this is non-standard
IMO.

Thanks,
Rafael
