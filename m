Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47024 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974AbbHYXZm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2015 19:25:42 -0400
Date: Tue, 25 Aug 2015 16:25:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>, bp@suse.de,
	bhelgaas@google.com, tomi.valkeinen@ti.com, airlied@linux.ie,
	linux-fbdev@vger.kernel.org, luto@amacapital.net,
	vinod.koul@intel.com, dan.j.williams@intel.com, toshi.kani@hp.com,
	benh@kernel.crashing.org, mst@redhat.com, daniel.vetter@ffwll.ch,
	konrad.wilk@oracle.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xen-devel@lists.xensource.com
Subject: Re: [PATCH v4 10/11] dma: rename dma_*_writecombine() to dma_*_wc()
Message-Id: <20150825162540.0591c8c8276b1ff279785e49@linux-foundation.org>
In-Reply-To: <20150825231912.GW8051@wotan.suse.de>
References: <1440443613-13696-1-git-send-email-mcgrof@do-not-panic.com>
	<1440443613-13696-11-git-send-email-mcgrof@do-not-panic.com>
	<20150825075318.GA2735@gmail.com>
	<20150825154837.GL8051@wotan.suse.de>
	<20150825134358.990073a55012c60a638b3144@linux-foundation.org>
	<20150825231912.GW8051@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 26 Aug 2015 01:19:13 +0200 "Luis R. Rodriguez" <mcgrof@suse.com> wrote:

> On Tue, Aug 25, 2015 at 01:43:58PM -0700, Andrew Morton wrote:
> > On Tue, 25 Aug 2015 17:48:37 +0200 "Luis R. Rodriguez" <mcgrof@suse.com> wrote:
> > 
> > > On Tue, Aug 25, 2015 at 09:53:18AM +0200, Ingo Molnar wrote:
> > > > Which kernel is this against? It has conflicts in 3 files with Linus's latest: 
> > > > v4.2-rc8.
> > > 
> > > Sorry I based it on linux-next, will respin the rename patch onto tip/auto-latest
> > > 
> > 
> > Doing that will make the patch kinda useless, because then the patch
> > will trash more mature work which is pending in linux-next, one week
> > before the merge window opens.
> > 
> > A better plan would be to base the patches on linux-next then wait for
> > 4.3-rc1.
> 
> There's a catch-22 issue here either way, for instance this rename
> patch has been being baked for probably 2 releases already but the
> difficulty has been trying to find the appropriate time to merge it
> without conflict.
> 
> If you do it in the beginning of the merge window, you have to ask
> yourself in what tree it will be done. Since subsystems are topic
> specific that means that subsystem will end up having a conflict
> at the end of the merge window.

Yes it's a special case.  I think the best way of handling such things
is to get them in to Linus either right at the end of the merge window
or the day after he releases -rc1.  This is when most people's trees
are mostly empty.


