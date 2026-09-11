Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4431A9F83;
	Fri, 11 Sep 2026 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085672; cv=none; b=oA+A0Wht3O/19fM+wKPpe44r0KxGe9i2Um8iWwLCPacEX6WYqJIAThExu9HRj5WxT2Kgg9pTzEVrKjRmqE+ircFkrIgieXDNzsbEAwVFH1fbUdBRu42wI3uwai1L7e5Sci0ZyTultoUBwgGecU0O/ZizTXrrURyDJl/z/EGeLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085672; c=relaxed/simple;
	bh=njL2XSvIs8CGbkcsl15FK8Q4rIkLxSZ0d9OU/ceCWj4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=nU33gecD7jlfA0sT/LHcVTvV1Ppn8sg03Tj4u9JjzlVxqFEv0ws28+as6pDJ2Fx565GQ9lc/dpLZ8PHqyiGodysLtgp2tjrphhjXBXnMIkDqt/C0cVY7puhuuCzL+UhX4qBQ/QR1g7j483DjAswRoxZziFEAHVLbgkO0RgqB+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jax0CuRJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jax0CuRJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALthJk1551974;
	Fri, 11 Sep 2026 00:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RrMJ1Ig9JDzTsdwomHBYsLFASYBtKx1mard/OxQVdQk=; b=jax0CuRJweOQsaGu
	VTm4odoI1lpgh0yAvuweyPVdxUDPf7ChinXCafH+4Ij8/nLTnt/AyrCwXP+jLQaE
	HVFSn2VRkC3GtR7YsWO/NIgMjHDbvCDbti9CDaJAcZpvN6esnQUNK0lVxfx0ZLa6
	FrC9DzxFWXnNGrkEdp26YgZQyaELsBtCCA57dqoFp6xcbKa6c8IjC+yoz8yWVqRh
	bFiqnF2vi7vytSzuUBG7nfj3cPAFpuOwUblXhTikLmhExHuuW8qH0ozdfJ4pAvKW
	jKPAlcJ3JKWGe4VKWtkc/ZC7KDATlgDDGgLzdIJNSSJ7ysZ5Euh+Nx7aOW5bQiqw
	xt3qlQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkxv7a2wu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 00:14:09 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B0E8rq2666586;
	Fri, 11 Sep 2026 00:14:08 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 68B0E8NH2666448
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 00:14:08 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 2C67422DF6;
	Thu, 10 Sep 2026 17:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 02/15] iommu/arm-smmu-v3: Add
 arm_smmu_attach_release()
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
In-Reply-To: <8594c8e42e846da3b87f96f1e196c143fe4d517a.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <8594c8e42e846da3b87f96f1e196c143fe4d517a.1789081084.git.nicolinc@nvidia.com>
Date: Thu, 10 Sep 2026 17:14:05 -0700
Message-Id: <178908564506.2841562.1534113496036362394.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDAwMSBTYWx0ZWRfXwNL/2ZgHWjfE
 twi1+Rtjk6dLEf9v+Cnl8tJc+/CHqBoVIjNEZV9x9PvT7w7bsIAa8vtNiFSxmOYwokWoiVehO6n
 kcbCTdAXWoBGTyQu8+lU+4TqLL7Li9M=
X-Proofpoint-GUID: KsLgX2FDAt-_Jb_YWuhUbwis6jNYnCsV
X-Authority-Analysis: v=2.4 cv=FPSOVOos c=1 sm=1 tr=0 ts=6aa347d1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=Ikd4Dj_1AAAA:8
 a=EUspDBNiAAAA:8 a=lgIsWJauOim-okwx_8IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDAwMSBTYWx0ZWRfX5InpCrjLVkZ0
 JrJ/IYTR+a0FK9BhCth8LbmICzgHlNDfudV6xPVflIDDTpk9RV8bMxqk1BXdPKX3QBRkdkKog2K
 IvDhTOSf2xW+oATiUEWcYgfCwId5j9UdvpWBzkGqX0GQXgcUD7gyYGBvDfAPF4VFLXUm5vfvkdU
 Li3lvzVpRcpRLP0mea1PSW6FWBU1CCw+dU2i39axIw+sp28E8zZ3+kiHmFplF3/SnzwkObIL7IB
 e0eU6reNbj1R1mjLoVTMwJofFduMfI/DYqwv30kaeKVLo1KFWE1BgCRtC92mKCT0YgRzFq5Ytgr
 dvuHsVVHReN6mUGLQ5vlpUJWltUBUD7y4FPTDPzs1cDmrJOJuBVDk9WPJRmRFec5Zjr8kRoKkug
 sGuQ5BVhIOSgHLCW0aZGTGuDTBxrfiht84Swi/yZv3YrXCxC6z6NaK+/db/CM7ls8gkIBpIFyIW
 039Q8blkeD8ASavULJA==
X-Proofpoint-ORIG-GUID: KsLgX2FDAt-_Jb_YWuhUbwis6jNYnCsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110001

> The IOPF teardown is done in arm_smmu_remove_master_domain() when releasing
> the master_domain on detach, under the global arm_smmu_asid_lock mutex.
> 
> A later change will add an IOPF workqueue flush to that teardown, which can
> block on a user-faulting page-fault handler. Holding the arm_smmu_asid_lock
> across it would stall every unrelated attachment in the system.
> 
> Split the teardown out of arm_smmu_remove_master_domain(), to a new helper
> arm_smmu_attach_release() that runs after arm_smmu_asid_lock is released.
> 
> No functional change: the old master_domain belongs to no other device, so
> freeing it outside the lock stays safe, still under iommu_group->mutex.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Nice now.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
