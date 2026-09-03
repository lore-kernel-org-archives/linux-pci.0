Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0794F30D4;
	Thu,  3 Sep 2026 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463172; cv=none; b=Hbc/iSdoUUt6+TtffefTb0QjywAuzHA3MbtCjRYy8ykO8IcdDJ+pMiu4I7pENr/DtDfpvW+BR/A3xfbDJnICEJTiroyhNmEPFPmnCOVElX70L49b+oNqrSVhaZOVUXKDHv2J+QOiw9/ssUBq5MivoHWl8cJlqdWTh4zIxWM1ehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463172; c=relaxed/simple;
	bh=PlFzrKm+Ru+2/+E6exxz8A0VNdYsRRHqwIQg8mG5aU0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=KzdA3yPhfzm0eqIk5zlwzSDHxcAk59mDdSax9LQzVYSFfjfkQmWqV3MDCTDaUjQgCB5VOp/eJx3qKzhsR33zPIB1f046BVRabPtR/QRPH6VnTjYdk1W2SdzUSbgWW0UNoek0M+rX/VMhbN1f6wBpV+yuzCcLY3fZv2/hZhqjbSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KIKohKdg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KIKohKdg"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G38JC927725;
	Thu, 3 Sep 2026 19:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ra7IVCkWuPaYE58YBy2u4tVccX4wVFTrsAKPrrP920Q=; b=KIKohKdgCpsbEAQd
	Lj+o5+B9ZsBQdPo+6YbkYtQHxiMG/pPZEpmxi+7I0v6ZiwXOJ7xvC62iRZGmcR6d
	xfGSOgAXjpFPxyM5wJ7d2yUr0kxuch6JAKnPc8cRB0w4yH7U98s0W7AFutMfqf7S
	1dZs1m+DszcLoK8F6EkQKCOaV7inI316+4pBjYXyY+1AOyGCC/OinQR5JoGcCgMC
	I7/QzS4LgOtRERikpS18xAIhaLgmSEj2Wdd0Bnqnonsi0K7JqtQkzEigoojpX4nV
	p8ttGCMmB3RNCTX+cGZ++pWIdKMtjLUtxrOPLpaHyoXPn57AdrRa4TfxCLzf7PDQ
	kf1Xow==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx2f6e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:36 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 683JIZTZ3214824;
	Thu, 3 Sep 2026 19:18:35 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 683JIZXM3214814
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:35 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 633FE22A92;
	Thu,  3 Sep 2026 12:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 03/13] iommu/arm-smmu-v3: Drain in-flight fault
 events on domain detach
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
        bhelgaas@google.com, praan@google.com, kevin.tian@intel.com,
        kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
        bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <8717f3329313f40308cff20006066283ebbb3a56.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <8717f3329313f40308cff20006066283ebbb3a56.1788222485.git.nicolinc@nvidia.com>
Date: Thu, 03 Sep 2026 12:18:33 -0700
Message-Id: <178846311316.1308030.6266899352044838554.b4-review@b4>
X-Mailer: b4 0.16.0
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: P8CdFX83cmwPHD-hm_KK9XDm2mq3yTJq
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a99c80c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=5E8cN6LfZOETjOzBigwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P8CdFX83cmwPHD-hm_KK9XDm2mq3yTJq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfX/x7ObPDJp0pN
 Av+qnrblfs97f0jRMbVhfDkHmtlf2pInT3XzjatGXW2L7YQ+PdIEO9ku+IJqawcBo2qg0INxyuP
 qWByYrFtUXPboGEZzFzMzPC+BAf05LhPIXnHqLuxF4oApVsg4DqGAh0vyeYpMLc2zf+I2ErGfoD
 BbVJPq3vpSwysJ2opnULWs3eYMgZPeVFcpEsClaNiiPmZfjlh0quCoOa2KbQ0/J9+v0CcFBfVvC
 Curo4a6JJxlAmIOwdE+9PEpKr/RtOvQ2gq/GIdal6utLLS4ikNj/BYbyrr9Bt5abtx/AIfro+Nk
 jY5ywvz3vYHSCx9g+a0DoFWWVm5nPU8y3EYO+/eCMfMad7Kw4od2Dz9grHKGyce7eJKsSfbfXS+
 ZeJZy3JiYsG9OCb1O35jHATpWNJf2+u4rIWLzb+ZFjcWI+TeYtrDXRE84AnB/Isc8Rw7+ze11ny
 yNiYV5thHjQh6cR+zIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfX5mppCfGFpokC
 DU6CAlWJMg8fb0uq5atRDH6smQ2YmkQYPZAGcF1sDUFilkjGN5FjJyUMjWcB/mZ9OXyIM53I9Gp
 GJ4NdF4ZbPFBwN0eyOKvRjkcrnb4s2I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030168

> When a device is switching away from a domain, either through a detach or a
> replace operation, in-flight stall events for the old domain might still be
> on the SMMU's hardware event queue or on the IOMMU core's IOPF queue. Thus,
> if the IOMMU core swaps the device's attach_handle and frees the old domain
> before those handlers complete, the IOPF work might hit use-after-free.
> 
> Two queues need to be drained: the SMMU hardware event queue and the IOMMU
> core IOPF software workqueue. Start with the former: add a counting-based
> arm_smmu_drain_queue() helper, and poll the evtq on a domain detach, so a
> pending IRQ won't let the threaded handler run after the drain and queue a
> fault referencing the domain being freed. Its until_empty mode serves the
> suspend and runtime PM routines that would drain the CMDQ. Any timed-out
> drain fires a WARN_ON as well, since reaching the timeout would take some
> stuck consumer in any realistic case.
> 
> The existing queue_poll() API is not reusable for such a drain: it is the
> atomic busy-wait for the command issuing paths, and it assumes a hardware
> consumer making progress. A drain caller is sleepable, in contrast, while
> the EVTQ/PRIQ consumer is a threaded IRQ handler that needs the CPU: such
> a busy wait would starve the handler throughout an entire timeout, whenever
> the waiter and the handler shared one CPU on a non-preemptible kernel. So,
> this new sleeping helper is marked with a might_sleep() as well, given that
> an atomic-context misuse would otherwise hide behind an empty queue.
> 
> Note that a drained event is dequeued, but not necessarily handled, since
> queue_remove_raw() moves the MMIO CONS before the threaded IRQ handler gets
> to push the event onto the IOPF workqueue. A subsequent change will invoke
> synchronize_irq() and iopf_queue_flush_dev() to close that gap, and it will
> act on the errno of a timed-out drain too.
> 
> The drain runs before the IOMMU core swaps the device's attach handle, so a
> fault event generated on the new STE during this window resolves to the old
> handle, completing with IOMMU_PAGE_RESP_INVALID that resumes the stall with
> abort: the impact is bounded to that one failed transaction.
> 
> Also run the drain for every stall-capable master, even when the departing
> attachment did not enable IOPF: such a stall event has to be aborted while
> it still resolves to the old attach handle, otherwise the threaded handler
> could pick it up right after the handle swap, mistakenly resuming it as if
> it were a valid page fault against a new domain.
>

Useful perhaps to call out if this has been seen in real systems or
not. I agree with the analysis but would rather hope drivers are
well behaved in ensuring all traffic is done, adn this is hardeninging
/ handling of naught hardware activity (all good if so!)

> Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
> Cc: stable@vger.kernel.org # v6.16
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index e00b6c88214f..d255ff2519f9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -948,6 +948,86 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
>  					   cmds->num, true);
>  }
>  
> +/**
> + * arm_smmu_drain_queue - Drain an SMMU queue
> + * @smmu: the SMMU device
> + * @q: the queue to drain
> + * @until_empty: target selection
> + *
> + * With @until_empty == true (for CMDQ), exit once the queue is observed empty:
> + *
> + *   cons0                cons                                prod
> + *     |                   |                                   |
> + *  ---+###################+=====================+=============+--->
> + *                         |<--------- undrained==0? --------->|
                                                    ^
What is the + indicating?  Seems where prod0 that isn't relevant here
would have been - that is a little confusing so maybe drop?

> + *
> + * With @until_empty == false (for EVTQ/PRIQ), exit once "drained" reaches its
> + * target: "pending" (i.e. prod0 - cons0, frozen at the entry time):
> + *
> + *   cons0                cons                 prod0         (prod)
> + *     |<---- drained ---->|                     |             |
> + *  ---+###################+=====================+=============+--->
> + *     |<--------------- pending --------------->|
> + *
> + * Note that a drained entry is dequeued, but not necessarily handled: the
> + * EVTQ/PRIQ callers must follow up with a synchronize_irq() to wait for the
> + * threaded IRQ handler to finish handling the dequeued entries.
> + *
> + * Context: Process context; may sleep.
> + * Return: 0 on success or a negative errno on timeout.
> + */
> +static int arm_smmu_drain_queue(struct arm_smmu_device *smmu,
> +				struct arm_smmu_queue *q, bool until_empty)

That name suggests this is doing the draining rather than waiting
for it to happen elsewhere.

> +{
> +	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
> +	u32 cons, prod, prev, undrained;
> +	u32 drained = 0, pending;

Pet irritation. Prefer splitting the elements that assign and those
that don't onto seeprate lines.  Here that just means moving pending
up one line.

> +
> +	might_sleep();
> +
> +	cons = readl_relaxed(q->cons_reg);
> +	prod = readl_relaxed(q->prod_reg);
> +	/* The exit target: the number of entries in the queue at entry */
> +	pending = Q_POS(&q->llq, prod - cons);

Applying a macro called Q_POS to a difference is a bit confusing to
me given the output isn't a position of anything. Maybe just needs
a wrapper Q_DIFF(q->llq, prod, cons)  Can use Q_POS underneath
but avoid that naming out here well away from the macro definitions.

> +
> +	while (true) {

Maybe pull defintion of prev and undrained in here so it is clear
they aren't state maintained across iternations.

> +		/* Accumulate the entries consumed since the last poll */
> +		prev = cons;
> +		cons = readl_relaxed(q->cons_reg);
> +		drained += Q_POS(&q->llq, cons - prev);
> +
> +		prod = readl_relaxed(q->prod_reg);
> +		undrained = Q_POS(&q->llq, prod - cons);
> +
> +		/* Exit on an empty queue, regardless of until_empty */
> +		if (!undrained)

Given you don't use undrained again (maybe in later patches, in which
case ignore me.)
		if (Q_DIFF(&q->llq, prod, cons) == 0)
perhaps.  This one entirely up to you as maybe the named local does
help with readability a little.

> +			return 0;
> +
> +		/* Snapshot mode: exit once the pending entries are drained */
> +		if (!until_empty && drained >= pending)
> +			return 0;
> +
> +		/*
> +		 * A timeout means the consumer might be stuck. In theory, if it
> +		 * moves 2 * qsize entries or more within a single poll interval
> +		 * Q_POS() would wrap and undercount drained: that could trigger
> +		 * a spurious warning too, if the queue was never once observed
> +		 * empty. Yet, that much consumption in such a short interval is
> +		 * unrealistic. WARN it only, as a stuck consumer is a real bug.

I don't like 'unrealisitic' based defenses (even though I agree it is pretty
unlikely).  Is there a way to bound this?  Maybe future systems will
be much quicker.

> +		 */
> +		if (WARN_ON(ktime_compare(ktime_get(), timeout) > 0))

Why WARN_ON here then a dev_warn_ratelimited() below? 

> +			break;
> +
> +		/* The consumer might be a threaded IRQ handler. Yield to it */
> +		usleep_range(100, 200);

fsleep() perhaps then we don't get to argue why that slack.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
