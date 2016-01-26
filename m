Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 26 Jan 2016 10:51:56 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
	izumi.taku@jp.fujitsu.com, wency@cn.fujitsu.com,
	caoj.fnst@cn.fujitsu.com, ddaney.cavm@gmail.com,
	okaya@codeaurora.org, bhelgaas@google.com,
	jiang.liu@linux.intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix unavailable irq number 255 reported by
 BIOS
In-Reply-To: <56A7404A.8080205@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.11.1601261049540.3886@nanos>
References: <1453705178-27389-1-git-send-email-chen.fan.fnst@cn.fujitsu.com> <20160125205803.GA10272@localhost> <alpine.DEB.2.11.1601260825510.3886@nanos> <56A7404A.8080205@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 26 Jan 2016, Chen Fan wrote:
> On 01/26/2016 04:26 PM, Thomas Gleixner wrote:
> > > >   	if (gsi < 0) {
> > > > -		if (acpi_isa_register_gsi(dev))
> > > > +#ifdef CONFIG_X86
> > > > +		/*
> > > > +		 * The Interrupt Line value of 0xff is defined to mean
> > > > "unknown"
> > > > +		 * or "no connection" (PCI 3.0, Section 6.2.4, footnote on
> > > > page
> > > > +		 * 223), using ~0U as invalid IRQ.
> > > > +		 */
> > And why would this be x86 specific? PCI3.0 is architecture independent,
> > right?
> quoting the spec document:
> "For x86 based PCs, the values in this register correspond to IRQ numbers
> (0-15) of the standard dual
> 8259 configuration. The value 255 is defined as meaning "unknown" or "no
> connection" to the interrupt
> controller. Values between 15 and 254 are reserved."

So if that is x86 specific then it needs to be documented proper. The fact
that the comment is inside the #ifdef x86 does not tell.

Thanks,

	tglx

 
