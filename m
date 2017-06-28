Return-Path: <SRS0=ylFh=6B=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=ylFh=6B=linutronix.de=tglx@kernel.org>
Date: Wed, 28 Jun 2017 22:31:20 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
    Peter Anvin <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
    Peter Zijlstra <peterz@infradead.org>,
    Stephane Eranian <eranian@google.com>, Andi Kleen <ak@linux.intel.com>,
    linux-pci@vger.kernel.org
Subject: Re: [patch 4/7] PCI: Provide Kconfig option for lockless config
 space accessors
In-Reply-To: <20170627211152.GE764@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.20.1706282220400.1890@nanos>
References: <20170316215002.726697858@linutronix.de> <20170316215057.205961140@linutronix.de> <20170627211152.GE764@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Tue, 27 Jun 2017, Bjorn Helgaas wrote:
> On Thu, Mar 16, 2017 at 10:50:06PM +0100, Thomas Gleixner wrote:
> > Provide a kernel config option which can be selected by an architecture
> > when the low level PCI configuration space accessors in the architecture
> > use their own serialization or can operate completely lockless.
> 
> The arch/x86/pci/common.c comment:
> 
>   /*
>    * This interrupt-safe spinlock protects all accesses to PCI
>    * configuration space.
>    */
>   DEFINE_RAW_SPINLOCK(pci_config_lock);
> 
> is no longer quite correct.

Yes. I updated it to:

 * This interrupt-safe spinlock protects all accesses to PCI configuration
 * space, except for the mmconfig (ECAM) based operations.

> I think the raw_pci_read() and raw_pci_write() implementations are
> such that we use the old locked accessors for the first 256 bytes,
> even when ECAM is available.  Not necessarily a problem, just an
> observation.

No, we actually don't after the next patch, which replaces the
pci_root_ops.read/write function pointers with the lockless ECAM accessors
after the end of the initialization, if none of the special quirks replaced
raw_pci_ext_ops and mmconfig/ECAM is available.

> I guess the uncore PMU registers are in the extended config space.

Yes.

Thanks,

	tglx
