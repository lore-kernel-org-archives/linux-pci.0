Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sun, 20 Aug 2017 16:54:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 1/1] Split VGA default device handler out of VGA arbiter
Message-ID: <20170820215449.GZ28977@bhelgaas-glaptop.roam.corp.google.com>
References: <20170817113028.16853-1-dja@axtens.net>
 <20170817113028.16853-2-dja@axtens.net>
 <20170819154753.GQ28977@bhelgaas-glaptop.roam.corp.google.com>
 <1503256100.12059.13.camel@kernel.crashing.org>
MIME-Version: 1.0
In-Reply-To: <1503256100.12059.13.camel@kernel.crashing.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: gabriele.paoloni@huawei.com, airlied@linux.ie, linux-pci@vger.kernel.org,
 will.deacon@arm.com, dri-devel@lists.freedesktop.org,
 z.liuxinliang@hisilicon.com, zourongrong@gmail.com, alex.williamson@redhat.com,
 lukas@wunner.de, catalin.marinas@arm.com, bhelgaas@google.com,
 daniel.vetter@intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 20, 2017 at 12:08:20PM -0700, Benjamin Herrenschmidt wrote:
> On Sat, 2017-08-19 at 10:47 -0500, Bjorn Helgaas wrote:
> > So if ARM64 doesn't have these PCI legacy resources, does that mean an
> > ARM64 host bridge cannot generate these legacy addresses on PCI?  That
> > is, there's no host bridge window that maps to those PCI addresses?
> > That seems like a curious restriction on host bridges, but I guess it
> > would be possible.
> 
> It's rather common. For example on POWER8:

I'm just trying to tease out which things are required by PCI and
which things are required by the arch.  It doesn't surprise me at all
that some platforms (on any arch) don't provide access to legacy
resources.  That's totally outside the PCI area.  Do Power and ARM64
actively *prohibit* platforms from using legacy resources?  I can
believe current platforms don't use them, but I can still conceive of
possible systems that could.

I think removing the "(e.g. ARM64)" from the original changelog would
have avoided my questions.  That example suggests that ARM64 is
special in some way and *cannot* use PCI legacy resources.  It's easy
to conceive of a system of any arch that can't use them, simply
because it chose to use a host bridge that can't generate PCI
transactions to the VGA frame buffer or to I/O space.

>  - There is no IO space at all
> 
>  - We configure the 32-bit MMIO window to be around 3..4G (to avoid
> overlapping with DMA space below it).
> 
> So we effectively have no path to the legacy areas, and that hasn't
> been a problem so far.

I assume vga16fb.c and similar things don't work (which isn't a
problem as long as that's what everybody expects).

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
