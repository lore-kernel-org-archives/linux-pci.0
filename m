Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:32814 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbdJEKvE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2017 06:51:04 -0400
Date: Thu, 5 Oct 2017 12:51:01 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Subject: [PATCH v2] pci/switchtec: Don't use completion's wait queue
Message-ID: <20171005105100.2nf4ih2fgq6dax5g@linutronix.de>
References: <20171004095007.19148-1-bigeasy@linutronix.de>
 <dfd717ac-a775-f30c-4d41-2da68e08ff54@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <dfd717ac-a775-f30c-4d41-2da68e08ff54@deltatee.com>
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
On 2017-10-04 10:13:15 [-0600], Logan Gunthorpe wrote:

> But at the very least, if we _absolutely_ have to patch this out, you
> shouldn't make it so convoluted. Just replace the struct completion with a
> wait queue and a done flag (which is what a completion is). Don't move the
> wait queue into switchtec_dev and don't use an unnecessary counter. And
> certainly don't think about merging it with another wait queue that has
> completely different wake events and waiters.

here it is.

v1…v2: use a status flag and a wait_queue_head_t instead as suggested by
       Logan.

 drivers/pci/switch/switchtec.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index af81b2dec42e..4c843fca709a 100644
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
@@ -331,7 +332,7 @@ static struct switchtec_user *stuser_create(struct switchtec_dev *stdev)
 	stuser->stdev = stdev;
 	kref_init(&stuser->kref);
 	INIT_LIST_HEAD(&stuser->list);
-	init_completion(&stuser->comp);
+	init_waitqueue_head(&stuser->cmd_comp);
 	stuser->event_cnt = atomic_read(&stdev->event_cnt);
 
 	dev_dbg(&stdev->dev, "%s: %p\n", __func__, stuser);
@@ -414,7 +415,7 @@ static int mrpc_queue_cmd(struct switchtec_user *stuser)
 	kref_get(&stuser->kref);
 	stuser->read_len = sizeof(stuser->data);
 	stuser_set_state(stuser, MRPC_QUEUED);
-	init_completion(&stuser->comp);
+	stuser->cmd_done = false;
 	list_add_tail(&stuser->list, &stdev->mrpc_queue);
 
 	mrpc_cmd_submit(stdev);
@@ -451,7 +452,7 @@ static void mrpc_complete_cmd(struct switchtec_dev *stdev)
 		      stuser->read_len);
 
 out:
-	complete_all(&stuser->comp);
+	wake_up_interruptible(&stuser->cmd_comp);
 	list_del_init(&stuser->list);
 	stuser_put(stuser);
 	stdev->mrpc_busy = 0;
@@ -721,10 +722,11 @@ static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
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
@@ -772,7 +774,7 @@ static unsigned int switchtec_dev_poll(struct file *filp, poll_table *wait)
 	struct switchtec_dev *stdev = stuser->stdev;
 	int ret = 0;
 
-	poll_wait(filp, &stuser->comp.wait, wait);
+	poll_wait(filp, &stuser->cmd_comp, wait);
 	poll_wait(filp, &stdev->event_wq, wait);
 
 	if (lock_mutex_and_test_alive(stdev))
@@ -780,7 +782,7 @@ static unsigned int switchtec_dev_poll(struct file *filp, poll_table *wait)
 
 	mutex_unlock(&stdev->mrpc_mutex);
 
-	if (try_wait_for_completion(&stuser->comp))
+	if (stuser->cmd_done)
 		ret |= POLLIN | POLLRDNORM;
 
 	if (stuser->event_cnt != atomic_read(&stdev->event_cnt))
@@ -1255,7 +1257,8 @@ static void stdev_kill(struct switchtec_dev *stdev)
 
 	/* Wake up and kill any users waiting on an MRPC request */
 	list_for_each_entry_safe(stuser, tmpuser, &stdev->mrpc_queue, list) {
-		complete_all(&stuser->comp);
+		stuser->cmd_done = true;
+		wake_up_interruptible(&stuser->cmd_comp);
 		list_del_init(&stuser->list);
 		stuser_put(stuser);
 	}
-- 
2.14.2
