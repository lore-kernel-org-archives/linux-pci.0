Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39481 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753699AbdLHOCX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Dec 2017 09:02:23 -0500
MIME-Version: 1.0
In-Reply-To: <20171208025616.16267-6-sergey.senozhatsky@gmail.com>
References: <20171208025616.16267-1-sergey.senozhatsky@gmail.com> <20171208025616.16267-6-sergey.senozhatsky@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 Dec 2017 15:02:22 +0100
Message-ID: <CAJZ5v0hQ+QyJZ_bw9AGaSByvckpK5MeU=jkuy-MYg4Qdzoxrrw@mail.gmail.com>
Subject: Re: [PATCH 5/9] pnp: remove unneeded kallsyms include
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
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 8, 2017 at 3:56 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> The file was converted from print_fn_descriptor_symbol()
> to %pF some time ago (2e532d68a2b3e2aa {pci,pnp} quirks.c:
> don't use deprecated print_fn_descriptor_symbol()). kallsyms
> does not seem to be needed anymore.
>
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pnp/quirks.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
> index f054cdddfef8..803666ae3635 100644
> --- a/drivers/pnp/quirks.c
> +++ b/drivers/pnp/quirks.c
> @@ -21,7 +21,6 @@
>  #include <linux/slab.h>
>  #include <linux/pnp.h>
>  #include <linux/io.h>
> -#include <linux/kallsyms.h>
>  #include "base.h"
>
>  static void quirk_awe32_add_ports(struct pnp_dev *dev,
> --

Do you want me to apply this or do you want to route it differently?
