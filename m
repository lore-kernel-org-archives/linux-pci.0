Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36486 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbdLHC5x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Dec 2017 21:57:53 -0500
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
Subject: [PATCH 9/9] genirq: remove unneeded kallsyms include
Date: Fri,  8 Dec 2017 11:56:16 +0900
Message-Id: <20171208025616.16267-10-sergey.senozhatsky@gmail.com>
In-Reply-To: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
References: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The file was converted from print_symbol() to %pf some time ago
(ef26f20cd117eb3c18 "genirq: Print threaded handler in spurious
debug output"). kallsyms does not seem to be needed anymore.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/spurious.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index ef2a47e0eab6..6cdecc6f4c53 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -10,7 +10,6 @@
 #include <linux/jiffies.h>
 #include <linux/irq.h>
 #include <linux/module.h>
-#include <linux/kallsyms.h>
 #include <linux/interrupt.h>
 #include <linux/moduleparam.h>
 #include <linux/timer.h>
-- 
2.15.1
