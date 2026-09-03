Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9A84EC646;
	Thu,  3 Sep 2026 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463162; cv=none; b=Xe5FvDhTZzdht2i85clH+EEtfFDlfmML6uzzO8Lj4/SO8GY//2w1W0hpUX1vc8cqwRjU8UAo20TEmsNeZX27W9HNN2SL+UGeLPz5fGFZflNRlxekMRPPHhxNyY90P3JmpxLA34lZYMRy4YKjaWk3l6MmpPSDXZtrfLKmIcthIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463162; c=relaxed/simple;
	bh=cFi8aZLb21bgf9X1fCcqUpIEtskxyYrXvccBoYHAeiA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=aaFgsffc8851dSPW3TNQnYhzdxzh1IAqURkxJf8E4bfEABhfmqZD2k0Q7urDLXeYgWsFZuyCslitsaAImi5vW6Pj55zM79Mk4CA5VUXOjq3ea0uEDqNfWzcuZyFkcc2BXWCGF0VFJdE9GFrVBLC3dqT08kVIPTnblgk78xu2VVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h9HLe91K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h9HLe91K"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683IDI3x1257096;
	Thu, 3 Sep 2026 19:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VHKia4mrAMGaiK1c+rB/8sfRul2wmWEduKRcfi6i6m4=; b=h9HLe91KaHovTuCO
	lNkHWMy+gHgah55NcTcKJ45Rb/E72Z0FXrIoiOa6REinJN7ngc2wpGuqBDULQvGT
	UJpV4tMbdgjoHoDhIH+mE/88B0G9x6hyXu/BhUK1OpsYvhMY3f/aj0Gzj3qq015Q
	Rs3Yauo+Y8jZT1a3QjQvLvBbfbf8APaTwP3nR9nnprZaV3cgYN6Ku2OUyqcJCDWJ
	34lgAG/ego8YG5Cpf7BNoftdU/7jrdK9WV21OJs9G/1RC+PczAq9TTdmjEXR4OvG
	2Vi2D9O5KJdMWocOqe0C/WkH88+muPAa5tLD48tHGSNqqOCmG/TY+TRWKDYIVD78
	Y1Ul2w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyxg9vq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:36 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 683JIZYZ3196771;
	Thu, 3 Sep 2026 19:18:35 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 683JIZZN3196743
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:35 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 5432922173;
	Thu,  3 Sep 2026 12:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 00/13] iommu/arm-smmu-v3: Add PRI support
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com
Cc: joro@8bytes.org, bhelgaas@google.com, praan@google.com,
        kevin.tian@intel.com, kees@kernel.org, smostafa@google.com,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, skaestle@nvidia.com, mmarrid@nvidia.com,
        skolothumtho@nvidia.com, bbiber@nvidia.com, harsha.v@oss.qualcomm.com,
        jic23@kernel.org
In-Reply-To: <cover.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
Date: Thu, 03 Sep 2026 12:18:33 -0700
Message-Id: <178846311315.1308030.14786655545615918885.b4-review@b4>
X-Mailer: b4 0.16.0
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: 2NMQdrqDA1lI1P_H7Sp8Hwb0_NKyvyJX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfX2sgLP/7J2ENE
 giomQiiQ3TiqYZneVZkIC62WsBnPxH7xG/rwUGFmRiFXcnXSn22HI63obhjAlMR95a75r0Hh7/1
 pskHtM6NyrGefPNn+RQkth6rpFyfnlQ=
X-Proofpoint-GUID: 2NMQdrqDA1lI1P_H7Sp8Hwb0_NKyvyJX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfX2aIYEuYOyEOO
 0NGyQOGh5FkTF84/q46u+CBoSffnsBm2Rem4VKZ95QLeqnLmAN8mVYL4RW2D8KNaEZGVMeMBbSu
 U8Q3Z67wQFor2CPgP6T3ExzbIy1zv5P9GRsaTh4SFfIFpVbff/2YC65o2hI8nqiPHLP9OvTLpMG
 JUXxrDnV074wNR2Y5QOyZ8xxiZU7nQUDXb4nvEPRPc0AecYcyZrwZg1UVQ5hhhtLYcIge03jaz9
 rDYYUCZoBZw0/ox6SrsGPjuhTpPPRdSlh58vLV9axpXvNY8+BGvBe2UHbPtTbSh7zMP4M4a2KEi
 JC+9fN0S+hgWmDg4T+et38sCfwtEuIxMH0qn/q2qNxc4wyGMYqfMydBzbU8T9Y5UunAGorU/pXq
 /b3IBxM3yRjZAcLPKaTkp5MMKxBdZGtOH954ol7Muq0B1N2HIavXO3eWK3hcUz5ZkPN1Gaix5eA
 W5BtmM1Bzo+D5bSGgCA==
X-Authority-Analysis: v=2.4 cv=X9Zi7mTe c=1 sm=1 tr=0 ts=6a99c80c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=o8C_gSUlc4ZSQu4mtAQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030168

Hi,

This is somewhat of a drive by review as I've been a bit snowed under
(blame the AI deluge if you like).  I'll try to come back to it but
don't wait on me.

Great to see this moving forward.

> The SMMUv3 driver doesn't handle events on the PRI queue or respond to IOPF
> faults. This series adds the missing pieces, using the IOPF infrastructure,
> to convert PRI page requests into iopf_faults and issue CMDQ_OP_PRI_RESP.
> 
> The iopf_queue_flush_dev() contract requires the driver to first drain the
> hardware PRI queue and synchronize using a threaded IRQ handler before the
> IOPF software flush. This drove the additional commits compared to v1:
>  - arm_smmu_drain_queue() drains the hardware queue by counting the
>    entries that the threaded IRQ handler consumes
>  - arm_smmu_attach_release() moves the teardown outside the global lock
>  - synchronize_irq() closes the gap before the final flush
> 
> Note that, although this series is only about PRIQ and EVTQ, the Q_POS and
> arm_smmu_drain_queue() helpers will be shared with Pranj's RPM series, per
> discussion below for CMDQ to use as well:
> https://lore.kernel.org/all/ao3ljjiXhnSJte5A@google.com/
> 
> Also, two patches in this series have some conflict with the kdump series:
> https://lore.kernel.org/all/cover.1788130528.git.nicolinc@nvidia.com/
> 
> As the kdump one is still under review, I leave those as-is, since Sashiko
> review relies on a clean rebase on linux-next to scan the series. Once the
> kdump series gets merged, I will rebase those kdump related stuff. For now,
> I think the series is good to collect review comments.
> 
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/smmuv3_pri-v3
> 
> FWIW, engineers on the NVIDIA side have managed to verify the PRI feature.

I don't suppose you can share what they used to test?

Thanks,

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
