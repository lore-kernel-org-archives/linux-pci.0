Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329FDC04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 21:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A2A2084E
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 21:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A2A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeLJVuK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:50:10 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:37385 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJVuK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Dec 2018 16:50:10 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mg6i8-1h63FD1cP0-00hb38; Mon, 10 Dec 2018 22:49:57 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: ibmphp_hpc: turn semaphores into completions or mutexes
Date:   Mon, 10 Dec 2018 22:49:10 +0100
Message-Id: <20181210214955.1826522-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qhve+nZpkFnqRZRfGZVu9wzsBEgdK1F2PWrbJbyJ3XpojC+cco0
 V80XYv4X5dfRUpzMMckq+FB/pPHzOGzsnBVtE2tzwVZCPysus5SIHvqbVe1vW1b23afkheR
 POlXgF87a9EjHrzd3BzNITPKQQgjf/FzTyvyiZtw8TSMTdz07aTa4TjWjf2ApgdJAgPf7k5
 evMPrA2/j7aULWqc9GMLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:edl0Oj4NHg0=:OgJmciwDIzp20J2h6R+Mnc
 PYXPnRVEISUN1oF3Kh7JbpYeDxC8i2AjPmTQL2MwCJ8wNdsvChC/8ER97pYqnxJWZQMlnHato
 YT0nNREFpzAtl4OmW+ok4T6g0cAciZG2tHxVbuk+QqC1XiIh25Bfcw0dyOjg5+KmlZIawN7Mq
 jCo0h/qFpXMeLzrqQCpGc6xbzcgsCfJ796Yf6RO06hfWDdlPTUzJnS3r920HehAM/kXhNYEk/
 Cl5bw+qY+Z1+fIoTySLd2vQ8T3BXwzaucf4skDUOFwY8sJkacQij393VEbncRNNI4OFYA4yxW
 ikroMD/Mw7GSeQAlkadyZA1ezWpFKMlTqdu9lZn58IT6pyX4RfCXFUJcbpxb852bS52HFQ1B9
 DrZwb0wMIPk65nSMEDCA1AlZTrnzZrMkGvN6vUHa5hUSfI7GGFhg6h4+nRM1UMMehSLuL+zHL
 Wos/4RUxEpsr9o5veTOaSp4914F8izmjRQJo59I7F6fB8aFmGR6EvvaQyHXu2/FPsLLn6JiBv
 nKibCaKufexCT5+IHm+o54v/M+cm5uUuAipYLYTRbudCpHrvUUKGryJcrCAgBO0LRbZWGgrT6
 yfkG2yPmSMcbYnLT3ibkiAG73dORPHWwXOxF1/VQlyfbXkemFCoVbj8NfYvEhWvuhFtzrgjo1
 uqZl3cMbnwa6DG5d85NLM/sERCC96gECM+Ir33BV5Mzam1XgTLT0K1khISfcPnzZeBqLD7xkM
 PNPGRyHI7QycP4S+dttNiJJj4Z9xGs6qZy+Z2A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sem_exit variable is conceptually a completion, so it should
be called that.

Similarly, the semOperations semaphore is a simple mutex, and
can be changed into that, respectively.

With both converted, the ibmphp_hpc_initvars() function is no longer
used and can be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/hotplug/ibmphp.h      |  1 -
 drivers/pci/hotplug/ibmphp_core.c |  2 --
 drivers/pci/hotplug/ibmphp_hpc.c  | 47 +++++++++----------------------
 3 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp.h b/drivers/pci/hotplug/ibmphp.h
index b89f850c3a4e..e90a4ebf6550 100644
--- a/drivers/pci/hotplug/ibmphp.h
+++ b/drivers/pci/hotplug/ibmphp.h
@@ -378,7 +378,6 @@ int ibmphp_add_pfmem_from_mem(struct resource_node *);
 struct bus_node *ibmphp_find_res_bus(u8);
 void ibmphp_print_test(void);	/* for debugging purposes */
 
-void ibmphp_hpc_initvars(void);
 int ibmphp_hpc_readslot(struct slot *, u8, u8 *);
 int ibmphp_hpc_writeslot(struct slot *, u8);
 void ibmphp_lock_operations(void);
diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 5752b57198e3..e04b17d81e38 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -1312,8 +1312,6 @@ static int __init ibmphp_init(void)
 
 	ibmphp_debug = debug;
 
-	ibmphp_hpc_initvars();
-
 	for (i = 0; i < 16; i++)
 		irqs[i] = 0;
 
diff --git a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
index 752c384cbd4c..508a62a6b5f9 100644
--- a/drivers/pci/hotplug/ibmphp_hpc.c
+++ b/drivers/pci/hotplug/ibmphp_hpc.c
@@ -15,13 +15,13 @@
 
 #include <linux/wait.h>
 #include <linux/time.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/sched.h>
-#include <linux/semaphore.h>
 #include <linux/kthread.h>
 #include "ibmphp.h"
 
@@ -88,10 +88,10 @@ static int to_debug = 0;
 //----------------------------------------------------------------------------
 // global variables
 //----------------------------------------------------------------------------
-static struct mutex sem_hpcaccess;	// lock access to HPC
-static struct semaphore semOperations;	// lock all operations and
+static DEFINE_MUTEX(sem_hpcaccess);	// lock access to HPC
+static DEFINE_MUTEX(operations_mutex);	// lock all operations and
 					// access to data structures
-static struct semaphore sem_exit;	// make sure polling thread goes away
+static DECLARE_COMPLETION(exit_complete); // make sure polling thread goes away
 static struct task_struct *ibmphp_poll_thread;
 //----------------------------------------------------------------------------
 // local function prototypes
@@ -109,23 +109,6 @@ static int hpc_wait_ctlr_notworking(int, struct controller *, void __iomem *, u8
 //----------------------------------------------------------------------------
 
 
-/*----------------------------------------------------------------------
-* Name:    ibmphp_hpc_initvars
-*
-* Action:  initialize semaphores and variables
-*---------------------------------------------------------------------*/
-void __init ibmphp_hpc_initvars(void)
-{
-	debug("%s - Entry\n", __func__);
-
-	mutex_init(&sem_hpcaccess);
-	sema_init(&semOperations, 1);
-	sema_init(&sem_exit, 0);
-	to_debug = 0;
-
-	debug("%s - Exit\n", __func__);
-}
-
 /*----------------------------------------------------------------------
 * Name:    i2c_ctrl_read
 *
@@ -780,7 +763,7 @@ void free_hpc_access(void)
 *---------------------------------------------------------------------*/
 void ibmphp_lock_operations(void)
 {
-	down(&semOperations);
+	mutex_lock(&operations_mutex);
 	to_debug = 1;
 }
 
@@ -790,7 +773,7 @@ void ibmphp_lock_operations(void)
 void ibmphp_unlock_operations(void)
 {
 	debug("%s - Entry\n", __func__);
-	up(&semOperations);
+	mutex_unlock(&operations_mutex);
 	to_debug = 0;
 	debug("%s - Exit\n", __func__);
 }
@@ -816,7 +799,7 @@ static int poll_hpc(void *data)
 
 	while (!kthread_should_stop()) {
 		/* try to get the lock to do some kind of hardware access */
-		down(&semOperations);
+		mutex_lock(&operations_mutex);
 
 		switch (poll_state) {
 		case POLL_LATCH_REGISTER:
@@ -871,13 +854,13 @@ static int poll_hpc(void *data)
 			break;
 		case POLL_SLEEP:
 			/* don't sleep with a lock on the hardware */
-			up(&semOperations);
+			mutex_unlock(&operations_mutex);
 			msleep(POLL_INTERVAL_SEC * 1000);
 
 			if (kthread_should_stop())
 				goto out_sleep;
 
-			down(&semOperations);
+			mutex_lock(&operations_mutex);
 
 			if (poll_count >= POLL_LATCH_CNT) {
 				poll_count = 0;
@@ -887,12 +870,12 @@ static int poll_hpc(void *data)
 			break;
 		}
 		/* give up the hardware semaphore */
-		up(&semOperations);
+		mutex_unlock(&operations_mutex);
 		/* sleep for a short time just for good measure */
 out_sleep:
 		msleep(100);
 	}
-	up(&sem_exit);
+	complete(&exit_complete);
 	debug("%s - Exit\n", __func__);
 	return 0;
 }
@@ -1060,9 +1043,9 @@ void __exit ibmphp_hpc_stop_poll_thread(void)
 	debug("after locking operations\n");
 
 	// wait for poll thread to exit
-	debug("before sem_exit down\n");
-	down(&sem_exit);
-	debug("after sem_exit down\n");
+	debug("before exit_complete down\n");
+	wait_for_completion(&exit_complete);
+	debug("after exit_completion down\n");
 
 	// cleanup
 	debug("before free_hpc_access\n");
@@ -1070,8 +1053,6 @@ void __exit ibmphp_hpc_stop_poll_thread(void)
 	debug("after free_hpc_access\n");
 	ibmphp_unlock_operations();
 	debug("after unlock operations\n");
-	up(&sem_exit);
-	debug("after sem exit up\n");
 
 	debug("%s - Exit\n", __func__);
 }
-- 
2.20.0

