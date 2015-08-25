Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 25 Aug 2015 13:43:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
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
Message-Id: <20150825134358.990073a55012c60a638b3144@linux-foundation.org>
In-Reply-To: <20150825154837.GL8051@wotan.suse.de>
References: <1440443613-13696-1-git-send-email-mcgrof@do-not-panic.com>
	<1440443613-13696-11-git-send-email-mcgrof@do-not-panic.com>
	<20150825075318.GA2735@gmail.com>
	<20150825154837.GL8051@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 25 Aug 2015 17:48:37 +0200 "Luis R. Rodriguez" <mcgrof@suse.com> wrote:

> On Tue, Aug 25, 2015 at 09:53:18AM +0200, Ingo Molnar wrote:
> > Which kernel is this against? It has conflicts in 3 files with Linus's latest: 
> > v4.2-rc8.
> 
> Sorry I based it on linux-next, will respin the rename patch onto tip/auto-latest
> 

Doing that will make the patch kinda useless, because then the patch
will trash more mature work which is pending in linux-next, one week
before the merge window opens.

A better plan would be to base the patches on linux-next then wait for
4.3-rc1.

