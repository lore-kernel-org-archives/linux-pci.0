Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67541A6834;
	Fri, 11 Sep 2026 00:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085678; cv=none; b=rqwIBjclwLrZEcBOP/8aZqNMw1ekAtd1Bxs28xQ3hmpKub9w35jC6kPfPxHZOiA4jdJiLLJo9qK/g2kKIu71O23R+XPA2489erggPyk0QaUKeWpadn0sk89skjQ3rpwB2Z+E+cVlqh4ab74pWoUrvnGBubW3Ed4q6/rkB3240lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085678; c=relaxed/simple;
	bh=+plh64ohtnwXunOuus8vfT7AHGrEJuW1k8AmtzTUV1A=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ENxq+AEQkSKTnaEPwqz8dN3jMsfL7rHLAdGfWlTjPwqUc4XTqURuF87lHYw6t252T/K/XxSZ8Puse0GueF08/tysFfv/fhtOixf964NlmF3vyrXSto6mKPA9JRzINaKpR/lVoMPg0/m9UbxR5fjH6SdnwMHfd1vaqL6qrClp9y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iptK1Xc+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iptK1Xc+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AMowbX2676753;
	Fri, 11 Sep 2026 00:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+2yMCv/IeveZIRpMaqplxaIqOiiEtohcRWE/XMtqizo=; b=iptK1Xc+U7jZ7NW3
	hV3+mhl7IukWoNUfPY0I5bI+8HY0q2xURP5JCX/YJ8TnpnLoPCcbHUW4bYLgbdhD
	3Urf5hZvDMi4MwyH60jaQJe1Fxc7LSdc7PWuWsowMWHuVR58pIvoiftFvn911We9
	FaS8qcxeDQoarvy+0DE8iqDE4IXrQSZLxoiuWW9Y/X0gBZeVxmL7RetmnKPURpri
	zJtClDV6U3PAlTKisCLC0llVJE6y4SeR3StVWrRYiJrs0J1qBh13mywOYTgAC9an
	vG4f2LPlfDGy9oOl23F7NLXwid6emL7p3p6SeJ2t6xJllHFqt7gC/1reo3Y1+nd8
	vJcNWg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm5q407hd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 00:14:09 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B0E9be2566639;
	Fri, 11 Sep 2026 00:14:09 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 68B0E8NY2566591
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 00:14:08 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 32D4C24D08;
	Thu, 10 Sep 2026 17:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 11/15] iommu/arm-smmu-v3: Discard partial PRI faults
 on PRIQ overflow
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
In-Reply-To: <1c274d8836e59c549130170d5794d22e9b8c7d7a.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <1c274d8836e59c549130170d5794d22e9b8c7d7a.1789081084.git.nicolinc@nvidia.com>
Date: Thu, 10 Sep 2026 17:14:05 -0700
Message-Id: <178908564507.2841562.2353413729337908028.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: COarsFRozZSHn0b7CCxkSRcRipXD5gWB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDAwMSBTYWx0ZWRfX5zHRmsVYGgSQ
 T0qo+T7TXhxLea9WnqALxltsiP14bxfRS/Yi9iD+WucSJ0jJxdrAw2dP+mErtVleivUSI/aDhsc
 2cv9X6Sq4Be/0RPu060TyjvUjT7P/uU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDAwMSBTYWx0ZWRfX3FDCKjQ9LpUs
 wW3M5+JO2J+3ErnqQQ34r0doKodX4uxM5lHHMJ2OEjZyO4PIDlRiIsiPzwIEPRvTbatG3l/o53b
 ICe7gV8UlwKgCUJWHn7hjpaJxMTRtOTChY+xJkrEWOi5SByGFPgo55a+kG1i0EtsFfuyuSslN8d
 ZKdbB1d6d2C6vHLoVfJvaP8/cdrSXhIemN9JFP7C/0CJGjzpbBrGSSw+nhdypwUsscEAR3JxctH
 vzCgqNdKqvCluVESpd0x6WSxZKPaPVjhWDiz9Buk6F+wLuHyYEz0xRT7IWxllkpxOxbgbFNZLaN
 CWwwwIBU9Q4LObhJvF7jXIZFlVFFXJAbKh6mtcxn9s/pKc9HsUlyeMkOrRlIUKx6bBXig4yoPDs
 RtblJuCkvwJwR47dzrqImKIlkE1WZ/XZmoRbvZyJyAkZ/+/DKqqoDmVNgZM9JVh3v5OSrqXqeun
 U6cd/4ZEbJmTs77e8rQ==
X-Proofpoint-ORIG-GUID: COarsFRozZSHn0b7CCxkSRcRipXD5gWB
X-Authority-Analysis: v=2.4 cv=Wsa+otfv c=1 sm=1 tr=0 ts=6aa347d1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Ikd4Dj_1AAAA:8 a=9AJO0qswdzV_ezoDFsIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110001

> On PRIQ overflow, partial requests stored via report_partial_fault() whose
> LAST-page entry was lost stay in iopf_param->partial. Drop them by calling
> iopf_queue_discard_partial(), matching intel-iommu's handling.
> 
> Do it only after the queue is fully drained, since the visible entries all
> precede the loss point: a group whose LAST-page entry is still in the queue
> gets assembled before the discard, rather than losing its stored partials
> to it.
> 
> Nothing can arrive in between, as an active overflow inhibits new entries
> from being written to the PRI queue until a final CONS write acknowledges
> it (IHI0070 8.1).
> 
> Suggested-by: Harsha Vardhan V <harsha.v@oss.qualcomm.com>
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
