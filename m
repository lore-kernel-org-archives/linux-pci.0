Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fengguang Wu <fengguang.wu@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH 5/9] pnp: remove unneeded kallsyms include
Date: Fri,  8 Dec 2017 11:56:12 +0900
Message-Id: <20171208025616.16267-6-sergey.senozhatsky@gmail.com>
In-Reply-To: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
References: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The file was converted from print_fn_descriptor_symbol()
to %pF some time ago (2e532d68a2b3e2aa {pci,pnp} quirks.c:
don't use deprecated print_fn_descriptor_symbol()). kallsyms
does not seem to be needed anymore.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pnp/quirks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
index f054cdddfef8..803666ae3635 100644
--- a/drivers/pnp/quirks.c
+++ b/drivers/pnp/quirks.c
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/pnp.h>
 #include <linux/io.h>
-#include <linux/kallsyms.h>
 #include "base.h"
 
 static void quirk_awe32_add_ports(struct pnp_dev *dev,
-- 
2.15.1
