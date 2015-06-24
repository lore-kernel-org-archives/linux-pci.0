Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1435183509.3790.14.camel@kernel.crashing.org>
Subject: Re: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Juergen Gross <jgross@suse.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>, arnd@arndb.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xensource.com, linux-fbdev@vger.kernel.org,
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
	konrad.wilk@oracle.com, ville.syrjala@linux.intel.com,
	david.vrabel@citrix.com, jbeulich@suse.com,
	Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Date: Thu, 25 Jun 2015 08:05:09 +1000
In-Reply-To: <20150624163821.GF11147@wotan.suse.de>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
	 <1434751712-24333-6-git-send-email-mcgrof@do-not-panic.com>
	 <1435099343.3996.13.camel@kernel.crashing.org>
	 <20150624163821.GF11147@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-06-24 at 18:38 +0200, Luis R. Rodriguez wrote:
> On Wed, Jun 24, 2015 at 08:42:23AM +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2015-06-19 at 15:08 -0700, Luis R. Rodriguez wrote:
> > > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > > 
> > > PCI BARs tell us whether prefetching is safe, but they don't say anything
> > > about write combining (WC).  WC changes ordering rules and allows writes to
> > > be collapsed, so it's not safe in general to use it on a prefetchable
> > > region.
> > 
> > Well, the PCIe spec at least specifies that a prefetchable BAR also
> > tolerates write merging... 
> 
> How can that be determined and can that be used as a full bullet proof hint
> to enable wc ? And are you sure? :) 

Well, I"m sure the spec says that ;-) But it could be new to PCIe, I
haven't checked legacy PCI.

> Reason all this was stated was to be
> apologetic over why we can't automate this behind the scenes. Otherwise
> we could amend what you stated into the commit log to elaborate on our
> technical apology. Let me know!

At least on powerpc, for mmap of resource to userspace, we take off the
garded bit in the PTE for prefetchable BARs. This has the effect
architecturally of enabling both prefetch and write combine (ie. side
effect) though afaik, the implementations probably don't actually
prefetch. We've done that for years.

In fact we don't have a way to split the notions, it's either G or no G,
which carries both meanings.

Do you have example/case of a device having problems ?

Cheers,
Ben.


