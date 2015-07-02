Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60519 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754155AbbGBStK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Jul 2015 14:49:10 -0400
Date: Thu, 2 Jul 2015 20:49:04 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Casey Leedom <leedom@chelsio.com>, Arnd Bergmann <arnd@arndb.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Juergen Gross <jgross@suse.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
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
	"venkatesh.pallipadi@intel.com" <venkatesh.pallipadi@intel.com>,
	Stefan Bader <stefan.bader@canonical.com>,
	"ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
Message-ID: <20150702184904.GA7021@wotan.suse.de>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
 <1435189081.3790.24.camel@kernel.crashing.org>
 <4985EFDD773FCB459EF7915D2A3621ADC02F10@nice.asicdesigners.com>
 <6806026.xb91q6Ad7G@wuerfel>
 <4985EFDD773FCB459EF7915D2A3621ADC031F8@nice.asicdesigners.com>
 <1435284123.3822.24.camel@kernel.crashing.org>
 <4985EFDD773FCB459EF7915D2A3621ADC03621@nice.asicdesigners.com>
 <1435356048.26815.9.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435356048.26815.9.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 27, 2015 at 08:00:48AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2015-06-26 at 16:24 +0000, Casey Leedom wrote:
> >   Thanks for looking into this Ben.  As it stands now, it seems as
> > if Write Combined mappings simply aren't supported and/or all
> > driver writers trying to utilize Write Combined mappings have to
> > "hand roll" their own solutions which really isn't supportable.
> > 
> >   One thing that might be considered is simply to treat the desire
> > to utilize the Write Combining hardware as a separate issue and
> > develop writel_wc(), writeq_wc(), etc.

That seems rather sloppy and cumbersome, its best to just provide the
infrastructure for initial mapping for an area and let the hardware do it for
you. With the current design drivers would just use regular read/write on all
areas and the only thing that will set them apart will be the mapping.  With
what you propose we'd end up having to shift a whole bunch of reads/writes for
just the purpose of adding WC to an area that didn't have wc before. That's
a waste of code and time.

> > Those could be defined
> > as legal only for Write Combined Mappings and would "do the
> > right thing" for each architecture.  

Yuck.

> The question then is what is "the right thing". In the powerpc case,
> we'll have a non-garded mapping, which means we also get no ordering
> between load and stores.

I don't follow, you *ordering* between load and stores for WC? We should
not need that for WC, its why WC is used for only very specific things
such as framebuffer and PIO (which BTw I still don't quite get all this
use case for infiniband to be honest, and I will note I do see some
proprietary hardware extensions like bursts but nothing covering all
this in a general doc, I think I think it all just has to do that this
is a hardware hack in reality, which we sell as a feature).

  Luis
