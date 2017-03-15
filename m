Return-Path: <SRS0=sW/k=2Y=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=sW/k=2Y=linutronix.de=tglx@kernel.org>
Date: Wed, 15 Mar 2017 11:00:22 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Andi Kleen <andi@firstfloor.org>, Andi Kleen <ak@linux.intel.com>,
    bhelgaas@google.com, x86@kernel.org, linux-pci@vger.kernel.org,
    eranian@google.com, Peter Zijlstra <peterz@infradead.org>,
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86, pci: Add interface to force mmconfig
In-Reply-To: <20170315025549.GA13191@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703150954180.3554@nanos>
References: <20170302232104.10136-1-andi@firstfloor.org> <20170302232104.10136-3-andi@firstfloor.org> <alpine.DEB.2.20.1703141407090.3619@nanos> <20170314154155.GG32070@tassilo.jf.intel.com> <alpine.DEB.2.20.1703141713010.3619@nanos>
 <20170314170255.GH32070@tassilo.jf.intel.com> <alpine.DEB.2.20.1703141849170.3619@nanos> <20170314194720.GD26264@bhelgaas-glaptop.roam.corp.google.com> <20170315022414.GC14380@two.firstfloor.org>
 <20170315025549.GA13191@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Tue, 14 Mar 2017, Bjorn Helgaas wrote:
> On Tue, Mar 14, 2017 at 07:24:14PM -0700, Andi Kleen wrote:
> > > I agree that it should be fairly safe to do ECAM/MMCONFIG without
> > > locking.  Can we handle the decision part by adding a "lockless" bit
> > > to struct pci_ops?  Old ops don't mention that bit, so it will be
> > > initialized to zero and we'll do locking as today.  ECAM/MMCONFIG ops
> > > can set it and we can skip the locking.
> > 
> > That's what my other patch already did. 
> 
> Yes, your 1/4 patch does add the "ll_allowed" bit in struct pci_ops.
> 
> What I was wondering, but didn't explain very well, was whether
> instead of setting that bit at run-time in pci_mmcfg_arch_init(), we
> could set it statically in the pci_ops definition, e.g.,
> 
>   static struct pci_ops ecam_ops = {
>     .lockless = 1,
>     .read = ecam_read,
>     .write = ecam_write,
>   };
> 
> I think it would be easier to read if the lockless-ness were declared
> right next to the accessors that need it (or don't need it).
> 
> But it is a little confusing with all the different paths, at least on
> x86, so maybe it wouldn't be quite that simple.

The pci_ops in x86 are a complete mess. We have

struct pci_ops pci_root_ops = {
        .read = pci_read,
	.write = pci_write,
};

That's the default and the r/w functions look like this:

pci_read/write()
{
	if (domain == 0 && reg && raw_pci_ops)
 		return raw_pci_ops->read/write();
	if (raw_pci_ext_ops)
 		return raw_pci_ext_ops->read/write();
	return -EINVAL;
}

raw_pci_ops and raw_pci_ext_ops are setup through an impenetrable maze of
functions. Some of them overwrite pci_root_ops to something entirely
different.

pci_root_ops is what is finally handed in to pci_scan_root_bus() as ops
argument for any bus segment no matter which type it is.

The locking aspect is interesting as well. The type0/1 functions are having
their own internal locking. Oh, well.

What we really want is to differentiate bus segments. That means a PCIe
segment takes mmconfig ops and a PCI segment the type0/1 ops. That way we
can do what you suggested above, i.e. marking the ecam/mmconfig ops as
lockless.

Sure that's more work than just whacking a sloppy quirk into the code, but
the right thing to do.

Thanks,

	tglx
