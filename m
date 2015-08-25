Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 25 Aug 2015 09:53:18 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: bp@suse.de, bhelgaas@google.com, tomi.valkeinen@ti.com,
	airlied@linux.ie, linux-fbdev@vger.kernel.org, luto@amacapital.net,
	vinod.koul@intel.com, dan.j.williams@intel.com, toshi.kani@hp.com,
	benh@kernel.crashing.org, mst@redhat.com,
	akpm@linux-foundation.org, daniel.vetter@ffwll.ch,
	konrad.wilk@oracle.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xen-devel@lists.xensource.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH v4 10/11] dma: rename dma_*_writecombine() to dma_*_wc()
Message-ID: <20150825075318.GA2735@gmail.com>
References: <1440443613-13696-1-git-send-email-mcgrof@do-not-panic.com>
 <1440443613-13696-11-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440443613-13696-11-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Luis R. Rodriguez <mcgrof@do-not-panic.com> wrote:

> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> Rename dma_*_writecombine() to dma_*_wc(), so that the naming
> is coherent across the various write-combining APIs.
> 
> The following Coccinelle SmPL patch was used for this simple
> transformation:
> 
> @ rename_dma_alloc_writecombine @
> expression dev, size, dma_addr, gfp;
> @@
> 
> -dma_alloc_writecombine(dev, size, dma_addr, gfp)
> +dma_alloc_wc(dev, size, dma_addr, gfp)
> 
> @ rename_dma_free_writecombine @
> expression dev, size, cpu_addr, dma_addr;
> @@
> 
> -dma_free_writecombine(dev, size, cpu_addr, dma_addr)
> +dma_free_wc(dev, size, cpu_addr, dma_addr)
> 
> @ rename_dma_mmap_writecombine @
> expression dev, vma, cpu_addr, dma_addr, size;
> @@
> 
> -dma_mmap_writecombine(dev, vma, cpu_addr, dma_addr, size)
> +dma_mmap_wc(dev, vma, cpu_addr, dma_addr, size)
> 
> Generated-by: Coccinelle SmPL
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
>  arch/arm/mach-lpc32xx/phy3250.c           | 13 ++++++-------
>  arch/arm/mach-netx/fb.c                   | 14 ++++++--------
>  arch/arm/mach-nspire/clcd.c               | 13 ++++++-------
>  arch/avr32/include/asm/dma-mapping.h      | 20 ++++++++++----------
>  arch/avr32/mm/dma-coherent.c              | 12 ++++++------
>  arch/metag/include/asm/dma-mapping.h      |  4 ++--
>  arch/metag/kernel/dma.c                   |  6 +++---
>  drivers/dma/iop-adma.c                    |  8 ++++----
>  drivers/dma/mv_xor.c                      |  4 ++--
>  drivers/dma/qcom_bam_dma.c                | 14 +++++++-------
>  drivers/gpu/drm/drm_gem_cma_helper.c      | 13 ++++++-------
>  drivers/gpu/drm/omapdrm/omap_dmm_tiler.c  | 13 ++++++-------
>  drivers/gpu/drm/omapdrm/omap_gem.c        |  8 ++++----
>  drivers/gpu/drm/sti/sti_cursor.c          | 13 ++++++-------
>  drivers/gpu/drm/sti/sti_gdp.c             |  3 +--
>  drivers/gpu/drm/sti/sti_hqvdp.c           |  6 +++---
>  drivers/gpu/drm/tegra/gem.c               | 11 +++++------
>  drivers/gpu/host1x/cdma.c                 |  8 ++++----
>  drivers/gpu/host1x/job.c                  | 10 ++++------
>  drivers/media/platform/coda/coda-bit.c    | 10 +++++-----
>  drivers/video/fbdev/acornfb.c             |  4 ++--
>  drivers/video/fbdev/amba-clcd-versatile.c | 14 ++++++--------
>  drivers/video/fbdev/amba-clcd.c           |  4 ++--
>  drivers/video/fbdev/atmel_lcdfb.c         |  9 +++++----
>  drivers/video/fbdev/ep93xx-fb.c           |  9 +++------
>  drivers/video/fbdev/gbefb.c               |  8 ++++----
>  drivers/video/fbdev/imxfb.c               | 12 ++++++------
>  drivers/video/fbdev/mx3fb.c               |  9 ++++-----
>  drivers/video/fbdev/nuc900fb.c            |  8 ++++----
>  drivers/video/fbdev/omap/lcdc.c           | 16 ++++++++--------
>  drivers/video/fbdev/pxa168fb.c            |  8 ++++----
>  drivers/video/fbdev/pxafb.c               |  4 ++--
>  drivers/video/fbdev/s3c-fb.c              |  7 +++----
>  drivers/video/fbdev/s3c2410fb.c           |  8 ++++----
>  drivers/video/fbdev/sa1100fb.c            |  8 ++++----
>  include/linux/dma-mapping.h               | 16 ++++++++--------
>  sound/arm/pxa2xx-pcm-lib.c                | 20 ++++++++------------
>  sound/soc/fsl/imx-pcm-fiq.c               | 10 ++++------
>  sound/soc/nuc900/nuc900-pcm.c             |  6 ++----
>  sound/soc/omap/omap-pcm.c                 | 12 ++++--------
>  40 files changed, 183 insertions(+), 212 deletions(-)

Which kernel is this against? It has conflicts in 3 files with Linus's latest: 
v4.2-rc8.

Thanks,

	Ingo
