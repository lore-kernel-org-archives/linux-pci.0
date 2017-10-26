Return-Path: <SRS0=Hm5P=BZ=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=Hm5P=BZ=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20171024201000.GF21840@bhelgaas-glaptop.roam.corp.google.com>
References: <20171019111007.25234-1-jeffy.chen@rock-chips.com>
 <20171019111007.25234-2-jeffy.chen@rock-chips.com> <20171023230252.GA53058@google.com>
 <20171024201000.GF21840@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Oct 2017 10:42:14 +0200
Message-ID: <CAJZ5v0gZ_+FEH+ijO4DGPvgnZQU_SpyWMdRYJLaN+pkpzP6qjw@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] PCI: Add support for wake irq
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, shawn.lin@rock-chips.com,
	Doug Anderson <dianders@chromium.org>, Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 24, 2017 at 10:10 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Include "PCIe WAKE#" signal in the subject, since this is specifically
> about that wire.
>
> On Mon, Oct 23, 2017 at 04:02:53PM -0700, Brian Norris wrote:
>> + PM folks
>>
>> Hi Jeffy,
>>
>> It's probably good if you send the whole thing to linux-pm@ in the
>> future, if you're really trying to implement generic PCI/PM for device
>> tree systems.
>>
>> On Thu, Oct 19, 2017 at 07:10:05PM +0800, Jeffy Chen wrote:
>> > Add support for PCIE_WAKE pin.
>
> I think you're referring to what the spec calls "the WAKE# signal".
> It will reduce confusion if you use exactly the same notation as the
> spec.
>
>> This is kind of an important change, so it feels like you should
>> document it a little more thoroughly than this. Particularly, I have a
>> few questions below, and it seems like some of these questions should be
>> acknowledged up front. e.g., why does this look so different than the
>> ACPI hooks?
>>
>> >
>> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> > ---
>> >
>> > Changes in v7:
>> > Move PCIE_WAKE handling into pci core.
>> >
>> > Changes in v6:
>> > Fix device_init_wake error handling, and add some comments.
>> >
>> > Changes in v5:
>> > Rebase
>> >
>> > Changes in v3:
>> > Fix error handling
>> >
>> > Changes in v2:
>> > Use dev_pm_set_dedicated_wake_irq
>> >         -- Suggested by Brian Norris <briannorris@chromium.com>
>> >
>> >  drivers/pci/pci.c    | 34 ++++++++++++++++++++++++++++++++--
>> >  drivers/pci/probe.c  | 32 ++++++++++++++++++++++++++++----
>> >  drivers/pci/remove.c |  9 +++++++++
>> >  3 files changed, 69 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> > index f0d68066c726..49080a10bdf0 100644
>> > --- a/drivers/pci/pci.c
>> > +++ b/drivers/pci/pci.c
>> > @@ -603,10 +603,40 @@ static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
>> >                     pci_platform_pm->choose_state(dev) : PCI_POWER_ERROR;
>> >  }
>> >
>> > +static int pci_dev_check_wakeup(struct pci_dev *dev, void *data)
>> > +{
>> > +   bool *wakeup = data;
>> > +
>> > +   if (device_may_wakeup(&dev->dev))
>> > +           *wakeup = true;
>> > +
>> > +   return *wakeup;
>> > +}
>> > +
>> >  static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
>> >  {
>> > -   return pci_platform_pm ?
>> > -                   pci_platform_pm->set_wakeup(dev, enable) : -ENODEV;
>> > +   struct pci_dev *parent = dev;
>> > +   struct pci_bus *bus;
>> > +   bool wakeup = false;
>>
>> It feels like you're implementing a set of pci_platform_pm_ops, except
>> you're not actually implementing them. It almost seems like we should
>> have a drivers/pci/pci-of.c to do this. But that brings up a few
>> questions....
>>
>> > +
>> > +   if (pci_platform_pm)
>>
>> So, if somebody already registered ops, then you won't follow the "OF"
>> route? That means this all breaks as soon as a kernel has both
>> CONFIG_ACPI and CONFIG_OF enabled. This is possible on at least ARM64,
>> which 'select's OF and may also be built/run with CONFIG_ACPI.
>>
>> And that conflict is the same if we try to register pci_platform_pm_ops
>> for OF systems -- it'll be a race over who sets them up first (or
>> rather, last).
>>
>> Also, what happens on !ACPI && !OF? Or if the device tree did not
>> contain a "wakeup" definition? You're now implementing a default path
>> that doesn't make much sense IMO; you may claim wakeup capability
>> without actually having set it up somewhere.
>>
>> I think you could use some more comments, and (again) a real commit
>> message.
>>
>> > +           return pci_platform_pm->set_wakeup(dev, enable);
>> > +
>> > +   device_set_wakeup_capable(&dev->dev, enable);
>>
>> Why are you setting that here? This function should just be telling the
>> lower layers to enable the physical WAKE# ability. In our case, it just
>> means configuring the WAKE# interrupt for wakeup -- or, since you've
>> used dev_pm_set_dedicated_wake_irq() which handles most of this
>> automatically...do you need this at all? It seems like you should
>> *either* implement these callbacks to manually manage the wakeup IRQ or
>> else use the dedicated wakeirq infrastructure -- not both.
>>
>> And even if you need this, I don't think you need to do this many times;
>> you should only need to set up the capabilities once, when you first set
>> up the device.
>>
>> And BTW, the description for the set_wakeup() callback says:
>>
>>  * @set_wakeup: enables/disables wakeup capability for the device
>>
>> I *don't* think that means "capability" as in the device framework's
>> view of "wakeup capable"; I think it means capability as in the physical
>> ability (a la, enable_irq_wake() or similar).
>>
>> > +
>> > +   while ((parent = pci_upstream_bridge(parent)))
>> > +           bus = parent->bus;
>> > +
>> > +   if (!bus || !pci_is_root_bus(bus) || !bus->bridge->parent)
>> > +           return -ENODEV;
>> > +
>> > +   pci_walk_bus(bus, pci_dev_check_wakeup, &wakeup);
>> > +   device_set_wakeup_capable(bus->bridge->parent, wakeup);
>>
>> What happens to any intermediate buses? You haven't marked them as
>> wakeup-capable. Should you?
>>
>> And the more fundamental question here is: is this a per-device
>> configuration or a per-root-port configuration? The APIs here are
>> modeled after ACPI, where I guess this is a per-device thing. The PCIe
>> spec doesn't exactly specify how many WAKE# pins you need, though it
>> seems to say
>>
>> (a) it's all-or-nothing (if one device uses it, all wakeup-capable EPs
>>     should be wired up to it)
>> (b) it *can* be done as a single input to the system controller, since
>>     it's an open drain signal
>> (c) ...but I also see now in the PCIe Card Electromechanical
>>     specification:
>>
>>     "WAKE# may be bused to multiple PCI Express add-in card connectors,
>>     forming a single input connection at the PM controller, or
>>     individual connectors can have individual connections to the PM
>>     controller."
>>
>> So I think you're kind of going along the lines of (b) (as I suggested
>> to you previously), and that matches the current hardware (we only have
>> a single WAKE#) and proposed DT binding. But should this be set up in a
>> way that suits (c) too? It's hard to tell exactly what ACPI-based
>> systems do, since they have this abstracted behind ACPI interfaces that
>> seem like they *could* support per-device or per-bridge type of hookups.
>>
>> Bjorn, any thoughts? This seems like a halfway attempt in between two
>> different designs, and I'm not really sure which one makes more sense.
>
> No thoughts yet.  Seems like this needs a little more time in the
> oven,

Agreed.

> and I'll take a deeper look after some of the issues you pointed
> out have been addressed.

This is in my list of things to look at, but I'm working on something
else now, so I'll be looking at it when I'm done with the other
thing(s).

Thanks,
Rafael
