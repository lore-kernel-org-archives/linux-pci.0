Return-Path: <SRS0=q5GP=2Z=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=q5GP=2Z=linutronix.de=tglx@kernel.org>
Date: Thu, 16 Mar 2017 20:36:19 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Mason <slash.tmp@free.fr>
cc: LKML <linux-kernel@vger.kernel.org>,
    Linux ARM <linux-arm-kernel@lists.infradead.org>,
    Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>,
    linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
    Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
    Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
    Robin Murphy <robin.murphy@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
    Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
    Rob Herring <robh@kernel.org>
Subject: Re: Legacy PCI interrupt support in PCIe host driver
In-Reply-To: <4e54c5f9-7cc1-cfab-592d-a87795147020@free.fr>
Message-ID: <alpine.DEB.2.20.1703162034430.4110@nanos>
References: <5612adb6-af5c-9fbf-e725-813ee7fe1b4b@free.fr> <8443b350-6aa6-75f8-af48-892c722fc2d9@free.fr> <alpine.DEB.2.20.1703161843420.3586@nanos> <4e54c5f9-7cc1-cfab-592d-a87795147020@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Thu, 16 Mar 2017, Mason wrote:

> On 16/03/2017 18:47, Thomas Gleixner wrote:
> > On Thu, 16 Mar 2017, Mason wrote:
> >> I guess if two interrupts fire at the same time, we'll just take two
> >> separate exceptions?
> > 
> > Wrong guess. That might work with level interrupts, but with other types
> > nothing will raise another exception. Sharing interrupts on edge types is a
> > stupid idea, but hardware folks insist on implementing stupid ideas.
> 
> When you say "That might work with level interrupts", what is "that" ?

That you take two exceptions because if both have raised the irq it will
stay raised when you only handle one. Non level types will not keep it
raised in the CPU and you lost.

> In my case,
> 
> 	interrupt-map = <0 0 0 1 &irq0 54 IRQ_TYPE_LEVEL_HIGH>;
> 	interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
> 
> Both ISRs expect LEVEL_HIGH. In fact, doesn't request_irq
> return an error if the triggers are different?

That's completely irrelevant.

Thanks,

	tglx
