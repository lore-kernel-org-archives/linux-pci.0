Return-Path: <SRS0=LhAB=6G=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=LhAB=6G=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Date: Mon, 3 Jul 2017 19:11:28 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
	Mark Rutland <mark.rutland@arm.com>, Mason <slash.tmp@free.fr>,
	Marc Zyngier <marc.zyngier@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
Message-ID: <20170703181128.GD4902@n2100.armlinux.org.uk>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
 <20170703134031.GG13824@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170703134031.GG13824@bhelgaas-glaptop.roam.corp.google.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 03, 2017 at 08:40:31AM -0500, Bjorn Helgaas wrote:
> The problem is serializing vs. memory accesses, since they don't use
> any wrappers.  However, they are ioremapped(), so it's at least
> conceivable that another solution would be to use VM to trap those
> accesses.  I'm not a VM person, so I don't know whether that's
> feasible in Linux.

Bjorn,

You're forgetting that MMIO (iow, memory returned by ioremap()) must
be accessed through the appropriate accessors, and must not be
directly dereferenced in C.  (We do have buggy drivers that do that
but they are buggy, and in many cases are getting attention to fix
that.)

However, adding a spinlock into them is really not nice, because it
adds extra overhead that's only necessary for rare cases like Sigma
Designs - especially when you consider that these accessors are used
for all MMIO accesses, not just PCI.  It would effectively mean that
we end up serialising all MMIO accesses throughout the kernel when
Sigma Designs SoCs are enabled, destroying some of the SMP benefit.

I don't think we can sanely use the MMU to trap those accesses either,
that would mean sending IPIs to tell other CPUs to do something, and
waiting for them to respond - which can deadlock if we're already in
an IRQ-protected region (iirc, config accesses are made with IRQs
off.)

I don't think there's an easy solution to this problem - and I'm not
sure that stop_machine() can be made to work in this path (which
needs a process context).  I have a suspicion that the Sigma Designs
PCI implementation is just soo insane that it's never going to work
reliably in a multi-SoC kernel without introducing severe performance
issues for everyone else.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
