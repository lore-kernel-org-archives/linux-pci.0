Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 27 Dec 2017 07:08:00 -0800
From: Tony Lindgren <tony@atomide.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: JeffyChen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, shawn.lin@rock-chips.com,
        briannorris@chromium.org, dianders@chromium.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
Message-ID: <20171227150800.GF3875@atomide.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
 <9593014.U0c2JQdoEZ@aspire.rjw.lan>
 <5A41A0A7.5070605@rock-chips.com>
 <5491520.JsEYlZiECc@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5491520.JsEYlZiECc@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Rafael J. Wysocki <rjw@rjwysocki.net> [171227 01:00]:
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
> >
> > That is suggested by Brian, because in that way, the wakeup pin would 
> > not "tied to what exact device is installed (or no device, if it's a slot)."
> 
> But I don't think it works when there are two devices using different WAKE#
> interrupt lines under the same bridge.  Or how does it work then?

It won't work currently for multiple devices but adding more than
one wakeriq per device is doable. And I think we will have other
cases where multiple wakeirqs are connected to a single device, so
that issue should be sorted out sooner or later.

And if requesting wakeirq for the PCI WAKE# lines at the PCI
controller does the job, then maybe that's all we need to start with.

Then in addition to that, we could do the following to allow
PCI devices to request the wakeirq from the PCI controller:

1. PCI controller or framework implements a chained irq for
   the WAKE# lines assuming it can mask/unmask the WAKE# lines

2. PCI devices then can just request the wakeirq from the PCI
   controller

And that's about it. Optionally we could leave out the dependency
to having PCI devices implement PM runtime and just resume the
parent (PCI controller) if PCI devices has not implemented
PM runtime.

> > >> >+	if (irq == -EPROBE_DEFER)
> > > Braces here, please.
> > ok, will fix in the next version.
> > 
> > >
> > >> >+		return irq;
> > >> >+	/* Ignore other errors, since a missing wakeup is non-fatal. */
> > >> >+	else if (irq < 0) {
> > >> >+		dev_info(&pdev->dev, "cannot get wakeup interrupt: %d\n", irq);
> > >> >+		return 0;
> > >> >+	}
> > >> >+
> > >> >+	device_init_wakeup(&pdev->dev, true);
> > > Why do you call this before dev_pm_set_dedicated_wake_irq()?
> >
> > hmmm, i thought so too, but it turns out the dedicated wake irq 
> > framework requires device_init_wakeup(dev, true) before attach the wake irq:
> > 
> > int device_wakeup_attach_irq(struct device *dev,
> >                               struct wake_irq *wakeirq)
> > {
> >          struct wakeup_source *ws;
> > 
> >          ws = dev->power.wakeup;
> >          if (!ws) {
> >                  dev_err(dev, "forgot to call device_init_wakeup?\n");
> >                  return -EINVAL;
> > 
> 
> Well, that's a framework issue, fair enough.
> 
> That said, what if user space removes the wakeup source from under you
> concurrently via sysfs?  Tony?

Hmm sounds racy, need to take a look. I think the only reason
to have the wakeirq pointer there was to save memory. It might
make sense to remove the wakeirq dependency here.

Regards,

Tony
