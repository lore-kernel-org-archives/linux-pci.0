Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:56487 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdJDJuT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2017 05:50:19 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-pci@vger.kernel.org
Cc: tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH] pci/switchtec: Don't use completion's wait queue
Date: Wed,  4 Oct 2017 11:50:07 +0200
Message-Id: <20171004095007.19148-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The poll callback is using completion's wait_queue_head_t member and
puts it in poll_wait() so the poll() caller gets a wakeup after command
completed. This does not work on RT because we don't have a
wait_queue_head_t in our completion implementation. Nobody in tree does
like that in tree so this is the only driver that breaks.

>From reading the code, the completion is used to signal to the waiter
that a command completed. I tried to wait_queue_head_t cmd_comp instead
using the completion for that. There is a cmd_cnt which is incremented
after each command completed and the user "copies" the value once the
read was successful.

I don't have the HW so I have no idea if it works as expected, so please
test it.
It looks like both wait queues (event_wq and cmd_comp) could be merged
into one. The events can be distinguished and the "command complete"
should be the event with the higher frequency. event_wq is only used on
poll.

Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc: Stephen Bates <stephen.bates@microsemi.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/pci/switch/switchtec.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index af81b2dec42e..879330eb77bd 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -286,7 +286,9 @@ struct switchtec_dev {
 	bool alive;
=20
 	wait_queue_head_t event_wq;
+	wait_queue_head_t cmd_comp;
 	atomic_t event_cnt;
+	atomic_t cmd_cnt;
 };
=20
 static struct switchtec_dev *to_stdev(struct device *dev)
@@ -306,7 +308,6 @@ struct switchtec_user {
=20
 	enum mrpc_state state;
=20
-	struct completion comp;
 	struct kref kref;
 	struct list_head list;
=20
@@ -317,6 +318,7 @@ struct switchtec_user {
 	size_t read_len;
 	unsigned char data[SWITCHTEC_MRPC_PAYLOAD_SIZE];
 	int event_cnt;
+	int cmd_cnt;
 };
=20
 static struct switchtec_user *stuser_create(struct switchtec_dev *stdev)
@@ -331,8 +333,8 @@ static struct switchtec_user *stuser_create(struct swit=
chtec_dev *stdev)
 	stuser->stdev =3D stdev;
 	kref_init(&stuser->kref);
 	INIT_LIST_HEAD(&stuser->list);
-	init_completion(&stuser->comp);
 	stuser->event_cnt =3D atomic_read(&stdev->event_cnt);
+	stuser->cmd_cnt =3D atomic_read(&stdev->cmd_cnt);
=20
 	dev_dbg(&stdev->dev, "%s: %p\n", __func__, stuser);
=20
@@ -414,7 +416,6 @@ static int mrpc_queue_cmd(struct switchtec_user *stuser)
 	kref_get(&stuser->kref);
 	stuser->read_len =3D sizeof(stuser->data);
 	stuser_set_state(stuser, MRPC_QUEUED);
-	init_completion(&stuser->comp);
 	list_add_tail(&stuser->list, &stdev->mrpc_queue);
=20
 	mrpc_cmd_submit(stdev);
@@ -451,7 +452,8 @@ static void mrpc_complete_cmd(struct switchtec_dev *std=
ev)
 		      stuser->read_len);
=20
 out:
-	complete_all(&stuser->comp);
+	atomic_inc(&stdev->cmd_cnt);
+	wake_up_interruptible(&stdev->cmd_comp);
 	list_del_init(&stuser->list);
 	stuser_put(stuser);
 	stdev->mrpc_busy =3D 0;
@@ -721,10 +723,11 @@ static ssize_t switchtec_dev_read(struct file *filp, =
char __user *data,
 	mutex_unlock(&stdev->mrpc_mutex);
=20
 	if (filp->f_flags & O_NONBLOCK) {
-		if (!try_wait_for_completion(&stuser->comp))
+		if (stuser->cmd_cnt =3D=3D atomic_read(&stdev->cmd_cnt))
 			return -EAGAIN;
 	} else {
-		rc =3D wait_for_completion_interruptible(&stuser->comp);
+		rc =3D wait_event_interruptible(stdev->cmd_comp,
+			      stuser->cmd_cnt !=3D atomic_read(&stdev->cmd_cnt));
 		if (rc < 0)
 			return rc;
 	}
@@ -752,7 +755,7 @@ static ssize_t switchtec_dev_read(struct file *filp, ch=
ar __user *data,
 		rc =3D -EFAULT;
 		goto out;
 	}
-
+	stuser->cmd_cnt =3D atomic_read(&stdev->cmd_cnt);
 	stuser_set_state(stuser, MRPC_IDLE);
=20
 out:
@@ -772,7 +775,7 @@ static unsigned int switchtec_dev_poll(struct file *fil=
p, poll_table *wait)
 	struct switchtec_dev *stdev =3D stuser->stdev;
 	int ret =3D 0;
=20
-	poll_wait(filp, &stuser->comp.wait, wait);
+	poll_wait(filp, &stdev->cmd_comp, wait);
 	poll_wait(filp, &stdev->event_wq, wait);
=20
 	if (lock_mutex_and_test_alive(stdev))
@@ -780,7 +783,7 @@ static unsigned int switchtec_dev_poll(struct file *fil=
p, poll_table *wait)
=20
 	mutex_unlock(&stdev->mrpc_mutex);
=20
-	if (try_wait_for_completion(&stuser->comp))
+	if (stuser->cmd_cnt !=3D atomic_read(&stdev->cmd_cnt))
 		ret |=3D POLLIN | POLLRDNORM;
=20
 	if (stuser->event_cnt !=3D atomic_read(&stdev->event_cnt))
@@ -1255,7 +1258,6 @@ static void stdev_kill(struct switchtec_dev *stdev)
=20
 	/* Wake up and kill any users waiting on an MRPC request */
 	list_for_each_entry_safe(stuser, tmpuser, &stdev->mrpc_queue, list) {
-		complete_all(&stuser->comp);
 		list_del_init(&stuser->list);
 		stuser_put(stuser);
 	}
@@ -1264,6 +1266,7 @@ static void stdev_kill(struct switchtec_dev *stdev)
=20
 	/* Wake up any users waiting on event_wq */
 	wake_up_interruptible(&stdev->event_wq);
+	wake_up_interruptible(&stdev->cmd_comp);
 }
=20
 static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
@@ -1287,7 +1290,9 @@ static struct switchtec_dev *stdev_create(struct pci_=
dev *pdev)
 	INIT_WORK(&stdev->mrpc_work, mrpc_event_work);
 	INIT_DELAYED_WORK(&stdev->mrpc_timeout, mrpc_timeout_work);
 	init_waitqueue_head(&stdev->event_wq);
+	init_waitqueue_head(&stdev->cmd_comp);
 	atomic_set(&stdev->event_cnt, 0);
+	atomic_set(&stdev->cmd_cnt, 0);
=20
 	dev =3D &stdev->dev;
 	device_initialize(dev);
--=20
2.14.2
