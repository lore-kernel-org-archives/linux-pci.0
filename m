Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C273EC685;
	Thu,  3 Sep 2026 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463161; cv=none; b=PrmOZkdC751fuS7zRj33PwB2JO/a/9DkA9x31AA9PQILOY1G45oTg/J3nVfoSJkQkRS2JcdN6leyDiqt3dgMF+ajua15ZsXwW+/FYemAb5CKpMPbwLngijivfk7UCmIopvGOX/EE+DgG+UidtqpoNQHrrgK451/exPSYrmy0uak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463161; c=relaxed/simple;
	bh=nEmfX9IloLFOpbtE1DK+3a6xIlvHJMYdiJIOa9MMdUQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UxFfCmt/aeWBXnhypz5xpPSugntriNyRiNeTgNnwV6s9Rh2YpUJGxTK/ePezPwE+G/cOAuKWnivEQ1L/K4qAPqsSrAPNwf8f7PwYpAHGtGuXOlWl0OioWcAVxaFf/ADi7q6TUgky8WaHaQ4CQH4UhXIahqvH8zlGmvhVcjWmWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z+/iiKq4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z+/iiKq4"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683ICiEb566366;
	Thu, 3 Sep 2026 19:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1KAhXVaxLdCjSi8v1isN8MOQkuFeoI805kch4NCeY5g=; b=Z+/iiKq4p4x5nuix
	MtXjlj2lEbMewEEK06TDvFQlLX3g3HQwdyp6prv/g9iQPuQ1+2SEppZtLfZEw8Kt
	lmmED3pY5fYnKlq0JFxzWl+pRCe5I69j67hwkLoBYu/rp57ZmWklfE2IHO299Jxl
	zJ7o6qAf6PimzBSYQFZwZAAt9+W7ZShGFiAHb7NJ4qhEI3lrLf9qi3O6yO1+u7qr
	nQm5RkqxMHow/WhNOwMQG64JZ1s8mXeYrF0kJYUBmUz8QdZNuLeN+pDJsmRVILV/
	6P8fBIhrAw4oF+JNJWEG0oyKfNWdqzL9XrO4PpsvBHKIJVlrfb5BeDGIGFo0rKcL
	1dpUQg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyp0997-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:36 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 683JIa113232800;
	Thu, 3 Sep 2026 19:18:36 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 683JIZ1N3232778
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:36 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 77C6524DD7;
	Thu,  3 Sep 2026 12:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 13/13] iommu/arm-smmu-v3: Enable PRI for PCI device
 in arm_smmu_probe_device()
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
        bhelgaas@google.com, praan@google.com, kevin.tian@intel.com,
        kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
        bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <b0442ba9eb1598bf07782b14fbcad284bcefbe40.1788222486.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <b0442ba9eb1598bf07782b14fbcad284bcefbe40.1788222486.git.nicolinc@nvidia.com>
Date: Thu, 03 Sep 2026 12:18:33 -0700
Message-Id: <178846311320.1308030.2192800704181905560.b4-review@b4>
X-Mailer: b4 0.16.0
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: lapXz9Lcf-Qfq54ReHLXWEO3vwYtFmfz
X-Proofpoint-GUID: lapXz9Lcf-Qfq54ReHLXWEO3vwYtFmfz
X-Authority-Analysis: v=2.4 cv=Q5XiJY2a c=1 sm=1 tr=0 ts=6a99c80c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=Ikd4Dj_1AAAA:8
 a=EUspDBNiAAAA:8 a=EIqCPuMYCVkQZYwhltEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfX/DpWtldwLDs9
 3vU7LoBF1hILaCVkKBNnd61LoiHnxSZFWNHoaARCBeFZUov62YzH6p1yzCeJxy8o1xTzSK35ic0
 tvAuYi1VDiTRTuoC4ifAOK5Kq7Sj4HwUp/yGt2XQm+2Yh9nnATVU2EFNq5n5JOVjKSApvml/54I
 V3HLCsUMT82IMZITOBx97FBGWxyR+nLySLmSnEcn3f0YzydDT2F2+vzEjtcoF4FfmdKma4z8vPV
 y6o5ubwv9cwKP+cD9zBzV6fOE1X6NNmDDamk26zFhAdWU8dZhed76G+l1CEAvJmdIFQRyY94n2/
 3qZshzui4v71HaaEGD7Y51jzDQ8SplORsULAkZA3AftLk/xhe8LBChsLlpmwzJnwwSCe7Sd+FTR
 kvq1xMJjvg57EntPu4b8RT1F/y7hTy5qdt3/wvJ+DZHfEPBfyT92ss05bRA4NWFQGRGvxFGJ3gN
 mTUYg7YbBMDViXacAlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfX75KocQD0vcNm
 frvcpoyEPo6KtSa/pEWsJKeSXWy8LSWileHqSdzJ0CXoA3AYR7F0n8Ogaxw6Tkm8M1KsVn/tjJ3
 /ZtwE7QXmEAj/ZGvNBjFc2I2ptDFkwM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030168

> Now PRI requests can be correctly handled. Enable the PCI cap when probing
> a PCI device. Also flush the priq in arm_smmu_attach_release().
> 
> Drain the priq for any PRI-enabled master following the same rationale as
> the eventq drain: a stale page request must be answered while it can still
> resolve to the old attach handle, even when the old attachment did not set
> up IOPF, or else the threaded handler could route it to the next domain.
> 
> Note that PRI is enabled at the probe time, while ATS gets toggled by the
> attach/detach routines, so a master could have PRI enabled when its ATS is
> disabled. PCIe (Base 6.3, Table 10-14) sets no ATS precondition on the PRI
> Enable bit. Its only ordering rule is that the interface must have gotten
> successfully Stopped prior to an enabling, which pci_enable_pri() already
> checks using PCI_PRI_STATUS_STOPPED. Also, a PRI-enabled device would not
> issue a page request until it starts to use ATS.
> 
> Set the per-device outstanding request budget to the full priq depth, same
> as intel-iommu's per-device PRQ_DEPTH choice. A fixed per-device cap won't
> prevent multiple PRI-capable devices from potentially exceeding the priq's
> capacity; priq overflow is recoverable per the SMMUv3 spec, and it is rare
> in practice.
> 
> Select PCI_PRI in Kconfig like other IOMMUs, gated on PCI so the build can
> stay clean for non-PCI ARM SMMUv3 configurations.
> 
> SMMUv3 forbids the Stall model on PCIe streams. Refuse to enable PRI on a
> PCIe master that came with stall_enabled, so page_response() can dispatch
> on master state unambiguously.

As earlier, we have exceptions in tree for Stall mode on PCIe streams
(lets not reopen that fun arguement) so I'd focus this on PRI not
making any sense if stall mode is in use as that has alternative
handling for page faults.


> 
> Refuse to enable PRI as well on any master reporting num_streams != 1, as
> arm_smmu_enable_iopf() rejects multi-stream masters, so IOPF cannot be set
> up for them; keeping PRI enabled would let a PRI request arrive on an alias
> StreamID and get a PRI_RESP_DENY issued against streams[0] by the driver's
> error-response path.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
A few minor things in here.

Thanks,
Jonathan

>
> diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
> index b848a4253677..a31d04f5b031 100644
> --- a/drivers/iommu/arm/Kconfig
> +++ b/drivers/iommu/arm/Kconfig
> @@ -80,6 +80,7 @@ config ARM_SMMU_V3
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select IOMMU_IOPF
>  	select GENERIC_MSI_IRQ
> +	select PCI_PRI if PCI
>  	select IOMMUFD_DRIVER if IOMMUFD
>  	help
>  	  Support for implementations of the ARM System MMU architecture
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 47c95b691503..d35d814900cb 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3509,6 +3509,17 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
>  			synchronize_irq(smmu->combined_irq);
>  	}
>  
> +	/* Same as the eventq drain above, for the hardware priq */
> +	if (master->pri_enabled) {
> +		ret |= arm_smmu_drain_queue(smmu, &smmu->priq.q, false);
> +		/* Ensure pending requests have reached the IOPF queue */
> +		if (!ret && smmu->priq.q.irq)

Similar to before, I'd factor out the if (!ret)
Using |= on return values is never particularly nice though safe
as used here.  Still I'd use another variable to store that things
timed out already so we are skipping these.

> +			synchronize_irq(smmu->priq.q.irq);
> +		/* Pending requests might be in the combined_irq handler */
> +		if (!ret && smmu->combined_irq)
> +			synchronize_irq(smmu->combined_irq);
> +	}
> +
>  	/*
>  	 * Only IOPF-enabled attachments queue fault work, and such work
>  	 * references the old domain via its attach handle. Flush it, as
> @@ -4446,6 +4457,40 @@ static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
>  	return arm_smmu_alloc_cd_tables(master);
>  }
>  
> +static void arm_smmu_master_enable_pri(struct arm_smmu_master *master)
> +{
> +	struct arm_smmu_device *smmu = master->smmu;
> +	struct pci_dev *pdev;
> +	unsigned int reqs;
> +
> +	if (!(smmu->features & ARM_SMMU_FEAT_PRI) || !smmu->evtq.iopf)
> +		return;
> +	if (!dev_is_pci(master->dev))
> +		return;
> +	pdev = to_pci_dev(master->dev);
> +
> +	if (!pci_pri_supported(pdev))
> +		return;
> +
> +	/* SMMUv3 forbids the Stall model on PCIe streams */

Again, I'd tweak the wording given we have quite a few examples
in tree that do stall mode on PCIe smelling streams.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
