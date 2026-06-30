Received: from va-2-35.ptr.blmpb.com (va-2-35.ptr.blmpb.com [209.127.231.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065A2F8E98
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839915; cv=none; b=aIrDvkocYvxEphmXkg8SWFURLntPjj5wiyzpW4kb+San/hGM2m0O0Kc1rqSICNmW7Hrcyw+raSHYaomjWzYjLuv8CUMtzsIYn7E7iPdGFu+TOYT8PfG1DXuYPJpq87vlO/ji4AGEgLq0Tpb+saPAMoNWdp7/cqsylz13mvqXh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839915; c=relaxed/simple;
	bh=JTZkHeISkECnYfbPjuqdl1a7GwJAQRtNALuGJeyTgYM=;
	h=To:Date:References:Subject:Message-Id:Mime-Version:Content-Type:
	 Cc:From:In-Reply-To; b=LZDnclp5Zou/fmQa0dYuGrjIkgu3tz+cY9DWq883EMCqjX/J4SodVPSLbab2H9Az9oGDko6uWaE/zcOjTSaXzkkE+HNkZkz1XmmfYv3+mFjsYAnwMmRC6Em9yUSqPdgMxW2+Xklav9x2OgBPJ8v0tkVQfQRhbma4WZ5bCIGety0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=q1peLlqN; arc=none smtp.client-ip=209.127.231.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="q1peLlqN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1782839906; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JTZkHeISkECnYfbPjuqdl1a7GwJAQRtNALuGJeyTgYM=;
 b=q1peLlqNHDAXvhhteSiEAhhlAuNAqZ0Xx671v/bkh55TnhqMvx3RpXNUmIXdEcXAIBBxnJ
 9Gd1Rh0zLkONTVt6Ee62k6rcrLwLXW3OcLrLg1NPa5Hrd2Bayn0JqX6DW7KA1D2us2go3C
 DJex7BJV7rBlHZ5hH5w4qWxiOfh7oXv76mbqVLIHrAJo4Es1F41M3YWXrqg8nbUW5/lvmV
 gVNZygv2oWQNWKVomG5Tv20jrvv0QbSW6xg8UsLAl6eAKSCgjOQxeQd6mDQSiKQHqRGo7U
 DU9nZbpl2luhhHb+gQfTmQHHjFYQHSnxKegWs1jBSRDXGeG+Zi0LE0q4wzbD3w==
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Date: Wed, 1 Jul 2026 01:18:22 +0800
User-Agent: Mozilla Thunderbird
References: <20260629092717.74946-1-yang.yicong@picoheart.com> <20260629092717.74946-3-yang.yicong@picoheart.com> <a1bbf438-c0d3-4467-9852-657fb93bc548@linux.alibaba.com>
Received: from [172.16.14.160] ([111.203.238.242]) by smtp.feishu.cn with ESMTPS; Wed, 01 Jul 2026 01:18:24 +0800
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] perf/dwc_pcie: Support narrowed time-based counter for long time monitoring
Message-Id: <387712cd-de35-46bf-81c1-a03e93cff709@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a43fa61+6d06a6+vger.kernel.org+yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Cc: <renyu.zj@linux.alibaba.com>, <will@kernel.org>, <mark.rutland@arm.com>, 
	<jic23@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <yang.yicong@picoheart.com>, 
	<jingoohan1@gmail.com>, <mani@kernel.org>, <juwenlong@picoheart.com>, 
	<geshijian@picoheart.com>, <douyufan@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
In-Reply-To: <a1bbf438-c0d3-4467-9852-657fb93bc548@linux.alibaba.com>

On 6/30/26 4:50 PM, Shuai Xue wrote:
>=20
>=20
> On 6/29/26 5:27 PM, Yicong Yang wrote:
>> From: Yufan Dou <douyufan@picoheart.com>
>>
>> The DWC PCIe Time-Based Analysis Data Register (the counter for time-bas=
ed
>> events) is architected as 64-bit, but some hardware implementations do n=
ot
>> implement the full width.=C2=A0 On these implementations the counter sto=
ps after
>> reaching its implemented width. This will limit the usage for short time
>> monitoring only. The counter will only cover ~15s for monitoring RX TLP
>> payloads on our platform.
>>
>> Add an optional hrtimer that fires every 2 seconds. It'll take the role
>> as the counter overflow interrupt to read-update-reset the counter and
>> event counts to break the limits of the narrow counters. It'll only
>> apply on timer-based counter. The 2 seconds update period is the half
>> of the maximum counting period (4s) of the time-based counter under
>> period counting mode of the hardware.
>>
>> Because fully-implemented 64-bit counters do not need this workaround,
>> enable this hrtimer on the platforms known to have narrowed counter.
>>
>> Before this patch, when counting fio for 10m the counts is incorrect:
>> =C2=A0=C2=A0 root@localhost:/tmp# perf stat -e dwc_rootport_20000/rx_pci=
e_tlp_data_payload/ -- fio --runtime=3D10m fio_job.config
>> =C2=A0=C2=A0 [...]
>> =C2=A0=C2=A0 Run status group 0 (all jobs):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 READ: bw=3D5594MiB/s (5865MB/s), 5594MiB/=
s-5594MiB/s (5865MB/s-5865MB/s), io=3D3278GiB (3519GB), run=3D600010-600010=
msec
>> =C2=A0=C2=A0 [...]
>> =C2=A0=C2=A0 Performance counter stats for 'system wide':
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 137,438,953,456=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dwc_rootport_20000/rx_pcie_tlp_data_payload/
>>
>> After this patch the counts is as expected:
>> =C2=A0=C2=A0 root@localhost:/tmp# perf stat -e dwc_rootport_20000/rx_pci=
e_tlp_data_payload/ -- fio --runtime=3D10m fio_job.config
>> =C2=A0=C2=A0 [...]
>> =C2=A0=C2=A0 Run status group 0 (all jobs):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 READ: bw=3D5632MiB/s (5905MB/s), 5632MiB/=
s-5632MiB/s (5905MB/s-5905MB/s), io=3D3300GiB (3543GB), run=3D600013-600013=
msec
>> =C2=A0=C2=A0 [...]
>> =C2=A0=C2=A0 Performance counter stats for 'system wide':
>> =C2=A0=C2=A0=C2=A0 3,543,850,268,576=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dwc_r=
ootport_20000/rx_pcie_tlp_data_payload/
>>
>> Signed-off-by: Yufan Dou <douyufan@picoheart.com>
>> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
>> ---
>> =C2=A0 drivers/perf/dwc_pcie_pmu.c | 69 ++++++++++++++++++++++++++++++++=
++---
>> =C2=A0 1 file changed, 65 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
>> index 5385401fa9cf..7ec8302d4090 100644
>> --- a/drivers/perf/dwc_pcie_pmu.c
>> +++ b/drivers/perf/dwc_pcie_pmu.c
>> @@ -11,6 +11,7 @@
>> =C2=A0 #include <linux/cpumask.h>
>> =C2=A0 #include <linux/device.h>
>> =C2=A0 #include <linux/errno.h>
>> +#include <linux/hrtimer.h>
>> =C2=A0 #include <linux/kernel.h>
>> =C2=A0 #include <linux/list.h>
>> =C2=A0 #include <linux/pcie-dwc.h>
>> @@ -83,6 +84,7 @@ enum dwc_pcie_event_type {
>> =C2=A0 =C2=A0 #define DWC_PCIE_LANE_EVENT_MAX_PERIOD=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 GENMASK_ULL(31, 0)
>> =C2=A0 #define DWC_PCIE_MAX_PERIOD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENMASK_ULL(63, 0)
>> +#define DWC_PCIE_PMU_TIMER_PERIOD_NS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (2 * NSEC_PER_SEC)
>> =C2=A0 =C2=A0 struct dwc_pcie_pmu {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pmu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pmu;
>> @@ -93,6 +95,8 @@ struct dwc_pcie_pmu {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Groups #6 and #7 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DECLARE_BITMAP(lane_events, 2 * DWC_PCIE_=
LANE_MAX_EVENTS_PER_GROUP);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct perf_event=C2=A0=C2=A0=C2=A0 *time=
_based_event;
>> +=C2=A0=C2=A0=C2=A0 bool=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 timer_enable;
>> +=C2=A0=C2=A0=C2=A0 struct hrtimer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 hrtimer;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hlist_node=C2=A0=C2=A0=C2=
=A0 cpuhp_node;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 on_cpu;
>> @@ -354,6 +358,26 @@ static u64 dwc_pcie_pmu_read_time_based_counter(str=
uct perf_event *event)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return val;
>> =C2=A0 }
>> =C2=A0 +static void dwc_pcie_pmu_reset_time_based_counter(struct perf_ev=
ent *event)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct dwc_pcie_pmu *pcie_pmu =3D to_dwc_pcie_pmu(ev=
ent->pmu);
>> +=C2=A0=C2=A0=C2=A0 struct hw_perf_event *hwc =3D &event->hw;
>> +=C2=A0=C2=A0=C2=A0 u64 prev;
>> +
>> +=C2=A0=C2=A0=C2=A0 dwc_pcie_pmu_time_based_event_enable(pcie_pmu, false=
);
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The hardware counter is reset to zero when d=
isabled. Synchronize
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * prev_count so that the next event_update() c=
omputes the correct
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * delta against the new counter baseline.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 do {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prev =3D local64_read(&hwc->=
prev_count);
>> +=C2=A0=C2=A0=C2=A0 } while (local64_cmpxchg(&hwc->prev_count, prev, 0) =
!=3D prev);
>> +
>> +=C2=A0=C2=A0=C2=A0 dwc_pcie_pmu_time_based_event_enable(pcie_pmu, true)=
;
>> +}
>> +
>> =C2=A0 static void dwc_pcie_pmu_event_update(struct perf_event *event)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hw_perf_event *hwc =3D &event->hw;
>> @@ -429,6 +453,26 @@ static int dwc_pcie_pmu_validate_group(struct perf_=
event *event)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +static enum hrtimer_restart dwc_pcie_pmu_hrtimer_callback(struct=
 hrtimer *hrtimer)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct dwc_pcie_pmu *pcie_pmu =3D container_of(hrtim=
er, struct dwc_pcie_pmu, hrtimer);
>> +=C2=A0=C2=A0=C2=A0 struct perf_event *event =3D pcie_pmu->time_based_ev=
ent;
>> +=C2=A0=C2=A0=C2=A0 struct hw_perf_event *hwc;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!event)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return HRTIMER_NORESTART;
>> +
>> +=C2=A0=C2=A0=C2=A0 hwc =3D &event->hw;
>> +=C2=A0=C2=A0=C2=A0 if (hwc->state & PERF_HES_STOPPED)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return HRTIMER_NORESTART;
>> +
>> +=C2=A0=C2=A0=C2=A0 dwc_pcie_pmu_event_update(event);
>> +=C2=A0=C2=A0=C2=A0 dwc_pcie_pmu_reset_time_based_counter(event);
>> +=C2=A0=C2=A0=C2=A0 hrtimer_forward_now(hrtimer, ns_to_ktime(DWC_PCIE_PM=
U_TIMER_PERIOD_NS));
>=20
> From sashiko:
>=20
> If the PCIe Root Port enters runtime suspend (such as D3hot or D3cold) wh=
ile
> this timer is active, will the hardware accesses in
> dwc_pcie_pmu_event_update() cause problems?
> Accessing the configuration space of a suspended device could return
> corrupted data or trigger system errors like synchronous external aborts.
>=20
> https://sashiko.dev/#/patchset/20260629092717.74946-1-yang.yicong%40picoh=
eart.com
>=20

this looks correct to me but should be a pre-existing issue and not
introduced by this patch.

we didn't handle the runtime D3 of the root port in the original driver,
so it's possible to do periodical counting (perf stat -I xxx) and read
the counter while ecam is not accessible (rootport enter D3cold in the
middle of the couting).

I may need to check it further and this fix should belong to a separate pat=
ch.

>> +
>> +=C2=A0=C2=A0=C2=A0 return HRTIMER_RESTART;
>> +}
>> +
>> =C2=A0 static int dwc_pcie_pmu_event_init(struct perf_event *event)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dwc_pcie_pmu *pcie_pmu =3D to_dwc_=
pcie_pmu(event->pmu);
>> @@ -478,10 +522,15 @@ static void dwc_pcie_pmu_event_start(struct perf_e=
vent *event, int flags)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwc->state =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local64_set(&hwc->prev_count, 0);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (type =3D=3D DWC_PCIE_LANE_EVENT)
>> +=C2=A0=C2=A0=C2=A0 if (type =3D=3D DWC_PCIE_LANE_EVENT) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dwc_pcie_pmu_lane=
_event_enable(pcie_pmu, event, true);
>> -=C2=A0=C2=A0=C2=A0 else if (type =3D=3D DWC_PCIE_TIME_BASE_EVENT)
>> +=C2=A0=C2=A0=C2=A0 } else if (type =3D=3D DWC_PCIE_TIME_BASE_EVENT) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dwc_pcie_pmu_time=
_based_event_enable(pcie_pmu, true);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pcie_pmu->timer_enable)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hrti=
mer_start(&pcie_pmu->hrtimer,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ns_to_ktime(DWC_P=
CIE_PMU_TIMER_PERIOD_NS),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HRTIMER_MODE_REL_=
PINNED_HARD);
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void dwc_pcie_pmu_event_stop(struct perf_event *eve=
nt, int flags)
>> @@ -495,10 +544,12 @@ static void dwc_pcie_pmu_event_stop(struct perf_ev=
ent *event, int flags)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dwc_pcie_pmu_event_update(event);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (type =3D=3D DWC_PCIE_LANE_EVENT)
>> +=C2=A0=C2=A0=C2=A0 if (type =3D=3D DWC_PCIE_LANE_EVENT) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dwc_pcie_pmu_lane=
_event_enable(pcie_pmu, event, false);
>> -=C2=A0=C2=A0=C2=A0 else if (type =3D=3D DWC_PCIE_TIME_BASE_EVENT)
>> +=C2=A0=C2=A0=C2=A0 } else if (type =3D=3D DWC_PCIE_TIME_BASE_EVENT) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dwc_pcie_pmu_time=
_based_event_enable(pcie_pmu, false);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hrtimer_cancel(&pcie_pmu->hr=
timer);
>=20
> While hrtimer_cancel() on an inactive timer is a no-op, it is asymmetric
> with event_start which only starts the timer when timer_enable is true.
> Please guard it for consistency:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pcie_pmu->timer_enable)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hrtimer_cancel(&pc=
ie_pmu->hrtimer);
>=20

ok will fix it. it does look better from the point of symmetric.

thanks.
