Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1435284726.3822.28.camel@kernel.crashing.org>
Subject: Re: [PATCH v8 0/9] pci: add pci_iomap_wc() and pci_ioremap_wc_bar()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: bp@suse.de, mingo@kernel.org, arnd@arndb.de, bhelgaas@google.com,
	luto@amacapital.net, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ti.com, mst@redhat.com, toshi.kani@hp.com,
	linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Date: Fri, 26 Jun 2015 12:12:06 +1000
In-Reply-To: <1435195342-26879-1-git-send-email-mcgrof@do-not-panic.com>
References: <1435195342-26879-1-git-send-email-mcgrof@do-not-panic.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-06-24 at 18:22 -0700, Luis R. Rodriguez wrote:
> Although I had test compiled this before just to be safe I went ahead and
> successfully test-compiled this set with allmodconfig, specially since I've now
> removed the exports for the devres routines.  Please let me know if these might
> be able to go through you or if there are any questions. I will note the recent
> discussion with Benjamin over the v7 series concluded that the ideas we both
> were alluding to, on automating instead the WC effects for devices seems a bit
> too idealistic for PCI / PCIE for now, but perhaps we should at least consider
> this in the future for userspace mmap() calls [4].

So I've been trying to figure out how to make this practically work for us (powerpc).

writel() will never write combine for us, it uses too heavy barriers.

writel_relaxed() today is identical to writel() but we can change it.

The problem is that switching to G=0 mappings (which is what provides us with write
combining) also architecturally enables prefetch and speculative loads... and again
architecturally (the implementations may differ), kills the effect of the lightweight
io barrier eieio which we would have to use in readl_relaxed() and writel_relaxed()
to provide their normal semantics.

So it boils down to: Can we modify the documentation of readl_relaxed() and writel_relaxed()
to define them as being even further relaxed when using a "wc" mapping ?

Otherwise, the only way out I see for us on powerpc is to bias massively writel_relaxed()
against real_relaxed() by putting heavy barriers around the load in the latter so we can
keep them completely out of the former and still enable wc.

Ben.

