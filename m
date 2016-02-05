Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 5 Feb 2016 16:36:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] Clean up warnings (part 2, asm/pci-bridge.h)
Message-ID: <20160205223658.GC16238@localhost>
References: <20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 02, 2016 at 01:38:26PM -0600, Bjorn Helgaas wrote:
> We've had some non-arch-specific stuff (pci_has_flag() and associated
> definitions like PCI_PROBE_ONLY) in asm/pci-bridge.h.  This leads to
> warnings like:
> 
>   drivers/pci/host/pcie-designware.c:562:20: error: 'PCI_PROBE_ONLY' undeclared (first use in this function)
>   drivers/pci/host/pcie-designware.c:562:7: error: implicit declaration of function 'pci_has_flag' [-Werror=implicit-function-declaration]
> 
> because arches don't consistently supply asm/pci-bridge.h, and several
> drivers include it when they shouldn't.
> 
> This series moves the generic stuff to linux/pci.h, so it's the same for
> everybody, and removes the now-empty asm-generic/pci-bridge.h.
> 
> There still a few arches that provide asm/pci-bridge.h (microblaze,
> powerpc, and xtensa), but now they contain truly arch-dependent things like
> struct pci_controller definitions, and they're only included by
> arch-specific files.
> 
> ---
> 
> Bjorn Helgaas (5):
>       PCI: Move pci_set_flags() from asm-generic/pci-bridge.h to linux/pci.h
>       PCI: Remove includes of empty asm-generic/pci-bridge.h
>       ARM64: PCI: Remove generated include of asm-generic/pci-bridge.h
>       PCI: Remove empty asm-generic/pci-bridge.h
>       PCI: Remove includes of asm/pci-bridge.h

I applied these, with Will's ack on the arm64 parts, to pci/misc
for v4.6.

>  arch/alpha/include/asm/pci.h               |    1 
>  arch/arm/include/asm/pci.h                 |    3 -
>  arch/arm64/include/asm/Kbuild              |    3 -
>  arch/arm64/include/asm/pci.h               |    1 
>  arch/arm64/kernel/pci.c                    |    2 -
>  arch/mips/include/asm/pci.h                |    1 
>  arch/powerpc/include/asm/pci-bridge.h      |    1 
>  arch/unicore32/include/asm/pci.h           |    2 -
>  arch/x86/pci/common.c                      |    1 
>  drivers/ata/pata_macio.c                   |    2 -
>  drivers/char/agp/uninorth-agp.c            |    1 
>  drivers/gpu/drm/radeon/radeon_combios.c    |    1 
>  drivers/ide/pdc202xx_new.c                 |    1 
>  drivers/ide/pmac.c                         |    1 
>  drivers/macintosh/macio_asic.c             |    1 
>  drivers/misc/cxl/pci.c                     |    1 
>  drivers/net/ethernet/sun/sungem.c          |    1 
>  drivers/net/ethernet/toshiba/spider_net.c  |    1 
>  drivers/of/of_pci.c                        |    1 
>  drivers/pci/pci.c                          |    1 
>  drivers/pci/probe.c                        |    8 +++
>  drivers/pci/setup-bus.c                    |    1 
>  drivers/scsi/mac53c94.c                    |    2 -
>  drivers/scsi/mesh.c                        |    2 -
>  drivers/usb/core/hcd-pci.c                 |    1 
>  drivers/video/fbdev/aty/aty128fb.c         |    1 
>  drivers/video/fbdev/aty/radeon_base.c      |    1 
>  drivers/video/fbdev/imsttfb.c              |    1 
>  drivers/video/fbdev/matrox/matroxfb_base.h |    1 
>  drivers/video/fbdev/offb.c                 |    4 --
>  include/asm-generic/pci-bridge.h           |   74 ----------------------------
>  include/linux/pci.h                        |   22 ++++++++
>  sound/ppc/pmac.c                           |    1 
>  33 files changed, 32 insertions(+), 114 deletions(-)
>  delete mode 100644 include/asm-generic/pci-bridge.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
