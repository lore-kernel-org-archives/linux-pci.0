Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C54FC8DE;
	Thu,  3 Sep 2026 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463166; cv=none; b=I5OLn864iiYhO+baIw2HH/7ZrEK5YWI7yvN/yBCXcFisg1G274PkE9ZWbmpIJFaF8vJTBfgsRXD3EoClBSATiQmRG7LYeerof491wt+PConq9gnWt7qSmc5VHyAyKOSsMQubjGtBMKQS8byMYisIyjEXQ2tbww9dih/Lre2J6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463166; c=relaxed/simple;
	bh=3hHAyVFTGj9AqpULELJgCCjejA/iXxCu6S8jzWP2ypE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=CZ0fxQWBPVTVQYR5xATfZ5z1IhqFsD3UJuyMAoycBnFfxSUt26hgOVUQqbMNB6Jhenn83uZriuGsWmuO12KTwqTdj7PU0Rubv+saPJ+4PYzuEhIlfnS2a6oooj7niXsHn+ChKSAIFLETbXSMJNK0qTHrQIwmu6ZOXtQbW4lQxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N1Bw58ZL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N1Bw58ZL"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G3r9C1091730;
	Thu, 3 Sep 2026 19:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hCyEkgP8KOw4p+DETdduFsvpdNWIMRHML0W3Kv9umQ4=; b=N1Bw58ZLnvOIYUG+
	C0N+HSlgjCknaO3UiosFt3JG0G6O61SNFjt+kofwTHZLZyyn78pB1pSCc75h+yBn
	HHEZPprIqPH8FwcZ/ua8+qt1/kcgSF0SFiEsSSmLApAMRGxvC+BYtNfOq2pQNOlb
	Bjo44exsSlPM+E6eFnV/C4qi+jGlbLUTSJhrtCJfSIGbS8LbQSeTwl0T0kuNs2yb
	txqa6JRoycL0f4XtB/iTeWBwL/VFE5XfLY9b3p4n3sTrXJAQaTcf5aJvMyD1AlCL
	sJVw2Mvgp6JmoasdRSG6n3+19qyLQDY9vOwR0WffBkgP2paxglKmOPmQCWc0VujX
	/LIeZQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf4ekk5tq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:36 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 683JIZqF3196776;
	Thu, 3 Sep 2026 19:18:35 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 683JIZIL3196744
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:35 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 5B238221B6;
	Thu,  3 Sep 2026 12:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 01/13] iommu/arm-smmu-v3: Add
 arm_smmu_attach_release()
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
        bhelgaas@google.com, praan@google.com, kevin.tian@intel.com,
        kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
        bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <7dcf4aaa538a6a14626f5e2854141f14268250fa.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <7dcf4aaa538a6a14626f5e2854141f14268250fa.1788222485.git.nicolinc@nvidia.com>
Date: Thu, 03 Sep 2026 12:18:33 -0700
Message-Id: <178846311316.1308030.7431615023426150106.b4-review@b4>
X-Mailer: b4 0.16.0
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: YbJUb1jxGO03V7TrRPiYKGQQM-ul-niJ
X-Proofpoint-GUID: YbJUb1jxGO03V7TrRPiYKGQQM-ul-niJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfX3tKeZnqicjnd
 3TdxidYv0xpRjIBVJ5xCFl4KKDHSrt9IXQYROG42Z+5MMsqoPt7ES+HCA7IzgFrXDmL/MP0N64p
 dDFa5skTxxXINAs4E5dqy5HfONqazNHFvAFHIauCAfeiw0at148pUI6FYTkkKACLMZrOKU3Q4MM
 oD3kIh5rGFm5B/AmE5bX+dKNivhG3a7q4h+G3rIIS2v1XgrtPza9ev20gFImA/5NPeltgizhsw6
 oOc0LYGyDv8qtBV9qtLMCaX5ElniCsAuRXrl2eH976Dt6iUAACDwmB2AkGt+nGSDUeEVfCxGTFp
 LxaOJyN4Nc7+26mhKIpOehMUxNSls7etpLohDFDIn6aSUWY/F6vawhOvlWlb4cVTZIArfNtGSsP
 ZigemhAyNlhAaXSQ6TkknQUJqaKOxW51KoHJEfu27PgbM+k+LGVdqv06fRD5wRh+bNmWIcdONub
 +qhrMRD6+jRyhOHor0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfX087hNYz9X1N7
 5zMCDOBYzQhvkg45Lmf0AIBPakINaQDGA4uDul0VklVNefYSNgMYSKxwjMFXWEIWDqBnsPG9Egn
 SzKSVqj8+4dUYr7HdB1tYD45H+lViHY=
X-Authority-Analysis: v=2.4 cv=PKc/P/qC c=1 sm=1 tr=0 ts=6a99c80c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=Ikd4Dj_1AAAA:8
 a=EUspDBNiAAAA:8 a=rRYPHyBk5bcyqWwTitIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030168

> The IOPF teardown is done in arm_smmu_remove_master_domain() when releasing
> the master_domain on detach, under the global arm_smmu_asid_lock mutex. But
> the teardown must drain any in-flight IOPF (for the old domain), before the
> master_domain is freed via iopf_queue_flush_dev() calling flush_workqueue()
> that can block on user-faulting page-fault handlers. Doing so while holding
> the arm_smmu_asid_lock would stall any unrelated attachment in the system.
> 
> Split the teardown out of arm_smmu_remove_master_domain(), to a new helper
> arm_smmu_attach_release() that runs after arm_smmu_asid_lock is released.
> 
> Since no other device would use the old master_domain that is being freed,
> it's safe to move out of arm_smmu_asid_lock (still under the protection of
> iommu_group->mutex).

This is a lot of text if the next bit about being a refactor only
is accurate.  Seems that not blocking attachments is the issue and
to me that is a functional and useful change. However, is that
in this patch?  Anyhow to me this needs a rewrite to focus on just
what is actually changing here rather than the eventual picture.


> 
> Note: this is a pure refactor; no functional change.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 25982bdbcbd9..fce026efa44f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -194,6 +194,7 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
>  	arm_smmu_install_ste_for_dev(master, &ste);
>  	arm_smmu_attach_commit(&state);
>  	mutex_unlock(&arm_smmu_asid_lock);
> +	arm_smmu_attach_release(&state);
>  	return 0;
>  }
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 5732f3ba0122..99baa59b39c9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3285,9 +3285,9 @@ arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
>  	return master->build_invs;
>  }
>  
> -static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
> -					  struct iommu_domain *domain,
> -					  ioasid_t ssid)
> +static struct arm_smmu_master_domain *
> +arm_smmu_remove_master_domain(struct arm_smmu_master *master,
> +			      struct iommu_domain *domain, ioasid_t ssid)
>  {
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain_devices(domain);
>  	struct arm_smmu_master_domain *master_domain;
> @@ -3295,7 +3295,7 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
>  	unsigned long flags;
>  
>  	if (!smmu_domain)
> -		return;
> +		return NULL;
>  
>  	if (domain->type == IOMMU_DOMAIN_NESTED)
>  		nested_ats_flush = to_smmu_nested_domain(domain)->enable_ats;
> @@ -3310,8 +3310,23 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
>  	}
>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  
> +	/* arm_smmu_attach_release() will free it */
> +	return master_domain;
> +}
> +
> +/* Release the old master_domain detached by arm_smmu_remove_master_domain() */
> +void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
> +{
> +	struct arm_smmu_master_domain *master_domain = state->old_master_domain;
> +	struct arm_smmu_master *master = state->master;
> +
> +	iommu_group_mutex_assert(master->dev);
> +
> +	if (!master_domain)

I guess this makes sense in later patches, but for now the local
variable seems more confusing than anything.

> +		return;

I'd add a blank line here to separate the sanity checks from bulk
code.


>  	arm_smmu_disable_iopf(master, master_domain);
>  	kfree(master_domain);
> +	state->old_master_domain = NULL;
>  }
>  

> @@ -3784,6 +3801,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
>
This path is hit from a failure of arm_smmu_attach_prepare()
At that point the old domain hasn't been detached.

Now it doesn't matter because of what is currently done in release,
but from a code flow / what that function is documented to be for
this seems wrong to me.  I'd separate the good and the bad
paths in the function.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
