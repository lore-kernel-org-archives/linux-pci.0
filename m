Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:54675 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932724AbdKBPMI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2017 11:12:08 -0400
Date: Thu, 2 Nov 2017 16:12:06 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Subject: [PATCH v3] pci/switchtec: Don't use completion's wait queue
Message-ID: <20171102151206.tvfsotckcqgnj3ky@linutronix.de>
References: <20171004095007.19148-1-bigeasy@linutronix.de>
 <dfd717ac-a775-f30c-4d41-2da68e08ff54@deltatee.com>
 <20171005105100.2nf4ih2fgq6dax5g@linutronix.de>
 <0ae3975a-b1b1-fb8b-2f90-ff103da9d178@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0ae3975a-b1b1-fb8b-2f90-ff103da9d178@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The poll callback is using completion's wait_queue_head_t member and
puts it in poll_wait() so the poll() caller gets a wakeup after command
completed. This does not work on RT because we don't have a
wait_queue_head_t in our completion implementation. Nobody in tree does
like that in tree so this is the only driver that breaks.

Instead of using the completion here is waitqueue with a status flag as
suggested by Logan.

I don't have the HW so I have no idea if it works as expected, so please
test it.

Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2…v3: add missing
	  stuser->cmd_done = true;
       spotted by Logan.

 drivers/pci/switch/switchtec.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -306,10 +306,11 @@ struct switchtec_user {
 
 	enum mrpc_state state;
 
-	struct completion comp;
+	wait_queue_head_t cmd_comp;
 	struct kref kref;
 	struct list_head list;
 
+	bool cmd_done;
 	u32 cmd;
 	u32 status;
 	u32 return_code;
@@ -331,7 +332,7 @@ static struct switchtec_user *stuser_cre
 	stuser->stdev = stdev;
 	kref_init(&stuser->kref);
 	INIT_LIST_HEAD(&stuser->list);
-	init_completion(&stuser->comp);
+	init_waitqueue_head(&stuser->cmd_comp);
 	stuser->event_cnt = atomic_read(&stdev->event_cnt);
 
 	dev_dbg(&stdev->dev, "%s: %p\n", __func__, stuser);
@@ -414,7 +415,7 @@ static int mrpc_queue_cmd(struct switcht
 	kref_get(&stuser->kref);
 	stuser->read_len = sizeof(stuser->data);
 	stuser_set_state(stuser, MRPC_QUEUED);
-	init_completion(&stuser->comp);
+	stuser->cmd_done = false;
 	list_add_tail(&stuser->list, &stdev->mrpc_queue);
 
 	mrpc_cmd_submit(stdev);
@@ -451,7 +452,8 @@ static void mrpc_complete_cmd(struct swi
 		      stuser->read_len);
 
 out:
-	complete_all(&stuser->comp);
+	stuser->cmd_done = true;
+	wake_up_interruptible(&stuser->cmd_comp);
 	list_del_init(&stuser->list);
 	stuser_put(stuser);
 	stdev->mrpc_busy = 0;
@@ -721,10 +723,11 @@ static ssize_t switchtec_dev_read(struct
 	mutex_unlock(&stdev->mrpc_mutex);
 
 	if (filp->f_flags & O_NONBLOCK) {
-		if (!try_wait_for_completion(&stuser->comp))
+		if (!stuser->cmd_done)
 			return -EAGAIN;
 	} else {
-		rc = wait_for_completion_interruptible(&stuser->comp);
+		rc = wait_event_interruptible(stuser->cmd_comp,
+					      stuser->cmd_done);
 		if (rc < 0)
 			return rc;
 	}
@@ -772,7 +775,7 @@ static unsigned int switchtec_dev_poll(s
 	struct switchtec_dev *stdev = stuser->stdev;
 	int ret = 0;
 
-	poll_wait(filp, &stuser->comp.wait, wait);
+	poll_wait(filp, &stuser->cmd_comp, wait);
 	poll_wait(filp, &stdev->event_wq, wait);
 
 	if (lock_mutex_and_test_alive(stdev))
@@ -780,7 +783,7 @@ static unsigned int switchtec_dev_poll(s
 
 	mutex_unlock(&stdev->mrpc_mutex);
 
-	if (try_wait_for_completion(&stuser->comp))
+	if (stuser->cmd_done)
 		ret |= POLLIN | POLLRDNORM;
 
 	if (stuser->event_cnt != atomic_read(&stdev->event_cnt))
@@ -1255,7 +1258,8 @@ static void stdev_kill(struct switchtec_
 
 	/* Wake up and kill any users waiting on an MRPC request */
 	list_for_each_entry_safe(stuser, tmpuser, &stdev->mrpc_queue, list) {
-		complete_all(&stuser->comp);
+		stuser->cmd_done = true;
+		wake_up_interruptible(&stuser->cmd_comp);
 		list_del_init(&stuser->list);
 		stuser_put(stuser);
 	}
