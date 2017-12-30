Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0icePurJoGdVtX06j=XHPdZSqXgm+vhL47ngv7OZoL3fw@mail.gmail.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
 <CAJZ5v0hpK0_vjX3HinCpsFuKffVUn3d5EnqXdz0P893aRZgnRw@mail.gmail.com>
 <20171228165134.GH3875@atomide.com> <6120485.xubBpvge6h@aspire.rjw.lan>
 <20171229171548.GI3875@atomide.com> <CAJZ5v0icePurJoGdVtX06j=XHPdZSqXgm+vhL47ngv7OZoL3fw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 30 Dec 2017 01:21:16 +0100
Message-ID: <CAJZ5v0hrzxJ2753Cj5LB=DkqDy9-JJnBXU_hJwOJpZazymStZg@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 30, 2017 at 12:39 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Dec 29, 2017 at 6:15 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Rafael J. Wysocki <rjw@rjwysocki.net> [171228 17:33]:
>>> On Thursday, December 28, 2017 5:51:34 PM CET Tony Lindgren wrote:
>>> >
>>> > Well Brian had a concern where we would have to implement PM runtime
>>> > for all device drivers for PCI devices.
>>>
>>> Why would we?
>>
>> Seems at least I was a bit confused. In the PCIe case the WAKE# is
>> owned by the PCIe slot, not the child PCIe device.
>
> Well, it depends on what you mean by "slot" and "child device", but if
> my understanding of it is correct, WAKE# actually is "owned" by the
> latter.
>
> First, let me clarify the terminology.  PCI slots are not really
> represented in the device hierarchy in Linux.  They are represented by
> kernel objects for hotplug purposes, but these objects are not based
> on struct device.
>
> Generally, there are two kinds of PCI entities represented by struct
> pci_dev, bridges and endpoints (functions).  Bridges may represent
> physical devices, like PCI-to-PCI bridges, or parts of physical
> devices, like PCIe ports.  In PCIe, every port is logically
> represented by a bridge (and a PCI config space region with a Type 1
> header).  However, ports do not take actions like generating
> interrupts; the pieces of hardware containing them (switches, Root
> Complex) do that.
>
> Endpoints (functions) are children of bridges (e.g. PCIe ports) and
> bridges may be children of other bridges (like in a switch that is
> represented by a bus segment with one upstream bridge - the upstream
> port - and possibly multiple downstream bridges - downstream ports).
> So in PCI a parent always is a bridge (either a PCI bridge - a bridge
> between to PCI bus segments - or a host bridge) and if that is a PCIe
> port, it cannot "own" anything like WAKE#, because it is not affected
> by it in any way and doesn't take part in the handling of it.
>
> In the context of "Figure 5-4" in the spec, Case 1, what matters is
> that every "Slot" in the figure represents a bunch (up to 8) of
> endpoints (functions), but the "Slot" is not the parent of them.  The
> port of the switch the "Slot" is connected to is the parent.  WAKE#
> basically comes from one of the endpoints belonging to the "Slot" and
> you need to look into the config space regions for all of these
> endpoints to check which one has PME Status set and clear it (to
> acknowledge the PME and make the hardware stop asserting the WAKE#
> signal).  So, from the software perspective, the endpoint (child) is
> the source of WAKE# and that should be reflected by DT properties IMO.
>
>> So you're right, there should be no need for the child PCIe device drivers to
>> implement runtime PM.
>
> There should be no need for that regardless.  You only need an
> interrupt handler that will look for the endpoint with PME Status set,
> acknowledge it and possibly invoke runtime PM for the endpoint in
> question (if supported).  All of that is standard and can happen at
> the bus type level and the interrupt handler I'm talking about may be
> based on pci_pme_wakeup() or pci_acpi_wake_dev().
>
>> I was thinking the wakeirq case with WLAN on SDIO bus. Some WLAN
>> devices can have a hardwired OOB wakeirq wired to a GPIO controller.
>> In that case the wakeirq is owned by the child device driver
>> (WLAN controller) and not by the SDIO slot. I was earlier
>> thinking this is the same as the "Figure 5-4" case 1, but it's
>> not.
>
> Well, it is not in the sense that the endpoint driver is not expected
> to handle the wakeup interrupt by itself.  The PCI bus type is
> responsible for that, but technically WAKE# comes from the endpoint
> (child).
>
>> So in the PCIe WAKE# case for device tree, we must have the
>> wakeirq property for the PCIe slot for the struct device managing
>> that slot,
>
> Which doesn't exist.
>
>> and not for the child device driver. I think it's
>> already this way in the most recent set of patches, I need to
>> look again.
>
> No, you need a wakeirq properly for the child *device* and that
> property will be consumed by the PCI layer.

Or, if you use the convention mentioned in another message in this
thread, you can make the wakeirq be a property of a bridge (port) with
the clarification of the assumption that WAKE# is shared by all
functions below the bridge.  So the presence of the "wakeirq" property
for a bridge (in addition to providing the wakeup IRQ) will mean that
it applies to all devices below the bridge.

In the case of parallel PCI (not PCIe), there may be multiple "slots"
(or "PCI devices" consisting each of multiple functions) under one
bridge and in theory each of them may use a different IRQ for WAKE#
signaling, so the above convention will not work then.

Thanks,
Rafael
