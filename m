Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A839DBC3
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315778; cv=none; b=BYAKrW+cSwBZXe3PZHLBU7vKMzT6mSS8MMYPiVy3I1OZGtxFTmzxhwTAwg1kb05s/bJH6KmZ7EvCOxzIiQY3bvxFJWpqcqQ4sQVmWeSCjT54MRbySSCyA5n64gY+tJYOCEnboLikSaGs7ar2+X0h7gLiajU/m9LuTVePOHmlftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315778; c=relaxed/simple;
	bh=vuDtbFLrMiurzB2+xC/ot2IB+T1N8Hc0u2jO0iC2vG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWWxF6Opa2DECz7zHydzM9ETzAjVIbxmH+mbMIRmiz/5qZM3mMfd/L4Uphu/hCTlmq1HljVPnWo6Nu70Q+BZUMwvNcA2s5pt7ffFgSp7SzmJjQrn99UvFjVKE3Z7CoWHW8/23+HS0411bMTjLqdlXcwwF4zo5YxzhNVHCkSW6hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HmaP0o5E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K8qk0tGV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HmaP0o5E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K8qk0tGV"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C2clWf1594509
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W9ejYWHNwRhjPiGAgnplcOS8lPIHbm/6D31/N+auTSw=; b=HmaP0o5E8kDigSFa
	alJVniCiNF7DjBpO3slqiNJ3tC/PYMDuDwHYrqAZ6m3faf3xBUSqMLfpUEiT0ME7
	uWWAeSVIZ60cNAHJhwuo6Vb8dOptnxFIZD2ZPlI6SJHGh0bEalGe5AilAQjBoaDU
	QZVlr/4PFlZA2kIerIpl0o8Gs05Rqi4LvYe2xoN8EAgrInA5+6ymKHj2jVoDFZlX
	twDN9GpYJxK9TErk0jdzr2qqWM7kBKQCbwArOlfCHOrYnIloY9u/so8cENTOFlPK
	42iYYDiTfRSrfY3aZO54lNm32900MmfmU17DmtlRZIiqhD4bfqXTlQnqegCK9Mod
	59ZCww==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cumvq9apa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:42:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aec784479cso5175795ad.3
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773315776; x=1773920576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9ejYWHNwRhjPiGAgnplcOS8lPIHbm/6D31/N+auTSw=;
        b=K8qk0tGV1VvYa8n6L4GNDEIrVk3ylGJtU1Tj0MngO4fgE7rkiOZpJOpDPwdgcPoHjJ
         3jIEz1gIIGqIPLX4PJGCOKffj5OQTnx6GRJBzh1lFqp2mUCvJ7h6vBtnh564Njc2SQRB
         UGFyJPwknQpbWPjrq3rug4F+SIFkArjit5lt7KxnrHmbZFMR0y3cXM336E7PHu499TRM
         NjQaydvCMaBmANW4iBaRhbkkUHEDZQ12jI7d+QyzAA/1Gx56toGvYf/Z4/d8M8mdw9mS
         tHe3dzN/bCwZPouSKY4/bHpknHsqRNbNxlcLgS+iLOCrzJMhrB2gm8vahNuVEa2njsM4
         OXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773315776; x=1773920576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9ejYWHNwRhjPiGAgnplcOS8lPIHbm/6D31/N+auTSw=;
        b=UxVAXI2vP1HyAI+zBqpmnALH+7zSuH/iHNrIHF9jNOAy8LZHU57MmrpbCSAJevlJsD
         0bgE+bOm1wRoZLz6x8wJP1qktpoKRYmzDVyV/fmVy50TBxzx/yBQRk+V8yCvgkPpNdgy
         61gquQQ8kiTUlyS1f5xdztSgD4++5HNOsAdPo6+KYYhjGt89ddqhLUSj5HscZQ/ZmYjo
         nC/HUKyAjmGHEkn4iFhZ+F00kFs23iHU5Gj+Zf6UWfVoHhrgMf50gFz9VaYRLWbQ4PJd
         5dOQeKg/Mxn3MAsGVL6p62hO+BxaEijh5EELqTx4M0hEwTBu5CvBZrs+bI1fiEQXM5N1
         yNSw==
X-Forwarded-Encrypted: i=1; AJvYcCUC3xUaA29A6ZHI5XFVYHw1bI/3jgX7cCZoSQSjvyqqZfRtmjPEQHxR6kUnLAfeTTKOeeaHJE04zqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySeqWNEd0eVBkGUHaf7ZaGxCBkvaOHBnqc+hcBUaCj70GkqYGy
	78zwNo6Odsb2l6FvS7wr01EDjW2IqhTRJ8U5T+hcHkhyvlnWPU6bjtwzm7Ol+2vtgudyfEFMej9
	SHifir/yaOnczSu7UiDuZ28SkIwAJt/v7ZBwiPS4nEzwAPAu5pyyCJGiq37C9hA0=
X-Gm-Gg: ATEYQzxLHqEFjWUjs+2aXPEZbuyaZI4SASCCmIcZqNfxPYB5U6HQRdrEnQpWiITf2fP
	prcTiUgLZ3dDsKZcRO1xNhUI2U4LSWrq1ubAThXtv7ES/gX/4Wf/bolve8jL2vV+qpzmD/YSpf+
	IKqOgJeoUPleMlfc5sQ4rLSZy8HPEQQ8FM5wFFrK/gZ4Cz7/f1VCiyDrFZo+riYAoGrdHgascx5
	kRIJt/FZM2fYQBSP0DY4g5LBc+CAKFHBL6Yb+NfcRMIi8xFaWzl0+Y0QwFiGGB1X3ntAzl52VVh
	q/DdiZAGjifuK/nERsAYJXCEHckb8px1CnHamuxM8C3DqWD3R4uN11lXF9gh6Vca3Fkaq+zfYcr
	eCk0oQESh2XRRJ1ydd8kyzSnrOt3KHyCpVogwLCtqYhiKy2YqDyfLo70khg==
X-Received: by 2002:a17:902:db06:b0:2ae:3fb2:ec9a with SMTP id d9443c01a7336-2aeae7ad446mr64958725ad.16.1773315776340;
        Thu, 12 Mar 2026 04:42:56 -0700 (PDT)
X-Received: by 2002:a17:902:db06:b0:2ae:3fb2:ec9a with SMTP id d9443c01a7336-2aeae7ad446mr64958285ad.16.1773315775895;
        Thu, 12 Mar 2026 04:42:55 -0700 (PDT)
Received: from [192.168.1.10] ([38.254.186.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae25cd67sm56194955ad.38.2026.03.12.04.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 04:42:55 -0700 (PDT)
Message-ID: <04eabe08-f339-4d9c-8b61-184241d192a4@oss.qualcomm.com>
Date: Thu, 12 Mar 2026 17:12:43 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] of: Respect #{iommu,msi}-cells in maps
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal
 <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260309210849.GA591344@bhelgaas>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260309210849.GA591344@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rZozU_U9WzrZqFEigtslpuA9xXkgDGsp
X-Proofpoint-GUID: rZozU_U9WzrZqFEigtslpuA9xXkgDGsp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5MiBTYWx0ZWRfX1fqwlEM0r+/s
 Saa/2+q7UzdaARhDCz6ML9m3X1LKGGlkYGEeT+unMryOms+n84G50p6NBl3iDPOu+ZQddRT86mY
 HMXds3eVz0nAJybj50huiiS2LQ68YxrCKTnDz0XlEkwuM7Cbk8c24l+7pKgTav8JlwNyzEwIlDk
 CxVmmKyCYRjpdAmXp6XdUdVMtKal3NW/vz4+Yi34mShHNBJh8HkXigF8xFN9FP+7Gm1hc6YZ3j2
 sQxggnex8OKmfEWPI58L6VZGacT2LWZmcrzjg28+puamld8jx1j0w6VfSb1Vi3EutNebl/NjBIn
 2SZ8LQh8ws8wGP4pWZSLHRuIUPq/2565Et7clTTEQ3FYTQNLhEhDlur7KS0e9JPDz68NTUzeZJT
 R+coLQNLu13in0PD0M4K8zuLylLNXV/v9o20KnqApO8Ga4MXwpng60CmkGp01eKRtoYNGB3ecom
 vDBZ7ZRzVYa/Wn1MlVw==
X-Authority-Analysis: v=2.4 cv=ccHfb3DM c=1 sm=1 tr=0 ts=69b2a6c0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=FuYIH7Xx0xzBSkYrynBYgw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7CQSdrXTAAAA:8 a=2oAOsZZM3GA0Nya8fkwA:9 a=QEXdDO2ut3YA:10 a=d1F_yjlUjjEA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120092



On 3/10/2026 2:38 AM, Bjorn Helgaas wrote:
> On Mon, Mar 09, 2026 at 01:03:39AM +0530, Vijayanand Jitta wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> So far our parsing of {iommu,msi}-map properites has always blindly
> 
> s/properites/properties/

sure , will update.

Thanks,
Vijay
