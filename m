Return-Path: <SRS0=j6uk=KP=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=j6uk=KP=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Date: Tue, 31 Jul 2018 09:01:12 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sebastian Reichel <sre@kernel.org>, Milo Kim <milo.kim@ti.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
Message-ID: <20180731080111.GG17271@n2100.armlinux.org.uk>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
 <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
 <20180730224252.GE45322@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.21.1807310047320.1725@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.21.1807310047320.1725@nanos.tec.linutronix.de>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 31, 2018 at 12:50:21AM +0200, Thomas Gleixner wrote:
> On Mon, 30 Jul 2018, Bjorn Helgaas wrote:
> 
> > [+cc maintainers of possibly erroneous callers of request_threaded_irq()]
> > 
> > On Mon, Jul 30, 2018 at 04:30:28PM -0500, Bjorn Helgaas wrote:
> > > [+cc Thomas, Christoph, LKML]
> > > 
> > > On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
> > > > If we have a threaded interrupt with the handler being NULL, then
> > > > request_threaded_irq() -> __setup_irq() will complain and bail out
> > > > if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
> > > > being NULL and set IRQF_ONESHOT in this case.
> > > > 
> > > > This change is needed to migrate the mei_me driver to
> > > > pci_alloc_irq_vectors() and pci_request_irq().
> > > > 
> > > > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > > 
> > > I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
> > > usage isn't mentioned in the request_threaded_irq() function doc or
> > > Documentation/
> > 
> > Possibly these other request_threaded_irq() callers are similarly
> > broken?  I can't tell for sure about tda998x_create(), but all the
> > others certainly call request_threaded_irq() with "handler == NULL"
> > and irqflags that do not contain IRQF_ONESHOT:
> > 
> >   tda998x_create()
> >     request_threaded_irq(client->irq, NULL, ..., irqd_get_trigger_type(), ...)
> >     (I can't tell what irqd_get_trigger_type() does)
> 
> It reads the trigger type back from the irq chip (level/edge/polarity) but
> does not return with the ONESHOT bit set.

What tree are you (Bjorn) using there?  Looking in my git history,
request_threaded_irq() was added in January 2014, as:

+               irqf_trigger =
+                       irqd_get_trigger_type(irq_get_irq_data(client->irq));
+               ret = request_threaded_irq(client->irq, NULL,
+                                          tda998x_irq_thread,
+                                          irqf_trigger | IRQF_ONESHOT,
+                                          "tda998x", priv);

and updated more recently for the CEC support in ae81553c30ef
("drm/i2c: tda998x: allow interrupt to be shared") to be:

-               irqf_trigger =
+               irq_flags =
                        irqd_get_trigger_type(irq_get_irq_data(client->irq));
+               irq_flags |= IRQF_SHARED | IRQF_ONESHOT;
                ret = request_threaded_irq(client->irq, NULL,
-                                          tda998x_irq_thread,
-                                          irqf_trigger | IRQF_ONESHOT,
+                                          tda998x_irq_thread, irq_flags,
                                           "tda998x", priv);

In all cases, IRQF_ONESHOT has been set for this threaded interrupt.

I've also checked drm-next, and it doesn't show anything like what
Bjorn quoted.

Confused.  Bjorn, can you double check that what you think are
erroneous request_threaded_irq() calls are actually as per what
you quoted please?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
