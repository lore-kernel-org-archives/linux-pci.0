Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33188 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbbHZEVl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Aug 2015 00:21:41 -0400
Date: Wed, 26 Aug 2015 06:21:36 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>,
	David Howells <dhowells@redhat.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>, bp@suse.de,
	bhelgaas@google.com, tomi.valkeinen@ti.com, airlied@linux.ie,
	linux-fbdev@vger.kernel.org, luto@amacapital.net,
	vinod.koul@intel.com, dan.j.williams@intel.com, toshi.kani@hp.com,
	benh@kernel.crashing.org, mst@redhat.com, daniel.vetter@ffwll.ch,
	konrad.wilk@oracle.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xen-devel@lists.xensource.com
Subject: Re: [PATCH v4 10/11] dma: rename dma_*_writecombine() to dma_*_wc()
Message-ID: <20150826042136.GA14584@gmail.com>
References: <1440443613-13696-1-git-send-email-mcgrof@do-not-panic.com>
 <1440443613-13696-11-git-send-email-mcgrof@do-not-panic.com>
 <20150825075318.GA2735@gmail.com>
 <20150825154837.GL8051@wotan.suse.de>
 <20150825134358.990073a55012c60a638b3144@linux-foundation.org>
 <20150825231912.GW8051@wotan.suse.de>
 <20150825162540.0591c8c8276b1ff279785e49@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150825162540.0591c8c8276b1ff279785e49@linux-foundation.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Andrew Morton <akpm@linux-foundation.org> wrote:

> > There's a catch-22 issue here either way, for instance this rename patch has 
> > been being baked for probably 2 releases already but the difficulty has been 
> > trying to find the appropriate time to merge it without conflict.
> > 
> > If you do it in the beginning of the merge window, you have to ask yourself in 
> > what tree it will be done. Since subsystems are topic specific that means that 
> > subsystem will end up having a conflict at the end of the merge window.
> 
> Yes it's a special case.  I think the best way of handling such things is to get 
> them in to Linus either right at the end of the merge window or the day after he 
> releases -rc1.  This is when most people's trees are mostly empty.

Yes, that was the plan last time around as well - but the end of the merge window 
is when we have the least maintainer bandwidth as well ...

Anyway, I applied most of the patches (sans the rename), so the rename patch 
should be a lot simpler to execute at the right moment this time around.

Thanks,

	Ingo
