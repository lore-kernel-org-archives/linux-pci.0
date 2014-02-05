Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <52F1A26F.3020105@gmail.com>
Date: Tue, 04 Feb 2014 18:31:11 -0800
From: Rajat Jain <rajatxjain@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>
CC: Guenter Roeck <groeck@juniper.net>,
	Rajat Jain <rajatjain@juniper.net>,
	Rajat Jain <rajatxjain@gmail.com>
Subject: [PATCH v4 8/8] pciehp: Introduce hotplug_lock to serialize HP events
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Today it is there is no protection around pciehp_enable_slot() and
pciehp_disable_slot() to ensure that they complete before another
hot-plug operation can be done on that particular slot.

This patch introduces the slot->hotplug_lock to ensure that any
hotplug operations (add / remove) complete before another HP event
can begin processing on that particular slot.

Signed-off-by: Rajat Jain <rajatxjain@gmail.com>
Signed-off-by: Rajat Jain <rajatjain@juniper.net>
Signed-off-by: Guenter Roeck <groeck@juniper.net>
---
 drivers/pci/hotplug/pciehp.h      |    1 +
 drivers/pci/hotplug/pciehp_core.c |    7 ++++++-
 drivers/pci/hotplug/pciehp_ctrl.c |   14 +++++++++++++-
 drivers/pci/hotplug/pciehp_hpc.c  |    1 +
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index d8d0336..8a66866 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -76,6 +76,7 @@ struct slot {
 	struct hotplug_slot *hotplug_slot;
 	struct delayed_work work;	/* work for button event */
 	struct mutex lock;
+	struct mutex hotplug_lock;
 	struct workqueue_struct *wq;
 };
 
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 53b58de..23b4bde 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -283,8 +283,11 @@ static int pciehp_probe(struct pcie_device *dev)
 	slot = ctrl->slot;
 	pciehp_get_adapter_status(slot, &occupied);
 	pciehp_get_power_status(slot, &poweron);
-	if (occupied && pciehp_force)
+	if (occupied && pciehp_force) {
+		mutex_lock(&slot->hotplug_lock);
 		pciehp_enable_slot(slot);
+		mutex_unlock(&slot->hotplug_lock);
+	}
 	/* If empty slot's power status is on, turn power off */
 	if (!occupied && poweron && POWER_CTRL(ctrl))
 		pciehp_power_off_slot(slot);
@@ -328,10 +331,12 @@ static int pciehp_resume (struct pcie_device *dev)
 
 	/* Check if slot is occupied */
 	pciehp_get_adapter_status(slot, &status);
+	mutex_lock(&slot->hotplug_lock);
 	if (status)
 		pciehp_enable_slot(slot);
 	else
 		pciehp_disable_slot(slot);
+	mutex_unlock(&slot->hotplug_lock);
 	return 0;
 }
 #endif /* PM */
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 3e40ec0..1f2716c 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -293,6 +293,7 @@ static void pciehp_power_thread(struct work_struct *work)
 	struct power_work_info *info =
 		container_of(work, struct power_work_info, work);
 	struct slot *p_slot = info->p_slot;
+	int ret;
 
 	switch (info->req) {
 	case DISABLE_REQ:
@@ -300,7 +301,9 @@ static void pciehp_power_thread(struct work_struct *work)
 			 "Disabling domain:bus:device=%04x:%02x:00\n",
 			 pci_domain_nr(p_slot->ctrl->pcie->port->subordinate),
 			 p_slot->ctrl->pcie->port->subordinate->number);
+		mutex_lock(&p_slot->hotplug_lock);
 		pciehp_disable_slot(p_slot);
+		mutex_unlock(&p_slot->hotplug_lock);
 		mutex_lock(&p_slot->lock);
 		p_slot->state = STATIC_STATE;
 		mutex_unlock(&p_slot->lock);
@@ -310,8 +313,10 @@ static void pciehp_power_thread(struct work_struct *work)
 			 "Enabling domain:bus:device=%04x:%02x:00\n",
 			 pci_domain_nr(p_slot->ctrl->pcie->port->subordinate),
 			 p_slot->ctrl->pcie->port->subordinate->number);
+		mutex_lock(&p_slot->hotplug_lock);
 		if (pciehp_enable_slot(p_slot))
 			pciehp_green_led_off(p_slot);
+		mutex_unlock(&p_slot->hotplug_lock);
 		mutex_lock(&p_slot->lock);
 		p_slot->state = STATIC_STATE;
 		mutex_unlock(&p_slot->lock);
@@ -546,6 +551,9 @@ static void interrupt_event_handler(struct work_struct *work)
 	kfree(info);
 }
 
+/*
+ * Note: This function must be called with slot->hotplug_lock held
+ */
 int pciehp_enable_slot(struct slot *p_slot)
 {
 	u8 getstatus = 0;
@@ -584,7 +592,9 @@ int pciehp_enable_slot(struct slot *p_slot)
 	return rc;
 }
 
-
+/*
+ * Note: This function must be called with slot->hotplug_lock held
+ */
 int pciehp_disable_slot(struct slot *p_slot)
 {
 	u8 getstatus = 0;
@@ -617,7 +627,9 @@ int pciehp_sysfs_enable_slot(struct slot *p_slot)
 	case STATIC_STATE:
 		p_slot->state = POWERON_STATE;
 		mutex_unlock(&p_slot->lock);
+		mutex_lock(&p_slot->hotplug_lock);
 		retval = pciehp_enable_slot(p_slot);
+		mutex_unlock(&p_slot->hotplug_lock);
 		mutex_lock(&p_slot->lock);
 		p_slot->state = STATIC_STATE;
 		break;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 6433e73..da4b020 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -686,6 +686,7 @@ static int pcie_init_slot(struct controller *ctrl)
 
 	slot->ctrl = ctrl;
 	mutex_init(&slot->lock);
+	mutex_init(&slot->hotplug_lock);
 	INIT_DELAYED_WORK(&slot->work, pciehp_queue_pushbutton_work);
 	ctrl->slot = slot;
 	return 0;
-- 
1.7.9.5

