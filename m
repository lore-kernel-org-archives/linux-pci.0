Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 4 Apr 2017 17:43:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] PCI resource mmap cleanup
Message-ID: <20170404224355.GC989@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1490188942.git.dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1490188942.git.dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 22, 2017 at 01:25:14PM +0000, David Woodhouse wrote:
> This started out as a fairly trivial "add pci_mmap_page_range() for 
> ARM64" patch. But pci_mmap_page_range() is a vile interface, taking 
> "user visible" resource addresses converted with pci_resource_to_user() 
> on those platforms unlucky enough to use that... and even in the *sane* 
> sysfs-based mmap method, we convert through user addresses to call the
> platform-specific method.
> 
> In most cases there's just no need for any of this crap. We can migrate
> most architectures to a generic implementation without much thought,
> and the few that aren't converted in this series can probably be added
> fairly easily too but need a little more arch-specific attention.
> 
> Utterly untested for now; I'll do some testing while I deal with the
> inevitable bikeshedding.

This looks really nice; thanks a lot for doing this!

I agree with Arnd about the __aarch64__ ifdef in pci/proc.c; I'd rather get
rid of that if we can.

I think you had a couple other updates; can you post a v2 when you're done
with those?

> David Woodhouse (17):
>   pci: Fix pci_mmap_fits() for HAVE_PCI_RESOURCE_TO_USER platforms
>   pci: Fix another sanity check bug in /proc/pci mmap
>   pci: Only allow WC mmap on prefetchable resources
>   pci: Add arch_can_pci_mmap_wc() macro
>   pci: Move multiple declarations of pci_mmap_page_range() to <linux/pci.h>
>   pci: Add HAVE_PCI_MMAP_IO to architectures which can mmap() I/O space
>   pci: Use BAR index in sysfs attr->private instead of resource pointer
>   pci: Add BAR index argument to pci_mmap_page_range()
>   pci: Add pci_mmap_resource_range() and use it for ARM64
>   arm: Use generic pci_mmap_resource_range()
>   cris: Use generic pci_mmap_resource_range()
>   mips: Use generic pci_mmap_resource_range()
>   mn10300: Use generic pci_mmap_resource_range()
>   parisc: Use generic pci_mmap_resource_range()
>   sh: Use generic pci_mmap_resource_range()
>   unicore: Use generic pci_mmap_resource_range()
>   arm64: Do not expose PCI mmap through procfs
> 
>  Documentation/filesystems/sysfs-pci.txt |  9 +++-
>  arch/arm/include/asm/pci.h              |  3 +-
>  arch/arm/kernel/bios32.c                | 19 -------
>  arch/arm64/include/asm/pci.h            |  3 ++
>  arch/cris/arch-v32/drivers/pci/bios.c   | 22 --------
>  arch/cris/include/asm/pci.h             |  4 +-
>  arch/ia64/include/asm/pci.h             |  4 +-
>  arch/ia64/pci/pci.c                     |  3 +-
>  arch/microblaze/include/asm/pci.h       |  6 +--
>  arch/microblaze/pci/pci-common.c        |  2 +-
>  arch/mips/include/asm/pci.h             |  5 +-
>  arch/mips/pci/pci.c                     | 24 ---------
>  arch/mn10300/include/asm/pci.h          |  4 +-
>  arch/mn10300/unit-asb2305/pci-asb2305.c | 23 ---------
>  arch/parisc/include/asm/pci.h           |  4 +-
>  arch/parisc/kernel/pci.c                | 28 ----------
>  arch/powerpc/include/asm/pci.h          |  9 ++--
>  arch/powerpc/kernel/pci-common.c        |  3 +-
>  arch/sh/drivers/pci/pci.c               | 21 --------
>  arch/sh/include/asm/pci.h               |  4 +-
>  arch/sparc/include/asm/pci_64.h         |  5 +-
>  arch/sparc/kernel/pci.c                 |  6 +--
>  arch/unicore32/include/asm/pci.h        |  3 +-
>  arch/unicore32/kernel/pci.c             | 23 ---------
>  arch/x86/include/asm/pci.h              |  6 +--
>  arch/x86/pci/i386.c                     |  3 +-
>  arch/xtensa/include/asm/pci.h           | 11 ++--
>  arch/xtensa/kernel/pci.c                |  5 +-
>  drivers/pci/Makefile                    |  2 +-
>  drivers/pci/mmap.c                      | 90 +++++++++++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c                 | 77 +++++++++++++---------------
>  drivers/pci/proc.c                      | 55 ++++++++++++++------
>  include/linux/pci.h                     | 19 +++++++
>  33 files changed, 233 insertions(+), 272 deletions(-)
>  create mode 100644 drivers/pci/mmap.c
> 
> -- 
> 2.9.3
> 
