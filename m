Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 Jun 2015 02:08:03 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Juergen Gross <jgross@suse.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	venkatesh.pallipadi@intel.com,
	Stefan Bader <stefan.bader@canonical.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?=
	<ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
Message-ID: <20150625000803.GH11147@wotan.suse.de>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
 <1434751712-24333-6-git-send-email-mcgrof@do-not-panic.com>
 <1435099343.3996.13.camel@kernel.crashing.org>
 <20150624163821.GF11147@wotan.suse.de>
 <1435183509.3790.14.camel@kernel.crashing.org>
 <CAB=NE6X0ySW=1udE3LCbo_eCjMfdrOMrceGsPvBZbDW+N-pLTw@mail.gmail.com>
 <1435189081.3790.24.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435189081.3790.24.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 25, 2015 at 09:38:01AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2015-06-24 at 15:29 -0700, Luis R. Rodriguez wrote:
> 
> > Nope but at least what made me squint at this being a possible
> > "feature" was that in practice when reviewing all of the kernels
> > pending device drivers using MTRR (potential write-combine candidates)
> > I encountered a slew of them which had the architectural unfortunate
> > practice of combining PCI bars for MMIO and their respective
> > write-combined desirable area (framebuffer for video, PIO buffers for
> > infiniband, etc). Now, to me that read more as a practice for old
> > school devices when such things were likely still being evaluated,
> > more modern devices seem to adhere to sticking a full PCI bar with
> > write-combining or not. Did you not encounter such mismatch splits on
> > powerpc ? Was such possibility addressed?
> 
> Yes, I remember we dealt with some networking (or maybe IB) stuff back
> in the day. We dealt with it by using a WC mapping and explicit barriers
> to prevent combine when not wanted.
> 
> It is to be noted that on powerpc at least, writel() and co will never
> combine due to the memory barriers in them. Only "normal" stores (or
> __raw_writel) will.
> 
> On Intel things I different I assume...

And the people who really know seem to be eaten by volcanoes or not have time.

> The problem I see is that architectures can provide widely different
> mechanisms and semantics in those areas and it's hard to define a
> generic driver interface.

Provided asm generic helpers are defined this should work though. The question
is just if there is enough motivation. Doesn't sound like it or as you note
maybe for userspace there might be. My position is that if it was too late for
PCIE or if this was too ambigious for PCIE perhaps the next generation bus
archicture or ammendments (I have no clue if this would would be possible) will
make this part of future device negotiation clear and fully expected, not a
wonderful side effect.

> > If what you are implying here is applicable to the x86 world I'm all
> > for enabling this as we'd have less code to maintain but I'll note
> > that getting a clarification alone on that prefetchable !=
> > write-combining was in and of itself hard, I'd be surprised if we
> > could get full architectural buy-in to this as an immediate automatic
> > feature.
> 
> I'm happy not to make it automatic for kernel space.

OK thanks I'll proceed with these patches then.

> As for user mappings,

Which APIs were you considering in this regard BTW?

> maybe the right thing to do is to let us do what we do by
> default with a quirk that can set a flag in pci_dev to disable that
> behaviour (maybe on a per BAR basis ?).

That might mean it could restrict userspace WC to require devices
to have WC parts on a full PCI BAR. Although this is restrictive
having reviewed most WC uses in the kernel I'd think this would be
a fair compromise to make, but again, if things are still murky
perhaps best we kiss this idea good bye for now and hope for it
to come in on future buses or ammendments (if that's even possible?).

> I think the common case is that WC works.

If WC does not I will note one hack which migh be worth mentioning -- just for
the record, this was devised as a shortcoming of a device where they failed to
split things properly and that *without* WC performance suffered quite a bit so
they made one full PCI BAR WC and as a work around this:

http://lkml.kernel.org/r/20150416041837.GA5712@hykim-PC

That is for registers that needed it:

write; wmb;

Then if they wanted to wait till the NIC has seen the write, they did:

write; wmb; read;

  Luis
