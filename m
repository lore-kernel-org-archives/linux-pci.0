Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33811 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbbD3Vqn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2015 17:46:43 -0400
Received: by iedfl3 with SMTP id fl3so87924223ied.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2015 14:46:42 -0700 (PDT)
Date: Thu, 30 Apr 2015 16:46:38 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, mst@redhat.com,
	plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, airlied@linux.ie,
	daniel.vetter@intel.com, linux-fbdev@vger.kernel.org,
	luto@amacapital.net, cocci@systeme.lip6.fr,
	linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
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
	xen-devel@lists.xensource.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/5] lib: devres: add pcim_iomap_wc() variants
Message-ID: <20150430214638.GE7888@google.com>
References: <1430343372-687-1-git-send-email-mcgrof@do-not-panic.com>
 <1430343372-687-3-git-send-email-mcgrof@do-not-panic.com>
 <20150430162647.GD7888@google.com>
 <20150430172723.GU5622@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150430172723.GU5622@wotan.suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 30, 2015 at 07:27:23PM +0200, Luis R. Rodriguez wrote:
> On Thu, Apr 30, 2015 at 11:26:47AM -0500, Bjorn Helgaas wrote:

> > I don't see users of either pcim_iomap_wc() or pcim_iomap_wc_regions() so
> > far.  Did I miss them, or do you just expect them in the near future?
> 
> The later, and also I hate seeing folks later add code under EXPORT_SYMBOL()
> rather than EXPORT_SYMBOL_GPL() so I figure I'd rather do it first. It happened
> recently in my v1 series, someone beat me to a write-combining export symbol
> and changed it to EXPORT_SYMBOL(). Feel free to drop this though but I hope
> no one out there then tries to just add an EXPORT_SYMBOL() later for this...

Why do you want them to be EXPORT_SYMBOL_GPL?  I would expect them to be
exported the same way pcim_iomap(), pcim_iomap_regions(), and ioremap_wc()
are exported, i.e., with EXPORT_SYMBOL.

Per Documentation/DocBook/kernel-hacking.tmpl, EXPORT_SYMBOL_GPL "implies
that the function is considered an internal implementation issue, and not
really an interface."  I don't think these are internal implementation
issues.

Bjorn
