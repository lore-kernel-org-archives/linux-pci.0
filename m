Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C7468C3D;
	Thu,  3 Sep 2026 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463156; cv=none; b=JCSLMIDEZx68qhSt3w7lixMGEdiFIw0hSI9nQPFaCUuc4qTvAssmBO3nFp+xj+n6UTXBDWMpK7dOEoD3KA338eyvB4EuFKQn2VKusJIb358K5jil+qko8LhmsdpO0xaQebodjOjy5ZfnJ7z9tkV7QjR8wPPAhYJxMmWiCuw6A+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463156; c=relaxed/simple;
	bh=+oHvx2p86yR18ioZGVS0GG3j14KXah5E2NiBfOuTsLs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Wpp0U56jua2BML1Esz74MyBh2tmlYqsQRiGd9/+YqkG2CVuZA47WxJ4QVZXGmYZAdaN3aC2vjtz5/ttibu1d7T0zxoFHMKaN3HvUJGg4O/pJkqGKO4nIUzJpbWX2vaX7t3X4TL1DTdYD5C3PW0U6Jn1kRgq9zZ01nOELJX0RZ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VzmRDqIw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VzmRDqIw"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G3cp4820114;
	Thu, 3 Sep 2026 19:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+8xEV3gyB+b412oqy+yUU2duGYCltNshXlEAgs5AS5Y=; b=VzmRDqIw5n/9C8+6
	rk00fIp9NHmuYzq/TUv6CIbqNuiqVN/pq6uZJGIw+6aTAKJ7Wa1qeNbdWL5b5UO2
	gkKKDpbB6epH7ms6PyWVNxgoeSFzqKrRg5c5V6Wn48mwKFdUG58G20nvdes9/qhc
	Vnsds/0eUHiUIfimK6PxMJb9red28X3akQon2YIXnfqnCb6tdu1Jq0GOQuX0vLI+
	q/DKfh2sX6UudpkAOZKV4BcYqE0TX/5I+yXYrKf/HMwPdqL/744MOJNwCPh3HRsy
	VK6KAtaQfTH5KpLd3bcy0acESzTTR1alHSn1/2OThtqiCGeuh2GA00NknyJZXGZ5
	MI3rLw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf82ka6fn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:36 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 683JIZdl3196770;
	Thu, 3 Sep 2026 19:18:35 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 683JIZp63196746
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:35 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 64E7F23A06;
	Thu,  3 Sep 2026 12:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 04/13] iommu/arm-smmu-v3: Flush in-flight fault work
 on domain detach
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
        bhelgaas@google.com, praan@google.com, kevin.tian@intel.com,
        kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
        bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <45b6e8c6dab5b67a91ba54c32bf11ab3347d80f5.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <45b6e8c6dab5b67a91ba54c32bf11ab3347d80f5.1788222485.git.nicolinc@nvidia.com>
Date: Thu, 03 Sep 2026 12:18:33 -0700
Message-Id: <178846311317.1308030.4066178511081757826.b4-review@b4>
X-Mailer: b4 0.16.0
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: Xg9Op-iI-ZDiO6YQlU-kMVWlq1BKuHgS
X-Proofpoint-ORIG-GUID: Xg9Op-iI-ZDiO6YQlU-kMVWlq1BKuHgS
X-Authority-Analysis: v=2.4 cv=OuJ/DS/t c=1 sm=1 tr=0 ts=6a99c80c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=Sr6eo-UsTNkHwbmlQE8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfX0JaJGElLw2ei
 I4E++lHkL1n3mpZ1ZFFPR4rUvVePpMioX17P+Y8Qyg6kOiT4QzcNGRkjPDQabvMlPJmzzs+tago
 k97c7TjnIrLuUXYawAS9jT+JK0YoAUx3LOfeIW7mu3m90xtDdXTfcr7XngaT9n5UoTPG49Jmi0U
 xYOsPreYw6R0wK+U/hqrZjH/ct1upZ16g+TmlpaqBJz/Ehi8cZwPg6R4vBU87SevAI3qfSx3fQN
 U4GJH7Qi5fNcSty//B8iWbIVKMpiQe3GpJn7hcfEcT7YDy6kSwdZj8TmFukGbT91sC+Q7wv0VLa
 qCGeYiWyXZip4ukN/UZ26V5mE4A0/J0Y35M2ne01g1XA9X9DuZn4ph5xsd4yDp2UF/Nb367MNDz
 YtpABk1uWk59Bn/Avpn9SNXFbz/6WdKL+JbxaTr9og9hzoDWvvHW33KxW+WLDS23cJKdVVX/1ZV
 DbxBMAMiqFMk/C+MVKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfXzjcNfJpdMZyJ
 Oa6cSkrDP0IJQ6nlxvBEG38oEDqp5H4Zhp2arfn8vncP/Tjmxhjc6+uZj5zx9t5x3XqmCEumjpF
 6MeuHSaY8/hkDWV7wu/7O62AxcusVEQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030168

> arm_smmu_attach_release() polls the hardware event queue to drain all the
> in-flight stall events for an old domain that the IOMMU core might free at
> any moment. However, a drained event is dequeued, yet it is not necessarily
> handled, and the IOPF work for a handled one can still be running.
> 
> So, first synchronize_irq() on the evtq and the combined IRQs following the
> drain, in order to guarantee that every dequeued event has reached the IOPF
> workqueue, since synchronize_irq() waits for an in-flight IRQ thread. Skip
> the waits on a timed-out drain though, since a stuck consumer would block

drop the "though" - doesn't read well or add anything.

> the unbounded wait_event() inside synchronize_irq() as well.
> 
> Then, invoke iopf_queue_flush_dev() to finally drain the IOPF workqueue, as
> the fault work references the old domain via its attach handle, while the
> IOMMU core might free that old domain once the detach call returns.
> 
> If arm_smmu_drain_queue() times out, fault work may still be in flight, and
> iopf_queue_remove_device() would free iopf groups that the queued work also
> references. Skip the iopf teardown and leak the master_domain, rather than
> risk a use-after-free.
> 
> The skip also leaks the iopf refcount, keeping the device enrolled on the
> IOPF queue, which would strand its fault parameter on the queue list once
> the device teardown frees dev->iommu, crashing a later iopf_queue_free().
> Reclaim the enrollment in arm_smmu_release_device(), where all the attach
> handles are gone so a straggler report cannot queue a new fault group.
> 
> Note that a residual race window remains between an iopf_queue_flush_dev()
> and iopf_queue_remove_device(): a fault arriving in between still resolves
> to the old attach handle, as the IOMMU core publishes a handle change only
> after the driver ops return. This window predates the drain narrowing it,
> and is only closable by an ordering fix in the IOMMU core. Furthermore, a
> timed-out drain shares exactly the same window, given that it must keep the
> device enrolled on the IOPF queue, where iopf_queue_remove_device() would
> free the iopf groups that any in-flight fault work still references.
> 
> Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
> Cc: stable@vger.kernel.org # v6.16
> Co-developed-by: Barak Biber <bbiber@nvidia.com>
> Signed-off-by: Barak Biber <bbiber@nvidia.com>
> Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d255ff2519f9..1851ee7ec15b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3399,6 +3399,7 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
>  	struct arm_smmu_master_domain *master_domain = state->old_master_domain;
>  	struct arm_smmu_master *master = state->master;
>  	struct arm_smmu_device *smmu = master->smmu;
> +	int ret = 0;
>  
>  	lockdep_assert_not_held(&arm_smmu_asid_lock);
>  	iommu_group_mutex_assert(master->dev);
> @@ -3412,8 +3413,40 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
>  	 * up once the IOMMU core swaps the handle, mistakenly resuming it
>  	 * against the next domain.
>  	 */
> -	if (master->stall_enabled)
> -		arm_smmu_drain_queue(smmu, &smmu->evtq.q, false);
> +	if (master->stall_enabled) {
> +		ret = arm_smmu_drain_queue(smmu, &smmu->evtq.q, false);
> +		/*
> +		 * Ensure pending events have reached the IOPF queue, unless
> +		 * the drain timed out: a stuck consumer would also block an
> +		 * unbounded wait_event() inside the synchronize_irq().
> +		 */
> +		if (!ret && smmu->evtq.q.irq)
> +			synchronize_irq(smmu->evtq.q.irq);
> +		/* Pending events might be in the combined_irq handler */
> +		if (!ret && smmu->combined_irq)
> +			synchronize_irq(smmu->combined_irq);

I'd group the two things that happen if we didn't time out.

		if (!ret) { /* Didn't time out */
			if (smmu->evtq.q.irq)
				synchronize_irq(smmu->evt.q.irq);
			if (smmu->combined_irq)
				synchronize_irq(smmu->combined_irq);
		}
		
> +	}

Thanks,
Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
