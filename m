Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4424A8FF7;
	Thu,  3 Sep 2026 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463155; cv=none; b=c/gOfXdx1Ex7bA9/L6YwJtLd/T1uaM2sVE0GRisp56lJpKEot+0nPmdB0IRnF0zmc+VbjOcajctpFvkE603SodW2FBG/P3jPRKSZX7SzYyKLUtlNv4ok+ndQulYhxzhf0e5cjQT3zZyMkXSI18H4ipeC5tUWuAtKEy+qTMA+/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463155; c=relaxed/simple;
	bh=trr0mUykALDm8fBrMxHr1YvoYnSuR5zOa0VrY8liPco=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ImklSd92EmKQdyEku9b8JV4dxyd3Rac94TaTzOx6zSJfiWFqtc3NQpOXd/4irSTgQB52SuiTvbcI2YRJ07L1nd7R8fwMjL92R+j/HasX3lb9NNRdK4hFHKG4YZkUJt2St/R/NyAJF54dhTu/V5RnLhvrhi/seG5/5+OPduKDZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gNlC7YiO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gNlC7YiO"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683IDI401257096;
	Thu, 3 Sep 2026 19:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eAUX5ujPfcPKUiEX32BJZnSRpa2KP+IM4lLw9lF6eeQ=; b=gNlC7YiOBc0ibLst
	fD7FMsoiKSfOeW+RuOWZKKUI7ubJzY/PTa9fTK5JziLmU9wKZggLcsZ0dn5pD1aT
	iPQf2X+LcZLiczv3mhWLCrdeGjMyv+nD6WitL165Ff3j2txax9zxKSimQI53LUP3
	UhWkw5gPIXn6gh6AWOnkfl9pRWCgnA/JxYWhgm8i6bLH5BZCbrBcrO5J40D9VzDP
	izKYdwkZk6Nj45YUwWSRb2Q7Qn181Myuxd7hXQZ3Vh//RMgrCeH2ZePD4A45XsXZ
	L/mpepmXHoTGZH+SirVdJrDXVIdjQi+wIywBvEfUIPtk5E1M1OBGof2NRsypkzSm
	/yM3Bw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyxg9vu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:36 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 683JIaSA3208975;
	Thu, 3 Sep 2026 19:18:36 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 683JIZnc3208953
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:36 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 6F72C24D05;
	Thu,  3 Sep 2026 12:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 10/13] iommu/arm-smmu-v3: Allocate IOPF queue for
 ARM_SMMU_FEAT_PRI
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
        bhelgaas@google.com, praan@google.com, kevin.tian@intel.com,
        kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
        bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <37a4e140ae26b1f58a08b9274937dcc9fa1e5e57.1788222486.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <37a4e140ae26b1f58a08b9274937dcc9fa1e5e57.1788222486.git.nicolinc@nvidia.com>
Date: Thu, 03 Sep 2026 12:18:33 -0700
Message-Id: <178846311319.1308030.9000417124188557278.b4-review@b4>
X-Mailer: b4 0.16.0
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: -YVENvjxRstb0fWm0drndlamyku68jmz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfXy2M1yXp9bl74
 1XcPTelj4QFngCCbXZx8yKHPgPJYZuorplbTZvQtFEWDTfFiMhK20dMffMbJgmMVGh/UQjFCMzY
 qi+0uxNayJRwE1f5zH2QavCI2uyudAA=
X-Proofpoint-GUID: -YVENvjxRstb0fWm0drndlamyku68jmz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfXzMK5tbEszxLX
 K5vderQj9IuSTXhgM6Ip2CBzQN/UJl4QVRXYF8U4TdJJxZpRTkzIWF/b2SwA9kSBMCxQ+ZOF/g+
 oF4AbJ55ZPAAQptq/ZwQuecGgU5FLhFNqqdJR/pCkZtYGIglbxE2RP6ubyqsNrhezL1GY48fkfD
 VeSPx+YBzg8xEVSpspz2fwdJdUFd7ci5BoEbOA6zOhnC+J95n5/JSIz2U3iWSrZSJ43Yj9FTVi1
 LZkToucu2nKl0nuD748PEx4NP8VTUSDaQXc8/TGVchwXX5ZVzAKTZwNSCACRGzaLYQBj6tMw+bV
 qgqVS8U8e/XwphEgSqt02xKLa4kyEUY3X2HfrpVYNI79WUE1GhwBDS39E2k+lyYYbkXq7pGPE2+
 NlQKWmeTa+rYjlxeOML6yMKP/gFfvrZhIKiLxpch4o3mEQ77AHDp6WY+Qu1gGqHfJ69zOkIHY34
 5OwfKnVuLbwQOAT1vCw==
X-Authority-Analysis: v=2.4 cv=X9Zi7mTe c=1 sm=1 tr=0 ts=6a99c80c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=Ikd4Dj_1AAAA:8
 a=EUspDBNiAAAA:8 a=6Dz9RvTaV1Tla3WjJHcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030168

> After the previous change drops the FEAT_SVA gate, arm_smmu_init_queues()
> allocates smmu->evtq.iopf when the SMMU advertises FEAT_STALLS. PRI support
> is being added on top of the IOPF infrastructure, so extend the allocation
> condition to cover SMMUs that advertise FEAT_PRI without FEAT_STALLS.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
