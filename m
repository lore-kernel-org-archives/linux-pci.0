Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 9 Jul 2015 19:25:07 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Borislav Petkov <bp@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?=
	<ville.syrjala@linux.intel.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@redhat.com>,
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
Message-ID: <20150709172507.GD7021@wotan.suse.de>
References: <1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com>
 <1435196060-27350-2-git-send-email-mcgrof@do-not-panic.com>
 <20150625230437.GA4362@sci.fi>
 <CAB=NE6V0HGCkpYFghUyyk=+St-494Y8e9PEakF9F7cEB8vpKvA@mail.gmail.com>
 <20150625231103.GB4362@sci.fi>
 <20150626010927.GI3005@wotan.suse.de>
 <20150626073028.GA14776@pd.tnic>
 <CAB=NE6Uac5x4+fr9d7OymaKS9nG=Da3h+qW7Ni0o0XGOSagEdg@mail.gmail.com>
 <CAB=NE6UKnhx0PoJp_wHeZMnXxHLsd8snzu2bOj=VWde=Bo-hVg@mail.gmail.com>
 <20150708083849.GB13710@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150708083849.GB13710@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 08, 2015 at 11:38:49AM +0300, Ville Syrjälä wrote:
> On Tue, Jul 07, 2015 at 05:24:57PM -0700, Luis R. Rodriguez wrote:
> > On Thu, Jul 2, 2015 at 4:23 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> > > On Fri, Jun 26, 2015 at 12:30 AM, Borislav Petkov <bp@suse.de> wrote:
> > >> On Fri, Jun 26, 2015 at 03:09:27AM +0200, Luis R. Rodriguez wrote:
> > >>> Sure, mind this as a follow up patch if its too late?
> > >>
> > >> No need, you can send me an updated one - I'll replace it.
> > >
> > > Will do!
> > 
> > OK the commend I'm adding:
> > 
> > @@ -3489,6 +3489,15 @@ static int atyfb_setup_generic(struct pci_dev
> > *pdev, struct fb_info *info,
> > 
> >         /* Map in frame buffer */
> >         info->fix.smem_start = addr;
> > +
> > +       /*
> > +        * The framebuffer is not always 8 MiB that's just the size of the
> > +        * PCI BAR, this is later corrected for use with write-combining
> > +        * helpers with aty_fudge_framebuffer_len() which will adjust the
> > +        * framebuffer accordingly depending on the device.
> 
> That somehow gives me the impression that aty_fudge_framebuffer_len()
> changes smem_len to match the framebuffer size, which it does
> not.
> 
> Dunno, maybe something like this?
> /*
>  * The framebuffer is not always 8 MiB that's just the size of the
>  * PCI BAR. We temporarily abuse smem_len here to store the size
>  * of the BAR. aty_init() will later correct it to match the actual
>  * framebuffer size.
>  *
>  * On devices that don't have the auxiliary register aperture, the
>  * registers are housed at the top end of the framebuffer PCI BAR.
>  * aty_fudge_framebuffer_len() is used to reduce smem_len to not
>  * overlap with the registers.
>  */

Thanks Ville, I used that. Will send out a v6 series.

 Luis
