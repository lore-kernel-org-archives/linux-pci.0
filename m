Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:35511 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbaAaMAT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2014 07:00:19 -0500
Received: by mail-qc0-f170.google.com with SMTP id e9so6894843qcy.15
        for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2014 04:00:18 -0800 (PST)
Date: Fri, 31 Jan 2014 07:00:15 -0500
From: Tejun Heo <tj@kernel.org>
To: Peter Chang <dpf@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PATCH: platforms: avoid queuing work if possible
Message-ID: <20140131120015.GE26148@htj.dyndns.org>
References: <CAF2xp_HgT+2zmxHTYpxRFiK-pfQKQJhJ74SJhQVER4s2ZZX0PQ@mail.gmail.com>
 <20140131115340.GD26148@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140131115340.GD26148@htj.dyndns.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 31, 2014 at 06:53:40AM -0500, Tejun Heo wrote:
> The patch description doesn't describe the reasons for the change at
> all.  What issues have you encountered?  What are you trying to
> achieve?

Okay, is it that on NUMA configurations the probing ends up being
bounced through work_on_cpu(), so tracking whether "async" was used
doesn't work making module probing finish before async probing is
complete?  If that's the case, wouldn't a more generic workaround be
handling that in work_on_cpu()?  You can change work_for_cpu_fn() to
clear ASYNC_USED before invoking the function and transfer the bit to
struct work_for_cpu so that work_on_cpu() can again transfer it to the
calling task.

Thanks.

-- 
tejun
