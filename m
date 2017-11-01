Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:56347 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933288AbdKAVFo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2017 17:05:44 -0400
Date: Wed, 1 Nov 2017 16:05:41 -0500
From: Rob Herring <robh@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, rjw@rjwysocki.net, dianders@chromium.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v10 1/7] dt-bindings: PCI: Add definition of PCIe
 WAKE# irq and PCI irq
Message-ID: <20171101210541.vacfufnn2ms65xrw@rob-hp-laptop>
References: <20171027072612.26565-1-jeffy.chen@rock-chips.com>
 <20171027072612.26565-2-jeffy.chen@rock-chips.com>
 <20171027204513.GA105121@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171027204513.GA105121@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 27, 2017 at 01:45:17PM -0700, Brian Norris wrote:
> Hi,
> 
> On Fri, Oct 27, 2017 at 03:26:06PM +0800, Jeffy Chen wrote:
> > We are going to handle PCIe WAKE# pin for PCI bus bridges and PCI
> > devices in the pci core, so add definitions of the optional PCIe
> > WAKE# pin for PCI bus bridges and PCI devices.
> > 
> > Also add an definition of the optional PCI interrupt pin for PCI
> > devices to distinguish it from the PCIe WAKE# pin.
> > 
> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> > ---
> > 
> > Changes in v10: None
> > Changes in v9:
> > Add section for PCI devices and rewrite the commit message.
> > 
> > Changes in v8:
> > Add optional "pci", and rewrite commit message.
> > 
> > Changes in v7: None
> > Changes in v6: None
> > Changes in v5:
> > Move to pci.txt
> > 
> > Changes in v3: None
> > Changes in v2: None
> > 
> >  Documentation/devicetree/bindings/pci/pci.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> > index c77981c5dd18..d4406d4e15ad 100644
> > --- a/Documentation/devicetree/bindings/pci/pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/pci.txt
> > @@ -24,3 +24,11 @@ driver implementation may support the following properties:
> >     unsupported link speed, for instance, trying to do training for
> >     unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
> >     for gen2, and '1' for gen1. Any other values are invalid.
> > +- interrupts: Interrupt specifier for each name in interrupt-names.
> > +- interrupt-names: May contains "wakeup" for PCIe WAKE# interrupt.
> 
> s/contains/contain/
> 
> > +
> > +PCI devices have standardized Device Tree bindings:
> 
> This line is a little unclear, especially since there *is* an old
> documented standard, yet the following text is actually introducing new,
> non-standard additions.
> 
> > +
> > +- interrupts: Interrupt specifier for each name in interrupt-names.
> > +- interrupt-names: May contains "wakeup" for PCIe WAKE# interrupt and "pci" for
> 
> s/contains/contain/
> 
> > +  PCI interrupt.
> 
> IMO, since you're trying to augment a standardized binding, you need to
> be a lot clearer here. I expect you should mention the existing standard
> (that devices may optionally include an 'interrupts' property that
> represents the legacy PCI interrupt) and how you're augmenting it (that
> additional interrupts can be supported optionally, but they require a
> corresponding 'interrupt-names' property).

There's an additional complication that I'd guess the wakeup is 
typically a GPIO line and hence a different parent. We have 2 options 
there. The first is interrupts-extended which is generally implicitly 
supported (i.e. we only document interrupts). The second is we already 
have interrupt-map if we have legacy interrupts and can map to different 
parents. For this to work, we'd have to use a number >4 for the wakeup 
interrupts.

Rob
