Return-Path: <SRS0=q5GP=2Z=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=q5GP=2Z=linutronix.de=tglx@kernel.org>
Date: Thu, 16 Mar 2017 23:45:35 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andi Kleen <andi@firstfloor.org>
cc: Bjorn Helgaas <helgaas@kernel.org>, Andi Kleen <ak@linux.intel.com>,
    bhelgaas@google.com, x86@kernel.org, linux-pci@vger.kernel.org,
    eranian@google.com, Peter Zijlstra <peterz@infradead.org>,
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86, pci: Add interface to force mmconfig
In-Reply-To: <20170316000247.GD14380@two.firstfloor.org>
Message-ID: <alpine.DEB.2.20.1703162335180.4110@nanos>
References: <20170302232104.10136-3-andi@firstfloor.org> <alpine.DEB.2.20.1703141407090.3619@nanos> <20170314154155.GG32070@tassilo.jf.intel.com> <alpine.DEB.2.20.1703141713010.3619@nanos> <20170314170255.GH32070@tassilo.jf.intel.com> <alpine.DEB.2.20.1703141849170.3619@nanos>
 <20170314194720.GD26264@bhelgaas-glaptop.roam.corp.google.com> <20170315022414.GC14380@two.firstfloor.org> <20170315025549.GA13191@bhelgaas-glaptop.roam.corp.google.com> <alpine.DEB.2.20.1703150954180.3554@nanos>
 <20170316000247.GD14380@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Wed, 15 Mar 2017, Andi Kleen wrote:
> > pci_root_ops is what is finally handed in to pci_scan_root_bus() as ops
> > argument for any bus segment no matter which type it is.
> 
> mmconfig is only initialized after PCI is initialized (an ordering
> problem with ACPI).

Wrong. It can be initialized before that and it actually is on most of my
machines. Unfortunately its not guaranteed.

> So it would require updating existing busses with likely interesting race
> conditions.

More racy than switching it from a random driver after the PCI bus has been
completely initialized and is already in use? Surely not.

> There are also other ordering problems in the PCI layer,
> that is one of the reason early and raw PCI accesses even exist.

Early accesses are a different class for PCI accesses _before_
pci_arch_init() or acpi_init() has been invoked. That's handled by the
early accessors which are hardcoded to use PCI type 1 configuration access
via CF8/CFC. These are completely seperate and not in any way related to
this.

So lets look how this works:

   pci_arch_init()

	Setup of raw_pci_ops and raw_pci_ext_ops

	This sets mmconfig, when the information is available already.

   acpi_init()

	Parses the ACPI tables and sets up the PCI root.

	Sets mmconfig when not yet set.

   pci_subsys_init()

	Final x86 pci init calls, which might affect pci ops.

So ideally we would switch to ECAM before acpi_init(), but

   - mmconfig might not yet be available
   
   - x86_init.pci.init() which is called from pci_subsys_init() can modify
     pci_root_ops or raw_pci_ops

Though that's a non issue simple because after x86_init.pci.init() still
nothing operates on PCI devices and it's safe and simple to replace the
pci_root_ops read and write pointers with ECAM based variants.

> > The locking aspect is interesting as well. The type0/1 functions are having
> > their own internal locking. Oh, well.

> Right it could set lockless too. The internal locking is still needed
> because there are other users too.

Looking at the x86 pci ops variants, there is only the ce4100 one, which
relies on the external locking in the generic pci code. That's reasonable
easy to fix and once that is done the whole conditional locking in the
generic PCI accessors can be avoided. The locking can simply be compiled
out.

> > What we really want is to differentiate bus segments. That means a PCIe
> > segment takes mmconfig ops and a PCI segment the type0/1 ops. That way we
> > can do what you suggested above, i.e. marking the ecam/mmconfig ops as
> > lockless.
> 
> There's no need to separate PCIe and PCI. mmconfig has nothing to do
> with that.

What? If the system does not have a PCIe compliant root complex/host
bridge, then you cannot use mmconfig at all. So yes, there needs to be a
decision made.

Sure, we don't have to treat PCI busses behind a PCIe to PCI(-X) bridge
differently as that handled by the host bridge and the PCIe/PCI(-X)
bridge. There might be dragons lurking, but those can be handled with a
date cutoff or a small set of quirks.

> > Sure that's more work than just whacking a sloppy quirk into the code, but
> > the right thing to do.
> 
> Before proposing grandiose plans it would be better if you acquired some
> basic understanding of the constraints this code is operating under
> first.

Contrary to you I studied the code and the spec before making uneducated
claims and accusations.

And contrary to you I care about the correctness and the maintainability of
the code. Your works for me and know everything better attitude is the main
reason for the mess which exists today. Your thought termination cliche,
that others do not understand what they are talking about has been proven
wrong over and over.

I did not claim that it's simple and I merily talked about the ideal
solution while I was well aware that there are dependencies and corner
cases.

It took me a only couple of hours to analyze all possible corner cases
which reconfigure pci_root_ops or raw_pci_*ops to find a spot where this
can be done in a sane way.

Patches come with a seperate mail. They get rid of the global pci_lock in
the generic accessors completely and avoid the extra pointer indirection
and do not even get near a driver.

It might look like a grandiose plan to you, but that might be due to a
gross overestimation of the complexity of that code or the lack of basic
engineering principles.

Thanks,

	tglx
