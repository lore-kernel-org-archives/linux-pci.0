Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35541 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbbHYXTS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 25 Aug 2015 19:19:18 -0400
Date: Wed, 26 Aug 2015 01:19:13 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>, bp@suse.de,
	bhelgaas@google.com, tomi.valkeinen@ti.com, airlied@linux.ie,
	linux-fbdev@vger.kernel.org, luto@amacapital.net,
	vinod.koul@intel.com, dan.j.williams@intel.com, toshi.kani@hp.com,
	benh@kernel.crashing.org, mst@redhat.com, daniel.vetter@ffwll.ch,
	konrad.wilk@oracle.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xen-devel@lists.xensource.com
Subject: Re: [PATCH v4 10/11] dma: rename dma_*_writecombine() to dma_*_wc()
Message-ID: <20150825231912.GW8051@wotan.suse.de>
References: <1440443613-13696-1-git-send-email-mcgrof@do-not-panic.com>
 <1440443613-13696-11-git-send-email-mcgrof@do-not-panic.com>
 <20150825075318.GA2735@gmail.com>
 <20150825154837.GL8051@wotan.suse.de>
 <20150825134358.990073a55012c60a638b3144@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150825134358.990073a55012c60a638b3144@linux-foundation.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 25, 2015 at 01:43:58PM -0700, Andrew Morton wrote:
> On Tue, 25 Aug 2015 17:48:37 +0200 "Luis R. Rodriguez" <mcgrof@suse.com> wrote:
> 
> > On Tue, Aug 25, 2015 at 09:53:18AM +0200, Ingo Molnar wrote:
> > > Which kernel is this against? It has conflicts in 3 files with Linus's latest: 
> > > v4.2-rc8.
> > 
> > Sorry I based it on linux-next, will respin the rename patch onto tip/auto-latest
> > 
> 
> Doing that will make the patch kinda useless, because then the patch
> will trash more mature work which is pending in linux-next, one week
> before the merge window opens.
> 
> A better plan would be to base the patches on linux-next then wait for
> 4.3-rc1.

There's a catch-22 issue here either way, for instance this rename
patch has been being baked for probably 2 releases already but the
difficulty has been trying to find the appropriate time to merge it
without conflict.

If you do it in the beginning of the merge window, you have to ask
yourself in what tree it will be done. Since subsystems are topic
specific that means that subsystem will end up having a conflict
at the end of the merge window.

If you do it at the end you run into the issue you describe.

So unless I'm missing something, perhaps metrics to argue one way is better
than another, it seems today this is up up to a subsystem's maintainer's
preference?

There are more subtle issues with this though, I've identified similar problems
before and proposed one solution to it could be a linux-oven [0], in that
thread I describe other issues and why I think a linux-oven might help.

Perhaps the biggest change that comes to mind that could have caused
tons of collateral was the UAPI change David Howells did years ago,
when did that go in, at the end of early? In retrospect what would have
helped?

Anyway, both version of the patch are now available, up to you guys :)

[0] http://lkml.kernel.org/r/20150619231255.GC7487@garbanzo.do-not-panic.com

  Luis
