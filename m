Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34428 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755429AbbEVAXs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 21 May 2015 20:23:48 -0400
Date: Fri, 22 May 2015 02:23:41 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	tomi.valkeinen@ti.com, airlied@linux.ie,
	linux-fbdev@vger.kernel.org, luto@amacapital.net,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xen-devel@lists.xensource.com, Toshi Kani <toshi.kani@hp.com>,
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
Message-ID: <20150522002341.GM23057@wotan.suse.de>
References: <1432163293-20965-1-git-send-email-mcgrof@do-not-panic.com>
 <1432163293-20965-2-git-send-email-mcgrof@do-not-panic.com>
 <20150521223321.GG32152@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150521223321.GG32152@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 21, 2015 at 05:33:21PM -0500, Bjorn Helgaas wrote:
> 
> I tentatively put this (and the rest of the series) on a pci/resource
> branch.  I'm hoping you'll propose some clarification about
> EXPORT_SYMBOL_GPL().

EXPORT_SYMBOL_GPL() also serves to ensure only GPL modules can
only run that code. So for instance although we have "Dual BSD/GPL"
tags for modules pure "BSD" tags do not exist for module tags and
cannot run EXPORT_SYMBOL_GPL() code [0]. Also there is some folks
who do believe tha at run time all kernel modules are GPL [1] [2].
And to be precise even though the FSF may claim a list of licenses
are GPL-compatible we cannot rely on this list alone for our own
goals and if folks want to use our EXPORT_SYMBOL_GPL()s they must
discuss this on lkml [2].

In the past when I've tried to try to clarify EXPORT_SYMBOL_GPL()
requirements, implications, its been said that its best to leave
some things as-is [3] and let attorneys figure things out. In so
far as to what exactly it is and can be used for requires legal
attorney review, but the question of derivative work certainly
comes up [4]. Now folks companies seem to want to obviously use
and abuse our symbols despite of all the things above, for instance
Red Hat once tried to change an EXPORT_SYMBOL_GPL() to
EXPORT_SYMBOL() [5]. Obviously that didn't go so well, and some
folks went off on a good rant about this [6].

What developers do and accept varies, I'm not going into pointing
out specifics and I do not wnat to do homework for folks who wish
to abuse things further, but by no means should a developer be
nack'd entry to new code if their functionality is not replacing
old one [9]. In this case this is new functionality. Also in terms
of preference:

"nobody has said that symbols exported with plain EXPORT_SYMBOL() can be freely
used by proprietary code; indeed, a number of developers claim that all (or
nearly all) loadable modules are derived products of the kernel regardless of
whether they use GPL-only symbols or not" [7].

And spot on:

"In general, the kernel community has long worked to maintain a vague and scary
ambiguity around the legal status of proprietary modules while being unwilling
to attempt to ban such modules outright." [7].

Now, a few maintainers insist on tons of new symbols to be EXPORT_SYMBOL_GPL()
though proactively [8] [9] and the reasons vary, I just happen to also write my
code to be perfectly clear with my goals and intent and you are the first to
ask me to reconsider this, even if you do make me use EXPORT_SYMBOL() my intent
and goal does not change, as with others. No code I ever write should be used
by proprietary shit, and I hope to convince others of the importance to do this
as well.

> In the meantime, I tried to make the changelog a bit more concise, as
> below.  Let me know if I omitted something essential.  We still have URLs
> for the discussion for the fine points.

Looks good.

[0] https://lkml.org/lkml/2012/4/7/102
[1] https://lkml.org/lkml/2012/4/8/71
[2] https://lkml.org/lkml/2012/4/8/71
[3] https://lkml.org/lkml/2009/6/1/385
[4] https://lkml.org/lkml/2009/6/1/376
[5] https://lkml.org/lkml/2012/4/20/328
[6] https://plus.google.com/+AlanCoxLinux/posts/D2feRNc6R4d
[7] https://lwn.net/Articles/603131/
[8] https://lwn.net/Articles/603139/
[9] https://lkml.org/lkml/2015/2/26/379

  Luis
