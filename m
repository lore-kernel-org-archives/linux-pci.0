Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42004 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeAYBWI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jan 2018 20:22:08 -0500
Received: by mail-pf0-f194.google.com with SMTP id b25so4560654pfd.9
        for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2018 17:22:07 -0800 (PST)
Date: Wed, 24 Jan 2018 17:22:04 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: JeffyChen <jeffy.chen@rock-chips.com>, tony@atomide.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, shawn.lin@rock-chips.com,
        dianders@chromium.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
Message-ID: <20180125012148.lcgnxi3uwcjzue7o@ban.mtv.corp.google.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
 <5491520.JsEYlZiECc@aspire.rjw.lan>
 <20180105004130.GA151625@google.com>
 <2806186.IK6EZBC0cX@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2806186.IK6EZBC0cX@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

Sorry once again on the delays...My email hygiene has been getting bad,
so mail gets buried.

On Fri, Jan 05, 2018 at 02:13:33AM +0100, Rafael J. Wysocki wrote:
> On Friday, January 5, 2018 1:41:31 AM CET Brian Norris wrote:
> > On Wed, Dec 27, 2017 at 01:57:07AM +0100, Rafael J. Wysocki wrote:
> > > On Tuesday, December 26, 2017 2:06:47 AM CET JeffyChen wrote:
> > > > On 12/26/2017 08:11 AM, Rafael J. Wysocki wrote:
> > > > >> >+
> > > > >> >+	dn = pci_device_to_OF_node(ppdev);
> > > > >> >+	if (!dn)
> > > > >> >+		return 0;
> > > > >> >+
> > > > >> >+	irq = of_irq_get_byname(dn, "wakeup");
> > > > > Why is this a property of the bridge and not of the device itself?
> > 
> > Wait, isn't 'dn' the port node, not the bridge node?
> 
> I may be confused about the structure you have in DT.

Probably :) And my DT structure may not be correct. But it's easily
available to review. See arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:

http://elixir.free-electrons.com/linux/v4.14.2/source/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi#L705

It has a bridge->port->device nesting hierarchy. I'm not actually sure
where this came from exactly, but I *thought* it was derived from the
standard documentation:

Documentation/devicetree/bindings/pci/pci.txt
PCI Bus Binding to: IEEE Std 1275-1994
http://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf

I'm not so sure now...

> In the device hierarchy PCIe ports are represented as bridges.

But device hierarchy can be slightly different than DT hierarchy. In our
case, pcie@0,0 seems to correspond to the port, but has no companion
"device".

Or maybe I'm really off-base.

> > > > That is suggested by Brian, because in that way, the wakeup pin would 
> > > > not "tied to what exact device is installed (or no device, if it's a slot)."
> > 
> > I believe my thinking has evolved a bit over time, and I definitely am
> > not the one true authority on this. I'll explain my main concerns, and
> > whatever solution resolves these concerns is fine with me.
> > 
> > * I was primarily interested in avoiding handling WAKE# in the endpoint
> >   drivers (e.g., as mwifiex is today).
> 
> OK, everybody on this thread is interested in that. :-)

Sure :)

> > * I was also interested in not having to redefine a new DT device
> >   node (with new "pciABCD,1234" compatible property) for each new device
> >   attached. That just won't work for removable cards.
> 
> So if you make it the property of a bridge, it should be fine (as long
> as the bridge itself is not removable).

OK...in that case you've answered your question at the top: "Why is this
a property of the bridge and not of the device itself?" I think Jeffy
answered similarly, but this walked you through how *I* got to that
conclusion, at least.

> > I need to reread the rest of this thread a few times to really
> > understand what Rafael and Tony are discussing. But I feel like some of
> > this is still moving away from the second point above.
> > 
> > > But I don't think it works when there are two devices using different WAKE#
> > > interrupt lines under the same bridge.  Or how does it work then?
> 
> We seem to have agreed that this case needs to be neglected here.

OK, I guess that's a reasonable conclusion.

> The "wakeup-interrupt" property at the bridge level basically has to be defined
> as the wakeup interrupt for all devices on the bus under the bridge.

The only thing I'm at a loss for is whether this goes in (referring to
rk3399-gru.dtsi) &pcie or &pci_rootport. I think some versions of this
series have been aiming for the former, and some the latter.

Brian
