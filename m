Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751875AbdJFN2S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Oct 2017 09:28:18 -0400
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        gabriele.paoloni@huawei.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com
Subject: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to and from devices
Date: Fri,  6 Oct 2017 14:31:32 +0100
Message-Id: <20171006133203.22803-6-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add bind and unbind operations to the IOMMU API. Device drivers can use
them to share process page tables with their device.
iommu_process_bind_group is provided for VFIO's convenience, as it needs
to provide a coherent interface on containers. Device drivers will most
likely want to use iommu_process_bind_device, which doesn't bind the whole
group.

PASIDs are de facto shared between all devices in a group (because of
hardware weaknesses), but we don't do anything about it at the API level.
Making bind_device call bind_group is probably the wrong way around,
because it requires more work on our side for no benefit. We'd have to
replay all binds each time a device is hotplugged into a group. But when a
device is hotplugged into a group, the device driver will have to do a
bind before using its PASID anyway and we can reject inconsistencies at
that point.

Concurrent calls to iommu_process_bind_device for the same process are not
supported at the moment (they'll race on process_alloc which will only
succeed for the first one; the others will have to retry the bind). I also
don't support calling bind() on a dying process, not sure if it matters.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu-process.c | 165 ++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c         |  64 ++++++++++++++++
 include/linux/iommu.h         |  41 +++++++++++
 3 files changed, 270 insertions(+)

diff --git a/drivers/iommu/iommu-process.c b/drivers/iommu/iommu-process.c
index 1ef3f55b962b..dee7691e3791 100644
--- a/drivers/iommu/iommu-process.c
+++ b/drivers/iommu/iommu-process.c
@@ -411,6 +411,171 @@ static struct mmu_notifier_ops iommu_process_mmu_notfier = {
 };
 
 /**
+ * iommu_process_bind_device - Bind a process address space to a device
+ * @dev: the device
+ * @task: the process to bind
+ * @pasid: valid address where the PASID will be stored
+ * @flags: bond properties (IOMMU_PROCESS_BIND_*)
+ *
+ * Create a bond between device and task, allowing the device to access the
+ * process address space using the returned PASID.
+ *
+ * On success, 0 is returned and @pasid contains a valid ID. Otherwise, an error
+ * is returned.
+ */
+int iommu_process_bind_device(struct device *dev, struct task_struct *task,
+			      int *pasid, int flags)
+{
+	int err, i;
+	int nesting;
+	struct pid *pid;
+	struct iommu_domain *domain;
+	struct iommu_process *process;
+	struct iommu_context *cur_context;
+	struct iommu_context *context = NULL;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (WARN_ON(!domain))
+		return -EINVAL;
+
+	if (!iommu_domain_get_attr(domain, DOMAIN_ATTR_NESTING, &nesting) &&
+	    nesting)
+		return -EINVAL;
+
+	pid = get_task_pid(task, PIDTYPE_PID);
+	if (!pid)
+		return -EINVAL;
+
+	/* If an iommu_process already exists, use it */
+	spin_lock(&iommu_process_lock);
+	idr_for_each_entry(&iommu_process_idr, process, i) {
+		if (process->pid != pid)
+			continue;
+
+		if (!iommu_process_get_locked(process)) {
+			/* Process is defunct, create a new one */
+			process = NULL;
+			break;
+		}
+
+		/* Great, is it also bound to this domain? */
+		list_for_each_entry(cur_context, &process->domains,
+				    process_head) {
+			if (cur_context->domain != domain)
+				continue;
+
+			context = cur_context;
+			*pasid = process->pasid;
+
+			/* Splendid, tell the driver and increase the ref */
+			err = iommu_process_attach_locked(context, dev);
+			if (err)
+				iommu_process_put_locked(process);
+
+			break;
+		}
+		break;
+	}
+	spin_unlock(&iommu_process_lock);
+	put_pid(pid);
+
+	if (context)
+		return err;
+
+	if (!process) {
+		process = iommu_process_alloc(domain, task);
+		if (IS_ERR(process))
+			return PTR_ERR(process);
+	}
+
+	err = iommu_process_attach(domain, dev, process);
+	if (err) {
+		iommu_process_put(process);
+		return err;
+	}
+
+	*pasid = process->pasid;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_process_bind_device);
+
+/**
+ * iommu_process_unbind_device - Remove a bond created with
+ * iommu_process_bind_device.
+ *
+ * @dev: the device
+ * @pasid: the pasid returned by bind
+ */
+int iommu_process_unbind_device(struct device *dev, int pasid)
+{
+	struct iommu_domain *domain;
+	struct iommu_process *process;
+	struct iommu_context *cur_context;
+	struct iommu_context *context = NULL;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (WARN_ON(!domain))
+		return -EINVAL;
+
+	/*
+	 * Caller stopped the device from issuing PASIDs, now make sure they are
+	 * out of the fault queue.
+	 */
+	iommu_fault_queue_flush(dev);
+
+	spin_lock(&iommu_process_lock);
+	process = idr_find(&iommu_process_idr, pasid);
+	if (!process) {
+		spin_unlock(&iommu_process_lock);
+		return -ESRCH;
+	}
+
+	list_for_each_entry(cur_context, &process->domains, process_head) {
+		if (cur_context->domain == domain) {
+			context = cur_context;
+			break;
+		}
+	}
+
+	if (context)
+		iommu_process_detach_locked(context, dev);
+	spin_unlock(&iommu_process_lock);
+
+	return context ? 0 : -ESRCH;
+}
+EXPORT_SYMBOL_GPL(iommu_process_unbind_device);
+
+/*
+ * __iommu_process_unbind_dev_all - Detach all processes attached to this
+ * device.
+ *
+ * When detaching @device from @domain, IOMMU drivers have to use this function.
+ */
+void __iommu_process_unbind_dev_all(struct iommu_domain *domain, struct device *dev)
+{
+	struct iommu_context *context, *next;
+
+	/* Ask device driver to stop using all PASIDs */
+	spin_lock(&iommu_process_lock);
+	if (domain->process_exit) {
+		list_for_each_entry(context, &domain->processes, domain_head)
+			domain->process_exit(domain, dev,
+					     context->process->pasid,
+					     domain->process_exit_token);
+	}
+	spin_unlock(&iommu_process_lock);
+
+	iommu_fault_queue_flush(dev);
+
+	spin_lock(&iommu_process_lock);
+	list_for_each_entry_safe(context, next, &domain->processes, domain_head)
+		iommu_process_detach_locked(context, dev);
+	spin_unlock(&iommu_process_lock);
+}
+EXPORT_SYMBOL_GPL(__iommu_process_unbind_dev_all);
+
+/**
  * iommu_set_process_exit_handler() - set a callback for stopping the use of
  * PASID in a device.
  * @dev: the device
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b2b34cf7c978..f9cb89dd28f5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1460,6 +1460,70 @@ void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_detach_group);
 
+/*
+ * iommu_process_bind_group - Share process address space with all devices in
+ * the group.
+ * @group: the iommu group
+ * @task: the process to bind
+ * @pasid: valid address where the PASID will be stored
+ * @flags: bond properties (IOMMU_PROCESS_BIND_*)
+ *
+ * Create a bond between group and process, allowing devices in the group to
+ * access the process address space using @pasid.
+ *
+ * On success, 0 is returned and @pasid contains a valid ID. Otherwise, an error
+ * is returned.
+ */
+int iommu_process_bind_group(struct iommu_group *group,
+			     struct task_struct *task, int *pasid, int flags)
+{
+	struct group_device *device;
+	int ret = -ENODEV;
+
+	if (!pasid)
+		return -EINVAL;
+
+	if (!group->domain)
+		return -EINVAL;
+
+	mutex_lock(&group->mutex);
+	list_for_each_entry(device, &group->devices, list) {
+		ret = iommu_process_bind_device(device->dev, task, pasid,
+						flags);
+		if (ret)
+			break;
+	}
+
+	if (ret) {
+		list_for_each_entry_continue_reverse(device, &group->devices, list)
+			iommu_process_unbind_device(device->dev, *pasid);
+	}
+	mutex_unlock(&group->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_process_bind_group);
+
+/**
+ * iommu_process_unbind_group - Remove a bond created with
+ * iommu_process_bind_group
+ *
+ * @group: the group
+ * @pasid: the pasid returned by bind
+ */
+int iommu_process_unbind_group(struct iommu_group *group, int pasid)
+{
+	struct group_device *device;
+
+	mutex_lock(&group->mutex);
+	list_for_each_entry(device, &group->devices, list)
+		iommu_process_unbind_device(device->dev, pasid);
+	mutex_unlock(&group->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_process_unbind_group);
+
 phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
 	if (unlikely(domain->ops->iova_to_phys == NULL))
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 42b818437fa1..e64c2711ea8d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -454,6 +454,10 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
+extern int iommu_process_bind_group(struct iommu_group *group,
+				    struct task_struct *task, int *pasid,
+				    int flags);
+extern int iommu_process_unbind_group(struct iommu_group *group, int pasid);
 
 #else /* CONFIG_IOMMU_API */
 
@@ -739,6 +743,19 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline int iommu_process_bind_group(struct iommu_group *group,
+					   struct task_struct *task, int *pasid,
+					   int flags)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_process_unbind_group(struct iommu_group *group,
+					     int pasid)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_PROCESS
@@ -747,6 +764,12 @@ extern void iommu_set_process_exit_handler(struct device *dev,
 					   void *token);
 extern struct iommu_process *iommu_process_find(int pasid);
 extern void iommu_process_put(struct iommu_process *process);
+extern int iommu_process_bind_device(struct device *dev,
+				     struct task_struct *task, int *pasid,
+				     int flags);
+extern int iommu_process_unbind_device(struct device *dev, int pasid);
+extern void __iommu_process_unbind_dev_all(struct iommu_domain *domain,
+					   struct device *dev);
 
 #else /* CONFIG_IOMMU_PROCESS */
 static inline void iommu_set_process_exit_handler(struct device *dev,
@@ -763,6 +786,24 @@ static inline struct iommu_process *iommu_process_find(int pasid)
 static inline void iommu_process_put(struct iommu_process *process)
 {
 }
+
+static inline int iommu_process_bind_device(struct device *dev,
+					    struct task_struct *task,
+					    int *pasid, int flags)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_process_unbind_device(struct device *dev, int pasid)
+{
+	return -ENODEV;
+}
+
+static inline void __iommu_process_unbind_dev_all(struct iommu_domain *domain,
+						  struct device *dev)
+{
+}
+
 #endif /* CONFIG_IOMMU_PROCESS */
 
 #endif /* __LINUX_IOMMU_H */
-- 
2.13.3
