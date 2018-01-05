Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:45619 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbeAEBOl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jan 2018 20:14:41 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Brian Norris <briannorris@chromium.org>
Cc: JeffyChen <jeffy.chen@rock-chips.com>, tony@atomide.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, shawn.lin@rock-chips.com,
        dianders@chromium.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE# signal for OF
Date: Fri, 05 Jan 2018 02:13:33 +0100
Message-ID: <2806186.IK6EZBC0cX@aspire.rjw.lan>
In-Reply-To: <20180105004130.GA151625@google.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com> <5491520.JsEYlZiECc@aspire.rjw.lan> <20180105004130.GA151625@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, January 5, 2018 1:41:31 AM CET Brian Norris wrote:
> Hi,
> 
> Trying to catch up on this thread...
> 
> On Wed, Dec 27, 2017 at 01:57:07AM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, December 26, 2017 2:06:47 AM CET JeffyChen wrote:
> > > Hi Rafael,
> > > 
> > > Thanks for your reply :)
> > > 
> > > On 12/26/2017 08:11 AM, Rafael J. Wysocki wrote:
> > > >> >+
> > > >> >+	dn = pci_device_to_OF_node(ppdev);
> > > >> >+	if (!dn)
> > > >> >+		return 0;
> > > >> >+
> > > >> >+	irq = of_irq_get_byname(dn, "wakeup");
> > > > Why is this a property of the bridge and not of the device itself?
> 
> Wait, isn't 'dn' the port node, not the bridge node?

I may be confused about the structure you have in DT.

In the device hierarchy PCIe ports are represented as bridges.

> > > That is suggested by Brian, because in that way, the wakeup pin would 
> > > not "tied to what exact device is installed (or no device, if it's a slot)."
> 
> I believe my thinking has evolved a bit over time, and I definitely am
> not the one true authority on this. I'll explain my main concerns, and
> whatever solution resolves these concerns is fine with me.
> 
> * I was primarily interested in avoiding handling WAKE# in the endpoint
>   drivers (e.g., as mwifiex is today).

OK, everybody on this thread is interested in that. :-)

> * I was also interested in not having to redefine a new DT device
>   node (with new "pciABCD,1234" compatible property) for each new device
>   attached. That just won't work for removable cards.

So if you make it the property of a bridge, it should be fine (as long
as the bridge itself is not removable).

> I need to reread the rest of this thread a few times to really
> understand what Rafael and Tony are discussing. But I feel like some of
> this is still moving away from the second point above.
> 
> > But I don't think it works when there are two devices using different WAKE#
> > interrupt lines under the same bridge.  Or how does it work then?

We seem to have agreed that this case needs to be neglected here.

The "wakeup-interrupt" property at the bridge level basically has to be defined
as the wakeup interrupt for all devices on the bus under the bridge.

Thanks,
Rafael
