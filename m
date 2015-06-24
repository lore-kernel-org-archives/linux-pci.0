Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49726 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885AbbFXQi2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Jun 2015 12:38:28 -0400
Date: Wed, 24 Jun 2015 18:38:22 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Juergen Gross <jgross@suse.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, arnd@arndb.de,
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
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	konrad.wilk@oracle.com, ville.syrjala@linux.intel.com,
	david.vrabel@citrix.com, jbeulich@suse.com,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
Message-ID: <20150624163821.GF11147@wotan.suse.de>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
 <1434751712-24333-6-git-send-email-mcgrof@do-not-panic.com>
 <1435099343.3996.13.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435099343.3996.13.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 24, 2015 at 08:42:23AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2015-06-19 at 15:08 -0700, Luis R. Rodriguez wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > 
> > PCI BARs tell us whether prefetching is safe, but they don't say anything
> > about write combining (WC).  WC changes ordering rules and allows writes to
> > be collapsed, so it's not safe in general to use it on a prefetchable
> > region.
> 
> Well, the PCIe spec at least specifies that a prefetchable BAR also
> tolerates write merging... 

How can that be determined and can that be used as a full bullet proof hint
to enable wc ? And are you sure? :) Reason all this was stated was to be
apologetic over why we can't automate this behind the scenes. Otherwise
we could amend what you stated into the commit log to elaborate on our
technical apology. Let me know!

  Luis
