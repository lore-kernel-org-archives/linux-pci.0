Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C71CEAC2
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545225; cv=none; b=mcndM6qzHmH2hvO/xz+Vn43k5MClKTe5FrpMgJCjNsgb34ihRVgotYWO7urbonXXssCEdbX9Ej3I3gbgtlyVdpF/Sugm7VNAlIXlk9DeMtgjbmIOr8ouiUjO1VfBHfFfmtQFkL2A/UG8kr5DgpKh+NuXfh090qEomZXlFZpKTDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545225; c=relaxed/simple;
	bh=sxilZYXZitHxtUfBkc3ckXJkLUBUcuamR7gTWm/dfPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nyhk2nHzSTAb0XEwamFjyujjfMO0aeRH3sydCMO3cCDaDNTWVY6mA47BdXvseticksOE9EfNnaiRiIlNoAtz8fjIsM9ncE4NMFBz21PhC9YOSDDPhw76O9DudhvBKLA7sNHezegirmNfO79I4CAEDz2KxmeOFXPsoChvKQJuZUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=io7EaE35; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=glLqlqmW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="io7EaE35";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="glLqlqmW"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9fq53849938
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g84aE0YMGYbvHRps1aTbmfM8XvrjQiSe0TEOY9hRXHs=; b=io7EaE35XqZcbdqP
	PotM+4RUaphRC50ljzIhBMMybKI6p1y82Jh2f0hHFrN1yOLB1VDg9zn0rCdMbFEm
	pFVf50bBCrwMPTqWFrIU1nfR9RVc6YZSwLPpScPxsLoz1ZonypEoIxgIzFRvDT7X
	3MyR19X6nNt6MnzzwmeQRsJYV0FTTjkq2qNe7fFsu7Ype/hOrK08A+0C0OaGaU1S
	gEijcyh+qRbUZq7GtAKYexY7QMMx9h4bG/TGPnwnw53aACA+4/FgthOYPxLGCE0H
	froEfd6C5zyDOPiNHz3tgpK1o7h+ENGn5aJG7pjbQApKvg5o2L69DyltE3D9vqR3
	ziDCsQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4q76utj3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:13:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b0601ff3d9so18462025ad.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774545223; x=1775150023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g84aE0YMGYbvHRps1aTbmfM8XvrjQiSe0TEOY9hRXHs=;
        b=glLqlqmWxx71xMEU8JT0OrpZxdN0clfg3vfiwYuiVkgngYxr/hK5JcV3NIdFTl0hOK
         btf3dk9FbB7MxLeg94OVWA8jvchnG+bjWGOa112AuLpL7HS9P9rnbSL7j8QQTG//hMIP
         8UMNCakUD3x0ZCFEPAxVuVp+yQfYLlfdLexq6iVROh6rKi4LF8dPS5xvLLYvHd7+RHDa
         MVrTUTlqO5dLpQce6c04Ap7cYuz0y5EFyiliKEfozWnYsgvfnsv4kIfgID8vCgZHHdhe
         Bywwu/9oJ/fUaUHkk+dyC48t8bvIlaeyNpKH67eQKEmRMJLzel7BMsHIJZLe2NbpEf6F
         wqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774545223; x=1775150023;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g84aE0YMGYbvHRps1aTbmfM8XvrjQiSe0TEOY9hRXHs=;
        b=BVusWAZGVXpwuCNURaa++L1ze5SdneHLGbYk1xCL6TsLsG2jY6o1qCfHJbFbE1PYC8
         9kqhPRM/w9FfHpU9T8Nj2zmdItKydLR0oknjsDt/xZHt5ukn0Wci/wF4UZLwK7Wu+LSU
         XZ9rLj77IOqd8orJ/KII69l4p078FLvtJjU8+jEicgYzbLZkU8KpaBlk7lwo5VR1NNnF
         rrxw6phCRzEVuVVjJRPV9tenSuL6qnKPIzX9h+0kVRUunIAo31zFNe3wgwvz+H88EnT9
         fWZ9+fg3Ap4rhaWzVp+1D9SOd95xI2uRwiwQkod58wNVxC5fGWuqCDo/VaVK2fVBAdve
         GXew==
X-Forwarded-Encrypted: i=1; AJvYcCUQcY4S424yENGC8juCerMtqb1xRuWKRnHfO3qPK/s6u6ocbr/Qw94gkrDc/afEJwZqj04gbf2+vCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKa7FlRV3pKFHNp0MOUIa+cIEfVRocPgsJ321oOEAQ7vq3jMfI
	u72UMvp9YQddg/mHT2+41lz+CtLrW5oE0nGvX4eDHXPmx5pmLM4ZkAM1GnC0GJqE5n3DC1thdpo
	fbxKoBcpyNq5PpwyGS2sdVQHoCgFsR0d40FlG9KEpAVJPFjBbTo3pIeDbo1IlCCA=
X-Gm-Gg: ATEYQzwDyy4gfqVJ5ROxNwvR6yZa9wSsVFuy7AWNQ2zOcmQncSzpcOnJWuE5c3oJkSJ
	THWU06ceNgMSb/V0nD4tzWq4mHUNvCUCLSA3QNt+61ZJ+GEylSn0zFGxwf/8DqyBAp/D83HQTuG
	7c3oHWP3PAuuNqDgpkfQJ0Vk8FFghaKW2Sgc9U66qPm7V+3d+GA8nQkHHgqpP5mPDDAYfhqZtVy
	sKOllNJzBW8JFc8mCgSGCfbk9LfJqDCdvsa/WiQTqxtu6mF6AEHczUcyLRxNrXhuO4lMNw4rd1c
	y055f959HTtvg/USVgsBoUPEhAldE05OBdRIO2M175D3FqoiPy7lrz6Rl8cLhNkuPz/kvX7fyWQ
	N9zR9L5qdundrGc7Epoc5PME=
X-Received: by 2002:a17:902:d549:b0:2b0:c3c9:cf15 with SMTP id d9443c01a7336-2b0c3c9d4c2mr27646085ad.15.1774545223299;
        Thu, 26 Mar 2026 10:13:43 -0700 (PDT)
X-Received: by 2002:a17:902:d549:b0:2b0:c3c9:cf15 with SMTP id d9443c01a7336-2b0c3c9d4c2mr27645785ad.15.1774545222738;
        Thu, 26 Mar 2026 10:13:42 -0700 (PDT)
Received: from [192.168.1.102] ([117.213.101.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc881e9csm38301735ad.42.2026.03.26.10.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:13:41 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: hongxing.zhu@nxp.com, l.stach@pengutronix.de, Frank.Li@nxp.com,
        bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        Sherry Sun <sherry.sun@nxp.com>
Cc: imx@lists.linux.dev, kernel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260306030456.1032815-1-sherry.sun@nxp.com>
References: <20260306030456.1032815-1-sherry.sun@nxp.com>
Subject: Re: [PATCH] PCI: imx6: Separate PERST# assertion from core reset
 functions
Message-Id: <177454521726.456360.10206150589096386820.b4-ty@b4>
Date: Thu, 26 Mar 2026 22:43:37 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=NOPYOk6g c=1 sm=1 tr=0 ts=69c56948 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=pjPfvbXasfe8cMZvnaMi6g==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=mEf8EMz-nW-Ju7kaI7MA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: WHP4k-1M2hmlNvTLztV-30YOdEjxQ5V1
X-Proofpoint-GUID: WHP4k-1M2hmlNvTLztV-30YOdEjxQ5V1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyMiBTYWx0ZWRfX1IY1126y9U2A
 Fk7NaZColaSHYA+EK45StKlH7iipKrT23oxiXqM6eTrIId1sG3Yn9p0az9pHpb0LgKTdsRbS3Yn
 +jS9bI2p1rs3EeXtJDHncYe5YFkcvH3GajHxZLF150Gldn9elXAJ9psYQ1l0SoYWy1CpCXr9WBJ
 pf56T30RYU60InEREb7xc0pMgrbKeMIp4fPyiIdloTbqdWkat2X7ZkRvkG+cKMLMAdPsiXhsO9M
 UFXLJ/j+7lpjCPoPWAhRVW/6GnEu6mOmBdVH4OK9F6tjPZavnkzOI6fvULBck88VrA2gnDCgjpc
 S5e/y5WBpGh5kcpUNaNFj4koT3nNwD1KLBAqA8c4DcxKD/XfmLN1zNwCwCAAutsmIzKHMd+QHrl
 zr3EGY2E0jPLs0jvhzc54040ugj7Kyii4nXvn+iRopisntnbAU+M76C/bVs+j2zXxI+HdHZGmk8
 2itT4LLkLeLZGj/CieQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260122


On Fri, 06 Mar 2026 11:04:56 +0800, Sherry Sun wrote:
> The imx_pcie_assert_core_reset() and imx_pcie_deassert_core_reset()
> functions are primarily intended to reset the RC controller itself, not
> the remote PCIe endpoint devices. However, the PERST# GPIO control was
> previously embedded within these functions, which conflates two distinct
> reset operations.
> 
> Move the PERST# GPIO handling into a dedicated function
> imx_pcie_assert_perst(). This makes the code more maintainable and
> prepares for parsing the reset-gpios property according to the new
> Root Port DT binding in subsequent patches.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Separate PERST# assertion from core reset functions
      commit: 180ea823bb45eb71dd5ed0dc0b78633accd21096

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

