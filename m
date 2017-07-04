Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 4 Jul 2017 10:15:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
Message-ID: <20170704151502.GH13824@bhelgaas-glaptop.roam.corp.google.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
 <20170703134031.GG13824@bhelgaas-glaptop.roam.corp.google.com>
 <20170703181128.GD4902@n2100.armlinux.org.uk>
MIME-Version: 1.0
In-Reply-To: <20170703181128.GD4902@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Mason <slash.tmp@free.fr>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 03, 2017 at 07:11:28PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 03, 2017 at 08:40:31AM -0500, Bjorn Helgaas wrote:
> > The problem is serializing vs. memory accesses, since they don't use
> > any wrappers.  However, they are ioremapped(), so it's at least
> > conceivable that another solution would be to use VM to trap those
> > accesses.  I'm not a VM person, so I don't know whether that's
> > feasible in Linux.
> 
> Bjorn,
> 
> You're forgetting that MMIO (iow, memory returned by ioremap()) must
> be accessed through the appropriate accessors, and must not be
> directly dereferenced in C.  (We do have buggy drivers that do that
> but they are buggy, and in many cases are getting attention to fix
> that.)

Oh, you're right, thank you!  I guess you're referring to readb()
and friends.  I haven't found an actual prohibition on directly
dereferencing addresses returned from ioremap(), but
Documentation/driver-api/device-io.rst is clear that they're
suitable for passing to readb(), etc.

I recently told someone else my mistaken idea that ioremap() must
return a valid virtual address.  I wish I remembered who it was, so I
could correct that.  Documentation/DMA-API-HOWTO.txt also suggests
that ioremap() returns a virtual address -- I think I wrote that, and
maybe that virtual address reference should be tweaked a bit.

Another wrinkle is that the pci_mmap_resource() interface is exposed
via sysfs and allows direct userspace mmap of PCI MMIO resources.  In
that case, there is no accessor available.  I wonder if we need some
way to disable this mmap when readb() is non-trivial.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
