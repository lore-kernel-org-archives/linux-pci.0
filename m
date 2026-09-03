Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E94CA79B;
	Thu,  3 Sep 2026 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463157; cv=none; b=s+PuvDIQ0bXQcyNPk8/qASkhGYeX2uzOd1VGVoYzen7QvramJaGtlcxc3DW1gjWj3EJL5ow/KMdocbH37Zbedpw3NoKYELmzrGZrpXMAFCTwBPHILTMt0Ih3GkMSo1czUWVAhQFqvJuIpQmsU42cdNf8fOpL0OQlm/lZjxgUng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463157; c=relaxed/simple;
	bh=oCTgMvt5odenXyh+hcel7JIH/cSW9wI5q38o3YbRPns=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ddt3QZEmRixBc/ah6WSIk+HCH7p7PIF2ZNQCAwBpNi7H/kkigg+ctv/lX6eCBpPk9UHjBZGOoz9D6jfJzf8EgEDFTr+tPbn2+qH/5OxKJ0gvn+vGlLn+TN65DKE0A+vHeI9tIVRKIqc9woksTs8J0gatNZzWlwQRAsGd9NXFv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OD3qvvzw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OD3qvvzw"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G36IZ2088749;
	Thu, 3 Sep 2026 19:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VQUv4IJx1WF0JivgfkVM/IklzBNGn+CV9jQg6jyPLU4=; b=OD3qvvzwPNFbIfSs
	UppFOyx8n8gZhDGU6BzaAaITUVHYDHFduYGn8TyNn4L0nGP3wellu6h97qMZI/rv
	p7sjZJHZDlye6FBPER9WMQSAaMAhJhfDKegmOEQvq2Qbc4JKzmdZ0zzhUcxAkb1U
	VCvLBHqWYlQDB0EBO4h2jDB4RXjzZmn3sJfz7GX1iVn715opUkSA4j/1CNQxrJi/
	ejLwTt0yieWrvydLZMNbOG+4BLwZtIC7egO7r1tJyVti7jpy4y8yWucQMm/3h9xy
	JT3XX+sg+AwLWuXD1qRa4W/0q2rFyCQCfXGZs0dDJlXOJqiXEUtfMt0rwyp554u6
	z1ndzA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf9b19uax-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:36 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 683JIaF43208976;
	Thu, 3 Sep 2026 19:18:36 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 683JIZKR3208952
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:36 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 6BDD424CD8;
	Thu,  3 Sep 2026 12:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 08/13] iommu/arm-smmu-v3: Disable PRI when no IRQ
 handler is registered
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
        bhelgaas@google.com, praan@google.com, kevin.tian@intel.com,
        kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
        bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <0b5282c7e850f1a1c650e43670899b4ef5335efd.1788222486.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <0b5282c7e850f1a1c650e43670899b4ef5335efd.1788222486.git.nicolinc@nvidia.com>
Date: Thu, 03 Sep 2026 12:18:33 -0700
Message-Id: <178846311318.1308030.4956293524348641228.b4-review@b4>
X-Mailer: b4 0.16.0
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: iqJhBiD2Rt_XnYVumeVj8eNBCwzrD3V5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfX2mJqKUwZXnQw
 pYkdOpzSuoxdkPE/6xDOZFMSo7a8A4XGSYaIdIKnWsgaRK8a3fExHEPTVTM9mWevwQx59buyGk+
 sfSnEJf8MUYDUk5inC+WB/9KERLP4/w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfX33I8L5/Etss1
 ACm+bPlIMs3vWXHQaSgsOeSlgoB6+72YLm4mWPTqhqVNAFvc5q1vlc451UO2hPTuQt5oOl08d5T
 /2aNVuxEy6NuvKuKFo6cSAeii0y2o1ORhLOqiS2U0/psdyaLvbV/Yc302uxRBTlAny22sn7RIMA
 tbMM+V/lNY9jpfyl+AIXecaMLpc9vpeKrihjdlrzFeqK2R8Cbgd9kUAmxMjRKXpdgPc7v98UtVZ
 ng7DTYtudJNx1Ca5f96j3RPYs0SnZvrlgW5zAreEqJKeG+9c3juWK1dvG+DgpO2+1xHfjXG9WLa
 FM/haKnXbqBWMbpwtjD0Y4L3u/P1fhdMBgtp6ZGzDSEQ1gSpylFzjGgs15PnrXemNFkD5zTld3q
 a4rGUnSAl2lCD6XM0iH4pv00qnzJ+ivpQVVvT5IeeSNN87ErvYE4uj79iQuUI78LssIQHQFYqYw
 6m1pjAiHn+JQPuCTzCg==
X-Authority-Analysis: v=2.4 cv=NNTlPU6g c=1 sm=1 tr=0 ts=6a99c80c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=zbFmn61Uz2ZoV8rCfbkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iqJhBiD2Rt_XnYVumeVj8eNBCwzrD3V5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030168

> arm_smmu_setup_irqs() has three failure paths that leave the priq without
> a handler: a missing priq IRQ line, devm_request_threaded_irq() failure on
> the priq IRQ, and devm_request_threaded_irq() failure on the combined IRQ.
> Each path warned but kept ARM_SMMU_FEAT_PRI set in smmu->features.
> 
> With FEAT_PRI still set, arm_smmu_setup_irqs() enables IRQ_CTRL_PRIQ_IRQEN
> against a handler that does not exist, and a later change would then have
> arm_smmu_probe_device() call pci_enable_pri() on PCIe endpoints, allowing
> them to issue PRI Page Requests that pile up in the priq with no drainer.
> Separately, arm_smmu_device_reset() has already enabled CR0_PRIQEN before
> it invoked arm_smmu_setup_irqs(), so the hardware queue would stay enabled
> regardless of what setup_irqs decides.
> 
> Clear ARM_SMMU_FEAT_PRI in all three failure paths, so that subsequent code
> treats PRI as unavailable. And disable CR0_PRIQEN after the setup function
> returns.
> 
> A kdump kernel cannot service page requests: strip FEAT_PRI when detecting
> features, so downstream PRI setup is skipped.

Dumb question - why can't a kdump kernel service page requests?
I'm nowhere near familiar enough with that stuff and I suspect I'm not
the only one who might be in that state and reading this series.
Configuration choice, or a fundamental thing?

Otherwise, seems fine to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
