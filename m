Return-Path: <SRS0=h4BL=2Z=firstfloor.org=andi@kernel.org>
Return-Path: <SRS0=h4BL=2Z=firstfloor.org=andi@kernel.org>
Date: Wed, 15 Mar 2017 17:02:48 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Andi Kleen <andi@firstfloor.org>,
	Andi Kleen <ak@linux.intel.com>, bhelgaas@google.com,
	x86@kernel.org, linux-pci@vger.kernel.org, eranian@google.com,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86, pci: Add interface to force mmconfig
Message-ID: <20170316000247.GD14380@two.firstfloor.org>
References: <20170302232104.10136-3-andi@firstfloor.org>
 <alpine.DEB.2.20.1703141407090.3619@nanos>
 <20170314154155.GG32070@tassilo.jf.intel.com>
 <alpine.DEB.2.20.1703141713010.3619@nanos>
 <20170314170255.GH32070@tassilo.jf.intel.com>
 <alpine.DEB.2.20.1703141849170.3619@nanos>
 <20170314194720.GD26264@bhelgaas-glaptop.roam.corp.google.com>
 <20170315022414.GC14380@two.firstfloor.org>
 <20170315025549.GA13191@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.20.1703150954180.3554@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1703150954180.3554@nanos>
List-ID: <linux-pci.vger.kernel.org>

> pci_root_ops is what is finally handed in to pci_scan_root_bus() as ops
> argument for any bus segment no matter which type it is.

mmconfig is only initialized after PCI is initialized
(an ordering problem with ACPI). So it would require
updating existing busses with likely interesting race
conditions.

There are also other ordering problems in the PCI layer,
that is one of the reason early and raw PCI accesses even exist.

> 
> The locking aspect is interesting as well. The type0/1 functions are having
> their own internal locking. Oh, well.

Right it could set lockless too. The internal locking is still needed
because there are other users too.

> What we really want is to differentiate bus segments. That means a PCIe
> segment takes mmconfig ops and a PCI segment the type0/1 ops. That way we
> can do what you suggested above, i.e. marking the ecam/mmconfig ops as
> lockless.

There's no need to separate PCIe and PCI. mmconfig has nothing to do
with that.

> Sure that's more work than just whacking a sloppy quirk into the code, but
> the right thing to do.

Before proposing grandiose plans it would be better if you
acquired some basic understanding of the constraints this
code is operating under first.

-Andi
