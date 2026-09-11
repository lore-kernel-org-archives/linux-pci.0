Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCB61A682A;
	Fri, 11 Sep 2026 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085671; cv=none; b=Q/FpviMdyrf3WY7ePfT+bdOR8zU8DMMLNYB8wWpWgJdF7Q2nWpKUgjmN3X+F8Ktcg+GfBHODcRCNH2473Q1+yEboalFN36iji6f5ExDIj2iM1jNkPmujWPsim5r2cm1ujNZVSeYZ01dk/OJhc56b0HORdMfVbOjw04zn7f0DlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085671; c=relaxed/simple;
	bh=w2h7wjls+f3GYrg1hYPX+OBLuIBxDP0HbSobwYgJ2/o=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Whi5EpQEzghNl53/5PP7OFM2U9IvHBU4cqV+f22bjl5v+gY4ODHPD1C4DIQMAUC1CLNsi0nuXeSwWkKESBPfDWqcz1z8RFoi5lRHyelbNUYjU5St4LDfo8/zBR89Ig+GEO9wrzNmH6XllrmNBWe2Dl1zed7cTqVKY4LM1jMkSEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=awBfZXB3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="awBfZXB3"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALVEFZ2353510;
	Fri, 11 Sep 2026 00:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bRFSBSCShHl4M3eZJxok3WnJUeixvQG1jvdvSxAHgPg=; b=awBfZXB3ZvdM2Xhm
	vFJflINK9k35aKScVy+EJNQXiWU+Its3xC6Yy5eykkKYsrQbZeSi2Z/NBr0WlhLg
	qFt+PLPDx2JP+yyIxwemvHVjb0W1PvphDG6ZKRr7VNAz8eq0WoJkNnrd7LG5JILq
	u5mpL20OHRytV+KMtsfyaZY2e3wZKlLjOaoadKzS/MuvHPCu7O1Wtxxse99PpGaA
	xfR24/a7+5c9zvMo+vPMFC2mcHBiVt4dFuDnS2gpcJ78U1rYAo8jJWylU4RM3aFS
	palmmBPDWK6TkenQYEfigiITvTpJeik8Ed86qoJECbfdXz+74c6eC0VO2meZ3yE5
	f2PpSw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwx9tn6a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 00:14:09 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B0E8GQ2666583;
	Fri, 11 Sep 2026 00:14:08 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 68B0E8UP2666450
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 00:14:08 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 293EE215C3;
	Thu, 10 Sep 2026 17:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 01/15] iommu/arm-smmu-v3: Disable the impl before
 disabling the SMMU on shutdown
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
In-Reply-To: <61536b87c45164b1f581ee4358574ee7822e212d.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <61536b87c45164b1f581ee4358574ee7822e212d.1789081084.git.nicolinc@nvidia.com>
Date: Thu, 10 Sep 2026 17:14:05 -0700
Message-Id: <178908564506.2841562.10082006196933269469.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDAwMSBTYWx0ZWRfX5iVMnz4+B7kb
 JsqIZJICBe6bvNpf/9DKhjvQsdACMvUPfXjQOtEcm9mhdY7wDOSVcjG4vXhNYFoBqSuQbkz3XWU
 +fui4YpricdCfCbCmTw995LdviN9KL/lTiRo7MQgPjF0HM9ZzvRhwmphbHUbOxjp5HT4Gc4P99m
 kn0BykTeglfxhY1oT75us1p6AbzCS6airM96omrAD2eBApz8ywUmE7146BYyDcQMXh1oMiVB7SI
 IYjfKfx9sP/4u8NahDwvfiEDyY5PzXCuvgqdDIx3dN0HyzF8Kp4MUx3XA1GivRA/FLsRmgO4IgL
 Zr2AbVDGSBZWfYRgcUa7uhrd2DIQeHkWjNKUYhL4DKq9wSe5XwTcN0lMnkdNduB0ClBMdKDmek8
 PZxYGvYYXKzowRlaEe3qq1crJycU1uu2zucOhk4hTloCUyeQl45bQqiSCIE8lOKorwQVNgHMatL
 STnxJDWbxdMJsaM75xg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDAwMSBTYWx0ZWRfX8R3s9jXsDRQw
 Vm7uc25zj5PwmoqrCAd5ifAxeeqUpzRTR8EaxN+xOnvoasia053S4Q8LN3dSyA9nIuWq9zuvOGG
 MNJG+FjNZrkKOUmXyMao7TdV1FZyz4Q=
X-Proofpoint-GUID: drvzodYnu-qDu_gIlbIy5pijSjX3s3Fq
X-Authority-Analysis: v=2.4 cv=TupzFzXh c=1 sm=1 tr=0 ts=6aa347d1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=uFJOAlDeKRdtNQH9JIwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: drvzodYnu-qDu_gIlbIy5pijSjX3s3Fq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110001

> arm_smmu_device_shutdown() only calls arm_smmu_device_disable(), and never
> the impl_ops->device_disable() hook. On tegra241-cmdqv, that hook quiesces
> every VINTF through tegra241_vintf_hw_deinit(), which issues a CMD_SYNC on
> the shared CMDQ while it is still enabled.
> 
> arm_smmu_disable_action() already runs this hook before disabling the SMMU,
> to cover an unbind or a probe failure, and no devres release ever follows a
> reboot or a kexec to run it again. Have arm_smmu_device_shutdown() call it
> directly, instead of reimplementing part of what it already does.
> 
> Fixes: 9ff145a25c5c ("iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-sonnet-5
Assisted-by: LLM

See Documetation/process changes around this. Personally I don't care
either way.

Otherwise fix makes sense to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
