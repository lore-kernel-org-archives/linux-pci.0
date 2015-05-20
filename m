Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 May 2015 15:39:36 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: David Airlie <airlied@redhat.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel.vetter@intel.com>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Antonino Daplas <adaplas@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stefan Bader <stefan.bader@canonical.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?=
	<ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
Subject: Re: [PATCH v5 1/5] pci: add pci_iomap_wc() variants
Message-ID: <20150520203936.GC32152@google.com>
References: <1430415364-19679-1-git-send-email-mcgrof@do-not-panic.com>
 <20150519224452.GT31666@google.com>
 <CAB=NE6VhdEpiTrxW=VqjsJ94pDzcL5XwEgJyJ07D3-14KAdt9g@mail.gmail.com>
 <CAErSpo6B3_vRq-4YTSPg4f927WChZ4MXnZRY7wWCvQgZJ=9eOQ@mail.gmail.com>
 <CAB=NE6U8Fg1TuU9ceVCBHJwR2j+DetDz+L3ZqcJzvSy3_wvPUA@mail.gmail.com>
 <1347189446.1486831.1432078140756.JavaMail.zimbra@redhat.com>
 <CAB=NE6VkAT7JidB4ty0C1tAWTc__-tgTvzHa5OdPazrDzCv0-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB=NE6VkAT7JidB4ty0C1tAWTc__-tgTvzHa5OdPazrDzCv0-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 19, 2015 at 04:45:30PM -0700, Luis R. Rodriguez wrote:
> On Tue, May 19, 2015 at 4:29 PM, David Airlie <airlied@redhat.com> wrote:
> >
> >> On Tue, May 19, 2015 at 4:02 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> > [-cc Venkatesh (bouncing)
> >> >
> >> > On Tue, May 19, 2015 at 5:46 PM, Luis R. Rodriguez
> >> > <mcgrof@do-not-panic.com> wrote:
> >> >> On Tue, May 19, 2015 at 3:44 PM, Bjorn Helgaas <bhelgaas@google.com>
> >> >> wrote:
> >> >>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >> >>
> >> >> Thanks! Who's tree should this go through?
> >> >
> >> > I don't know.  This is the only patch that went to linux-pci, so I
> >> > haven't seen the rest.
> >>
> >> Oh I only rev'd a v5 for 1/5 as that's the only one that had feedback
> >> asking for changes.
> >>
> >> Patch v4 2/5 was for "lib: devres: add pcim_iomap_wc() variants", you
> >> had questions about EXPORT_SYMBOL_GPL() and the fact that this is not
> >> yet used. I replied. This patch can then be ignored but again, I'd
> >> hate for folks to go in and try to add a non EXPORT_SYMBOL_GPL()
> >> symbol of this.

I'm not really a fan of adding code before it's needed.

But even when we have a user and that objection is resolved, I'd
like to have a little more guidance on the difference between
EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL(), e.g., a patch to clarify
what's in Documentation/DocBook/kernel-hacking.tmpl.  I can't
evaluate that issue based on "current trends and reality"; I need
something a little more formal.

If we want to allow non-GPL modules and we want to give them a
consistent kernel interface, even though it might be lacking some
implementation-specific things, I can follow that guideline.

That's how I read the current kernel-hacking.tmpl text
("[EXPORT_SYMBOL_GPL()] implies that the function is considered
an internal implementation issue, and not really an interface"),
and that would lead me to suggest EXPORT_SYMBOL() in this case.

If we don't care about consistency, and EXPORT_SYMBOL_GPL()
should be used at the developer's preference, I can follow that
guideline instead, but it would be easier if it were made more
explicit.

> >> Patches v4 3-5 remain intact, I had addressed it to you, but failed to
> >> Cc linux-pci, I'll go ahead and bounce those now.
> >>
> >> Just today Dave Arlie provided a Reviewed-by to some simple
> >> framebuffer device driver changes. I wonder if these changes should go
> >> through the framebuffer tree provided you already gave the Acked-by
> >> for the PCI parts, or if the PCI parts should go in first and only
> >> later (I guess we'd have to wait) then intake the driver changes that
> >> use the symbol.
> >>
> >> What we decide should likely also apply to the series that adds
> >> pci_ioremap_wc_bar() and makes use of it on drivers.
> >>
> >> Dave, Tomi, any preference?
> >>
> >
> > Maybe send Bjorn a pull request with a tree with the pci changes, and the fb changes reviewed-by me and acked by Tomi.
> >
> > Seems like it could be the simplest path forward.
> 
> Works with me, Bjorn, are you OK with that?

Can you incorporate the acks and just post a complete v6?  I don't like
trying to assemble patches from different versions of a series; it's too
much administrative hassle and too easy for me to screw up.

Bjorn
