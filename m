Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:57822 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754046AbcLQRpe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Dec 2016 12:45:34 -0500
From: Logan Gunthorpe <logang@deltatee.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Date: Sat, 17 Dec 2016 10:09:22 -0700
Message-Id: <1481994562-9283-2-git-send-email-logang@deltatee.com>
In-Reply-To: <1481994562-9283-1-git-send-email-logang@deltatee.com>
References: <1481994562-9283-1-git-send-email-logang@deltatee.com>
Subject: [RFC 1/1] MicroSemi Switchtec management interface driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Microsemi's "Switchtec" line of PCI switch devices is already
supported by the kernel with standard PCI switch drivers. However, the
Switchtec device advertises a special management endpoint which
enables some additional functionality. This includes:

 * Packet and Byte Counters
 * Firmware Upgrades
 * Event and Error logs
 * Querying port link status
 * Custom user firmware commands

This patch introduces the switchtec kernel module which provides
pci driver that exposes a char device. The char device provides
userspace access to this interface through read, write and (optionally)
poll calls. Currently no ioctls have been implemented but a couple
may be added in a later revision.

A short text file is provided which documents the switchtec driver
and outlines the semantics of using the char device.

A WIP userspace tool which utilizes this interface is available
at [1]. This tool takes
inspiration (and borrows some code) from nvme-cli [2].

[1] https://github.com/sbates130272/switchtec-user
[2] https://github.com/linux-nvme/nvme-cli

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Stephen Bates <stephen.bates@microsemi.com>
---
 Documentation/switchtec.txt    |  54 +++
 MAINTAINERS                    |   9 +
 drivers/pci/Kconfig            |   1 +
 drivers/pci/Makefile           |   1 +
 drivers/pci/switch/Kconfig     |  13 +
 drivers/pci/switch/Makefile    |   1 +
 drivers/pci/switch/switchtec.c | 824 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/switch/switchtec.h | 119 ++++++
 8 files changed, 1022 insertions(+)
 create mode 100644 Documentation/switchtec.txt
 create mode 100644 drivers/pci/switch/Kconfig
 create mode 100644 drivers/pci/switch/Makefile
 create mode 100644 drivers/pci/switch/switchtec.c
 create mode 100644 drivers/pci/switch/switchtec.h

diff --git a/Documentation/switchtec.txt b/Documentation/switchtec.txt
new file mode 100644
index 0000000..04657ce
--- /dev/null
+++ b/Documentation/switchtec.txt
@@ -0,0 +1,54 @@
+
+Linux Switchtec Support
+========================
+
+Microsemi's "Switchtec" line of PCI switch devices is already
+supported by the kernel with standard PCI switch drivers. However, the
+Switchtec device advertises a special management endpoint which
+enables some additional functionality. This includes:
+
+ * Packet and Byte Counters
+ * Firmware Upgrades
+ * Event and Error logs
+ * Querying port link status
+ * Custom user firmware commands
+
+The switchtec kernel module implements this functionality.
+
+
+
+Interface
+=========
+
+The primary means of communicating with the Switchtec management firmware is
+through the Memory-mapped Remote Procedure Call (MRPC) interface.
+Commands are submitted to the interface with a 4-byte command
+identifier and up to 1KB of command specific data. The firmware will
+respond with a 4 bytes return code and up to 1KB of command specific
+data. The interface only processes a single command at a time.
+
+
+Userspace Interface
+===================
+
+The MRPC interface will be exposed to userspace through a simple char
+device: /dev/switchtec#, one for each management endpoint in the system.
+
+The char device has the following semantics:
+
+ * A write must consist of at least 4 bytes and no more than 1028 bytes.
+   The first four bytes will be interpreted as the command to run and
+   the remainder will be used as the input data. A write will send the
+   command to the firmware to begin processing.
+
+ * Each write must be followed by exactly one read. Any double write will
+   produce an error and any read that doesn't follow a write will
+   produce an error.
+
+ * A read will block until the firmware completes the command and return
+   the four bytes of status plus up to 1024 bytes of output data. (The
+   length will be specified by the size parameter of the read call --
+   reading less than 4 bytes will produce an error.
+
+ * The poll call will also be supported for userspace applications that
+   need to do other things while waiting for the command to complete.
diff --git a/MAINTAINERS b/MAINTAINERS
index 63cefa6..1e21505 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9288,6 +9288,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/aardvark-pci.txt
 F:	drivers/pci/host/pci-aardvark.c
 
+PCI DRIVER FOR MICROSEMI SWITCHTEC
+M:	Kurt Schwemmer <kurt.schwemmer@microsemi.com>
+M:	Stephen Bates <stephen.bates@microsemi.com>
+M:	Logan Gunthorpe <logang@deltatee.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/switchtec.txt
+F:	drivers/pci/switch/switchtec*
+
 PCI DRIVER FOR NVIDIA TEGRA
 M:	Thierry Reding <thierry.reding@gmail.com>
 L:	linux-tegra@vger.kernel.org
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 6555eb7..f72e8c5 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -133,3 +133,4 @@ config PCI_HYPERV
 
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/host/Kconfig"
+source "drivers/pci/switch/Kconfig"
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 8db5079..15b46dd 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -68,3 +68,4 @@ ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
 
 # PCI host controller drivers
 obj-y += host/
+obj-y += switch/
diff --git a/drivers/pci/switch/Kconfig b/drivers/pci/switch/Kconfig
new file mode 100644
index 0000000..97f8979
--- /dev/null
+++ b/drivers/pci/switch/Kconfig
@@ -0,0 +1,13 @@
+menu "PCI switch controller drivers"
+	depends on PCI
+
+config PCI_SW_SWITCHTEC
+        tristate "MicroSemi Switchtec PCIe Switch Management Driver"
+	help
+	 Enables support for the management interface for the MicroSemi
+	 Switchtec series of PCIe switches. Supports userspace access
+	 to submit MRPC commands to the switch via /dev/switchtecX
+	 devices. See <file:Documentation/switchtec.txt> for more
+	 information.
+
+endmenu
diff --git a/drivers/pci/switch/Makefile b/drivers/pci/switch/Makefile
new file mode 100644
index 0000000..37d8cfb
--- /dev/null
+++ b/drivers/pci/switch/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_PCI_SW_SWITCHTEC) += switchtec.o
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
new file mode 100644
index 0000000..bd05b29
--- /dev/null
+++ b/drivers/pci/switch/switchtec.c
@@ -0,0 +1,824 @@
+/*
+ * Microsemi Switchtec(tm) PCIe Management Driver
+ * Copyright (c) 2016, Microsemi Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include "switchtec.h"
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/poll.h>
+
+MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCI-E Management Driver");
+MODULE_VERSION("0.1");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Microsemi Corporation");
+
+static int switchtec_major;
+static struct class *switchtec_class;
+static DEFINE_IDA(switchtec_minor_ida);
+
+static int __match_devt(struct device *dev, const void *data)
+{
+	const dev_t *devt = data;
+
+	return dev->devt == *devt;
+}
+
+static struct device *switchtec_dev_find(dev_t dev_t)
+{
+	return class_find_device(switchtec_class, NULL, &dev_t, __match_devt);
+}
+
+struct switchtec_user {
+	struct switchtec_dev *stdev;
+
+	enum mrpc_state {
+		MRPC_IDLE = 0,
+		MRPC_QUEUED,
+		MRPC_RUNNING,
+		MRPC_DONE,
+	} state;
+
+	struct completion comp;
+	struct kref kref;
+	struct list_head list;
+
+	u32 cmd;
+	u32 status;
+	u32 return_code;
+	size_t data_len;
+	unsigned char data[SWITCHTEC_MRPC_PAYLOAD_SIZE];
+};
+
+static void stuser_free(struct kref *kref)
+{
+	struct switchtec_user *stuser;
+
+	stuser = container_of(kref, struct switchtec_user, kref);
+
+	kfree(stuser);
+}
+
+static void stuser_init(struct switchtec_user *stuser,
+			struct switchtec_dev *stdev)
+{
+	stuser->stdev = stdev;
+	kref_init(&stuser->kref);
+	INIT_LIST_HEAD(&stuser->list);
+	init_completion(&stuser->comp);
+}
+
+static void stuser_put(struct switchtec_user *stuser)
+{
+	kref_put(&stuser->kref, stuser_free);
+}
+
+static void stuser_set_state(struct switchtec_user *stuser,
+			     enum mrpc_state state)
+{
+	const char * const state_names[] = {
+		[MRPC_IDLE] = "IDLE",
+		[MRPC_QUEUED] = "QUEUED",
+		[MRPC_RUNNING] = "RUNNING",
+		[MRPC_DONE] = "DONE",
+	};
+
+	stuser->state = state;
+
+	dev_dbg(stdev_dev(stuser->stdev), "stuser state %p -> %s",
+		stuser, state_names[state]);
+}
+
+static void mrpc_complete_cmd(struct switchtec_dev *stdev);
+
+static void mrpc_cmd_submit(struct switchtec_dev *stdev)
+{
+	/* requires the mrpc_mutex to already be held when called */
+
+	struct switchtec_user *stuser;
+
+	if (stdev->mrpc_busy)
+		return;
+
+	if (list_empty(&stdev->mrpc_queue))
+		return;
+
+	stuser = list_entry(stdev->mrpc_queue.next, struct switchtec_user,
+			    list);
+
+	stuser_set_state(stuser, MRPC_RUNNING);
+	stdev->mrpc_busy = 1;
+	memcpy_toio(&stdev->mmio_mrpc->input_data,
+		    stuser->data, stuser->data_len);
+	iowrite32(stuser->cmd, &stdev->mmio_mrpc->cmd);
+
+	stuser->status = ioread32(&stdev->mmio_mrpc->status);
+	if (stuser->status != SWITCHTEC_MRPC_STATUS_INPROGRESS)
+		mrpc_complete_cmd(stdev);
+
+	schedule_delayed_work(&stdev->mrpc_timeout,
+			      msecs_to_jiffies(500));
+}
+
+static void mrpc_queue_cmd(struct switchtec_user *stuser)
+{
+	/* requires the mrpc_mutex to already be held when called */
+
+	struct switchtec_dev *stdev = stuser->stdev;
+
+	kref_get(&stuser->kref);
+	stuser_set_state(stuser, MRPC_QUEUED);
+	init_completion(&stuser->comp);
+	list_add_tail(&stuser->list, &stdev->mrpc_queue);
+
+	mrpc_cmd_submit(stdev);
+}
+
+static void mrpc_complete_cmd(struct switchtec_dev *stdev)
+{
+	/* requires the mrpc_mutex to already be held when called */
+	struct switchtec_user *stuser;
+
+	if (list_empty(&stdev->mrpc_queue))
+		return;
+
+	stuser = list_entry(stdev->mrpc_queue.next, struct switchtec_user,
+			    list);
+
+	stuser->status = ioread32(&stdev->mmio_mrpc->status);
+	if (stuser->status == SWITCHTEC_MRPC_STATUS_INPROGRESS)
+		return;
+
+	stuser_set_state(stuser, MRPC_DONE);
+	stuser->return_code = 0;
+
+	if (stuser->status != SWITCHTEC_MRPC_STATUS_DONE)
+		goto out;
+
+	stuser->return_code = ioread32(&stdev->mmio_mrpc->ret_value);
+	if (stuser->return_code != 0)
+		goto out;
+
+	memcpy_fromio(stuser->data, &stdev->mmio_mrpc->output_data,
+		      sizeof(stuser->data));
+
+out:
+	complete_all(&stuser->comp);
+	list_del_init(&stuser->list);
+	stuser_put(stuser);
+	stdev->mrpc_busy = 0;
+
+	mrpc_cmd_submit(stdev);
+}
+
+static void mrpc_event_work(struct work_struct *work)
+{
+	struct switchtec_dev *stdev;
+
+	stdev = container_of(work, struct switchtec_dev, mrpc_work);
+
+	dev_dbg(stdev_dev(stdev), "%s\n", __func__);
+
+	mutex_lock(&stdev->mrpc_mutex);
+	cancel_delayed_work(&stdev->mrpc_timeout);
+	mrpc_complete_cmd(stdev);
+	mutex_unlock(&stdev->mrpc_mutex);
+}
+
+static void mrpc_timeout_work(struct work_struct *work)
+{
+	struct switchtec_dev *stdev;
+	u32 status;
+
+	stdev = container_of(work, struct switchtec_dev, mrpc_timeout.work);
+
+	dev_dbg(stdev_dev(stdev), "%s\n", __func__);
+
+	mutex_lock(&stdev->mrpc_mutex);
+
+	status = ioread32(&stdev->mmio_mrpc->status);
+	if (status == SWITCHTEC_MRPC_STATUS_INPROGRESS) {
+		schedule_delayed_work(&stdev->mrpc_timeout,
+				      msecs_to_jiffies(500));
+		goto out;
+	}
+
+	mrpc_complete_cmd(stdev);
+
+out:
+	mutex_unlock(&stdev->mrpc_mutex);
+}
+
+static int switchtec_register_dev(struct switchtec_dev *stdev)
+{
+	int rc;
+	int minor;
+	struct device *dev;
+	dev_t devt;
+
+	minor = ida_simple_get(&switchtec_minor_ida, 0, 0,
+			       GFP_KERNEL);
+	if (minor < 0)
+		return minor;
+
+	devt = MKDEV(switchtec_major, minor);
+	dev = device_create(switchtec_class, &stdev->pdev->dev,
+			    devt, stdev, "switchtec%d", minor);
+	if (IS_ERR(dev)) {
+		rc = PTR_ERR(dev);
+		goto err_create;
+	}
+
+	stdev->dev = dev;
+
+	return 0;
+
+err_create:
+	ida_simple_remove(&switchtec_minor_ida, minor);
+
+	return rc;
+}
+
+static void switchtec_unregister_dev(struct switchtec_dev *stdev)
+{
+	device_unregister(stdev_dev(stdev));
+	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev_dev(stdev)->devt));
+}
+
+static void stdev_free(struct kref *kref)
+{
+	struct switchtec_dev *stdev;
+	struct switchtec_user *stuser, *temp;
+
+	stdev = container_of(kref, struct switchtec_dev, kref);
+
+	if (!stdev->dev)
+		goto free_and_exit;
+
+	get_device(stdev_dev(stdev));
+
+	dev_dbg(stdev_dev(stdev), "%s\n", __func__);
+
+	cancel_delayed_work(&stdev->mrpc_timeout);
+	mutex_lock(&stdev->mrpc_mutex);
+
+	list_for_each_entry_safe(stuser, temp, &stdev->mrpc_queue, list) {
+		stuser->status = SWITCHTEC_MRPC_STATUS_INTERRUPTED;
+		list_del_init(&stuser->list);
+		stuser_put(stuser);
+	}
+
+	mutex_unlock(&stdev->mrpc_mutex);
+
+	switchtec_unregister_dev(stdev);
+	put_device(stdev_dev(stdev));
+
+free_and_exit:
+	kfree(stdev);
+}
+
+static void stdev_init(struct switchtec_dev *stdev,
+		       struct pci_dev *pdev)
+{
+	stdev->pdev = pdev;
+	kref_init(&stdev->kref);
+	INIT_LIST_HEAD(&stdev->mrpc_queue);
+	mutex_init(&stdev->mrpc_mutex);
+	stdev->mrpc_busy = 0;
+	INIT_WORK(&stdev->mrpc_work, mrpc_event_work);
+	INIT_DELAYED_WORK(&stdev->mrpc_timeout, mrpc_timeout_work);
+}
+
+static void stdev_put(struct switchtec_dev *stdev)
+{
+	kref_put(&stdev->kref, stdev_free);
+}
+
+static int stdev_is_alive(struct switchtec_dev *stdev)
+{
+	return stdev->mmio != NULL;
+}
+
+static int switchtec_dev_open(struct inode *inode, struct file *filp)
+{
+	struct device *dev;
+	struct switchtec_dev *stdev;
+	struct switchtec_user *stuser;
+	int rc;
+
+	dev = switchtec_dev_find(inode->i_rdev);
+	if (!dev)
+		return -ENXIO;
+
+	device_lock(dev);
+	stdev = dev_get_drvdata(dev);
+	if (!stdev) {
+		rc = -ENXIO;
+		goto err_unlock_exit;
+	}
+
+	kref_get(&stdev->kref);
+
+	stuser = kzalloc(sizeof(*stuser), GFP_KERNEL);
+	if (!stuser) {
+		rc = -ENOMEM;
+		goto err_unlock_exit;
+	}
+
+	stuser_init(stuser, stdev);
+	filp->private_data = stuser;
+
+	dev_dbg(stdev_dev(stdev), "%s: %p\n", __func__, stuser);
+
+	device_unlock(dev);
+	nonseekable_open(inode, filp);
+	return 0;
+
+err_unlock_exit:
+	device_unlock(dev);
+	put_device(dev);
+	return rc;
+}
+
+static int switchtec_dev_release(struct inode *inode, struct file *filp)
+{
+	struct switchtec_user *stuser = filp->private_data;
+	struct switchtec_dev *stdev = stuser->stdev;
+	struct device *dev = stdev_dev(stdev);
+
+	dev_dbg(dev, "%s: %p\n", __func__, stuser);
+
+	stuser_put(stuser);
+	stdev_put(stdev);
+	put_device(dev);
+
+	return 0;
+}
+
+static ssize_t switchtec_dev_write(struct file *filp, const char __user *data,
+				   size_t size, loff_t *off)
+{
+	struct switchtec_user *stuser = filp->private_data;
+	struct switchtec_dev *stdev = stuser->stdev;
+	int rc;
+
+	if (!stdev_is_alive(stdev))
+		return -ENXIO;
+
+	if (size < sizeof(stuser->cmd) ||
+	    size > sizeof(stuser->cmd) + SWITCHTEC_MRPC_PAYLOAD_SIZE)
+		return -EINVAL;
+
+	if (mutex_lock_interruptible(&stdev->mrpc_mutex))
+		return -EINTR;
+
+	if (stuser->state != MRPC_IDLE) {
+		rc = -EBADE;
+		goto out;
+	}
+
+	rc = copy_from_user(&stuser->cmd, data, sizeof(stuser->cmd));
+	if (rc) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	data += sizeof(stuser->cmd);
+	rc = copy_from_user(&stuser->data, data, size - sizeof(stuser->cmd));
+	if (rc) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	stuser->data_len = size - sizeof(stuser->cmd);
+
+	mrpc_queue_cmd(stuser);
+
+	rc = size;
+
+out:
+	mutex_unlock(&stdev->mrpc_mutex);
+
+	return rc;
+}
+
+static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
+				  size_t size, loff_t *off)
+{
+	struct switchtec_user *stuser = filp->private_data;
+	struct switchtec_dev *stdev = stuser->stdev;
+	int rc;
+
+	if (!stdev_is_alive(stdev))
+		return -ENXIO;
+
+	if (size < sizeof(stuser->cmd) ||
+	    size >= sizeof(stuser->cmd) + SWITCHTEC_MRPC_PAYLOAD_SIZE)
+		return -EINVAL;
+
+	if (stuser->state == MRPC_IDLE)
+		return -EBADE;
+
+	if (filp->f_flags & O_NONBLOCK) {
+		if (!try_wait_for_completion(&stuser->comp))
+			return -EAGAIN;
+	} else {
+		rc = wait_for_completion_interruptible(&stuser->comp);
+		if (rc < 0)
+			return rc;
+	}
+
+	if (mutex_lock_interruptible(&stdev->mrpc_mutex))
+		return -EINTR;
+
+	if (stuser->state != MRPC_DONE)
+		return -EBADE;
+
+	rc = copy_to_user(data, &stuser->return_code,
+			  sizeof(stuser->return_code));
+	if (rc) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	data += sizeof(stuser->return_code);
+	rc = copy_to_user(data, &stuser->data,
+			  size - sizeof(stuser->return_code));
+	if (rc) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	stuser_set_state(stuser, MRPC_IDLE);
+
+	if (stuser->status == SWITCHTEC_MRPC_STATUS_DONE)
+		rc = size;
+	else if (stuser->status == SWITCHTEC_MRPC_STATUS_INTERRUPTED)
+		rc = -ENXIO;
+	else
+		rc = -EBADMSG;
+
+out:
+	mutex_unlock(&stdev->mrpc_mutex);
+
+	return rc;
+}
+
+static unsigned int switchtec_dev_poll(struct file *filp, poll_table *wait)
+{
+	struct switchtec_user *stuser = filp->private_data;
+	struct switchtec_dev *stdev = stuser->stdev;
+
+	poll_wait(filp, &stuser->comp.wait, wait);
+
+	if (!stdev_is_alive(stdev))
+		return POLLERR;
+
+	if (stuser->state == MRPC_IDLE)
+		return POLLERR;
+	else if (try_wait_for_completion(&stuser->comp))
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+static const struct file_operations switchtec_fops = {
+	.owner = THIS_MODULE,
+	.open = switchtec_dev_open,
+	.release = switchtec_dev_release,
+	.write = switchtec_dev_write,
+	.read = switchtec_dev_read,
+	.poll = switchtec_dev_poll,
+};
+
+static irqreturn_t switchtec_event_isr(int irq, void *dev)
+{
+	struct switchtec_dev *stdev = dev;
+	u32 summary;
+
+	summary = ioread32(&stdev->mmio_part_cfg->part_event_summary);
+
+	if (summary & SWITCHTEC_PART_CFG_EVENT_MRPC_CMP) {
+		schedule_work(&stdev->mrpc_work);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int switchtec_init_msix_isr(struct switchtec_dev *stdev)
+{
+	struct pci_dev *pdev = stdev_pdev(stdev);
+	int rc, i, msix_count, node;
+
+	node = dev_to_node(&pdev->dev);
+
+	stdev->msix = kzalloc_node(4 * sizeof(*stdev->msix),
+				  GFP_KERNEL, node);
+	if (!stdev->msix)
+		return -ENOMEM;
+
+	for (i = 0; i < 4; ++i)
+		stdev->msix[i].entry = i;
+
+	msix_count = pci_enable_msix_range(pdev, stdev->msix, 1, 4);
+	if (msix_count < 0) {
+		rc = msix_count;
+		goto err_msix_enable;
+	}
+
+	stdev->event_irq = ioread32(&stdev->mmio_part_cfg->vep_vector_number);
+	if (stdev->event_irq < 0 || stdev->event_irq >= msix_count) {
+		rc = -EFAULT;
+		goto err_msix_request;
+	}
+
+	rc = request_irq(stdev->msix[stdev->event_irq].vector,
+			 switchtec_event_isr, 0,
+			 "switchtec_event_isr", stdev);
+
+	if (rc)
+		goto err_msix_request;
+
+	dev_dbg(stdev_pdev_dev(stdev), "Using msix interrupts: event_irq=%d\n",
+		stdev->event_irq);
+	return 0;
+
+err_msix_request:
+	pci_disable_msix(pdev);
+err_msix_enable:
+	kfree(stdev->msix);
+	return rc;
+}
+
+static void switchtec_deinit_msix_isr(struct switchtec_dev *stdev)
+{
+	free_irq(stdev->msix[stdev->event_irq].vector, stdev);
+	pci_disable_msix(stdev_pdev(stdev));
+	kfree(stdev->msix);
+}
+
+static int switchtec_init_msi_isr(struct switchtec_dev *stdev)
+{
+	int rc;
+	struct pci_dev *pdev = stdev_pdev(stdev);
+
+	stdev->msix = NULL;
+
+	/* Try to set up msi irq */
+	rc = pci_enable_msi_range(pdev, 1, 4);
+	if (rc < 0)
+		goto err_msi_enable;
+
+	stdev->event_irq = ioread32(&stdev->mmio_part_cfg->vep_vector_number);
+	if (stdev->event_irq < 0 || stdev->event_irq >= 4) {
+		rc = -EFAULT;
+		goto err_msi_request;
+	}
+
+	rc = request_irq(pdev->irq + stdev->event_irq, switchtec_event_isr, 0,
+			 "switchtec_event_isr", stdev);
+	if (rc)
+		goto err_msi_request;
+
+	dev_dbg(stdev_pdev_dev(stdev), "Using msi interrupts: event_irq=%d\n",
+		stdev->event_irq);
+	return 0;
+
+err_msi_request:
+	pci_disable_msi(pdev);
+err_msi_enable:
+	return rc;
+}
+
+static void switchtec_deinit_msi_isr(struct switchtec_dev *stdev)
+{
+	struct pci_dev *pdev = stdev_pdev(stdev);
+
+	free_irq(pdev->irq + stdev->event_irq, stdev);
+	pci_disable_msi(pdev);
+}
+
+static void switchtec_deinit_isr(struct switchtec_dev *stdev)
+{
+	if (stdev->msix)
+		switchtec_deinit_msix_isr(stdev);
+	else
+		switchtec_deinit_msi_isr(stdev);
+}
+
+static int switchtec_init_isr(struct switchtec_dev *stdev)
+{
+	int ret;
+
+	ret = switchtec_init_msix_isr(stdev);
+	if (ret)
+		ret = switchtec_init_msi_isr(stdev);
+
+	return ret;
+}
+
+static int switchtec_init_pci(struct switchtec_dev *stdev,
+			      struct pci_dev *pdev)
+{
+	int rc;
+	int partition;
+
+	pci_set_drvdata(pdev, stdev);
+
+	rc = pci_enable_device(pdev);
+	if (rc)
+		goto err_pci_enable;
+
+	rc = pci_request_regions(pdev, KBUILD_MODNAME);
+	if (rc)
+		goto err_pci_regions;
+
+	pci_set_master(pdev);
+
+	stdev->mmio = pci_iomap(pdev, 0, 0);
+	if (!stdev->mmio) {
+		rc = -EIO;
+		goto err_iomap;
+	}
+
+	stdev->mmio_mrpc = stdev->mmio + SWITCHTEC_GAS_MRPC_OFFSET;
+	stdev->mmio_ntb = stdev->mmio + SWITCHTEC_GAS_NTB_OFFSET;
+	partition = ioread8(&stdev->mmio_ntb->partition_id);
+	stdev->mmio_part_cfg = stdev->mmio + SWITCHTEC_GAS_PART_CFG_OFFSET +
+		sizeof(struct part_cfg_regs) * partition;
+
+	return 0;
+
+err_iomap:
+	pci_clear_master(pdev);
+	pci_release_regions(pdev);
+err_pci_regions:
+	pci_disable_device(pdev);
+err_pci_enable:
+	pci_set_drvdata(pdev, NULL);
+	return rc;
+}
+
+static void switchtec_deinit_pci(struct switchtec_dev *stdev)
+{
+	struct pci_dev *pdev = stdev_pdev(stdev);
+
+	pci_iounmap(pdev, stdev->mmio);
+	stdev->mmio = NULL;
+
+	pci_clear_master(pdev);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static int switchtec_pci_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *id)
+{
+	struct switchtec_dev *stdev;
+	int rc, node;
+
+	node = dev_to_node(&pdev->dev);
+
+	stdev = kzalloc_node(sizeof(*stdev), GFP_KERNEL, node);
+	if (!stdev) {
+		rc = -ENOMEM;
+		goto err_stdev;
+	}
+
+	stdev_init(stdev, pdev);
+
+	rc = switchtec_init_pci(stdev, pdev);
+	if (rc)
+		goto err_init_pci;
+
+	rc = switchtec_init_isr(stdev);
+	if (rc) {
+		dev_err(stdev_pdev_dev(stdev), "failed to init isr.\n");
+		goto err_init_isr;
+	}
+
+	rc = switchtec_register_dev(stdev);
+	if (rc)
+		goto err_register_dev;
+
+	dev_info(stdev_dev(stdev), "Management device registered.\n");
+
+	return 0;
+
+err_register_dev:
+	switchtec_deinit_isr(stdev);
+err_init_isr:
+	switchtec_deinit_pci(stdev);
+err_init_pci:
+	stdev_put(stdev);
+err_stdev:
+	return rc;
+}
+
+static void switchtec_pci_remove(struct pci_dev *pdev)
+{
+	struct switchtec_dev *stdev = pci_get_drvdata(pdev);
+
+	switchtec_deinit_isr(stdev);
+	switchtec_deinit_pci(stdev);
+	stdev_put(stdev);
+}
+
+#define SWITCHTEC_PCI_DEVICE(device_id) \
+	{ \
+		.vendor     = MICROSEMI_VENDOR_ID, \
+		.device     = device_id, \
+		.subvendor  = PCI_ANY_ID, \
+		.subdevice  = PCI_ANY_ID, \
+		.class      = MICROSEMI_MGMT_CLASSCODE, \
+		.class_mask = 0xFFFFFFFF, \
+	}, \
+	{ \
+		.vendor     = MICROSEMI_VENDOR_ID, \
+		.device     = device_id, \
+		.subvendor  = PCI_ANY_ID, \
+		.subdevice  = PCI_ANY_ID, \
+		.class      = MICROSEMI_NTB_CLASSCODE, \
+		.class_mask = 0xFFFFFFFF, \
+	}
+
+static const struct pci_device_id switchtec_pci_tbl[] = {
+	SWITCHTEC_PCI_DEVICE(0x8531),  //PFX 24xG3
+	SWITCHTEC_PCI_DEVICE(0x8532),  //PFX 32xG3
+	SWITCHTEC_PCI_DEVICE(0x8533),  //PFX 48xG3
+	SWITCHTEC_PCI_DEVICE(0x8534),  //PFX 64xG3
+	SWITCHTEC_PCI_DEVICE(0x8535),  //PFX 80xG3
+	SWITCHTEC_PCI_DEVICE(0x8536),  //PFX 96xG3
+	SWITCHTEC_PCI_DEVICE(0x8543),  //PSX 48xG3
+	SWITCHTEC_PCI_DEVICE(0x8544),  //PSX 64xG3
+	SWITCHTEC_PCI_DEVICE(0x8545),  //PSX 80xG3
+	SWITCHTEC_PCI_DEVICE(0x8546),  //PSX 96xG3
+	{0}
+};
+MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
+
+static struct pci_driver switchtec_pci_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= switchtec_pci_tbl,
+	.probe		= switchtec_pci_probe,
+	.remove		= switchtec_pci_remove,
+};
+
+static int __init switchtec_init(void)
+{
+	int rc;
+
+	rc = register_chrdev(0, "switchtec", &switchtec_fops);
+	if (rc < 0)
+		return rc;
+	switchtec_major = rc;
+
+	switchtec_class = class_create(THIS_MODULE, "switchtec");
+	if (IS_ERR(switchtec_class)) {
+		rc = PTR_ERR(switchtec_class);
+		goto err_create_class;
+	}
+
+	rc = pci_register_driver(&switchtec_pci_driver);
+	if (rc)
+		goto err_pci_register;
+
+	pr_info(KBUILD_MODNAME ": loaded.\n");
+
+	return 0;
+
+err_pci_register:
+	class_destroy(switchtec_class);
+
+err_create_class:
+	unregister_chrdev(switchtec_major, "switchtec");
+
+	return rc;
+}
+module_init(switchtec_init);
+
+static void __exit switchtec_exit(void)
+{
+	pci_unregister_driver(&switchtec_pci_driver);
+	class_destroy(switchtec_class);
+	unregister_chrdev(switchtec_major, "switchtec");
+	ida_destroy(&switchtec_minor_ida);
+
+	pr_info(KBUILD_MODNAME ": unloaded.\n");
+}
+module_exit(switchtec_exit);
diff --git a/drivers/pci/switch/switchtec.h b/drivers/pci/switch/switchtec.h
new file mode 100644
index 0000000..10a9909
--- /dev/null
+++ b/drivers/pci/switch/switchtec.h
@@ -0,0 +1,119 @@
+/*
+ * Microsemi Switchtec PCIe Driver
+ * Copyright (c) 2016, Microsemi Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#ifndef SWITCHTEC_H
+#define SWITCHTEC_H
+
+#include <linux/pci.h>
+
+#define MICROSEMI_VENDOR_ID         0x11f8
+#define MICROSEMI_NTB_CLASSCODE     0x068000
+#define MICROSEMI_MGMT_CLASSCODE    0x058000
+
+#define SWITCHTEC_MRPC_PAYLOAD_SIZE 1024
+
+enum {
+	SWITCHTEC_GAS_MRPC_OFFSET       = 0x0000,
+	SWITCHTEC_GAS_TOP_CFG_OFFSET    = 0x1000,
+	SWITCHTEC_GAS_SW_EVENT_OFFSET   = 0x1800,
+	SWITCHTEC_GAS_PART_CFG_OFFSET   = 0x4000,
+	SWITCHTEC_GAS_NTB_OFFSET        = 0x10000,
+	SWITCHTEC_GAS_PFF_CSR_OFFSET    = 0x134000,
+};
+
+struct mrpc_regs {
+	u8 input_data[SWITCHTEC_MRPC_PAYLOAD_SIZE];
+	u8 output_data[SWITCHTEC_MRPC_PAYLOAD_SIZE];
+	u32 cmd;
+	u32 status;
+	u32 ret_value;
+} __packed;
+
+enum mrpc_status {
+	SWITCHTEC_MRPC_STATUS_INPROGRESS = 1,
+	SWITCHTEC_MRPC_STATUS_DONE = 2,
+	SWITCHTEC_MRPC_STATUS_ERROR = 0xFF,
+	SWITCHTEC_MRPC_STATUS_INTERRUPTED = 0x100,
+};
+
+struct ntb_info_regs {
+	u8  partition_count;
+	u8  partition_id;
+	u16 reserved1;
+	u64 ep_map;
+	u16 requester_id;
+} __packed;
+
+struct part_cfg_regs {
+	u32 status;
+	u32 state;
+	u32 port_cnt;
+	u32 usp_port_mode;
+	u32 usp_pff_inst_id;
+	u32 vep_pff_inst_id;
+	u32 dsp_inst_id[47];
+	u32 reserved1[11];
+	u16 vep_vector_number;
+	u16 usp_vector_number;
+	u32 port_event_bitmap;
+	u32 reserved2[3];
+	u32 part_event_summary;
+	u32 reserved3[3];
+	u32 part_reset_event_hdr;
+	u8  part_reset_event_data[20];
+	u32 mrpc_completion_hdr;
+	u8  mrpc_completion_data[20];
+	u32 mrpc_completion_async_hdr;
+	u8  mrpc_completion_async_data[20];
+	u32 dynamic_part_binding_evt_hdr;
+	u8 dynamic_part_binding_evt_data[20];
+	u32 reserved4[159];
+} __packed;
+
+enum {
+	SWITCHTEC_PART_CFG_EVENT_MRPC_CMP = 2,
+	SWITCHTEC_PART_CFG_EVENT_MRPC_ASYNC_CMP = 4,
+};
+
+struct switchtec_dev {
+	struct pci_dev *pdev;
+	struct msix_entry *msix;
+	struct device *dev;
+	struct kref kref;
+
+	unsigned int event_irq;
+
+	void __iomem *mmio;
+	struct mrpc_regs __iomem *mmio_mrpc;
+	struct ntb_info_regs __iomem *mmio_ntb;
+	struct part_cfg_regs __iomem *mmio_part_cfg;
+
+	/*
+	 * The mrpc mutex must be held when accessing the other
+	 * mrpc fields
+	 */
+	struct mutex mrpc_mutex;
+	struct list_head mrpc_queue;
+	int mrpc_busy;
+	struct work_struct mrpc_work;
+	struct delayed_work mrpc_timeout;
+};
+
+#define stdev_pdev(stdev) ((stdev)->pdev)
+#define stdev_pdev_dev(stdev) (&stdev_pdev(stdev)->dev)
+#define stdev_name(stdev) pci_name(stdev_pdev(stdev))
+#define stdev_dev(stdev) ((stdev)->dev)
+
+#endif
-- 
2.1.4

