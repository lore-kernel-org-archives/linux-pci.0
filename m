Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E8C3BD22E;
	Thu, 24 Sep 2026 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230549; cv=none; b=UM1B8my1r3U7NTW5CAHB3ppZ/oWLVMdvIfNczPvAUIuCXgfXBbb+DZUxd55b3nAr8WjR9Cp1V6nvVaWy2yeIhuq/QTh9YrXYhxTYmjrtxcSAVLmYt+evZq+Ys8Re/YewitQsfJEty/yT7qV9o6PPbNRP8Wwovgu+oad9DE7RxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230549; c=relaxed/simple;
	bh=O2s2nMDXA8bUUx/tDQcMqrSq2h8qTyV5Dmcm7g7R0SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQzEjhxz4yCBGgg2bbFWFveSPE5cgCOQM0jxRE61cKwsQ7E7RbFkcigQMZADHf7TfXkMzPcZUszOPx5TmP8iqzVQ/t5h/9US4XHh7dl7T5ncsL5gHW4kJsy2n+IPHxnn5wYiPAIVp40mxxOdYakEVjHwVH2zF5oKhislvERIwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.9109073|0.1356083;CH=green;DM=|AD|false|;DS=CONTINUE|ham_regular_dialog|0.0110819-0.00116182-0.987756;FP=2518774180095731379|4|2|2|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=liaoxuan@open-hieco.net;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jLtpc1n_1790230533;
Received: from Ubuntu2404-XLH.hygon.cn(mailfrom:liaoxuan@open-hieco.net fp:SMTPD_---.jLtpc1n_1790230533 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 14:15:39 +0800
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
Subject: [PATCH 2/3] nvme: Add hysteresis and idle detection to link rate switching
Date: Thu, 24 Sep 2026 14:15:12 +0800
Message-ID: <de23e8b9699b5a7a77e7ee215e8e4c9f530ce5da.1790222172.git.liaoxuan@hygon.cn>
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

The rate switching decision currently toggles the link rate in every
monitoring window based on the I/O of that window alone, which can
cause excessive rate switching when the workload fluctuates around the
threshold.

Add counters that require the threshold to be exceeded for a
consecutive number of windows before the rate is upgraded, and to stay
below the threshold for a consecutive number of windows before it is
downgraded. The upgrade happens immediately (threshold 0 by default)
so that latency is not sacrificed, while the downgrade requires 10
consecutive windows.

Monitoring is stopped after 10 seconds of inactivity and is re-armed by
the next I/O.

Signed-off-by: Liao Xuan <liaoxuan@open-hieco.net>
---
 drivers/nvme/host/nvme.h         |  5 +++
 drivers/nvme/host/speed_switch.c | 52 ++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ff06f85d1..5d5034601 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -346,6 +346,11 @@ struct nvme_speed_switch {
 	u8 min_speed;
 	u32 monitor_interval;	/* ms */
 	u32 threshold;		/* KB */
+	u32 up_cnt;
+	u32 down_cnt;
+	u32 up_threshold;
+	u32 down_threshold;
+	u32 idle_cnt;
 	struct timer_list timer;
 	struct work_struct work;
 	struct nvme_speed_switch_stats __percpu *stats;
diff --git a/drivers/nvme/host/speed_switch.c b/drivers/nvme/host/speed_switch.c
index 88c046fcd..22f180c81 100644
--- a/drivers/nvme/host/speed_switch.c
+++ b/drivers/nvme/host/speed_switch.c
@@ -228,10 +228,15 @@ static void nvme_clear_io_stats(struct nvme_speed_switch *sw)
 
 /*
  * Aggregate the per-CPU I/O counters of the last monitoring window and
- * decide the target rate: the maximum rate if the window exceeded the
- * threshold, the minimum rate otherwise.
+ * decide the target rate.  Hysteresis counters are used to avoid
+ * excessive rate switching when the workload fluctuates around the
+ * threshold: the rate is only upgraded after the threshold was exceeded
+ * for a number of consecutive windows, and only downgraded after it
+ * stayed below the threshold for a number of consecutive windows.  When
+ * no I/O was observed for 10 seconds the monitoring is stopped.
  */
-static int nvme_check_io_and_decide_speed(struct nvme_speed_switch *sw)
+static int nvme_check_io_and_decide_speed(struct nvme_speed_switch *sw,
+					  bool *io_activity)
 {
 	struct nvme_ctrl *ctrl = container_of(sw, struct nvme_ctrl, speed_switch);
 	u64 read_bytes = 0, write_bytes = 0;
@@ -247,31 +252,62 @@ static int nvme_check_io_and_decide_speed(struct nvme_speed_switch *sw)
 		stat->write_bytes = 0;
 	}
 
+	if (read_bytes || write_bytes) {
+		*io_activity = true;
+		sw->idle_cnt = 0;
+	} else {
+		sw->idle_cnt++;
+	}
+
+	/* Stop monitoring after 10 seconds of inactivity (100 windows of 100ms). */
+	if (sw->idle_cnt >= 100)
+		*io_activity = false;
+
 	read_kb = read_bytes / 1024;
 	write_kb = write_bytes / 1024;
 	dev_dbg(ctrl->device,
 		"I/O in window: read=%lu KB, write=%lu KB, threshold=%u KB\n",
 		read_kb, write_kb, READ_ONCE(sw->threshold));
 
-	if (read_kb >= sw->threshold || write_kb >= sw->threshold)
+	if (read_kb >= sw->threshold || write_kb >= sw->threshold) {
+		sw->up_cnt++;
+		sw->down_cnt = 0;
+	} else {
+		sw->down_cnt++;
+		sw->up_cnt = 0;
+	}
+
+	if (sw->up_cnt > READ_ONCE(sw->up_threshold)) {
+		sw->up_cnt = 0;
 		return sw->max_speed;
+	}
+
+	if (sw->down_cnt > READ_ONCE(sw->down_threshold) || !*io_activity) {
+		sw->down_cnt = 0;
+		return sw->min_speed;
+	}
 
-	return sw->min_speed;
+	return READ_ONCE(sw->cur_speed);
 }
 
 static void nvme_speed_switch_timer_fn(struct timer_list *t)
 {
 	struct nvme_speed_switch *sw = container_of(t, struct nvme_speed_switch, timer);
+	bool io_activity = true;
 
 	if (!READ_ONCE(sw->enabled)) {
 		atomic_set(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE);
 		return;
 	}
 
-	sw->target_speed = nvme_check_io_and_decide_speed(sw);
+	sw->target_speed = nvme_check_io_and_decide_speed(sw, &io_activity);
 	if (sw->target_speed != READ_ONCE(sw->cur_speed))
 		schedule_work(&sw->work);
 
+	if (!io_activity) {
+		atomic_set(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE);
+		return;
+	}
 	mod_timer(t, jiffies + msecs_to_jiffies(READ_ONCE(sw->monitor_interval)));
 }
 
@@ -279,6 +315,10 @@ static void nvme_speed_switch_params_init(struct nvme_speed_switch *sw)
 {
 	sw->monitor_interval = 100;
 	sw->min_speed = PCI_EXP_LNKSTA_CLS_2_5GB;
+	/* Upgrade immediately once the threshold is exceeded. */
+	sw->up_threshold = 0;
+	/* Downgrade after 10 consecutive below-threshold windows. */
+	sw->down_threshold = 10;
 }
 
 void nvme_speed_switch_init(struct nvme_ctrl *ctrl)
-- 
2.43.0

