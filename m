Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39315 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754845AbdL1RnW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 12:43:22 -0500
MIME-Version: 1.0
In-Reply-To: <6120485.xubBpvge6h@aspire.rjw.lan>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
 <CAJZ5v0hpK0_vjX3HinCpsFuKffVUn3d5EnqXdz0P893aRZgnRw@mail.gmail.com>
 <20171228165134.GH3875@atomide.com> <6120485.xubBpvge6h@aspire.rjw.lan>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Dec 2017 18:43:20 +0100
Message-ID: <CAJZ5v0hSMqwitCvfi7D+sknuO0YFr5F-kdkV-cSoVp30Cmdaeg@mail.gmail.com>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
To: Tony Lindgren <tony@atomide.com>
Cc: JeffyChen <jeffy.chen@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 28, 2017 at 6:29 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrot=
e:
> On Thursday, December 28, 2017 5:51:34 PM CET Tony Lindgren wrote:
>> * Rafael J. Wysocki <rafael@kernel.org> [171228 12:21]:
>> > On Thu, Dec 28, 2017 at 5:22 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
>> > > * Rafael J. Wysocki <rafael@kernel.org> [171228 00:51]:
>> > >> On Wed, Dec 27, 2017 at 4:08 PM, Tony Lindgren <tony@atomide.com> w=
rote:
>> > >> > * Rafael J. Wysocki <rjw@rjwysocki.net> [171227 01:00]:
>> > >> >> On Tuesday, December 26, 2017 2:06:47 AM CET JeffyChen wrote:
>> > >> >> > Hi Rafael,
>> > >> >> >
>> > >> >> > Thanks for your reply :)
>> > >> >> >
>> > >> >> > On 12/26/2017 08:11 AM, Rafael J. Wysocki wrote:
>> > >> >> > >> >+
>> > >> >> > >> >+       dn =3D pci_device_to_OF_node(ppdev);
>> > >> >> > >> >+       if (!dn)
>> > >> >> > >> >+               return 0;
>> > >> >> > >> >+
>> > >> >> > >> >+       irq =3D of_irq_get_byname(dn, "wakeup");
>> > >> >> > > Why is this a property of the bridge and not of the device i=
tself?
>> > >> >> >
>> > >> >> > That is suggested by Brian, because in that way, the wakeup pi=
n would
>> > >> >> > not "tied to what exact device is installed (or no device, if =
it's a slot)."
>> > >> >>
>> > >> >> But I don't think it works when there are two devices using diff=
erent WAKE#
>> > >> >> interrupt lines under the same bridge.  Or how does it work then=
?
>> > >> >
>> > >> > It won't work currently for multiple devices but adding more than
>> > >> > one wakeriq per device is doable. And I think we will have other
>> > >> > cases where multiple wakeirqs are connected to a single device, s=
o
>> > >> > that issue should be sorted out sooner or later.
>> > >> >
>> > >> > And if requesting wakeirq for the PCI WAKE# lines at the PCI
>> > >> > controller does the job, then maybe that's all we need to start w=
ith.
>> > >>
>> > >> These are expected to be out-of-band, so not having anything to do
>> > >> with the Root Complex.
>> > >>
>> > >> In-band PME Messages go through the PCIe hierarchy, but that is a
>> > >> standard mechanism and it is supported already.
>> > >>
>> > >> WAKE# are platform-specific, pretty much by definition and I guess
>> > >> that on most ARM boards they are just going to be some kind of GPIO
>> > >> pins.
>> > >
>> > > OK. So probably supporting the following two configurations
>> > > should be enough then:
>> > >
>> > > 1. One or more WAKE# lines configured as a wakeirq for the PCI
>> > >    controller
>> > >
>> > >    When the wakeirq calls pm_wakeup_event() for the PCI controller
>> > >    device driver, the PCI controller wakes up and can deal with
>> > >    it's child devices
>> >
>> > But this shouldn't be necessary at all.  Or if it is, I wonder why
>> > that's the case.
>>
>> Well Brian had a concern where we would have to implement PM runtime
>> for all device drivers for PCI devices.
>
> Why would we?
>
>> > I'm assuming that we're talking about PCI Express here, which has two
>> > wakeup mechanisms defined, one of which is based on using PME Messages
>> > (Beacon) and the second one is WAKE#:
>> >
>> > "The WAKE# mechanism uses sideband signaling to implement wakeup
>> > functionality. WAKE# is
>> > an =E2=80=9Copen drain=E2=80=9D signal asserted by components requesti=
ng wakeup and
>> > observed by the associated
>> > power controller."
>> >
>> > (from PCIe Base Spec 3.0).  [And there's a diagram showing the routing
>> > of WAKE# in two cases in Figure 5-4: Conceptual Diagrams Showing Two
>> > Example Cases of WAKE# Routing.]
>>
>> Thanks for the pointer, I had not seen that :) So the use cases
>> I was trying to describe above are similar to the wiring in the
>> PCIe Base Spec 3.0 "Figure 5-4" , but numbered the other way around.
>>
>> > Note that WAKE# is defined to be "observed by the associated power
>> > controller", so I'm not sure what the PCI controller's role in the
>> > handing of it is at all.
>>
>> To me it seems the "switch" part stays at least partially powered
>> and then in-band PME messages are used after host is woken up to
>> figure out which WAKE# triggered?
>
> Yes, that's my understanding too.

To be precise, it is not quite possible to figure out which WAKE#
triggered, if they are sharing the line, without looking into the
config spaces of the devices below the switch.  The switch is not
expected to do that AFAICS.  It only generates a PME message meaning
"wakeup is being signaled somewhere below" and the PME driver that
handles the Root Port receiving it should look at the PME Status bits
of the devices below the switch (the pme.c driver does that IIRC or at
least it should do that ;-)).

Still, the handling of WAKE# doesn't need to cover this case AFAICS.

Thanks,
Rafael
