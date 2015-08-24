Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35288 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbHXTNm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2015 15:13:42 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: mingo@kernel.org
Cc: bp@suse.de, bhelgaas@google.com, tomi.valkeinen@ti.com,
	airlied@linux.ie, linux-fbdev@vger.kernel.org, luto@amacapital.net,
	vinod.koul@intel.com, dan.j.williams@intel.com, toshi.kani@hp.com,
	benh@kernel.crashing.org, mst@redhat.com,
	akpm@linux-foundation.org, daniel.vetter@ffwll.ch,
	konrad.wilk@oracle.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xen-devel@lists.xensource.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH v4 00/11] x86/dma: RIP MTRR and dma write-combine API rename
Date: Mon, 24 Aug 2015 12:13:22 -0700
Message-Id: <1440443613-13696-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Ingo,

This is my pending series of patches for both write-combining and moving
Linux' use of MTRR into the grave. It combines three set of straggler patch
series which have been pending integration for a while now. The rename patches
do not depend in any way with the MTRR patches but I've combined them here as
they are all pending and relating to write-combining. I explain why integration
of such patches has been delayed but also provide reasoning for why I believe
its time to merge them.

1) The DMA API rename for write-combining goes with the old naming convention
   defines added as suggested by you for any possible stragglers which may come
   up as this goes through and gets merged. We can remove the old define
   mappings after a release once this gets sucked in and things settle. These
   patches have been in Boris tree for a while but I keep having to refresh
   them as the kernel moves on, the addition of the old mapping should allow
   us to merge this without any collateral.

2) The PCI driver changes go with Tomi Valkeinen's Acks as well as
   Arnd Bergmann's own Acks for the PCI and asm-generic changes. This series
   was technically acknowledged by Bjorn to be correct and acceptable but his
   preference was for this to not use EXPORT_SYMBOL_GPL() as not *all*
   write-combine APIs are using EXPORT_SYMBOL_GPL(). Our goal on x86 though
   is to not deal with bug reports for new PAT APIs [0] and since its now clear
   through documentation that its up to the maintainers / developers if they
   decide to use EXPORT_SYMBOL_GPL() for new *features* [1] I keep that
   practice in alignment with our own x86 goals to avoid bug reports and
   issues with proprietary drivers on new PAT interfaces. Bjorn was happy for
   this to go through someone else's tree, in particular Arnd's. Arnd Acked
   the series [2] but is unable to take these patches in at this time as he's
   out on paternal leave so sending these through you with the respective Acks.
   Boris has been hugely instrumental on helping review all MTRR related 
   series, these were sitting on his queue for a while, but he's also
   unavailable now as he's on vacation.

3) Unexporting direct MTRR access. This is last patch, I had posted this first
   on March 2015 when [3] I originally had meshed up all the MTRR work into one
   giant series. I ending up splitting up all the work into *over* 12 series.
   Now that all the work is merged except these few patches I've combined that
   patch as the last part of this series. I've amended an obituary note for
   MTRR regarding platform firmware access to MTRR based on recent discussions
   [4] and updated the documentation to reflect the status quo for Linux.

All of these patches have been tested by the 0-day bot machine. The only thing
*new* here is just my obituary amended documentation note for platform firmware
access to MTRRs on the last patch based hugely on review with Toshi.

[0] http://lkml.kernel.org/r/1424961893.17007.139.camel@misato.fc.hp.com
[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=582ed8d51e2b6cb8a168c94852bca482685c2509
[2] http://lkml.kernel.org/r/2962702.QXZzP3RbKY@wuerfel
[3] http://lkml.kernel.org/r/1426893517-2511-48-git-send-email-mcgrof@do-not-panic.com
[4] http://lkml.kernel.org/r/1438991330.3109.196.camel@hp.com

Luis R. Rodriguez (11):
  PCI: Add pci_ioremap_wc_bar()
  drivers/video/fbdev/i740fb: Use arch_phys_wc_add() and
    pci_ioremap_wc_bar()
  drivers/video/fbdev/kyrofb: Use arch_phys_wc_add() and
    pci_ioremap_wc_bar()
  drivers/video/fbdev/gxt4500: Use pci_ioremap_wc_bar() to map
    framebuffer
  PCI: Add pci_iomap_wc() variants
  drivers/video/fbdev/arkfb.c: Use arch_phys_wc_add() and pci_iomap_wc()
  drivers/video/fbdev/s3fb: Use arch_phys_wc_add() and pci_iomap_wc()
  drivers/video/fbdev/vt8623fb: Use arch_phys_wc_add() and
    pci_iomap_wc()
  drivers/dma/iop-adma: Use dma_alloc_writecombine() kernel-style
  dma: rename dma_*_writecombine() to dma_*_wc()
  mtrr: bury MTRR - unexport mtrr_add() and mtrr_del()

 Documentation/x86/mtrr.txt                | 20 ++++++++--
 arch/arm/mach-lpc32xx/phy3250.c           | 13 +++---
 arch/arm/mach-netx/fb.c                   | 14 +++----
 arch/arm/mach-nspire/clcd.c               | 13 +++---
 arch/avr32/include/asm/dma-mapping.h      | 20 +++++-----
 arch/avr32/mm/dma-coherent.c              | 12 +++---
 arch/metag/include/asm/dma-mapping.h      |  4 +-
 arch/metag/kernel/dma.c                   |  6 +--
 arch/x86/kernel/cpu/mtrr/main.c           |  2 -
 drivers/dma/iop-adma.c                    |  9 +++--
 drivers/dma/mv_xor.c                      |  4 +-
 drivers/dma/qcom_bam_dma.c                | 14 +++----
 drivers/gpu/drm/drm_gem_cma_helper.c      | 13 +++---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c  | 13 +++---
 drivers/gpu/drm/omapdrm/omap_gem.c        |  8 ++--
 drivers/gpu/drm/sti/sti_cursor.c          | 13 +++---
 drivers/gpu/drm/sti/sti_gdp.c             |  3 +-
 drivers/gpu/drm/sti/sti_hqvdp.c           |  6 +--
 drivers/gpu/drm/tegra/gem.c               | 11 +++---
 drivers/gpu/host1x/cdma.c                 |  8 ++--
 drivers/gpu/host1x/job.c                  | 10 ++---
 drivers/media/platform/coda/coda-bit.c    | 10 ++---
 drivers/pci/pci.c                         | 14 +++++++
 drivers/video/fbdev/acornfb.c             |  4 +-
 drivers/video/fbdev/amba-clcd-versatile.c | 14 +++----
 drivers/video/fbdev/amba-clcd.c           |  4 +-
 drivers/video/fbdev/arkfb.c               | 36 +++--------------
 drivers/video/fbdev/atmel_lcdfb.c         |  9 +++--
 drivers/video/fbdev/ep93xx-fb.c           |  9 ++---
 drivers/video/fbdev/gbefb.c               |  8 ++--
 drivers/video/fbdev/gxt4500.c             |  2 +-
 drivers/video/fbdev/i740fb.c              | 35 +++-------------
 drivers/video/fbdev/imxfb.c               | 12 +++---
 drivers/video/fbdev/kyro/fbdev.c          | 33 ++++++----------
 drivers/video/fbdev/mx3fb.c               |  9 ++---
 drivers/video/fbdev/nuc900fb.c            |  8 ++--
 drivers/video/fbdev/omap/lcdc.c           | 16 ++++----
 drivers/video/fbdev/pxa168fb.c            |  8 ++--
 drivers/video/fbdev/pxafb.c               |  4 +-
 drivers/video/fbdev/s3c-fb.c              |  7 ++--
 drivers/video/fbdev/s3c2410fb.c           |  8 ++--
 drivers/video/fbdev/s3fb.c                | 35 +++-------------
 drivers/video/fbdev/sa1100fb.c            |  8 ++--
 drivers/video/fbdev/vt8623fb.c            | 31 +++------------
 include/asm-generic/pci_iomap.h           | 14 +++++++
 include/linux/dma-mapping.h               | 16 ++++----
 include/linux/pci.h                       |  1 +
 include/video/kyro.h                      |  4 +-
 lib/pci_iomap.c                           | 66 +++++++++++++++++++++++++++++++
 sound/arm/pxa2xx-pcm-lib.c                | 20 ++++------
 sound/soc/fsl/imx-pcm-fiq.c               | 10 ++---
 sound/soc/nuc900/nuc900-pcm.c             |  6 +--
 sound/soc/omap/omap-pcm.c                 | 12 ++----
 53 files changed, 331 insertions(+), 358 deletions(-)

-- 
2.4.3

