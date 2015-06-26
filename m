Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53410 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195AbbFZBJd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Jun 2015 21:09:33 -0400
Date: Fri, 26 Jun 2015 03:09:27 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@elte.hu>,
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
Message-ID: <20150626010927.GI3005@wotan.suse.de>
References: <1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com>
 <1435196060-27350-2-git-send-email-mcgrof@do-not-panic.com>
 <20150625230437.GA4362@sci.fi>
 <CAB=NE6V0HGCkpYFghUyyk=+St-494Y8e9PEakF9F7cEB8vpKvA@mail.gmail.com>
 <20150625231103.GB4362@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150625231103.GB4362@sci.fi>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 26, 2015 at 02:11:03AM +0300, Ville Syrjälä wrote:
> On Thu, Jun 25, 2015 at 04:06:45PM -0700, Luis R. Rodriguez wrote:
> > On Thu, Jun 25, 2015 at 4:04 PM, Ville Syrjälä <syrjala@sci.fi> wrote:
> > > it doesn't hurt too much
> > > since smem_len gets overwritten later in aty_init().
> > 
> > That's the idea, we set it with a default as it will be overwritten
> > later anyway.
> 
> Maybe toss in a comment? Otherwise it's a bit dishonest and might give
> someone the impression that all PCI cards really have 8MB of memory.

Sure, mind this as a follow up patch if its too late?

  Luis
