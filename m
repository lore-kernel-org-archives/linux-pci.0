Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07713326942;
	Tue, 30 Jun 2026 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782809431; cv=none; b=osvjxrEEo46Dsa0Xmox13D+P3xNKYhzf6nMGFuy5ckY4S/zWE3CjE/3WBi2/pZnzK5FqIxhSfTvUAjdJ8uOLOs0gLVdBlORlS/2H8EMfdNUKU/eIOFHmm+ENKLAta9915+CICc/OtKw0BL/j6J+QlJvwb+Hh+zbE6hOG1bL65pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782809431; c=relaxed/simple;
	bh=s8NCk5JLe+q6e+flxQkXCGA/4nmNnyyQhiYMSWKvGpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1KyQjTpPNmz0VRrtGuY+FKZCP5Vu3gLT3LW1qZIBU87zldrhd7oFy+Dw+FejrYS5Y9qUasOoh0oc9wT/BGpNg+KjowjZGTAfILPQYddI/8JGhTgg0n46cA1gZUMmUEz4jRCrFDpboz6Bb85B1T7ISNfQsK72igJPcpni51a7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JnJ4LEnZ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JnJ4LEnZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782809418; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Hd9Xy3BKgc5W8RUvuu8A1WEkp55orQPHJDKQSlJVOwM=;
	b=JnJ4LEnZxB4bE01m9S1L1qDGJleQgC6JpL6RCSK1Nd7AfdK5QuJBOuCw08EltakPrjN8OvqfD7GR4CnJAmdfv5VMWrAXzE44tF+5AqD97ytcZrKgdE7iQsTqib9e7jFye3e1OE1yysoR2YC5h0osZ2gWJJciPGxJnkS47U88fp4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X6-m7Hz_1782809416;
Received: from 30.246.161.179(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X6-m7Hz_1782809416 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 16:50:17 +0800
Message-ID: <a1bbf438-c0d3-4467-9852-657fb93bc548@linux.alibaba.com>
Date: Tue, 30 Jun 2026 16:50:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] perf/dwc_pcie: Support narrowed time-based counter
 for long time monitoring
To: Yicong Yang <yang.yicong@picoheart.com>, renyu.zj@linux.alibaba.com,
 will@kernel.org, mark.rutland@arm.com, jic23@kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jingoohan1@gmail.com, mani@kernel.org, juwenlong@picoheart.com,
 geshijian@picoheart.com, douyufan@picoheart.com
References: <20260629092717.74946-1-yang.yicong@picoheart.com>
 <20260629092717.74946-3-yang.yicong@picoheart.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260629092717.74946-3-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/29/26 5:27 PM, Yicong Yang wrote:
> From: Yufan Dou <douyufan@picoheart.com>
> 
> The DWC PCIe Time-Based Analysis Data Register (the counter for time-based
> events) is architected as 64-bit, but some hardware implementations do not
> implement the full width.  On these implementations the counter stops after
> reaching its implemented width. This will limit the usage for short time
> monitoring only. The counter will only cover ~15s for monitoring RX TLP
> payloads on our platform.
> 
> Add an optional hrtimer that fires every 2 seconds. It'll take the role
> as the counter overflow interrupt to read-update-reset the counter and
> event counts to break the limits of the narrow counters. It'll only
> apply on timer-based counter. The 2 seconds update period is the half
> of the maximum counting period (4s) of the time-based counter under
> period counting mode of the hardware.
> 
> Because fully-implemented 64-bit counters do not need this workaround,
> enable this hrtimer on the platforms known to have narrowed counter.
> 
> Before this patch, when counting fio for 10m the counts is incorrect:
>    root@localhost:/tmp# perf stat -e dwc_rootport_20000/rx_pcie_tlp_data_payload/ -- fio --runtime=10m fio_job.config
>    [...]
>    Run status group 0 (all jobs):
>       READ: bw=5594MiB/s (5865MB/s), 5594MiB/s-5594MiB/s (5865MB/s-5865MB/s), io=3278GiB (3519GB), run=600010-600010msec
>    [...]
>    Performance counter stats for 'system wide':
>       137,438,953,456      dwc_rootport_20000/rx_pcie_tlp_data_payload/
> 
> After this patch the counts is as expected:
>    root@localhost:/tmp# perf stat -e dwc_rootport_20000/rx_pcie_tlp_data_payload/ -- fio --runtime=10m fio_job.config
>    [...]
>    Run status group 0 (all jobs):
>       READ: bw=5632MiB/s (5905MB/s), 5632MiB/s-5632MiB/s (5905MB/s-5905MB/s), io=3300GiB (3543GB), run=600013-600013msec
>    [...]
>    Performance counter stats for 'system wide':
>     3,543,850,268,576      dwc_rootport_20000/rx_pcie_tlp_data_payload/
> 
> Signed-off-by: Yufan Dou <douyufan@picoheart.com>
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 69 ++++++++++++++++++++++++++++++++++---
>   1 file changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 5385401fa9cf..7ec8302d4090 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -11,6 +11,7 @@
>   #include <linux/cpumask.h>
>   #include <linux/device.h>
>   #include <linux/errno.h>
> +#include <linux/hrtimer.h>
>   #include <linux/kernel.h>
>   #include <linux/list.h>
>   #include <linux/pcie-dwc.h>
> @@ -83,6 +84,7 @@ enum dwc_pcie_event_type {
>   
>   #define DWC_PCIE_LANE_EVENT_MAX_PERIOD		GENMASK_ULL(31, 0)
>   #define DWC_PCIE_MAX_PERIOD			GENMASK_ULL(63, 0)
> +#define DWC_PCIE_PMU_TIMER_PERIOD_NS		(2 * NSEC_PER_SEC)
>   
>   struct dwc_pcie_pmu {
>   	struct pmu		pmu;
> @@ -93,6 +95,8 @@ struct dwc_pcie_pmu {
>   	/* Groups #6 and #7 */
>   	DECLARE_BITMAP(lane_events, 2 * DWC_PCIE_LANE_MAX_EVENTS_PER_GROUP);
>   	struct perf_event	*time_based_event;
> +	bool			timer_enable;
> +	struct hrtimer		hrtimer;
>   
>   	struct hlist_node	cpuhp_node;
>   	int			on_cpu;
> @@ -354,6 +358,26 @@ static u64 dwc_pcie_pmu_read_time_based_counter(struct perf_event *event)
>   	return val;
>   }
>   
> +static void dwc_pcie_pmu_reset_time_based_counter(struct perf_event *event)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 prev;
> +
> +	dwc_pcie_pmu_time_based_event_enable(pcie_pmu, false);
> +
> +	/*
> +	 * The hardware counter is reset to zero when disabled. Synchronize
> +	 * prev_count so that the next event_update() computes the correct
> +	 * delta against the new counter baseline.
> +	 */
> +	do {
> +		prev = local64_read(&hwc->prev_count);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev, 0) != prev);
> +
> +	dwc_pcie_pmu_time_based_event_enable(pcie_pmu, true);
> +}
> +
>   static void dwc_pcie_pmu_event_update(struct perf_event *event)
>   {
>   	struct hw_perf_event *hwc = &event->hw;
> @@ -429,6 +453,26 @@ static int dwc_pcie_pmu_validate_group(struct perf_event *event)
>   	return 0;
>   }
>   
> +static enum hrtimer_restart dwc_pcie_pmu_hrtimer_callback(struct hrtimer *hrtimer)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu = container_of(hrtimer, struct dwc_pcie_pmu, hrtimer);
> +	struct perf_event *event = pcie_pmu->time_based_event;
> +	struct hw_perf_event *hwc;
> +
> +	if (!event)
> +		return HRTIMER_NORESTART;
> +
> +	hwc = &event->hw;
> +	if (hwc->state & PERF_HES_STOPPED)
> +		return HRTIMER_NORESTART;
> +
> +	dwc_pcie_pmu_event_update(event);
> +	dwc_pcie_pmu_reset_time_based_counter(event);
> +	hrtimer_forward_now(hrtimer, ns_to_ktime(DWC_PCIE_PMU_TIMER_PERIOD_NS));

 From sashiko:

If the PCIe Root Port enters runtime suspend (such as D3hot or D3cold) while
this timer is active, will the hardware accesses in
dwc_pcie_pmu_event_update() cause problems?
Accessing the configuration space of a suspended device could return
corrupted data or trigger system errors like synchronous external aborts.

https://sashiko.dev/#/patchset/20260629092717.74946-1-yang.yicong%40picoheart.com

> +
> +	return HRTIMER_RESTART;
> +}
> +
>   static int dwc_pcie_pmu_event_init(struct perf_event *event)
>   {
>   	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> @@ -478,10 +522,15 @@ static void dwc_pcie_pmu_event_start(struct perf_event *event, int flags)
>   	hwc->state = 0;
>   	local64_set(&hwc->prev_count, 0);
>   
> -	if (type == DWC_PCIE_LANE_EVENT)
> +	if (type == DWC_PCIE_LANE_EVENT) {
>   		dwc_pcie_pmu_lane_event_enable(pcie_pmu, event, true);
> -	else if (type == DWC_PCIE_TIME_BASE_EVENT)
> +	} else if (type == DWC_PCIE_TIME_BASE_EVENT) {
>   		dwc_pcie_pmu_time_based_event_enable(pcie_pmu, true);
> +		if (pcie_pmu->timer_enable)
> +			hrtimer_start(&pcie_pmu->hrtimer,
> +				      ns_to_ktime(DWC_PCIE_PMU_TIMER_PERIOD_NS),
> +				      HRTIMER_MODE_REL_PINNED_HARD);
> +	}
>   }
>   
>   static void dwc_pcie_pmu_event_stop(struct perf_event *event, int flags)
> @@ -495,10 +544,12 @@ static void dwc_pcie_pmu_event_stop(struct perf_event *event, int flags)
>   
>   	dwc_pcie_pmu_event_update(event);
>   
> -	if (type == DWC_PCIE_LANE_EVENT)
> +	if (type == DWC_PCIE_LANE_EVENT) {
>   		dwc_pcie_pmu_lane_event_enable(pcie_pmu, event, false);
> -	else if (type == DWC_PCIE_TIME_BASE_EVENT)
> +	} else if (type == DWC_PCIE_TIME_BASE_EVENT) {
>   		dwc_pcie_pmu_time_based_event_enable(pcie_pmu, false);
> +		hrtimer_cancel(&pcie_pmu->hrtimer);

While hrtimer_cancel() on an inactive timer is a no-op, it is asymmetric
with event_start which only starts the timer when timer_enable is true.
Please guard it for consistency:

       if (pcie_pmu->timer_enable)
           hrtimer_cancel(&pcie_pmu->hrtimer);


Thanks.
Shuai
