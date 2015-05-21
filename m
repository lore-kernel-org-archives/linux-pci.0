Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34103 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519AbbEUWd1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2015 18:33:27 -0400
Received: by ieczm2 with SMTP id zm2so19267462iec.1
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2015 15:33:26 -0700 (PDT)
Date: Thu, 21 May 2015 17:33:21 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: tomi.valkeinen@ti.com, airlied@linux.ie,
	linux-fbdev@vger.kernel.org, luto@amacapital.net,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xen-devel@lists.xensource.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	venkatesh.pallipadi@intel.com,
	Stefan Bader <stefan.bader@canonical.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	konrad.wilk@oracle.com, ville.syrjala@linux.intel.com,
	david.vrabel@citrix.com, jbeulich@suse.com,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [PATCH v6 1/4] pci: add pci_iomap_wc() variants
Message-ID: <20150521223321.GG32152@google.com>
References: <1432163293-20965-1-git-send-email-mcgrof@do-not-panic.com>
 <1432163293-20965-2-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432163293-20965-2-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 20, 2015 at 04:08:10PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> This allows drivers to take advantage of write-combining
> when possible. The PCI specification does not allow for us
> to automatically identify a memory region which needs
> write-combining so drivers have to identify these areas
> on their own. There is IORESOURCE_PREFETCH but as clarified
> by Michael and confirmed later by Bjorn, PCI prefetch bit
> merely means bridges can combine writes and prefetch reads.
> Prefetch does not affect ordering rules and does not allow
> writes to be collapsed [0]. WC is stronger, it allows collapsing
> and changes ordering rules. WC can also hurt latency as small
> writes are buffered. Because of all this drivers needs to
> know what they are doing, we can't set a write-combining
> preference flag in the pci core automatically for drivers.
> 
> Lastly although there is also arch_phys_wc_add() this makes
> use of architecture specific write-combining *hacks* and
> the only one currently defined and used is MTRR for x86.
> MTRRs are legacy, limited in number, have restrictive size
> constraints, and are known to interact pooly with the BIOS.
> MTRRs should only really be considered on old video framebuffer
> drivers. If we made ioremap_wc() and similar calls start
> automatically adding MTRRs, then performance will vary wildly
> with the order of driver loading because we'll run out of MTRRs
> part-way through bootup.
> 
> There are a few motivations for phasing out of MTRR and
> helping driver change over to use write-combining with PAT:
> 
> a) Take advantage of PAT when available
> 
> b) Help bury MTRR code away, MTRR is architecture specific and on
>    x86 its replaced by PAT
> 
> c) Help with the goal of eventually using _PAGE_CACHE_UC over
>    _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (see commit
>    de33c442e titled "x86 PAT: fix performance drop for glx,
>    use UC minus for ioremap(), ioremap_nocache() and
>    pci_mmap_page_range()")
> 
> [0] https://lkml.org/lkml/2015/4/21/714

I tentatively put this (and the rest of the series) on a pci/resource
branch.  I'm hoping you'll propose some clarification about
EXPORT_SYMBOL_GPL().

In the meantime, I tried to make the changelog a bit more concise, as
below.  Let me know if I omitted something essential.  We still have URLs
for the discussion for the fine points.

commit 75387ae87b7aebc2a5b447f4d1b8b17a23c15b08
Author: Luis R. Rodriguez <mcgrof@suse.com>
Date:   Wed May 20 16:08:10 2015 -0700

    PCI: Add pci_iomap_wc() variants
    
    PCI BARs tell us whether prefetching is safe, but they don't say anything
    about write combining (WC).  WC changes ordering rules and allows writes to
    be collapsed, so it's not safe in general to use it on a prefetchable
    region.
    
    Add pci_iomap_wc() and pci_iomap_wc_range() so drivers can take advantage
    of write combining when they know it's safe.
    
    On architectures that don't fully support WC, e.g., x86 without PAT,
    drivers for legacy framebuffers may get some of the benefit by using
    arch_phys_wc_add() in addition to pci_iomap_wc().  But arch_phys_wc_add()
    is unreliable and should be avoided in general.  On x86, it uses MTRRs,
    which are limited in number and size, so the results will vary based on
    driver loading order.
    
    The goals of adding pci_iomap_wc() are to:
    
      - Give drivers an architecture-independent way to use WC so they can stop
        using interfaces like mtrr_add() (on x86, pci_iomap_wc() uses PAT when
        available)
    
      - Move toward using _PAGE_CACHE_MODE_UC, not _PAGE_CACHE_MODE_UC_MINUS,
        on x86 on ioremap_nocache() (see de33c442ed2a ("x86 PAT: fix
        performance drop for glx, use UC minus for ioremap(), ioremap_nocache()
        and pci_mmap_page_range()")
    
    [bhelgaas: changelog]
    Link: http://lkml.kernel.org/r/1426893517-2511-6-git-send-email-mcgrof@do-not-panic.com
    Original-posting: http://lkml.kernel.org/r/1432163293-20965-1-git-send-email-mcgrof@do-not-panic.com
    Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
