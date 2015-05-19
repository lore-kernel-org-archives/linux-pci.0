Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43709 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbbESRyg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 May 2015 13:54:36 -0400
Date: Tue, 19 May 2015 19:54:32 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: bhelgaas@google.com, mst@redhat.com, plagnioj@jcrosoft.com,
	tomi.valkeinen@ti.com, airlied@linux.ie, daniel.vetter@intel.com,
	linux-fbdev@vger.kernel.org, luto@amacapital.net,
	cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, venkatesh.pallipadi@intel.com,
	Stefan Bader <stefan.bader@canonical.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	konrad.wilk@oracle.com, ville.syrjala@linux.intel.com,
	david.vrabel@citrix.com, jbeulich@suse.com,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	xen-devel@lists.xensource.com
Subject: Re: [PATCH v5 1/5] pci: add pci_iomap_wc() variants
Message-ID: <20150519175432.GI23057@wotan.suse.de>
References: <1430415364-19679-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430415364-19679-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 30, 2015 at 10:36:04AM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>

<-- snip -->
> ---
> 
> This v5 makes the code return NULL for IORESOURCE_IO and fixes the commit
> log to clarify the conclusions reached for MTRR and our review of
> IORESOURCE_PREFETCH.
> 
>  include/asm-generic/pci_iomap.h | 14 ++++++++++
>  lib/pci_iomap.c                 | 61 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)

Hey Bjorn, any feedack on this series? Thanks.

  Luis
