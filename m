Return-Path: <rjwysocki@gmail.com>
Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20160811132003.GA7369@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de> <CAJZ5v0hPbeaUotiFxg_BbkS86HEz=u0ThkdwJju5WyXOuDgd6A@mail.gmail.com>
 <20160807090347.GA5679@wunner.de> <2182119.Z8Tk7onsTO@vostro.rjw.lan> <20160811132003.GA7369@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Aug 2016 02:50:04 +0200
Message-ID: <CAJZ5v0g86L+nL6SxfBMQ84NNpUzz0X83bvP=E5WdSs1TozpY8w@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] PCI: Avoid going from D3cold to D3hot for system sleep
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 11, 2016 at 3:20 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Mon, Aug 08, 2016 at 01:32:54AM +0200, Rafael J. Wysocki wrote:
>> On Sunday, August 07, 2016 11:03:47 AM Lukas Wunner wrote:
>> > On Thu, Aug 04, 2016 at 05:30:47PM +0200, Rafael J. Wysocki wrote:
>> > > On Thu, Aug 4, 2016 at 10:14 AM, Lukas Wunner <lukas@wunner.de> wrote:
>> > > > On Thu, Aug 04, 2016 at 03:07:56AM +0200, Rafael J. Wysocki wrote:
>> > > >> On Thu, Aug 4, 2016 at 2:45 AM, Lukas Wunner <lukas@wunner.de> wrote:
>> > > >> > On Thu, Aug 04, 2016 at 01:50:39AM +0200, Rafael J. Wysocki wrote:
>> > > >> >> On Wed, Aug 3, 2016 at 2:28 PM, Lukas Wunner <lukas@wunner.de> wrote:
>> > > >> >> > I will update this patch with Bjorn's suggestion to also leave the
>> > > >> >> > device in D3cold if it is wakeup-capable. The idea is to just change
>> > > >> >> > the default state in the first line of the function like this:
>> > > >> >> >
>> > > >> >> > -       pci_power_t target_state = PCI_D3hot;
>> > > >> >> > +       pci_power_t target_state =
>> > > >> >> > +               dev->current_state == PCI_D3cold ? PCI_D3cold : PCI_D3hot;
>> > > >> >>
>> > > >> >> That should work (even though it is a little clumsy IMO).
>> > > >> >
>> > > >> > Not sure why that is clumsy but happy to use something else if you
>> > > >> > have a suggestion?
>> > > >>
>> > > >> The clumsy thing is that we'd take the target_state as D3cold only if
>> > > >> the device already was in that state.
>> > > >>
>> > > >> Otherwise, we'd take D3hot as the target state for the same device,
>> > > >> which doesn't seem particularly consistent to me.
>> > > >>
>> > > >> Not that I have better ideas ATM, but then the current code works for
>> > > >> my use cases. :-)
>> > > >
>> > > > The goal is to afford direct-complete to devices which are not power-
>> > > > manageable by the platform but can still be runtime suspended to D3cold.
>> > >
>> > > Well, this is a bit misleading.
>> > >
>> > > According to the PCI spec there are two ways to put a device into
>> > > D3cold: either by putting its bus into B3 (which for PCIe means
>> > > turning the link off IIRC) which happens when the bridge goes into
>> > > D3hot, or through the platform.
>> > >
>> > > You aren't talking about any of those cases, though, so we go outside
>> > > of the spec here.
>> >
>> > Yes. With Nvidia Optimus / AMD PowerXpress hybrid graphics on non-Macs
>> > and Thunderbolt on Macs, it could still be argued that D3cold is
>> > facilitated by the platform, albeit with custom methods instead of _PS3.
>>
>> So you'd need a custom set of callbacks for that "platform", but that's
>> only a few devices in the system, so you would also need normal ACPI callbacks
>> for the rest.
>>
>> Conceivably, that could be addressed with per-device platform callbacks,
>> but that is conceptually equivalent to adding a pm_domain pointer to the
>> devices in question.
>
> Precisely.
>
>> > > > The de facto standard to power manage such devices seems to be with
>> > > > dev_pm_domain_set(). That's what vga_switcheroo does and I'll move
>> > > > to that as well for v3 of this series.
>> > >
>> > > OK
>> > >
>> > > > I could add a "bool can_power_off" to struct dev_pm_domain.
>> > >
>> > > I'm not sure if dev_pm_domain is the right level.  The "can_power_off"
>> > > thing would be sort of specific to your particular use case.
>> > >
>> > > Say you have something like
>> > >
>> > > struct pci_pm_domain {
>> > >         struct dev_pm_domain pd;
>> > >         ...
>> > > };
>
> So I would like to find a common ground and something you feel
> comfortable to ack. The problem I see with your suggested approach
> of subclassing struct dev_pm_domain in a struct pci_pm_domain is
> that I can easily envision Apple putting some custom methods in the
> DSDT to power a non-PCI device up and down. They're starting to use
> SPI and UART to attach devices in newer machines.

Those devices have no standard power state definitions.

The problem you have here really is PCI-specific, because you want to
use PCI PM along with the non-standard methods.

> Hence my suggestion to add a flag to struct dev_pm_domain, even
> though at the moment that flag would only be queried by the PCI core.
> I don't care if this is called can_power_off or power_manageable or
> whatever.

struct dev_pm_domain is way too generic for that though, as I'm sure
there are users of it where the can_power_off thing wouldn't make any
sense whatever.

Thanks,
Rafael
