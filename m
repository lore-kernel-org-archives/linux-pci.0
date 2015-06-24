Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50048 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbbFXXkA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Jun 2015 19:40:00 -0400
Message-ID: <1435189081.3790.24.camel@kernel.crashing.org>
Subject: Re: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
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
	Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
	<ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Date: Thu, 25 Jun 2015 09:38:01 +1000
In-Reply-To: <CAB=NE6X0ySW=1udE3LCbo_eCjMfdrOMrceGsPvBZbDW+N-pLTw@mail.gmail.com>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
	 <1434751712-24333-6-git-send-email-mcgrof@do-not-panic.com>
	 <1435099343.3996.13.camel@kernel.crashing.org>
	 <20150624163821.GF11147@wotan.suse.de>
	 <1435183509.3790.14.camel@kernel.crashing.org>
	 <CAB=NE6X0ySW=1udE3LCbo_eCjMfdrOMrceGsPvBZbDW+N-pLTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-06-24 at 15:29 -0700, Luis R. Rodriguez wrote:

> Nope but at least what made me squint at this being a possible
> "feature" was that in practice when reviewing all of the kernels
> pending device drivers using MTRR (potential write-combine candidates)
> I encountered a slew of them which had the architectural unfortunate
> practice of combining PCI bars for MMIO and their respective
> write-combined desirable area (framebuffer for video, PIO buffers for
> infiniband, etc). Now, to me that read more as a practice for old
> school devices when such things were likely still being evaluated,
> more modern devices seem to adhere to sticking a full PCI bar with
> write-combining or not. Did you not encounter such mismatch splits on
> powerpc ? Was such possibility addressed?

Yes, I remember we dealt with some networking (or maybe IB) stuff back
in the day. We dealt with it by using a WC mapping and explicit barriers
to prevent combine when not wanted.

It is to be noted that on powerpc at least, writel() and co will never
combine due to the memory barriers in them. Only "normal" stores (or
__raw_writel) will.

On Intel things I different I assume...

The problem I see is that architectures can provide widely different
mechanisms and semantics in those areas and it's hard to define a
generic driver interface.

> If what you are implying here is applicable to the x86 world I'm all
> for enabling this as we'd have less code to maintain but I'll note
> that getting a clarification alone on that prefetchable !=
> write-combining was in and of itself hard, I'd be surprised if we
> could get full architectural buy-in to this as an immediate automatic
> feature.

I'm happy not to make it automatic for kernel space. As for user
mappings, maybe the right thing to do is to let us do what we do by
default with a quirk that can set a flag in pci_dev to disable that
behaviour (maybe on a per BAR basis ?). I think the common case is
that WC works.

>  Because of this and because PAT did have some errata as well,
> I would not be surprised if some PCI bridges / devices would end up
> finding corner cases, as such if we can really do what you're saying
> and unless we can get some super sane certainty over it across the
> board, I'd be inclined to leave such things as a part of a new API.
> Maybe have some folks test using the new API for all calls and after
> some sanity of testing / releases consider a full switch.
> 
> That is, unless of course you're sure all this is sane and would wager
> all-in on it from the get-go.

Cheers,
Ben.


