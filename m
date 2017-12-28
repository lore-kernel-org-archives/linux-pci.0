Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f169.google.com ([74.125.82.169]:35141 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdL1MS2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 07:18:28 -0500
MIME-Version: 1.0
In-Reply-To: <20171228042205.GG3875@atomide.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
 <9593014.U0c2JQdoEZ@aspire.rjw.lan> <5A41A0A7.5070605@rock-chips.com>
 <5491520.JsEYlZiECc@aspire.rjw.lan> <20171227150800.GF3875@atomide.com>
 <CAJZ5v0iaHPGiZJURhqZb8wdJXHxrAEHVN=U6rNHWGf-FGemPJA@mail.gmail.com> <20171228042205.GG3875@atomide.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Dec 2017 13:18:26 +0100
Message-ID: <CAJZ5v0hpK0_vjX3HinCpsFuKffVUn3d5EnqXdz0P893aRZgnRw@mail.gmail.com>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        JeffyChen <jeffy.chen@rock-chips.com>,
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

On Thu, Dec 28, 2017 at 5:22 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Rafael J. Wysocki <rafael@kernel.org> [171228 00:51]:
>> On Wed, Dec 27, 2017 at 4:08 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Rafael J. Wysocki <rjw@rjwysocki.net> [171227 01:00]:
>> >> On Tuesday, December 26, 2017 2:06:47 AM CET JeffyChen wrote:
>> >> > Hi Rafael,
>> >> >
>> >> > Thanks for your reply :)
>> >> >
>> >> > On 12/26/2017 08:11 AM, Rafael J. Wysocki wrote:
>> >> > >> >+
>> >> > >> >+       dn =3D pci_device_to_OF_node(ppdev);
>> >> > >> >+       if (!dn)
>> >> > >> >+               return 0;
>> >> > >> >+
>> >> > >> >+       irq =3D of_irq_get_byname(dn, "wakeup");
>> >> > > Why is this a property of the bridge and not of the device itself=
?
>> >> >
>> >> > That is suggested by Brian, because in that way, the wakeup pin wou=
ld
>> >> > not "tied to what exact device is installed (or no device, if it's =
a slot)."
>> >>
>> >> But I don't think it works when there are two devices using different=
 WAKE#
>> >> interrupt lines under the same bridge.  Or how does it work then?
>> >
>> > It won't work currently for multiple devices but adding more than
>> > one wakeriq per device is doable. And I think we will have other
>> > cases where multiple wakeirqs are connected to a single device, so
>> > that issue should be sorted out sooner or later.
>> >
>> > And if requesting wakeirq for the PCI WAKE# lines at the PCI
>> > controller does the job, then maybe that's all we need to start with.
>>
>> These are expected to be out-of-band, so not having anything to do
>> with the Root Complex.
>>
>> In-band PME Messages go through the PCIe hierarchy, but that is a
>> standard mechanism and it is supported already.
>>
>> WAKE# are platform-specific, pretty much by definition and I guess
>> that on most ARM boards they are just going to be some kind of GPIO
>> pins.
>
> OK. So probably supporting the following two configurations
> should be enough then:
>
> 1. One or more WAKE# lines configured as a wakeirq for the PCI
>    controller
>
>    When the wakeirq calls pm_wakeup_event() for the PCI controller
>    device driver, the PCI controller wakes up and can deal with
>    it's child devices

But this shouldn't be necessary at all.  Or if it is, I wonder why
that's the case.

I'm assuming that we're talking about PCI Express here, which has two
wakeup mechanisms defined, one of which is based on using PME Messages
(Beacon) and the second one is WAKE#:

"The WAKE# mechanism uses sideband signaling to implement wakeup
functionality. WAKE# is
an =E2=80=9Copen drain=E2=80=9D signal asserted by components requesting wa=
keup and
observed by the associated
power controller."

(from PCIe Base Spec 3.0).  [And there's a diagram showing the routing
of WAKE# in two cases in Figure 5-4: Conceptual Diagrams Showing Two
Example Cases of WAKE# Routing.]

Note that WAKE# is defined to be "observed by the associated power
controller", so I'm not sure what the PCI controller's role in the
handing of it is at all.

> 2. Optionally a WAKE# line from a PCI device configured as wakeirq
>    for the PCI device driver
>
>    In this case calling the PM runtime resume in the child
>    PCI device will also wake up the parent PCI controller,
>    and then the PCI controller can deal with it's children
>
> Seems like this series is pretty close to 1 above except
> we need to have a list of wakeirqs per device instead of
> just one. And option 2 should already work as long as the
> PCI device driver parses and configures the wakeirq.

Well, this is confusing, because as I said above, option 1 doesn't
look relevant even.

>> > Then in addition to that, we could do the following to allow
>> > PCI devices to request the wakeirq from the PCI controller:
>> >
>> > 1. PCI controller or framework implements a chained irq for
>> >    the WAKE# lines assuming it can mask/unmask the WAKE# lines
>> >
>> > 2. PCI devices then can just request the wakeirq from the PCI
>> >    controller
>> >
>> > And that's about it. Optionally we could leave out the dependency
>> > to having PCI devices implement PM runtime and just resume the
>> > parent (PCI controller) if PCI devices has not implemented
>> > PM runtime.
>>
>> So if my understanding is correct, DT should give you the WAKE# IRQ
>> for the given endpoint PCI device and you only are expected to request
>> it.   The rest should just follow from the other pieces of information
>> in the DT.
>
> Yeah and it seems that we should allow configuring both cases
> 1 and 2 above.
>
>> With the quite obvious caveat that the same IRQ may be used as WAKE#
>> for multiple endpoint devices (which BTW need not be under the same
>> bridge even).
>
> And with the shared interrupts we can't do the masking/unmasking
> automatically..

Or we need to use reference counting (so actually the wakeup IRQs are
not dedicated).

>> >> > >> >+       if (irq =3D=3D -EPROBE_DEFER)
>> >> > > Braces here, please.
>> >> > ok, will fix in the next version.
>> >> >
>> >> > >
>> >> > >> >+               return irq;
>> >> > >> >+       /* Ignore other errors, since a missing wakeup is non-f=
atal. */
>> >> > >> >+       else if (irq < 0) {
>> >> > >> >+               dev_info(&pdev->dev, "cannot get wakeup interru=
pt: %d\n", irq);
>> >> > >> >+               return 0;
>> >> > >> >+       }
>> >> > >> >+
>> >> > >> >+       device_init_wakeup(&pdev->dev, true);
>> >> > > Why do you call this before dev_pm_set_dedicated_wake_irq()?
>> >> >
>> >> > hmmm, i thought so too, but it turns out the dedicated wake irq
>> >> > framework requires device_init_wakeup(dev, true) before attach the =
wake irq:
>> >> >
>> >> > int device_wakeup_attach_irq(struct device *dev,
>> >> >                               struct wake_irq *wakeirq)
>> >> > {
>> >> >          struct wakeup_source *ws;
>> >> >
>> >> >          ws =3D dev->power.wakeup;
>> >> >          if (!ws) {
>> >> >                  dev_err(dev, "forgot to call device_init_wakeup?\n=
");
>> >> >                  return -EINVAL;
>> >> >
>> >>
>> >> Well, that's a framework issue, fair enough.
>> >>
>> >> That said, what if user space removes the wakeup source from under yo=
u
>> >> concurrently via sysfs?  Tony?
>> >
>> > Hmm sounds racy, need to take a look.
>>
>> Not only racy, as I don't see anything to prevent user space from
>> making the dev->power.wakeup wakeup source go away via sysfs at any
>> time *after* the IRQ has been requested.
>
> Currently nothing happens with wakeirqs if there's no struct
> wakeup_source. On device_wakeup_enable() we call device_wakeup_attach()
> that just copies dev->power.wakeirq to ws->wakeirq. And when struct
> wake_source is freed the device should be active and wakeirq
> disabled. Or are you seeing other issues here?

I'm suspicious about one thing, but I need to look deeper into the code. :-=
)

>> Pretty much right after dev_pm_set_dedicated_wake_irq() has returned,
>> device_wakeup_disable() may be called on the device via wakeup_store()
>> and it doesn't even check if the device has a wakeup irq.
>>
>> > I think the only reason
>> > to have the wakeirq pointer there was to save memory. It might
>> > make sense to remove the wakeirq dependency here.
>>
>> Well, that looks necessary to be honest.
>
> Seems like we're OK there except for the race. But I still wonder
> if could just get rid of wakeirq in struct wakeup_source. Maybe
> all we need is to see if dev->power.wakeup is allocated for the
> wakeirqs.

I guess "no", but let me get back to you when I have looked at things
in more detail.

Thanks,
Rafael
