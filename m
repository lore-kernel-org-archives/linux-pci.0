Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 3 Jan 2018 11:53:59 -0800
From: Tony Lindgren <tony@atomide.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Anderson <dianders@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v12 1/5] dt-bindings: PCI: Add definition of PCIe
 WAKE# irq and PCI irq
Message-ID: <20180103195359.GM3875@atomide.com>
References: <20171226020806.32710-1-jeffy.chen@rock-chips.com>
 <20171226020806.32710-2-jeffy.chen@rock-chips.com>
 <20171229175717.GL3875@atomide.com>
 <CAJZ5v0iRRAQWSji0ioJ5B5M5RjbYAyb1VmuWhTZw4qy0G7_a4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0iRRAQWSji0ioJ5B5M5RjbYAyb1VmuWhTZw4qy0G7_a4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Rafael J. Wysocki <rafael@kernel.org> [171229 23:52]:
> On Fri, Dec 29, 2017 at 6:57 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Jeffy Chen <jeffy.chen@rock-chips.com> [171226 02:11]:
> >> We are going to handle PCIe WAKE# pin for PCI devices in the pci core,
> >> so add definitions of the optional PCIe WAKE# pin for PCI devices.
> >>
> >> Also add an definition of the optional PCI interrupt pin for PCI
> >> devices to distinguish it from the PCIe WAKE# pin.
> >
> >> --- a/Documentation/devicetree/bindings/pci/pci.txt
> >> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> >> @@ -24,3 +24,13 @@ driver implementation may support the following properties:
> >>     unsupported link speed, for instance, trying to do training for
> >>     unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
> >>     for gen2, and '1' for gen1. Any other values are invalid.
> >> +
> >> +PCI devices may support the following properties:
> >
> > This should say PCI ports instead of PCI devices.
> 
> No, it is more accurate to say "PCI devices".
> 
> Well, it actually gets somewhat confusing, because in the PCI
> terminology a "PCI device" means a physical piece of hardware that can
> be put into a single "slot" (think socket on a board) and may consist
> up to 8 functional units called "functions" which are each represented
> by a struct pci_dev.  So there may be up to 8 struct pci_dev objects
> per "PCI device" (as per the standard language) and, BTW, drivers bind
> to functions (via the struct pci_dev objects).

OK then let's stick to "PCI devices".

> Now, WAKE# is shared by all functions within the same "PCI device"
> (I'm not sure if the standard specifies that directly, but at least it
> appears to be treated as an obvious physical limitation), so it may be
> useful to represent the "slot" or "device" level in the DT even though
> it has no struct device based representation in the kernel.

Yeah that makes sense as there is only one WAKE# line in the slot :)

Regards,

Tony
