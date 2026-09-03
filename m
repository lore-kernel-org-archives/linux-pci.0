Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37A44F30FE;
	Thu,  3 Sep 2026 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463148; cv=none; b=Z0IJpaNcabaTjq84ME11vCKAnsddD8docVhfFPwbfdHsA0fImDBEVF6kkqkznbz0XUc9FhTNRlzEy7DX/t/lY+J50g4XakybU+ebYNA0i7POn4+R/wOO4NE8U3lh41GYYf7q8BIgcMSDiIjwTmHQrl08L40a62F87Lht90GlZUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463148; c=relaxed/simple;
	bh=+xGEaWDAQnk2irc5itHenNo9rPTdQoSjxtjJaClKROw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=PG1uWsVToHvJ9M8mQH8boJRPyjH/pPVX7OdGOVwsQPn5eTFKYgxH6Ch9F+L9O7VKte1EyIuVluLTWZ5oXJIy6t9ar9o145RfaZs509GQRIq347ZNH8ha+hfLlHo0RNqtJXblnkJ7suu1As4pNUiKHeqCaO54SFxPaOo6Vx3Y6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OZJ77l8M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OZJ77l8M"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G3Ge1417609;
	Thu, 3 Sep 2026 19:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	USrZhzBciZQ8U7KPxAoC/B0dynwx1W1kbw5c5TVLEQg=; b=OZJ77l8Mp1HSGX48
	CMDsiqfmT98vqj4aYoXco+ELWQUJRQz0scoJbu5RVlVLmt439VcaTK6Fey9jnT1U
	P8GvvTpPMNsMmcaxI6OC7r7XS9L+KJVxt8lvDn/imYQkgHqFexKjjiNTYu7/hASn
	x9+kVJWxAU6Lb/cuMqr78/nTc7ipUo6vgumAszSbWfqD2/llimZ1nrjOL/1FXzJF
	T6FCLb8zl8zT1o22gge5/VPLncQx+vAATK7eMszEOfagEyTO+uuONHeOiZZapabL
	EcvQQdBg0UI7yaeiFhY7wtWm3GmABV2wPHQ3wjlPG3otGnpG2ELve77IYPvuKCA7
	TlT9QA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf51m31a0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:36 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 683JIaWe3200063;
	Thu, 3 Sep 2026 19:18:36 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 683JIZtU3200051
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:35 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 6820224CD6;
	Thu,  3 Sep 2026 12:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 06/13] iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP
 for IOPF event
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
        bhelgaas@google.com, praan@google.com, kevin.tian@intel.com,
        kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
        bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <9280aea7ae7197eca3f223ef5b998aa25afb29d6.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <9280aea7ae7197eca3f223ef5b998aa25afb29d6.1788222485.git.nicolinc@nvidia.com>
Date: Thu, 03 Sep 2026 12:18:33 -0700
Message-Id: <178846311317.1308030.4335813024474016483.b4-review@b4>
X-Mailer: b4 0.16.0
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: 9G37ujsOx84etlvoi9xdDPmP1fbjZaPq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfX3t71EamZFxDU
 ZAkMkBO1ip7/gxCcjAtl29CYiRJ6VQz72G84/NKsSunYbrz5qEJhg9LPbrY71V6QXlbicQ4QWQN
 ZTlTcjM2PEFJHXe06Hba/+Lb6x5raS2ohw9Jb66rOm37VUHEpH5gTZM6g4qXxeuqfifOmvs7H6j
 8STeRr9Si85JTDvPuVYP+6xKfQsu8JqwB8Icvj3JKDjagpt3u3A8Jneln7SuWmv8DMxW4vdMlum
 w5CcFFDioa7N0h+W2n/4t3T64BoIOd3VpP43UV+JLzuCc0GMQvXJVrr6SgPuTlxBFrbYu921IUV
 MjbwKKSZzk7Gq9qodFoeuxMTR7xSS5qgAH9vitGMfGCMYxnMu750M4Xjn+fAa7vMBY1iFeV8PAG
 rZXAH+oZ0IeoG4yYvTct+uFV5HlyESzGiDNctTWhOEkj87n3vlhfwcC2dV8NWw5hxZoHekOKJyh
 095efZNjfiEyRjwE8TA==
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=6a99c80c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=Ikd4Dj_1AAAA:8
 a=EUspDBNiAAAA:8 a=PE7_2P9x3socOyUVfT8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfX2Ke/NNUxS59a
 qbX2i4QNnKV9ITuckOlMdmXuRDxfEPS3e2sHn7gzDK17GolO9eR/zQabR4k+eQ89vragx2jVRYw
 jU6O/z1rcI1fM+znfDKj5eYKYk8Rznw=
X-Proofpoint-ORIG-GUID: 9G37ujsOx84etlvoi9xdDPmP1fbjZaPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030168

> To handle IOMMU_FAULT_PAGE_REQ from the PRI queue, arm_smmu_page_response()
> must issue a CMDQ_OP_PRI_RESP back to the SMMU.
> 
> A stall event in the EVTQ and a PRI request in the PRIQ both surface to the
> IOPF infrastructure with fault.type == IOMMU_FAULT_PAGE_REQ. SMMUv3 forbids
> the Stall model on PCIe streams (PCIe must use Terminate), and PRI is only

There are those systems that annoy some because they smell like PCIe
(present PCIe software interfaces) but aren't and use stall mode. However, it
is nonsense to use PRI with stall mode. So, instead I'd just argue that for
stall the fault handling is done synchronously from a device point of
view so a PRI request makes no sense rather htan associating this with
PCIe as such.

Hopefully someone with such a system (Huawei folk) are testing this
and can confirm nothing breaks.

> enabled on PCIe masters, so stall_enabled and pri_enabled never co-occur on
> a single master. arm_smmu_page_response() can therefore key on the master
> state: CMDQ_OP_RESUME for stall_enabled, CMDQ_OP_PRI_RESP for pri_enabled,
> mapping IOMMU_PAGE_RESP_* to the PRI response codes.
> 
> Note that a CMD_PRI_RESP.Resp encodes 0b00 as ResponseFailure (a permanent
> non-paging error), 0b01 as InvalidRequest (page-in unsuccessful), and 0b10
> as Success. So IOMMU_PAGE_RESP_FAILURE maps to PRI_RESP_DENY (0b00) while
> IOMMU_PAGE_RESP_INVALID maps to PRI_RESP_FAIL (0b01), following the codes
> rather than the similarity of the enum names.
> 
> Extend arm_smmu_enable_iopf() to also proceed for a PRI-enabled master, so
> that attaching a fault-capable domain would set up IOPF for it. Note that
> a later change will set master->pri_enabled, once all PRI paths are ready.
> 
> Note: streams[0].id remains the RID because arm_smmu_enable_iopf() rejects
> num_streams != 1.
> 
> Co-developed-by: Barak Biber <bbiber@nvidia.com>
> Signed-off-by: Barak Biber <bbiber@nvidia.com>
> Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
One trivial comment inline.  Given I've mostly forgotten how all this
works, this tag might not worth that much!

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 352c916b2a57..64540cfb7324 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1028,32 +1028,69 @@ static int arm_smmu_drain_queue(struct arm_smmu_device *smmu,
>  	return -ETIMEDOUT;
>  }
>  
> -static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
> +static void arm_smmu_page_response(struct device *dev, struct iopf_fault *evt,
>  				   struct iommu_page_response *resp)
>  {
...
> +	} else if (master->pri_enabled) {
> +		enum pri_resp pri_resp;
> +		bool ssv;
> +
> +		/* PCIe allows only one PRG Response per group */
> +		if (!(evt->fault.prm.flags &
> +		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))

Go long on that line.  It is worth it for readability and it's only 81
chars.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
