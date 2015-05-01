Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 1 May 2015 02:20:04 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, mst@redhat.com,
	plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, airlied@linux.ie,
	daniel.vetter@intel.com, linux-fbdev@vger.kernel.org,
	luto@amacapital.net, cocci@systeme.lip6.fr,
	linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, venkatesh.pallipadi@intel.com,
	Stefan Bader <stefan.bader@canonical.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	konrad.wilk@oracle.com, ville.syrjala@linux.intel.com,
	david.vrabel@citrix.com, jbeulich@suse.com,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	xen-devel@lists.xensource.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/5] lib: devres: add pcim_iomap_wc() variants
Message-ID: <20150501002004.GA5622@wotan.suse.de>
References: <1430343372-687-1-git-send-email-mcgrof@do-not-panic.com>
 <1430343372-687-3-git-send-email-mcgrof@do-not-panic.com>
 <20150430162647.GD7888@google.com>
 <20150430172723.GU5622@wotan.suse.de>
 <20150430214638.GE7888@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150430214638.GE7888@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 30, 2015 at 04:46:38PM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 30, 2015 at 07:27:23PM +0200, Luis R. Rodriguez wrote:
> > On Thu, Apr 30, 2015 at 11:26:47AM -0500, Bjorn Helgaas wrote:
> 
> > > I don't see users of either pcim_iomap_wc() or pcim_iomap_wc_regions() so
> > > far.  Did I miss them, or do you just expect them in the near future?
> > 
> > The later, and also I hate seeing folks later add code under EXPORT_SYMBOL()
> > rather than EXPORT_SYMBOL_GPL() so I figure I'd rather do it first. It happened
> > recently in my v1 series, someone beat me to a write-combining export symbol
> > and changed it to EXPORT_SYMBOL(). Feel free to drop this though but I hope
> > no one out there then tries to just add an EXPORT_SYMBOL() later for this...
> 
> Why do you want them to be EXPORT_SYMBOL_GPL?  I would expect them to be
> exported the same way pcim_iomap(), pcim_iomap_regions(), and ioremap_wc()
> are exported, i.e., with EXPORT_SYMBOL.
>> 
> Per Documentation/DocBook/kernel-hacking.tmpl, EXPORT_SYMBOL_GPL "implies
> that the function is considered an internal implementation issue, and not
> really an interface."  I don't think these are internal implementation
> issues.

What Documentation/DocBook/kernel-hacking.tmpl states over EXPORT_SYMBOL_GPL()
is old and in no way reflects current trends and reality. For instance, some
folks believe that if some code has EXPORT_SYMBOL() declared that they can use
it on proprietary modules. This is terribly incorrect, quite a few developers
do not in any way stand by this as a "needed" clarification on their code [0].
I'm one of them, but to be even more clear on this I simply *always* use
EXPORT_SYMBOL_GPL() to remove any possible doubt over this on any symbols
that I export. Heck, even tons of driver library code uses EXPORT_SYMBOL_GPL().

[0] https://lkml.org/lkml/2012/4/20/402

  Luis
