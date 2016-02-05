Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 5 Feb 2016 10:34:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] x86, pci: Add quirk for unsizeable Broadwell EP bar
Message-ID: <20160205163427.GD29306@localhost>
References: <1452896279-22034-1-git-send-email-andi@firstfloor.org>
 <20160204174155.GB19957@localhost>
 <20160204185442.GA4875@tassilo.jf.intel.com>
 <20160205015734.GA29929@localhost>
 <20160205033616.GF3696@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160205033616.GF3696@two.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 05, 2016 at 04:36:17AM +0100, Andi Kleen wrote:
> > > But would actually anything use it?
> > 
> > You mean, would anything actually use the lspci output?  I don't know,
> > but why would we want it to print garbage?
> 
> In he kernel. I don't think lspci is that interesting.
> > 
> > And the kernel certainly uses the struct resource.  Setting
> > IORESOURCE_PCI_FIXED is not a way of saying "please ignore this
> > resource."
> 
> There is already another quirk that uses the same technique to handle
> a bad bar. I also didn't notice any bad side effects. Again what would it be
> used for?

I suppose you mean pci_siemens_interrupt_controller(), added by
73a74ed3a6f8 ("PCI: i386: fixup for Siemens Nixdorf AG FSC
Multiprocessor Interrupt Controllers")?

Here are the problems I see:

  - We still try to size the register as though it were a real BAR,
    which means we write 0xffffffff to it.  This register isn't a BAR,
    so we have no idea what effect this will have on the device.  In
    your case, you might know it's safe, but it's not safe in general

  - We read from the register and interpret the low bits as a BAR
    type.  We have no idea what data we'll get from a non-BAR
    register, so we're essentially putting junk in the struct resource
    flags.

  - We try to figure out the size of the BAR.  Depending on what data
    we get, we may compute some arbitrary size.  You might know that
    we happen to compute a zero size or something else safe, but that
    depends on your device and is not safe in general.  I don't want
    to have to worry about your device settings in that register being
    magically compatible with the pci_size() computation.

  - I think it's possible that the data we read from this register
    would lead us to conclude this is a BAR that consumes memory space
    at some adddress.  Or I/O space at some address.  We rely on this
    information to perform PCI address space allocation.

> I looked into the new device ops you asked for, but it is fairly
> complicated as the ops are not per device but per bus, and there
> can be many copies of this device, and the pci_dev is not passed,
> so it needs complicated pattern matching on the devfn.
> 
> Doing it like the existing quirk is much simpler, and seems to work
> just fine.

It's simple and seems to work in this case, but it doesn't lead to a
consistent model of the system.

It may be a hassle to work around this via pci_ops, but, well, if you
[Intel] want to take advantage of all the generic PCI code, you sort
of have to play within the constraints of the generic PCI model.

Maybe there's some other way to do a quirk that doesn't involve using
IORESOURCE_PCI_FIXED.  I just object to the fact that we run so much
code that thinks this is a real BAR, and we have no idea what data
we're getting back, so we don't know what that struct resource will
end up looking like.  What I *want* is for that resource to remain
zeroed out, just like any other resource corresponding to an
unimplemented BAR.

Bjorn
