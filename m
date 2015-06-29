Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwdur.emc.com ([128.221.224.79]:26651 "EHLO
	mailuogwdur.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbbF2P3i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2015 11:29:38 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 2/9] NTB: Add flow control to the ntb_netdev
Date: Mon, 29 Jun 2015 11:28:52 -0400
Message-Id: <b9741f90ecfa33e97d8a6690ed357fd64f683b06.1435587291.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1435587291.git.Allen.Hubbe@emc.com>
References: <cover.1435587291.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

Right now if we push the NTB really hard, we start dropping packets due to
not able to process the packets fast enough. We need to stop the upper layer
from flooding us when that happens.

A timer is necessary in order to restart the queue once the resource has
been processed on the receive side. Due to the way NTB is setup, the
resources on the tx side are tied to the processing of the rx side and
there's no async way to know when the rx side has released those resources.

The following module parameters are added:
tx_time: The time in usecs for us to wait before we check if we restart
	 transmit queue. (default: 1)
tx_start: The number of descriptors we wait for to free up before resuming
	  transmit queue. (default: 10)
tx_stop: The low water mark of free descriptors before we stop tx queue.
	 (default: 5)

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ntb_netdev.c      | 71 +++++++++++++++++++++++++++++++++++++++++++
 drivers/ntb/ntb_transport.c   | 20 +++++++++++-
 include/linux/ntb_transport.h |  1 +
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 5f1ee7c05f68..7a0aeac00c24 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -61,11 +61,24 @@ MODULE_VERSION(NTB_NETDEV_VER);
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Intel Corporation");
 
+static unsigned int tx_time = 1;
+module_param(tx_time, uint, 0644);
+MODULE_PARM_DESC(tx_time, "Time in usecs for tx resource reaper");
+
+static unsigned int tx_start = 10;
+module_param(tx_start, uint, 0644);
+MODULE_PARM_DESC(tx_start, "Number of descriptors to free before resume tx");
+
+static unsigned int tx_stop = 5;
+module_param(tx_stop, uint, 0644);
+MODULE_PARM_DESC(tx_stop, "Number of descriptors before stop upper layer tx");
+
 struct ntb_netdev {
 	struct list_head list;
 	struct pci_dev *pdev;
 	struct net_device *ndev;
 	struct ntb_transport_qp *qp;
+	struct timer_list tx_timer;
 };
 
 #define	NTB_TX_TIMEOUT_MS	1000
@@ -136,11 +149,39 @@ enqueue_again:
 	}
 }
 
+static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
+				      struct ntb_transport_qp *qp, int size)
+{
+	struct ntb_netdev *dev = netdev_priv(netdev);
+
+	netif_stop_queue(netdev);
+	smp_mb();
+
+	if (likely(ntb_transport_tx_free_entry(qp) < size)) {
+		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
+		return -EBUSY;
+	}
+
+	netif_start_queue(netdev);
+	return 0;
+}
+
+static int ntb_netdev_maybe_stop_tx(struct net_device *ndev,
+				    struct ntb_transport_qp *qp, int size)
+{
+	if (netif_queue_stopped(ndev) ||
+	    (ntb_transport_tx_free_entry(qp) >= size))
+		return 0;
+
+	return __ntb_netdev_maybe_stop_tx(ndev, qp, size);
+}
+
 static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
 	struct net_device *ndev = qp_data;
 	struct sk_buff *skb;
+	struct ntb_netdev *dev = netdev_priv(ndev);
 
 	skb = data;
 	if (!skb || !ndev)
@@ -155,6 +196,12 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	}
 
 	dev_kfree_skb(skb);
+
+	if (ntb_transport_tx_free_entry(dev->qp) >= tx_start) {
+		smp_mb();
+		if (netif_queue_stopped(ndev))
+			netif_wake_queue(ndev);
+	}
 }
 
 static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
@@ -163,10 +210,15 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 	struct ntb_netdev *dev = netdev_priv(ndev);
 	int rc;
 
+	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+
 	rc = ntb_transport_tx_enqueue(dev->qp, skb, skb->data, skb->len);
 	if (rc)
 		goto err;
 
+	/* check for next submit */
+	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+
 	return NETDEV_TX_OK;
 
 err:
@@ -175,6 +227,20 @@ err:
 	return NETDEV_TX_BUSY;
 }
 
+static void ntb_netdev_tx_timer(unsigned long data)
+{
+	struct net_device *ndev = (struct net_device *)data;
+	struct ntb_netdev *dev = netdev_priv(ndev);
+
+	if (ntb_transport_tx_free_entry(dev->qp) < tx_stop) {
+		 mod_timer(&dev->tx_timer, jiffies + msecs_to_jiffies(tx_time));
+	} else {
+		smp_mb();
+		if (netif_queue_stopped(ndev))
+			netif_wake_queue(ndev);
+	}
+}
+
 static int ntb_netdev_open(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
@@ -197,8 +263,11 @@ static int ntb_netdev_open(struct net_device *ndev)
 		}
 	}
 
+	setup_timer(&dev->tx_timer, ntb_netdev_tx_timer, (unsigned long)ndev);
+
 	netif_carrier_off(ndev);
 	ntb_transport_link_up(dev->qp);
+	netif_start_queue(ndev);
 
 	return 0;
 
@@ -219,6 +288,8 @@ static int ntb_netdev_close(struct net_device *ndev)
 	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
 		dev_kfree_skb(skb);
 
+	del_timer_sync(&dev->tx_timer);
+
 	return 0;
 }
 
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index b87578fb91d6..3c257f1d235f 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -487,6 +487,12 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 			       "tx_index - \t%u\n", qp->tx_index);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "qp->remote_rx_info->entry - \t%u\n",
+			       qp->remote_rx_info->entry);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "free tx - \t%u\n",
+			       ntb_transport_tx_free_entry(qp));
 
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "\nQP Link %s\n",
@@ -528,6 +534,7 @@ static struct ntb_queue_entry *ntb_list_rm(spinlock_t *lock,
 	}
 	entry = list_first_entry(list, struct ntb_queue_entry, entry);
 	list_del(&entry->entry);
+
 out:
 	spin_unlock_irqrestore(lock, flags);
 
@@ -1826,7 +1833,7 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
 	if (!entry) {
 		qp->tx_err_no_buf++;
-		return -ENOMEM;
+		return -EBUSY;
 	}
 
 	entry->cb_data = cb;
@@ -1952,6 +1959,17 @@ unsigned int ntb_transport_max_size(struct ntb_transport_qp *qp)
 }
 EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 
+#define NTBQ_SPACE(tail, head, size) ((tail) > (head)) ? ((tail) - (head)) : ((size) - (head) + (tail))
+
+unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
+{
+	unsigned int head = qp->tx_index;
+	unsigned int tail = qp->remote_rx_info->entry;
+
+	return NTBQ_SPACE(tail, head, qp->tx_max_entry);
+}
+EXPORT_SYMBOL_GPL(ntb_transport_tx_free_entry);
+
 static void ntb_transport_doorbell_callback(void *data, int vector)
 {
 	struct ntb_transport_ctx *nt = data;
diff --git a/include/linux/ntb_transport.h b/include/linux/ntb_transport.h
index 2862861366a5..7243eb98a722 100644
--- a/include/linux/ntb_transport.h
+++ b/include/linux/ntb_transport.h
@@ -83,3 +83,4 @@ void *ntb_transport_rx_remove(struct ntb_transport_qp *qp, unsigned int *len);
 void ntb_transport_link_up(struct ntb_transport_qp *qp);
 void ntb_transport_link_down(struct ntb_transport_qp *qp);
 bool ntb_transport_link_query(struct ntb_transport_qp *qp);
+unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp);
-- 
2.4.0.rc0.43.gcf8a8c6

