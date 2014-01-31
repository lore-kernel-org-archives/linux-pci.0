Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:60216 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbaAaLxn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2014 06:53:43 -0500
Received: by mail-qa0-f50.google.com with SMTP id cm18so6179096qab.9
        for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2014 03:53:43 -0800 (PST)
Date: Fri, 31 Jan 2014 06:53:40 -0500
From: Tejun Heo <tj@kernel.org>
To: Peter Chang <dpf@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PATCH: platforms: avoid queuing work if possible
Message-ID: <20140131115340.GD26148@htj.dyndns.org>
References: <CAF2xp_HgT+2zmxHTYpxRFiK-pfQKQJhJ74SJhQVER4s2ZZX0PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAF2xp_HgT+2zmxHTYpxRFiK-pfQKQJhJ74SJhQVER4s2ZZX0PQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, Jan 30, 2014 at 05:24:16PM -0800, Peter Chang wrote:
> 774a1221e862b343388347bac9b318767336b20b tries to avoid an expensive sync
> by marking the current task iff it uses the async_schedule() machinery.

That wasn't an optimization.  It was a workaround for deadlock.

> however, if the part of the driver's probe is called through a worker
> thread the bookeeping fails to mark the correct task as having used the
> async machinery.
> 
> this is a workaround for the common case that we're already running
> on the correct cpu. however, it seems sort of reasonable to not use
> the worker thread if we don't have to.
> 
> Tested:
> - checked on vebmy2 (ibis + satasquatch) which is where the original issue
>   was discovered.
> - checked on fdha347 (ikaria + loggerhead + satasquatch) to show that
>   nothing changed.

The patch description doesn't describe the reasons for the change at
all.  What issues have you encountered?  What are you trying to
achieve?

> Change-Id: Ibe8996cf652735c74a9e06ba9fd03118078395bd
> Google-Bug-Id: 12632867

The above tags don't mean anything upstream.  Please drop them when
posting patches.

Thanks.

-- 
tejun
