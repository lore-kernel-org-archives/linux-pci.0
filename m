Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33766 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbdLHC45 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Dec 2017 21:56:57 -0500
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
Subject: [PATCH 3/9] power: remove unneeded kallsyms include
Date: Fri,  8 Dec 2017 11:56:10 +0900
Message-Id: <20171208025616.16267-4-sergey.senozhatsky@gmail.com>
In-Reply-To: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
References: <20171208025616.16267-1-sergey.senozhatsky@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The file was converted from print_fn_descriptor_symbol()
to %pF some time ago (c80cfb0406c01bb "vsprintf: use new
vsprintf symbolic function pointer format"). kallsyms does
not seem to be needed anymore.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
---
 drivers/base/power/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 5bc2cf1f812c..e2539d8423f7 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -18,7 +18,6 @@
  */
 
 #include <linux/device.h>
-#include <linux/kallsyms.h>
 #include <linux/export.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
-- 
2.15.1
