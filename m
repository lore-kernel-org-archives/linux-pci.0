Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:57821 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbbFYXEr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jun 2015 19:04:47 -0400
Date: Fri, 26 Jun 2015 02:04:37 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: akpm@linux-foundation.org, bp@suse.de, mingo@elte.hu,
	ville.syrjala@linux.intel.com, luto@amacapital.net,
	tomi.valkeinen@ti.com, mst@redhat.com, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-pci@vger.kernel.org, airlied@redhat.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Rob Clark <robdclark@gmail.com>,
	Mathias Krause <minipli@googlemail.com>,
	Andrzej Hajda <a.hajda@samsung.com>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH v5 1/3] video: fbdev: atyfb: clarify ioremap() base and
 length used
Message-ID: <20150625230437.GA4362@sci.fi>
References: <1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com>
 <1435196060-27350-2-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1435196060-27350-2-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 24, 2015 at 06:34:18PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> This has no functional changes, it just adjusts
> the ioremap() call for the framebuffer to use
> the same values we later use for the framebuffer,
> this will make it easier to review the next change.
> 
> The size of the framebuffer varies but since this is
> for PCI we *know* this defaults to 0x800000.
> atyfb_setup_generic() is *only* used on PCI probe.
> 
> Cc: Toshi Kani <toshi.kani@hp.com>
> Cc: Suresh Siddha <sbsiddha@gmail.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Ville Syrjälä <syrjala@sci.fi>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Mathias Krause <minipli@googlemail.com>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
>  drivers/video/fbdev/aty/atyfb_base.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
> index 16936bb..8025624 100644
> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c
> @@ -3489,7 +3489,9 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
>  
>  	/* Map in frame buffer */
>  	info->fix.smem_start = addr;
> -	info->screen_base = ioremap(addr, 0x800000);
> +	info->fix.smem_len = 0x800000;
> +
> +	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);

The framebuffer size isn't always 8MB. That's the size of the BAR. So
this change isn't really correct. I suppose it doesn't hurt too much
since smem_len gets overwritten later in aty_init().

>  	if (info->screen_base == NULL) {
>  		ret = -ENOMEM;
>  		goto atyfb_setup_generic_fail;
> -- 
> 2.3.2.209.gd67f9d5.dirty
> 

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/
