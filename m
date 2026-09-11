Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA026FDBF;
	Fri, 11 Sep 2026 00:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085678; cv=none; b=pS9piP5+J+AvPsSUVCWkHuvRdAwHnRcBW2sPzLELFlnUsbM/30sb5Mbyao0c8cXqDclt7WVZvO4MUd+Jvk8jIDlAk7Pta/mvhY6kr+GtwCaJZDjtFasReMqGedmoyquHob3/vkVur7c2BQKR9m+INSllKj1hF0DT2mfEXYFjaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085678; c=relaxed/simple;
	bh=6MwH4/GSRdnMUdV1vATmp8eq9LVaTzUFxp8khz7bKGw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=D1GzqXpXykaRZM4RO+TdDFHT34ojJuDfbe71TyLevD8oYWZN5EnSsJs8LbeAo/42jZDvF64rZt7iUd/Ig7gWCqgEr2FsxSds4gsg+VyDlAcX1zeBEY1F448qWt5rdxwxRko8xG51agV5i3mgxhOToHQAm9iM2wgFTxpIQ194yWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hq5tZ2dN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hq5tZ2dN"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALTqfs2127156;
	Fri, 11 Sep 2026 00:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xvGDgKXNGrFX7zXWk+uEC51/j7YeXMHQLdea9RnD8lg=; b=Hq5tZ2dNeYLLvAR5
	CyVzOZgNScpYhNUn6syinbIA7WBxWynh6i9LuQTwuQJBY8CxYKQdP3wGxJnkizVe
	MbBNls5xQk2H4fj0jvbqOIB4t1aQJ3dahATg1kaXWpVtIhNcmK4oY2g6MypxiyFf
	LPH8Bx6r3loweG/OKZZPrtHTrohyS69pMT5wNH98lXsPYgL5cJtkLlz11WZnZJrl
	E7OUpLV1gCSd2QUtCjp3/tVm2BcyYOHP4yLeu/RAN9CA01iivD/uuGu/9vTqYKvn
	Xdhq0idwZbmfdzGQqJwfy2+BPoYOlAoBfmJYEs/f0FnA2sHUhS38ggMEiq6KDyOO
	Blzg8A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwkwamhg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 00:14:09 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B0E8Zk2566592;
	Fri, 11 Sep 2026 00:14:08 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 68B0E8j22566472
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 00:14:08 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 3137E24CC9;
	Thu, 10 Sep 2026 17:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 10/15] iommu/arm-smmu-v3: Support PRI Page Request
 in arm_smmu_handle_ppr()
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, joro@8bytes.org,
        bhelgaas@google.com, praan@google.com, kevin.tian@intel.com,
        kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com,
        Jean-Philippe Brucker <jpb@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
        bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <cbe6e6f578af848f4efdd8d1050181032effae37.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <cbe6e6f578af848f4efdd8d1050181032effae37.1789081084.git.nicolinc@nvidia.com>
Date: Thu, 10 Sep 2026 17:14:05 -0700
Message-Id: <178908564507.2841562.6430226716089872094.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=EZNd0/mC c=1 sm=1 tr=0 ts=6aa347d1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=Ikd4Dj_1AAAA:8
 a=EUspDBNiAAAA:8 a=47CvhXRu4ZBn5Ykpww8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDAwMSBTYWx0ZWRfX9IfynBLisEK0
 H9Ihz+6OXgcs7fMNp6EGvbYJ90WdFFMUU/mvQWEdfqPkmt77ICv8YPeVSu2Q439MyaGfBDKnED9
 YD0wQUYXCccLyXxwvBYnftwb5MQTdko=
X-Proofpoint-ORIG-GUID: ID_fBYV2hIvCfwlUe8BtaB6rZmbvSGyB
X-Proofpoint-GUID: ID_fBYV2hIvCfwlUe8BtaB6rZmbvSGyB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDAwMSBTYWx0ZWRfX3xB1Kej7o4h7
 EQEcKoSIDGKfm5LxjWpo5t8MZ+9b/QwgptqrO3e0ru4Eh2pQSzziON60zx5AaIektgj17kMLFGQ
 XRDc6rJKlyhg6lb5rgd7ddxMwzE5Q07djRRGitOy239KaMoM39gecFFbVopoRJWx1mKR9+TqTrO
 SUCkHLmQ/r3BUBO/DidoVYlMC6Nj729+rGuEqh2XOnLW2zC39nz47PQ7XM613rhjeZ+V9LwjN0Q
 hIhV9dUunEqLbY4JzpfoEeh5wTr7mG8nT/QfQjMQPuMAFNeUMQgMWQqpwELzR5Qq1tT5tWPctgA
 b7cIqhB9ADtKNNblk2zogt+HMGCavUppZvFSMDKtH8tPVbAJpYkdPx5vpJkwG8tSBv0qpW4Sn6f
 vXLB7vFcNTGtmnt2iwmy8HrQoGkvfc2Z+9ORRMVkbTuXVn5fGCfx5+ST3YD4ghk7tR2dDwMXDyT
 h9uLasTInKUwh5ZCqRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110001

> For a PRI-enabled master, convert every PRIQ entry into an iopf_fault and
> report it through iommu_report_device_fault().
> 
> For an unknown StreamID or a master without PRI enabled, keep the existing
> LAST-page DENY path. Merge its two messages into one ratelimited line so a
> faulty device cannot flood the kernel log.
> 
> Discard any PASID Stop Marker (LRW = 0b100) prior to the fault report and
> the DENY fallback both, because a Stop Marker does not expect a response.
> The IOPF infrastructure requires the driver to discard it, as per the doc
> at iommu_report_device_fault(). This also matches the intel-iommu code.
> 
> Note that master->pri_enabled will only be set by a later change, once all
> the PRI paths are ready.
> 
> Co-developed-by: Barak Biber <bbiber@nvidia.com>
> Signed-off-by: Barak Biber <bbiber@nvidia.com>
> Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

One question inline. I made the error of looking at the spec
and got confused.

Jonathan


>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 43a6029cef43..c631c6344685 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2370,6 +2370,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  
>  static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
>  {
> +	struct arm_smmu_master *master;
>  	u32 sid, ssid;
>  	u16 grpid;
>  	bool ssv, last;
> @@ -2380,9 +2381,47 @@ static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
>  	last = FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
>  	grpid = FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
>  
> -	dev_info(smmu->dev, "unexpected PRI request received:\n");
> -	dev_info(smmu->dev,
> -		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
> +	/*
> +	 * A PASID Stop Marker (LRW = 0b100) does not expect a response and
> +	 * must be discarded before fault reporting: see the documentation
> +	 * at iommu_report_device_fault().
> +	 */
> +	if (last && !(evt[0] & (PRIQ_0_PERM_READ | PRIQ_0_PERM_WRITE)))

There is a bit of spec language about case where there is no PASID
LWR=0xb100 not being a stop marker, SSV == 0 and should be treated as
a PRI request. I'm not sure what that means in practice but maybe
a comment on why that case doesn't matter. Feels like breadcrumbs we
might need in future.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
