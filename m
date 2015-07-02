Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39123 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbbGBW2E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Jul 2015 18:28:04 -0400
Message-ID: <1435875987.1475.73.camel@kernel.crashing.org>
Subject: Re: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
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
	Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Date: Fri, 03 Jul 2015 08:26:27 +1000
In-Reply-To: <20150702184904.GA7021@wotan.suse.de>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
	 <1435189081.3790.24.camel@kernel.crashing.org>
	 <4985EFDD773FCB459EF7915D2A3621ADC02F10@nice.asicdesigners.com>
	 <6806026.xb91q6Ad7G@wuerfel>
	 <4985EFDD773FCB459EF7915D2A3621ADC031F8@nice.asicdesigners.com>
	 <1435284123.3822.24.camel@kernel.crashing.org>
	 <4985EFDD773FCB459EF7915D2A3621ADC03621@nice.asicdesigners.com>
	 <1435356048.26815.9.camel@kernel.crashing.org>
	 <20150702184904.GA7021@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-07-02 at 20:49 +0200, Luis R. Rodriguez wrote:
> > The question then is what is "the right thing". In the powerpc case,
> > we'll have a non-garded mapping, which means we also get no ordering
> > between load and stores.
> 
> I don't follow, you *ordering* between load and stores for WC? We should
> not need that for WC, its why WC is used for only very specific things
> such as framebuffer and PIO (which BTw I still don't quite get all this
> use case for infiniband to be honest, and I will note I do see some
> proprietary hardware extensions like bursts but nothing covering all
> this in a general doc, I think I think it all just has to do that this
> is a hardware hack in reality, which we sell as a feature).

Well, that's the problem, the semantics that we provide to drivers
aren't well defined.

The words "write combine" themselves only specify that writes to subsequent
addresses can be combined into larger transactions. That's in itself is already
quite vague (are their boundaries, limits ? some can depend on bus type, etc...)
though in practice is probably sufficient.

However, overloading a _wc mapping with additional memory model differences
such as loss of ordering between load and stores, etc... is not an obvious
thing to do. I agree it would make *my* life easier if we did it since this
is precisely the semantics provided by a "G=0" mapping on ppc, but we need
to agree and *document* it, otherwise bad things will happen eventually.

We also need to document in that case which barriers can be used to explicitly
enforce the ordering on such a mapping and which barriers can be used to break
write combine (they don't necessarily have to be the same).

We also need to document which accessors will actually provide the write combine
"feature" of a _wc mapping. For example while writel() will do it on Intel, it
will not on ppc and I wouldn't be surprised if a bunch of other archs fall in
the same bucket as ppc (basically anything that has barriers in their writel
implementation to order vs. DMA etc...).

So we might need to explicitly document that writel_relaxed() needs to be used.

Finally what are the precise guaranteed semantics of writeX/readX,
writeX_relaxed/readX_relaxed and __raw_ (everything else) on a _wc mapping, what
do we mandate and document, what do we leave to be implementation dependent ?

Cheers,
Ben.


