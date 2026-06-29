Received: from va-2-40.ptr.blmpb.com (va-2-40.ptr.blmpb.com [209.127.231.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620C3BF678
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725263; cv=none; b=RHKnwQlAQ2EvqZkMIjyBPd3ELfmWq/APn9PdQGEV13wFwgdV2IS/DsYZIOVaxNB3IgfCsFA0GGHM2xtgq82WyORZmb/smV6vPoj1MPumOqqtWJgrdaiOe1r6nofk/pxSeaZsfRgjPBxQXc/pZHztkL/fmBzi6IEic9G7+UA0/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725263; c=relaxed/simple;
	bh=+MsdtWdjh7+u/+KrYe9Orx4KJHk55Y2F/MrAmm2GWZY=;
	h=Subject:Message-Id:To:Cc:References:Content-Type:Date:In-Reply-To:
	 From:Mime-Version; b=rSbfNyrQF9A//QwhAaBlUl4z/vj0cBI/xx0K2rmL3uRXYYWSuTbeK/v4guFtMTxmFbQe0O7Kw/J+wsUGBXsxXHf7NYFX7L6Jh5X1dK2qA6loqrmAoOFAVfFfgbIyHn6hZkXs/TfKIsyR45euG3W46hVeJ7qEi0TjFQq7gCsHzLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=YOjOa8dX; arc=none smtp.client-ip=209.127.231.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="YOjOa8dX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1782725249; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=xsbhqbDc1asbZ/sBOjH9OQzH1gz9oDCYn5HIl2HB8lY=;
 b=YOjOa8dXTOG0GPCobTOLOw6cQzpwPENqsYaFy6QCMbciURVNBgS6bRhRiVZ4Nl17SSjh+f
 YiEfcmbFIybyIMIjBeLSOcz3YNgwbYWw+H5DmGwnu9qyJaowtJsHZu7eRtL47PYao5SQZQ
 SdffLBmDuCWXvuyhcfgFDG+As/s2KljfsrB72pK/RcWcE2GZV3AR+u9PXHUZcHmodIQvj4
 Oe5lbXPwIUEJzWpJhej5n2VbB61LPPawxjbYj4slDXzyCsZtfSSe5jw4yeWGUFmV0Gk5WV
 mxZq73ca+XCKgdkPMFhO+I4rC/1FhIAP/lZ8O7+8d86U+8iaZ5mguYaKp792TQ==
Subject: [PATCH v2 2/3] perf/dwc_pcie: Support narrowed time-based counter for long time monitoring
Message-Id: <20260629092717.74946-3-yang.yicong@picoheart.com>
To: <xueshuai@linux.alibaba.com>, <renyu.zj@linux.alibaba.com>, 
	<will@kernel.org>, <mark.rutland@arm.com>, <jic23@kernel.org>, 
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Cc: <jingoohan1@gmail.com>, <mani@kernel.org>, <juwenlong@picoheart.com>, 
	<geshijian@picoheart.com>, <yang.yicong@picoheart.com>, 
	<douyufan@picoheart.com>
References: <20260629092717.74946-1-yang.yicong@picoheart.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 17:27:16 +0800
In-Reply-To: <20260629092717.74946-1-yang.yicong@picoheart.com>
Received: from G9WYR9K0VW.bytedance.net ([61.141.241.118]) by smtp.feishu.cn with ESMTPS; Mon, 29 Jun 2026 17:27:25 +0800
X-Mailer: git-send-email 2.50.1
X-Lms-Return-Path: <lba+26a423a7f+7aca9a+vger.kernel.org+yang.yicong@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

From: Yufan Dou <douyufan@picoheart.com>

The DWC PCIe Time-Based Analysis Data Register (the counter for time-based
events) is architected as 64-bit, but some hardware implementations do not
implement the full width.  On these implementations the counter stops after
reaching its implemented width. This will limit the usage for short time
monitoring only. The counter will only cover ~15s for monitoring RX TLP
payloads on our platform.

Add an optional hrtimer that fires every 2 seconds. It'll take the role
as the counter overflow interrupt to read-update-reset the counter and
event counts to break the limits of the narrow counters. It'll only
apply on timer-based counter. The 2 seconds update period is the half
of the maximum counting period (4s) of the time-based counter under
period counting mode of the hardware.

Because fully-implemented 64-bit counters do not need this workaround,
enable this hrtimer on the platforms known to have narrowed counter.

Before this patch, when counting fio for 10m the counts is incorrect:
  root@localhost:/tmp# perf stat -e dwc_rootport_20000/rx_pcie_tlp_data_payload/ -- fio --runtime=10m fio_job.config
  [...]
  Run status group 0 (all jobs):
     READ: bw=5594MiB/s (5865MB/s), 5594MiB/s-5594MiB/s (5865MB/s-5865MB/s), io=3278GiB (3519GB), run=600010-600010msec
  [...]
  Performance counter stats for 'system wide':
     137,438,953,456      dwc_rootport_20000/rx_pcie_tlp_data_payload/

After this patch the counts is as expected:
  root@localhost:/tmp# perf stat -e dwc_rootport_20000/rx_pcie_tlp_data_payload/ -- fio --runtime=10m fio_job.config
  [...]
  Run status group 0 (all jobs):
     READ: bw=5632MiB/s (5905MB/s), 5632MiB/s-5632MiB/s (5905MB/s-5905MB/s), io=3300GiB (3543GB), run=600013-600013msec
  [...]
  Performance counter stats for 'system wide':
   3,543,850,268,576      dwc_rootport_20000/rx_pcie_tlp_data_payload/

Signed-off-by: Yufan Dou <douyufan@picoheart.com>
Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
---
 drivers/perf/dwc_pcie_pmu.c | 69 ++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 5385401fa9cf..7ec8302d4090 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -11,6 +11,7 @@
 #include <linux/cpumask.h>
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/hrtimer.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/pcie-dwc.h>
@@ -83,6 +84,7 @@ enum dwc_pcie_event_type {
 
 #define DWC_PCIE_LANE_EVENT_MAX_PERIOD		GENMASK_ULL(31, 0)
 #define DWC_PCIE_MAX_PERIOD			GENMASK_ULL(63, 0)
+#define DWC_PCIE_PMU_TIMER_PERIOD_NS		(2 * NSEC_PER_SEC)
 
 struct dwc_pcie_pmu {
 	struct pmu		pmu;
@@ -93,6 +95,8 @@ struct dwc_pcie_pmu {
 	/* Groups #6 and #7 */
 	DECLARE_BITMAP(lane_events, 2 * DWC_PCIE_LANE_MAX_EVENTS_PER_GROUP);
 	struct perf_event	*time_based_event;
+	bool			timer_enable;
+	struct hrtimer		hrtimer;
 
 	struct hlist_node	cpuhp_node;
 	int			on_cpu;
@@ -354,6 +358,26 @@ static u64 dwc_pcie_pmu_read_time_based_counter(struct perf_event *event)
 	return val;
 }
 
+static void dwc_pcie_pmu_reset_time_based_counter(struct perf_event *event)
+{
+	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev;
+
+	dwc_pcie_pmu_time_based_event_enable(pcie_pmu, false);
+
+	/*
+	 * The hardware counter is reset to zero when disabled. Synchronize
+	 * prev_count so that the next event_update() computes the correct
+	 * delta against the new counter baseline.
+	 */
+	do {
+		prev = local64_read(&hwc->prev_count);
+	} while (local64_cmpxchg(&hwc->prev_count, prev, 0) != prev);
+
+	dwc_pcie_pmu_time_based_event_enable(pcie_pmu, true);
+}
+
 static void dwc_pcie_pmu_event_update(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -429,6 +453,26 @@ static int dwc_pcie_pmu_validate_group(struct perf_event *event)
 	return 0;
 }
 
+static enum hrtimer_restart dwc_pcie_pmu_hrtimer_callback(struct hrtimer *hrtimer)
+{
+	struct dwc_pcie_pmu *pcie_pmu = container_of(hrtimer, struct dwc_pcie_pmu, hrtimer);
+	struct perf_event *event = pcie_pmu->time_based_event;
+	struct hw_perf_event *hwc;
+
+	if (!event)
+		return HRTIMER_NORESTART;
+
+	hwc = &event->hw;
+	if (hwc->state & PERF_HES_STOPPED)
+		return HRTIMER_NORESTART;
+
+	dwc_pcie_pmu_event_update(event);
+	dwc_pcie_pmu_reset_time_based_counter(event);
+	hrtimer_forward_now(hrtimer, ns_to_ktime(DWC_PCIE_PMU_TIMER_PERIOD_NS));
+
+	return HRTIMER_RESTART;
+}
+
 static int dwc_pcie_pmu_event_init(struct perf_event *event)
 {
 	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
@@ -478,10 +522,15 @@ static void dwc_pcie_pmu_event_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 	local64_set(&hwc->prev_count, 0);
 
-	if (type == DWC_PCIE_LANE_EVENT)
+	if (type == DWC_PCIE_LANE_EVENT) {
 		dwc_pcie_pmu_lane_event_enable(pcie_pmu, event, true);
-	else if (type == DWC_PCIE_TIME_BASE_EVENT)
+	} else if (type == DWC_PCIE_TIME_BASE_EVENT) {
 		dwc_pcie_pmu_time_based_event_enable(pcie_pmu, true);
+		if (pcie_pmu->timer_enable)
+			hrtimer_start(&pcie_pmu->hrtimer,
+				      ns_to_ktime(DWC_PCIE_PMU_TIMER_PERIOD_NS),
+				      HRTIMER_MODE_REL_PINNED_HARD);
+	}
 }
 
 static void dwc_pcie_pmu_event_stop(struct perf_event *event, int flags)
@@ -495,10 +544,12 @@ static void dwc_pcie_pmu_event_stop(struct perf_event *event, int flags)
 
 	dwc_pcie_pmu_event_update(event);
 
-	if (type == DWC_PCIE_LANE_EVENT)
+	if (type == DWC_PCIE_LANE_EVENT) {
 		dwc_pcie_pmu_lane_event_enable(pcie_pmu, event, false);
-	else if (type == DWC_PCIE_TIME_BASE_EVENT)
+	} else if (type == DWC_PCIE_TIME_BASE_EVENT) {
 		dwc_pcie_pmu_time_based_event_enable(pcie_pmu, false);
+		hrtimer_cancel(&pcie_pmu->hrtimer);
+	}
 
 	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
 }
@@ -726,6 +777,16 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 	pcie_pmu->ras_des_offset = vsec;
 	pcie_pmu->nr_lanes = pcie_get_width_cap(pdev);
 	pcie_pmu->on_cpu = -1;
+	hrtimer_setup(&pcie_pmu->hrtimer, dwc_pcie_pmu_hrtimer_callback,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
+
+	/*
+	 * Use timer for updating time-based counts on platforms known
+	 * to have narrowed counter.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_PICOHEART)
+		pcie_pmu->timer_enable = true;
+
 	pcie_pmu->pmu = (struct pmu){
 		.name		= name,
 		.parent		= &plat_dev->dev,
-- 
2.50.1 (Apple Git-155)
