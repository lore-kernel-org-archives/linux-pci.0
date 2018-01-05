Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 4 Jan 2018 16:41:31 -0800
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
Message-ID: <20180105004130.GA151625@google.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
 <9593014.U0c2JQdoEZ@aspire.rjw.lan>
 <5A41A0A7.5070605@rock-chips.com>
 <5491520.JsEYlZiECc@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5491520.JsEYlZiECc@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Trying to catch up on this thread...

On Wed, Dec 27, 2017 at 01:57:07AM +0100, Rafael J. Wysocki wrote:
> On Tuesday, December 26, 2017 2:06:47 AM CET JeffyChen wrote:
> > Hi Rafael,
> > 
> > Thanks for your reply :)
> > 
> > On 12/26/2017 08:11 AM, Rafael J. Wysocki wrote:
> > >> >+
> > >> >+	dn = pci_device_to_OF_node(ppdev);
> > >> >+	if (!dn)
> > >> >+		return 0;
> > >> >+
> > >> >+	irq = of_irq_get_byname(dn, "wakeup");
> > > Why is this a property of the bridge and not of the device itself?

Wait, isn't 'dn' the port node, not the bridge node?

> > That is suggested by Brian, because in that way, the wakeup pin would 
> > not "tied to what exact device is installed (or no device, if it's a slot)."

I believe my thinking has evolved a bit over time, and I definitely am
not the one true authority on this. I'll explain my main concerns, and
whatever solution resolves these concerns is fine with me.

* I was primarily interested in avoiding handling WAKE# in the endpoint
  drivers (e.g., as mwifiex is today).
* I was also interested in not having to redefine a new DT device
  node (with new "pciABCD,1234" compatible property) for each new device
  attached. That just won't work for removable cards.

I need to reread the rest of this thread a few times to really
understand what Rafael and Tony are discussing. But I feel like some of
this is still moving away from the second point above.

> But I don't think it works when there are two devices using different WAKE#
> interrupt lines under the same bridge.  Or how does it work then?

Brian
