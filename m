Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46238 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752616AbdLHC5f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Dec 2017 21:57:35 -0500
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
Subject: [PATCH 7/9] workqueue: remove unneeded kallsyms include
Date: Fri,  8 Dec 2017 11:56:14 +0900
Message-Id: <20171208025616.16267-8-sergey.senozhatsky@gmail.com>
In-Reply-To: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
References: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The filw was converted from print_symbol() to %pf some time
ago (044c782ce3a901fb "workqueue: fix checkpatch issues").
kallsyms does not seem to be needed anymore.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f4ff9fa5586a..acf485eada1b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -38,7 +38,6 @@
 #include <linux/hardirq.h>
 #include <linux/mempolicy.h>
 #include <linux/freezer.h>
-#include <linux/kallsyms.h>
 #include <linux/debug_locks.h>
 #include <linux/lockdep.h>
 #include <linux/idr.h>
-- 
2.15.1
