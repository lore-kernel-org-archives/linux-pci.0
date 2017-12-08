Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44034 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753107AbdLHKjg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Dec 2017 05:39:36 -0500
Date: Fri, 8 Dec 2017 19:39:31 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] sched/autogroup: move sched.h include
Message-ID: <20171208103931.GG628@jagdpanzerIV>
References: <20171208025616.16267-2-sergey.senozhatsky@gmail.com>
 <20171208082422.5021-1-sergey.senozhatsky@gmail.com>
 <20171208085755.GA3148@linux.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208085755.GA3148@linux.suse>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On (12/08/17 09:57), Petr Mladek wrote:
> On Fri 2017-12-08 17:24:22, Sergey Senozhatsky wrote:
> > Move local "sched.h" include to the bottom. sched.h defines
> > several macros that are getting redefined in ARCH-specific
> > code, for instance, finish_arch_post_lock_switch() and
> > prepare_arch_switch(), so we need ARCH-specific definitions
> > to come in first.
> 
> This patch is needed to fix compilation error [1] caused by a patchset
> that deprecates %pf/%pF printk modifiers[2].
> 
> IMHO, we should make sure that this fix goes into Linus' tree
> before the printk-related patchset. What is the best practice,
> please?

as long as sched pull request goes before printk pull request we
are fine. but I see your point.

> I see two reasonable possibilities. Either sched people could
> push this for-4.15-rcX. Or I could put it into printk.git for-4.16
> in the right order.

agreed.

> What do you think?

either way is fine with me. we can have it in print.git (no objections
from my side) or in sched tree and just make sure that sched pull request
has "bigger priority", or it can go to Linus's tree as a potential fix
(I'd prefer the last option, I think).

	-ss
