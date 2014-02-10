Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:50761 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbaBJWmD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2014 17:42:03 -0500
Received: by mail-qa0-f46.google.com with SMTP id ii20so10394165qab.19
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2014 14:42:02 -0800 (PST)
Date: Mon, 10 Feb 2014 17:41:58 -0500
From: Tejun Heo <tj@kernel.org>
To: Peter Chang <dpf@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PATCH: platforms: avoid queuing work if possible
Message-ID: <20140210224158.GF25350@mtj.dyndns.org>
References: <CAF2xp_HgT+2zmxHTYpxRFiK-pfQKQJhJ74SJhQVER4s2ZZX0PQ@mail.gmail.com>
 <20140131115340.GD26148@htj.dyndns.org>
 <CAF2xp_F_WeMOhffLv+tA2O8L6+8Vn=VZtNh3S4WXmEAMEQC-jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAF2xp_F_WeMOhffLv+tA2O8L6+8Vn=VZtNh3S4WXmEAMEQC-jw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, Peter.

On Tue, Feb 04, 2014 at 08:13:58PM -0800, Peter Chang wrote:
> the problem is that our current user-space environment expects block
> devices to be in /sys/block after the module load completes. if the
> cross cpu worker task is marked w/ ASYNC_USED (rather than the module
> loading task), module loading completes and the async tasks are
> 'racing' w/ user space.
>
> i fixed up the patch to just do the ASYNC_USED copying in the worker
> function (since there was some bogus-ness in the original w/
> get_cpu()). does this patch make more sense?

Heh, this is almost inherently nasty.  The whole thing is a nasty hack
after all. :( Would it be possible to make work_on_cpu() do the
copying instead?  That might be a bit cleaner and I think it could be
better to keep the work around in async / workqueue side rather than
specific drivers.

Thanks.

-- 
tejun
