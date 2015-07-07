Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50880 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757011AbbGGQPM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jul 2015 12:15:12 -0400
Date: Tue, 7 Jul 2015 18:15:09 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, bp@suse.de,
	mingo@kernel.org, arnd@arndb.de, bhelgaas@google.com,
	luto@amacapital.net, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ti.com, mst@redhat.com, toshi.kani@hp.com,
	linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com
Subject: Re: [PATCH v8 0/9] pci: add pci_iomap_wc() and pci_ioremap_wc_bar()
Message-ID: <20150707161509.GS7021@wotan.suse.de>
References: <1435195342-26879-1-git-send-email-mcgrof@do-not-panic.com>
 <1435284726.3822.28.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435284726.3822.28.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 26, 2015 at 12:12:06PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2015-06-24 at 18:22 -0700, Luis R. Rodriguez wrote:
> > Although I had test compiled this before just to be safe I went ahead and
> > successfully test-compiled this set with allmodconfig, specially since I've now
> > removed the exports for the devres routines.  Please let me know if these might
> > be able to go through you or if there are any questions. I will note the recent
> > discussion with Benjamin over the v7 series concluded that the ideas we both
> > were alluding to, on automating instead the WC effects for devices seems a bit
> > too idealistic for PCI / PCIE for now, but perhaps we should at least consider
> > this in the future for userspace mmap() calls [4].
> 
> So I've been trying to figure out how to make this practically work for us (powerpc).
> 
> writel() will never write combine for us, it uses too heavy barriers.
> 
> writel_relaxed() today is identical to writel() but we can change it.
> 
> The problem is that switching to G=0 mappings (which is what provides us with write
> combining) also architecturally enables prefetch and speculative loads... and again
> architecturally (the implementations may differ), kills the effect of the lightweight
> io barrier eieio which we would have to use in readl_relaxed() and writel_relaxed()
> to provide their normal semantics.
> 
> So it boils down to: Can we modify the documentation of readl_relaxed() and writel_relaxed()
> to define them as being even further relaxed when using a "wc" mapping ?
>
> Otherwise, the only way out I see for us on powerpc is to bias massively writel_relaxed()
> against real_relaxed() by putting heavy barriers around the load in the latter so we can
> keep them completely out of the former and still enable wc.

Depends if you semantically then also are implicating its use for the ioremap_wc()
area and if we've ensured we've visited all other possibilities to avoid this. Instead
of replying here though it seems we have a large general ioremap() semantic discussion
ongoing on another thread which is far ahead of this one and more generalized. Mind
following up there, seems the party is there:

http://lkml.kernel.org/r/20150707160703.GR7021@wotan.suse.de

 Luis
