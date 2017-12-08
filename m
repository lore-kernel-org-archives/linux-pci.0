Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbdLHRxt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Dec 2017 12:53:49 -0500
Date: Fri, 8 Dec 2017 11:53:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 4/9] pci: remove unneeded kallsyms include
Message-ID: <20171208175345.GA12367@bhelgaas-glaptop.roam.corp.google.com>
References: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
 <20171208025616.16267-5-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208025616.16267-5-sergey.senozhatsky@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 08, 2017 at 11:56:11AM +0900, Sergey Senozhatsky wrote:
> The file was converted from print_fn_descriptor_symbol()
> to %pF some time ago (c9bbb4abb658da "PCI: use %pF instead
> of print_fn_descriptor_symbol() in quirks.c"). kallsyms does
> not seem to be needed anymore.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/misc for v4.16, thanks for cleaning this up!

I *assume* there's no ordering dependency like the one you mentioned
for sched/printk.  If there is, let me know, and I'll move this to
for-linus to get it in v4.15.

> ---
>  drivers/pci/quirks.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 10684b17d0bd..fd49b976973f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -19,7 +19,6 @@
>  #include <linux/init.h>
>  #include <linux/delay.h>
>  #include <linux/acpi.h>
> -#include <linux/kallsyms.h>
>  #include <linux/dmi.h>
>  #include <linux/pci-aspm.h>
>  #include <linux/ioport.h>
> -- 
> 2.15.1
> 
