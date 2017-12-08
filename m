Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42150 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbdLHLUx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Dec 2017 06:20:53 -0500
Date: Fri, 8 Dec 2017 20:20:48 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 1/9] sched/autogroup: remove unneeded kallsyms include
Message-ID: <20171208112048.GH628@jagdpanzerIV>
References: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
 <20171208025616.16267-2-sergey.senozhatsky@gmail.com>
 <20171208105611.rcoxze4erxkpimad@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208105611.rcoxze4erxkpimad@hirez.programming.kicks-ass.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On (12/08/17 11:56), Peter Zijlstra wrote:
> On Fri, Dec 08, 2017 at 11:56:08AM +0900, Sergey Senozhatsky wrote:
> > Autogroup does not seem to use any of kallsyms functions/defines.
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> 
> Feel free to take this through whatever tree you need this in.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!


Petr, let's pick up sched/autogroup patches then. Thank you.

	-ss
