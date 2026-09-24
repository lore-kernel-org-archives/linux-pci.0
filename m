Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E94052B5;
	Thu, 24 Sep 2026 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230556; cv=none; b=BZ/mWvTqXBdD6/+z8Pitj7pWZmc8aD358BXzKF127aP0a8x/2vNWqkZm2STAOOY3MoDI2Tvht8eKmb6RG5Bwjg23dUGVhkTAy06iVc1nYK6ewW2g9dEdYJF27qyh/pm6yrGndObZAvlBC73aX57LQ+XVhYZsNH9vfD6A7Etky9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230556; c=relaxed/simple;
	bh=/+r8BjdshQLpVadcRaPohuwWG5BuqJvHdxd9EFpIYYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aD58fzoFMXHtv/8Oz9+z8ag2rPn+4K+VdNvCgZcL3R2nnqCv7Pyq8SFRLQq0lG+sAWhBYI43/u238urJ1OAr3leYMfQmOKI0w5+gyhe7I+tzAa+b9+9x5EiUS6TmEd6p4uFjuYb8mpB9pdTktlWy56VuD+gU2hITTL/nf6xf+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.9243626|0.09915012;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.00916686-0.00211984-0.988713;FP=4531310025125743281|4|2|3|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=liaoxuan@open-hieco.net;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jLtpbp4_1790230522;
Received: from Ubuntu2404-XLH.hygon.cn(mailfrom:liaoxuan@open-hieco.net fp:SMTPD_---.jLtpbp4_1790230522 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 14:15:32 +0800
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
	Liao Xuan <liaoxuan@open-hieco.net>,
	Zheng Tan <tanzheng@kylinos.cn>
Subject: [PATCH 1/3] nvme: Add adaptive PCIe link rate switching function
Date: Thu, 24 Sep 2026 14:15:11 +0800
Message-ID: <9e99e007bf05a608b1b82da740c2b33935a27175.1790222172.git.liaoxuan@hygon.cn>
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

Add support for dynamically adjusting the PCIe link rate of NVMe
devices based on I/O activity. The link is downgraded to a
configurable minimum rate during periods of low activity to save
power, and upgraded to the maximum supported rate as soon as the
workload exceeds a computed threshold, so that peak performance is
maintained under load.

The amount of transferred data is accumulated on the I/O submission
path and aggregated by a per-controller timer. The threshold is
derived from the bandwidth of the minimum and maximum rates such that
the extra time required to transfer the data at the minimum rate does
not exceed the estimated link retraining time.

The feature is currently only supported on Hygon platforms.

Four NVMe devices were tested on the link with this patch. The power
benefit was measured by sampling the voltage and current of the power
monitor every 1 second, each run lasted 3 minutes and the test was
repeated 5 times.

Test run    Power Benefit(w)
1           5.3236
2           5.2285
3           5.4176
4           5.4538
5           5.3444
Average     5.3536

The adaptive link rate switching saves about 5.3w of system power
on average.

The feature was tested with Gen1 as the minimum link rate. The workload
runs 10 seconds of random read followed by 0.5 seconds of idle, repeated
100 times.

                              Avg IOPS (k)  Avg BW (GiB/s)  Avg clat (us)
With speed switching          2671.2        10.19           378.1
Without speed switching       2681.5        10.23           377.0

The differences are within measurement noise (< 0.5%), which shows
that the adaptive link rate switching does not degrade the baseline
performance and keeps the I/O stable.

In summary, the adaptive link rate switching keeps the I/O performance
essentially unchanged (the differences in IOPS, bandwidth and latency
are all within 0.5% measurement noise) while saving about 5w of
system power, providing an effective way to reduce the platform power
consumption under light I/O without sacrificing throughput or latency.

Signed-off-by: Liao Xuan <liaoxuan@open-hieco.net>
Signed-off-by: Zheng Tan <tanzheng@kylinos.cn>
---
 drivers/nvme/host/Kconfig        |  10 +
 drivers/nvme/host/Makefile       |   1 +
 drivers/nvme/host/core.c         |   4 +
 drivers/nvme/host/nvme.h         |  42 ++++
 drivers/nvme/host/pci.c          |   4 +
 drivers/nvme/host/speed_switch.c | 371 +++++++++++++++++++++++++++++++
 drivers/pci/pcie/bwctrl.c        |   1 +
 7 files changed, 433 insertions(+)
 create mode 100644 drivers/nvme/host/speed_switch.c

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 31974c7dd..098ec7abb 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -134,3 +134,13 @@ config NVME_APPLE
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvme-apple.
+
+config NVME_SPEED_SWITCH
+	bool "NVMe adaptive PCIe link rate switching"
+	depends on BLK_DEV_NVME && X86
+	help
+	  This provides support for dynamic PCIe link rate switching for NVMe
+	  devices. When enabled, the NVMe driver can dynamically adjust the
+	  PCIe link speed and width based on workload requirement.
+
+	  If unsure, say N.
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 6414ec968..f33e804e9 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -18,6 +18,7 @@ nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
 nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
 nvme-core-$(CONFIG_NVME_HWMON)		+= hwmon.o
 nvme-core-$(CONFIG_NVME_HOST_AUTH)	+= auth.o
+nvme-core-$(CONFIG_NVME_SPEED_SWITCH)	+= speed_switch.o
 
 nvme-y					+= pci.o
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2..f190dd05e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4627,6 +4627,7 @@ static void nvme_scan_work(struct work_struct *work)
 		/* Re-read the ANA log page to not miss updates */
 		queue_work(nvme_wq, &ctrl->ana_work);
 #endif
+	nvme_speed_switch_start(ctrl);
 }
 
 /*
@@ -5051,6 +5052,7 @@ EXPORT_SYMBOL_GPL(nvme_remove_io_tag_set);
 
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
+	nvme_speed_switch_exit(ctrl);
 	nvme_mpath_stop(ctrl);
 	nvme_auth_stop(ctrl);
 	nvme_stop_failfast_work(ctrl);
@@ -5266,6 +5268,8 @@ int nvme_add_ctrl(struct nvme_ctrl *ctrl)
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
 	nvme_get_ctrl(ctrl);
 
+	nvme_speed_switch_init(ctrl);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_add_ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824651cc8..ff06f85d1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -331,6 +331,33 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_FROZEN		= 6,
 };
 
+#ifdef CONFIG_NVME_SPEED_SWITCH
+struct nvme_speed_switch_stats {
+	u64 read_bytes;
+	u64 write_bytes;
+};
+
+struct nvme_speed_switch {
+	bool initialized;
+	bool enabled;
+	u8 max_speed;
+	u8 cur_speed;
+	u8 target_speed;
+	u8 min_speed;
+	u32 monitor_interval;	/* ms */
+	u32 threshold;		/* KB */
+	struct timer_list timer;
+	struct work_struct work;
+	struct nvme_speed_switch_stats __percpu *stats;
+	atomic_t timer_active;
+};
+
+enum nvme_speed_timer_state {
+	NVME_SPEED_TIMER_INACTIVE,
+	NVME_SPEED_TIMER_ACTIVE,
+};
+#endif
+
 struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
@@ -472,8 +499,23 @@ struct nvme_ctrl {
 	enum nvme_dctype dctype;
 
 	u16			awupf; /* 0's based value. */
+#ifdef CONFIG_NVME_SPEED_SWITCH
+	struct nvme_speed_switch speed_switch;
+#endif
 };
 
+#ifdef CONFIG_NVME_SPEED_SWITCH
+void nvme_update_io_stats(struct nvme_ctrl *ctrl, struct request *req);
+void nvme_speed_switch_start(struct nvme_ctrl *ctrl);
+void nvme_speed_switch_init(struct nvme_ctrl *ctrl);
+void nvme_speed_switch_exit(struct nvme_ctrl *ctrl);
+#else
+static inline void nvme_update_io_stats(struct nvme_ctrl *ctrl, struct request *req) {}
+static inline void nvme_speed_switch_start(struct nvme_ctrl *ctrl) {}
+static inline void nvme_speed_switch_init(struct nvme_ctrl *ctrl) {}
+static inline void nvme_speed_switch_exit(struct nvme_ctrl *ctrl) {}
+#endif
+
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 {
 	return READ_ONCE(ctrl->state);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 69932d640..862c38242 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1455,6 +1455,9 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	ret = nvme_prep_rq(req);
 	if (unlikely(ret))
 		return ret;
+
+	nvme_update_io_stats(&dev->ctrl, req);
+
 	spin_lock(&nvmeq->sq_lock);
 	nvme_sq_copy_cmd(nvmeq, &iod->cmd);
 	nvme_write_sq_db(nvmeq, bd->last);
@@ -1473,6 +1476,7 @@ static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct rq_list *rqlist)
 	while ((req = rq_list_pop(rqlist))) {
 		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
+		nvme_update_io_stats(&nvmeq->dev->ctrl, req);
 		nvme_sq_copy_cmd(nvmeq, &iod->cmd);
 	}
 	nvme_write_sq_db(nvmeq, true);
diff --git a/drivers/nvme/host/speed_switch.c b/drivers/nvme/host/speed_switch.c
new file mode 100644
index 000000000..88c046fcd
--- /dev/null
+++ b/drivers/nvme/host/speed_switch.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe link speed switch driver
+ *
+ * Adjusts the PCIe link rate of NVMe devices dynamically based on the I/O
+ * workload: the link is downgraded to a configurable minimum rate during
+ * periods of low activity to save power, and upgraded to the maximum
+ * supported rate as soon as the workload requires it.
+ *
+ * Copyright (c) 2026 Hygon Information Technology Co., Ltd.
+ * Copyright (c) 2026 Kylin Software Co., Ltd.
+ *
+ */
+
+#include <linux/blk-mq.h>
+#include <linux/math64.h>
+#include <linux/pci.h>
+#include <linux/percpu.h>
+#include <linux/processor.h>
+
+#include "nvme.h"
+
+/*
+ * PCIe link bandwidth in KB/s for each generation (rows, Gen1..Gen5) and
+ * lane width (columns, x1..x16).  The table is used to derive the I/O
+ * threshold exceed/below which the link can be upgraded/downgraded.
+ */
+static const u32 nvme_speed_table[][5] = {
+	{  312,  625, 1250, 2500, 5000 },   /* Gen1 */
+	{  625, 1250, 2500, 5000, 10000 },  /* Gen2 */
+	{ 1000, 2000, 4000, 8000, 16000 },  /* Gen3 */
+	{ 2000, 4000, 8000, 16000, 32000 }, /* Gen4 */
+	{ 4000, 8000, 16000, 32000, 64000 },/* Gen5 */
+};
+
+static int nvme_bandwidth_index(enum pcie_link_width width)
+{
+	switch (width) {
+	case PCIE_LNK_X1:
+		return 0;
+	case PCIE_LNK_X2:
+		return 1;
+	case PCIE_LNK_X4:
+		return 2;
+	case PCIE_LNK_X8:
+		return 3;
+	case PCIE_LNK_X16:
+		return 4;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Read the maximum supported link rate of the upstream port from the Link
+ * Capability register.
+ */
+static int nvme_get_max_link_speed(struct pci_dev *pdev)
+{
+	u16 linkcap;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCAP, &linkcap);
+
+	return linkcap & PCI_EXP_LNKCAP_SLS;
+}
+
+static enum pci_bus_speed nvme_speed_to_bus_speed(u8 gen)
+{
+	return gen + PCIE_SPEED_2_5GT - 1;
+}
+
+/*
+ * Work item that actually changes the link rate.  The queues are frozen
+ * before retraining to quiesce I/O and resumed once the switch completed.
+ */
+static void nvme_speed_switch_work(struct work_struct *work)
+{
+	struct nvme_speed_switch *sw = container_of(work, struct nvme_speed_switch, work);
+	struct nvme_ctrl *ctrl = container_of(sw, struct nvme_ctrl, speed_switch);
+	struct pci_dev *pdev = to_pci_dev(ctrl->dev);
+	struct pci_dev *bridge = pdev->bus->self;
+	u8 cur_speed = READ_ONCE(sw->cur_speed);
+	int ret;
+
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE)
+		return;
+
+	/* Freeze I/O to avoid timeouts during link retraining. */
+	nvme_start_freeze(ctrl);
+	nvme_wait_freeze(ctrl);
+
+	ret = pcie_set_target_speed(bridge, nvme_speed_to_bus_speed(sw->target_speed),
+				    true);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "failed to set target rate Gen%u (%d), trying rollback to Gen%u\n",
+			 sw->target_speed, ret, cur_speed);
+		ret = pcie_set_target_speed(bridge, nvme_speed_to_bus_speed(cur_speed),
+					    true);
+		if (ret) {
+			dev_err(ctrl->device,
+				"rollback to Gen%u failed (%d), disabling speed switch\n",
+				cur_speed, ret);
+			WRITE_ONCE(sw->enabled, false);
+			nvme_unfreeze(ctrl);
+			return;
+		}
+	} else {
+		WRITE_ONCE(sw->cur_speed, sw->target_speed);
+	}
+
+	nvme_unfreeze(ctrl);
+	dev_dbg(ctrl->device, "link rate changed to Gen%u\n",
+		READ_ONCE(sw->cur_speed));
+}
+
+/*
+ * Compute the I/O threshold (in KB) for a monitoring window.
+ *
+ * The threshold is derived from the following constraint: for the link
+ * speed to be upgraded, the transfer time of the data at the minimum
+ * speed must be greater than the sum of the transfer time at maximum
+ * speed and the link retraining time (100us):
+ *
+ *	data / min_bw >= data / max_bw + 100us
+ *
+ * which yields data <= min_bw * max_bw * 0.1ms / (max_bw - min_bw).
+ * The bandwidths are taken from the link capability of the upstream port
+ * and the link width capability of the device.
+ */
+static u32 nvme_calc_speed_threshold(struct nvme_speed_switch *sw,
+				     enum pcie_link_width max_width)
+{
+	struct nvme_ctrl *ctrl = container_of(sw, struct nvme_ctrl, speed_switch);
+	int bw_idx, min_gen = sw->min_speed, max_gen = sw->max_speed;
+	u64 min_bw, max_bw, x, y;
+	u32 threshold;
+
+	if (min_gen < 1 || min_gen > 5 || max_gen < 1 || max_gen > 5) {
+		dev_warn(ctrl->device,
+			 "invalid link rate range for threshold: min=Gen%d, max=Gen%d\n",
+			 min_gen, max_gen);
+		return 0;
+	}
+
+	bw_idx = nvme_bandwidth_index(max_width);
+	if (bw_idx < 0) {
+		dev_warn(ctrl->device,
+			 "unsupported link width (%d) for threshold calculation\n",
+			 max_width);
+		return 0;
+	}
+
+	min_bw = nvme_speed_table[min_gen - 1][bw_idx];
+	max_bw = nvme_speed_table[max_gen - 1][bw_idx];
+	if (min_bw >= max_bw) {
+		dev_warn(ctrl->device,
+			 "invalid bandwidth for threshold: min=%llu KB/s, max=%llu KB/s\n",
+			 min_bw, max_bw);
+		return 0;
+	}
+
+	x = min_bw * max_bw;
+	y = 10ULL * (max_bw - min_bw);
+	threshold = div64_u64(x + (y >> 1), y);
+
+	dev_dbg(ctrl->device,
+		"I/O threshold: %u KB (min=Gen%d, max=Gen%d, width=x%d)\n",
+		threshold, min_gen, max_gen, max_width);
+
+	return threshold;
+}
+
+/* Called on the I/O submission path to accumulate the transferred bytes. */
+void nvme_update_io_stats(struct nvme_ctrl *ctrl, struct request *req)
+{
+	struct nvme_speed_switch *sw = &ctrl->speed_switch;
+	struct nvme_speed_switch_stats *stat;
+	enum req_op op = req_op(req);
+	unsigned int bytes = blk_rq_bytes(req);
+
+	if (!READ_ONCE(sw->enabled))
+		return;
+
+	if (op != REQ_OP_READ && op != REQ_OP_WRITE)
+		return;
+
+	if (!sw->stats) {
+		dev_dbg(ctrl->device, "I/O statistics not allocated, skip accounting\n");
+		return;
+	}
+
+	stat = get_cpu_ptr(sw->stats);
+	if (op == REQ_OP_READ)
+		stat->read_bytes += bytes;
+	else
+		stat->write_bytes += bytes;
+	put_cpu_ptr(sw->stats);
+
+	if (atomic_cmpxchg(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE,
+			   NVME_SPEED_TIMER_ACTIVE) != NVME_SPEED_TIMER_INACTIVE)
+		return;
+
+	/* First I/O of the activity period: compute the threshold and arm the timer. */
+	WRITE_ONCE(sw->threshold, nvme_calc_speed_threshold(sw,
+					pcie_get_width_cap(to_pci_dev(ctrl->dev))));
+	if (!READ_ONCE(sw->threshold)) {
+		dev_warn(ctrl->device,
+			 "failed to compute speed switch threshold, keeping current rate\n");
+		atomic_set(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE);
+		return;
+	}
+	mod_timer(&sw->timer, jiffies + msecs_to_jiffies(READ_ONCE(sw->monitor_interval)));
+}
+EXPORT_SYMBOL_GPL(nvme_update_io_stats);
+
+static void nvme_clear_io_stats(struct nvme_speed_switch *sw)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct nvme_speed_switch_stats *stat = per_cpu_ptr(sw->stats, cpu);
+
+		stat->read_bytes = 0;
+		stat->write_bytes = 0;
+	}
+}
+
+/*
+ * Aggregate the per-CPU I/O counters of the last monitoring window and
+ * decide the target rate: the maximum rate if the window exceeded the
+ * threshold, the minimum rate otherwise.
+ */
+static int nvme_check_io_and_decide_speed(struct nvme_speed_switch *sw)
+{
+	struct nvme_ctrl *ctrl = container_of(sw, struct nvme_ctrl, speed_switch);
+	u64 read_bytes = 0, write_bytes = 0;
+	unsigned long read_kb, write_kb;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct nvme_speed_switch_stats *stat = per_cpu_ptr(sw->stats, cpu);
+
+		read_bytes += stat->read_bytes;
+		write_bytes += stat->write_bytes;
+		stat->read_bytes = 0;
+		stat->write_bytes = 0;
+	}
+
+	read_kb = read_bytes / 1024;
+	write_kb = write_bytes / 1024;
+	dev_dbg(ctrl->device,
+		"I/O in window: read=%lu KB, write=%lu KB, threshold=%u KB\n",
+		read_kb, write_kb, READ_ONCE(sw->threshold));
+
+	if (read_kb >= sw->threshold || write_kb >= sw->threshold)
+		return sw->max_speed;
+
+	return sw->min_speed;
+}
+
+static void nvme_speed_switch_timer_fn(struct timer_list *t)
+{
+	struct nvme_speed_switch *sw = container_of(t, struct nvme_speed_switch, timer);
+
+	if (!READ_ONCE(sw->enabled)) {
+		atomic_set(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE);
+		return;
+	}
+
+	sw->target_speed = nvme_check_io_and_decide_speed(sw);
+	if (sw->target_speed != READ_ONCE(sw->cur_speed))
+		schedule_work(&sw->work);
+
+	mod_timer(t, jiffies + msecs_to_jiffies(READ_ONCE(sw->monitor_interval)));
+}
+
+static void nvme_speed_switch_params_init(struct nvme_speed_switch *sw)
+{
+	sw->monitor_interval = 100;
+	sw->min_speed = PCI_EXP_LNKSTA_CLS_2_5GB;
+}
+
+void nvme_speed_switch_init(struct nvme_ctrl *ctrl)
+{
+	struct nvme_speed_switch *sw = &ctrl->speed_switch;
+	struct pci_dev *pdev;
+	int max_speed;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_HYGON) {
+		dev_dbg(ctrl->device,
+			"link rate switching is only supported on Hygon platforms\n");
+		return;
+	}
+
+	if (!dev_is_pci(ctrl->dev)) {
+		dev_err(ctrl->device, "link rate switching requires a PCI device\n");
+		return;
+	}
+
+	pdev = to_pci_dev(ctrl->dev);
+	if (!pdev->bus->self) {
+		dev_err(ctrl->device,
+			"link rate switching requires a PCIe upstream port\n");
+		return;
+	}
+
+	nvme_speed_switch_params_init(sw);
+
+	max_speed = nvme_get_max_link_speed(pdev->bus->self);
+	if (max_speed <= sw->min_speed) {
+		dev_err(ctrl->device,
+			"invalid link rate range: min=Gen%u, max=Gen%d\n",
+			sw->min_speed, max_speed);
+		return;
+	}
+	sw->max_speed = max_speed;
+
+	sw->stats = alloc_percpu(struct nvme_speed_switch_stats);
+	if (!sw->stats) {
+		dev_err(ctrl->device, "failed to allocate per-CPU I/O statistics\n");
+		return;
+	}
+	nvme_clear_io_stats(sw);
+
+	WRITE_ONCE(sw->cur_speed, sw->max_speed);
+	WRITE_ONCE(sw->threshold, nvme_calc_speed_threshold(sw, pcie_get_width_cap(pdev)));
+	if (!READ_ONCE(sw->threshold)) {
+		dev_err(ctrl->device, "failed to compute speed switch threshold\n");
+		free_percpu(sw->stats);
+		sw->stats = NULL;
+		return;
+	}
+
+	INIT_WORK(&sw->work, nvme_speed_switch_work);
+	timer_setup(&sw->timer, nvme_speed_switch_timer_fn, 0);
+	atomic_set(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE);
+	WRITE_ONCE(sw->enabled, true);
+	sw->initialized = true;
+
+	dev_info(ctrl->device,
+		 "NVMe link rate switching initialized (min Gen%u, max Gen%d)\n",
+		 sw->min_speed, sw->max_speed);
+}
+
+void nvme_speed_switch_start(struct nvme_ctrl *ctrl)
+{
+	struct nvme_speed_switch *sw = &ctrl->speed_switch;
+
+	if (!READ_ONCE(sw->enabled))
+		return;
+
+	atomic_set(&sw->timer_active, NVME_SPEED_TIMER_ACTIVE);
+	mod_timer(&sw->timer, jiffies + msecs_to_jiffies(READ_ONCE(sw->monitor_interval)));
+}
+
+void nvme_speed_switch_exit(struct nvme_ctrl *ctrl)
+{
+	struct nvme_speed_switch *sw = &ctrl->speed_switch;
+
+	if (!sw->initialized)
+		return;
+
+	sw->initialized = false;
+	WRITE_ONCE(sw->enabled, false);
+	timer_delete_sync(&sw->timer);
+	cancel_work_sync(&sw->work);
+
+	free_percpu(sw->stats);
+	sw->stats = NULL;
+}
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index c4c8d260b..b2949ed59 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -178,6 +178,7 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pcie_set_target_speed);
 
 static void pcie_bwnotif_enable(struct pcie_device *srv)
 {
-- 
2.43.0

