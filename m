Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BFA30C606;
	Thu, 24 Sep 2026 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230554; cv=none; b=rEqAfLbV6Hm1Q2ECZtjgshhbseCzNoaUKLvl9FJuglJjxZTkbzFd8SEa2uFme0aKqgfCpT2BlEOlerQPZCyT1uWoF7Hh5hnWaxFnBux0+esnmPTb0cpNnu30x9st1DbrRiIdElw3TVDrJlG/1/txZkG+b+v1Rt6E46urrKBfqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230554; c=relaxed/simple;
	bh=UbMWoKe6pqT353V/GlqBxI/KJSnu/EKkAA1ahBadfmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIQ6XQRzZCN7u5E7C0Ey2RGQBZJ+IriFs/RYMFivj1/ipTZnLc2hbeegIHELmWDrwfgs8dOiK4/rDq+1H13+WQOMu3otiu8ynME/lUuTOC6Ogn5UqUbGx/wpI++9FyBHIkC6ZiMjUkIzyocdl/3vnUY2XlZTCBL4LIeVjOLYBC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.9243626|0.8991501;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_system_inform|0.0183685-0.000289767-0.981342;FP=5974062528137348283|4|2|2|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=liaoxuan@open-hieco.net;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jLtpcA7_1790230539;
Received: from Ubuntu2404-XLH.hygon.cn(mailfrom:liaoxuan@open-hieco.net fp:SMTPD_---.jLtpcA7_1790230539 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 14:15:42 +0800
From: Liao Xuan <liaoxuan@open-hieco.net>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Liao Xuan <liaoxuan@open-hieco.net>
Subject: [PATCH 3/3] nvme: Expose link rate switching tunables via sysfs
Date: Thu, 24 Sep 2026 14:15:13 +0800
Message-ID: <be224cd8385a5c28a20db65d635000a7be4da91a.1790222172.git.liaoxuan@hygon.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790222172.git.liaoxuan@hygon.cn>
References: <cover.1790222172.git.liaoxuan@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a speed attribute group under /sys/class/nvme/nvmeX/ that
exposes the adaptive link rate switching parameters for runtime tuning:

  enable           - toggle the feature on/off (0/1)
  monitor_interval - I/O monitoring window in milliseconds (>= 100)
  min_speed        - minimum PCIe generation to downgrade to (1-5)
  up_threshold     - windows above the threshold needed to upgrade
  down_threshold   - windows below the threshold needed to downgrade

The attributes are read/write and are removed when the controller is
torn down.

Signed-off-by: Liao Xuan <liaoxuan@open-hieco.net>
---
 drivers/nvme/host/nvme.h         |   3 +
 drivers/nvme/host/speed_switch.c |  15 +++-
 drivers/nvme/host/sysfs.c        | 143 +++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5d5034601..fb958ff13 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1076,6 +1076,9 @@ extern const struct attribute_group nvme_dev_attrs_group;
 extern const struct attribute_group nvme_dev_diag_attrs_group;
 extern const struct attribute_group *nvme_subsys_attrs_groups[];
 extern const struct attribute_group *nvme_dev_attr_groups[];
+#ifdef CONFIG_NVME_SPEED_SWITCH
+extern const struct attribute_group nvme_speed_attr_group;
+#endif
 extern const struct block_device_operations nvme_bdev_ops;
 
 void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/speed_switch.c b/drivers/nvme/host/speed_switch.c
index 22f180c81..fce426845 100644
--- a/drivers/nvme/host/speed_switch.c
+++ b/drivers/nvme/host/speed_switch.c
@@ -325,7 +325,7 @@ void nvme_speed_switch_init(struct nvme_ctrl *ctrl)
 {
 	struct nvme_speed_switch *sw = &ctrl->speed_switch;
 	struct pci_dev *pdev;
-	int max_speed;
+	int max_speed, ret;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_HYGON) {
 		dev_dbg(ctrl->device,
@@ -376,6 +376,18 @@ void nvme_speed_switch_init(struct nvme_ctrl *ctrl)
 	timer_setup(&sw->timer, nvme_speed_switch_timer_fn, 0);
 	atomic_set(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE);
 	WRITE_ONCE(sw->enabled, true);
+
+	ret = sysfs_create_group(&ctrl->device->kobj, &nvme_speed_attr_group);
+	if (ret) {
+		dev_err(ctrl->device,
+			"failed to create link rate switching sysfs group (%d)\n",
+			ret);
+		timer_delete_sync(&sw->timer);
+		free_percpu(sw->stats);
+		sw->stats = NULL;
+		WRITE_ONCE(sw->enabled, false);
+		return;
+	}
 	sw->initialized = true;
 
 	dev_info(ctrl->device,
@@ -405,6 +417,7 @@ void nvme_speed_switch_exit(struct nvme_ctrl *ctrl)
 	WRITE_ONCE(sw->enabled, false);
 	timer_delete_sync(&sw->timer);
 	cancel_work_sync(&sw->work);
+	sysfs_remove_group(&ctrl->device->kobj, &nvme_speed_attr_group);
 
 	free_percpu(sw->stats);
 	sw->stats = NULL;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 75b2d69b5..cd899b87b 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -1308,3 +1308,146 @@ const struct attribute_group *nvme_subsys_attrs_groups[] = {
 	&nvme_subsys_attrs_group,
 	NULL,
 };
+
+#ifdef CONFIG_NVME_SPEED_SWITCH
+enum nvme_speed_attr_id {
+	NVME_SPEED_ATTR_ENABLE,
+	NVME_SPEED_ATTR_MONITOR_INTERVAL,
+	NVME_SPEED_ATTR_MIN_SPEED,
+	NVME_SPEED_ATTR_UP_THRESHOLD,
+	NVME_SPEED_ATTR_DOWN_THRESHOLD,
+};
+
+struct nvme_speed_attr {
+	struct device_attribute attr;
+	enum nvme_speed_attr_id id;
+};
+
+static ssize_t nvme_speed_attr_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_speed_switch *sw = &ctrl->speed_switch;
+	struct nvme_speed_attr *sa =
+		container_of(attr, struct nvme_speed_attr, attr);
+	u32 val;
+
+	switch (sa->id) {
+	case NVME_SPEED_ATTR_ENABLE:
+		val = READ_ONCE(sw->enabled);
+		break;
+	case NVME_SPEED_ATTR_MONITOR_INTERVAL:
+		val = READ_ONCE(sw->monitor_interval);
+		break;
+	case NVME_SPEED_ATTR_MIN_SPEED:
+		val = READ_ONCE(sw->min_speed);
+		break;
+	case NVME_SPEED_ATTR_UP_THRESHOLD:
+		val = READ_ONCE(sw->up_threshold);
+		break;
+	case NVME_SPEED_ATTR_DOWN_THRESHOLD:
+		val = READ_ONCE(sw->down_threshold);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t nvme_speed_attr_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_speed_switch *sw = &ctrl->speed_switch;
+	struct nvme_speed_attr *sa =
+		container_of(attr, struct nvme_speed_attr, attr);
+	u32 val;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	switch (sa->id) {
+	case NVME_SPEED_ATTR_ENABLE:
+		if (val > 1)
+			return -EINVAL;
+		if (!val && READ_ONCE(sw->enabled)) {
+			WRITE_ONCE(sw->enabled, false);
+			timer_delete_sync(&sw->timer);
+			cancel_work_sync(&sw->work);
+			atomic_set(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE);
+		} else
+			WRITE_ONCE(sw->enabled, val);
+		break;
+	case NVME_SPEED_ATTR_MONITOR_INTERVAL:
+		if (val < 100)
+			return -EINVAL;
+		WRITE_ONCE(sw->monitor_interval, val);
+		break;
+	case NVME_SPEED_ATTR_MIN_SPEED:
+		if (val < 1 || val > 5)
+			return -EINVAL;
+		if (val > sw->max_speed)
+			val = sw->max_speed;
+		WRITE_ONCE(sw->min_speed, val);
+		break;
+	case NVME_SPEED_ATTR_UP_THRESHOLD:
+		WRITE_ONCE(sw->up_threshold, val);
+		break;
+	case NVME_SPEED_ATTR_DOWN_THRESHOLD:
+		WRITE_ONCE(sw->down_threshold, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static struct nvme_speed_attr nvme_speed_attr_enable = {
+	.attr = __ATTR(enable, 0644,
+		       nvme_speed_attr_show, nvme_speed_attr_store),
+	.id = NVME_SPEED_ATTR_ENABLE,
+};
+
+static struct nvme_speed_attr nvme_speed_attr_monitor_interval = {
+	.attr = __ATTR(monitor_interval, 0644,
+		       nvme_speed_attr_show, nvme_speed_attr_store),
+	.id = NVME_SPEED_ATTR_MONITOR_INTERVAL,
+};
+
+static struct nvme_speed_attr nvme_speed_attr_min_speed = {
+	.attr = __ATTR(min_speed, 0644,
+		       nvme_speed_attr_show, nvme_speed_attr_store),
+	.id = NVME_SPEED_ATTR_MIN_SPEED,
+};
+
+static struct nvme_speed_attr nvme_speed_attr_up_threshold = {
+	.attr = __ATTR(up_threshold, 0644,
+		       nvme_speed_attr_show, nvme_speed_attr_store),
+	.id = NVME_SPEED_ATTR_UP_THRESHOLD,
+};
+
+static struct nvme_speed_attr nvme_speed_attr_down_threshold = {
+	.attr = __ATTR(down_threshold, 0644,
+		       nvme_speed_attr_show, nvme_speed_attr_store),
+	.id = NVME_SPEED_ATTR_DOWN_THRESHOLD,
+};
+
+static struct attribute *nvme_speed_attrs[] = {
+	&nvme_speed_attr_enable.attr.attr,
+	&nvme_speed_attr_monitor_interval.attr.attr,
+	&nvme_speed_attr_min_speed.attr.attr,
+	&nvme_speed_attr_up_threshold.attr.attr,
+	&nvme_speed_attr_down_threshold.attr.attr,
+	NULL,
+};
+
+const struct attribute_group nvme_speed_attr_group = {
+	.name = "speed",
+	.attrs = nvme_speed_attrs,
+};
+#endif /* CONFIG_NVME_SPEED_SWITCH */
-- 
2.43.0

