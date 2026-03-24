Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19383CBE77
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336673; cv=none; b=oPxMVbDr92+owbu3vqyO06DvN27k77lacBWRYVGa1f+6P/hfrKoG4ASYjpam2LI5TUQ45ZqU1S58VipZQUPJP0I4Me9nLLDqFM3QvRoFvjZDRw3X7Qd7rNRkZJ0uHyVMMOzCX4sh0ByYmIQxBJzfqlk3XksmEukEJVZ15lSwWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336673; c=relaxed/simple;
	bh=dHiZweBuHkG8DSuP+oN/yzXOsLU1bE9ooY5ugDluJpk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gSBsNes+/QzQIBi2jSR2iBT4GXb8TFNVWscCohrBMu0ux8uwxh1kXnBkmjOfi+nYyBHubjU/C9ayuvJbhBzNt10WVo4RLXs0M5/aebakqtUoXvnvFd0pLhK0dOey/MPGXX0RlN4eei1ygmIr8THuoPouN5jXZnNWj02Q38v6azI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k/TLGKZa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C3w/S2Ur; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k/TLGKZa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C3w/S2Ur"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O3eqoG943589
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 07:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HQM7eHnVoeAhrAn7FxIm1PZgvchjSYSQc/shb75BI+E=; b=k/TLGKZa2XF0AXaU
	NXP2vVc6qfoyi+dwPVjMyYhtVH4X4uX8L2v7EW79vb8PBZE/QN+VQJGjwTIY5Qsp
	V8LoPPvnQEoSa33Z/5PJdYCeKBWlwg/wwc9t9myLn+EUElvd8O0/KWjydVzvvApO
	sNCPP0KW7nnmsMpOamTdJQMHCTx01dUlbwe4Q2HFRvT/uPSNciQ49GSX+1Sqgd7A
	+qR7yZOj6CpgCQ4P1ryXP+gxEm1R07BRbDFOVoTs3WZFs+h0bKaA6BlsBpXY/XD3
	BVgwPJZ9TdRE/GIxSUB0qWF8VBXkWSsQHkRUD4pMYDF8OJWMVMA3YwE10Yr+k8tT
	OSMJeA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34vkuqrv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 07:17:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b0601ff3d9so18755865ad.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 00:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774336664; x=1774941464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQM7eHnVoeAhrAn7FxIm1PZgvchjSYSQc/shb75BI+E=;
        b=C3w/S2UrjujXE28pj02L7+IOuLbnLlin7QpXcMZqhgeZVyGsd/lEw+5Qcu7XV9+RAp
         kQRVC5wSEvJtuVSzONePUQ796SvzLDVJZnvWfGlREyPKGJZ5e0XmwUxeUmg/jTSobyoH
         Rp5dcmiUjAciyJuwM6NJQvC/PBo8WISKKADeLvOG/LWgCEntq72/hHT8mAAsNxBvboXl
         KLa0MjBxcRKscEPzqEPCQL6EJaJwZn6Kl2mZnM81dUUBp7LdxP8s1T4jOnb4+exi1+TH
         4fVkWM9/7OXrEotPCAkUo6pRdWe/9+jNsAve2EAS/PcZQ1GjOgkRSY2zfFX3QIJh9JGP
         xi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774336664; x=1774941464;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HQM7eHnVoeAhrAn7FxIm1PZgvchjSYSQc/shb75BI+E=;
        b=bwfSjKdKJ1azThZ3Ub7eg4R0dP4TcWjSXW4HMIY6DKogBK2BVAdzoA1M0tVn5KPH1J
         zBw0wrRQqP0/ztdqADY69ko3A9Aw+GMPcimnUbxRdaLaY47jSyVJuSfaLQLdbnNf22LU
         D0uq7qCODJv5QWRG9/dXwkDknvT5xZW86z05tgUlJklKL39s1PTO86EnlIchgQ9eVEp2
         Qd8LixA5gTV6iK5BBDAzZ8c2FhsqZuxuC3pihQXb8cvOkfAgyykaU4o82LUgSxDTASUD
         gH24JG/npXME8reR09oPMaUDlAc9SkwhtWlttKs9ytsqARvJ81fCXUhFTR9VBJtjlNT6
         rqYw==
X-Gm-Message-State: AOJu0YypWCZgOJBMOHmur1UNhe9VzZIwFG51dMa4YZ3H4iauzfn/wPXe
	/iJ+ma7er3APfURRwEwvFfOv4G7W4lNAICQoAgyhpWSR3n0Txhni0VfhGDjFNwh2P3xw898gzXQ
	NnxR7wg3oI/MpnsHK3kv7+pJoTPBldemhD2P3rkDHWSLsVUrSmadh1KX74q4ejf4=
X-Gm-Gg: ATEYQzyM7T5BSPDQ3mv1/9vekdVuwM+hcHA8qMV1ILM7tdBhjMtFWkotvRj6WrpyUO9
	1tzBZivNeKcxfOxC126ssaLchv9l1mkElcaWcZnHXaXpGvJh/acuPRKQ4kvD9XJ/y7Atezij9tM
	BeN3kQ6xLCbkOnBsz32HuTgEEuODSaTlPrMjjpLjkDwNTPYgNu0UbU7rTTk1dvzOU1Wsv0J/zT4
	TtKVnPDKDuxYMC6c/yzcEFqN0tH7jHCyxXhpf6sA/X8VvpwA9rYo7aH0vtd8nE3QK3s0CyoW+QA
	onDGuhc6xqB15ZC+CiliTZdsf06mkIxNeTkanG0KEhMjH6MrA6j9Mt5kso3HloUENtwd0YaoPwe
	S26Q06N+Vk3dPH+tszu6nOu0=
X-Received: by 2002:a17:903:946:b0:2b0:531b:b3e6 with SMTP id d9443c01a7336-2b0826c382bmr151661875ad.10.1774336663913;
        Tue, 24 Mar 2026 00:17:43 -0700 (PDT)
X-Received: by 2002:a17:903:946:b0:2b0:531b:b3e6 with SMTP id d9443c01a7336-2b0826c382bmr151661745ad.10.1774336663426;
        Tue, 24 Mar 2026 00:17:43 -0700 (PDT)
Received: from [192.168.1.102] ([117.193.214.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0aa622677sm6868975ad.74.2026.03.24.00.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 00:17:43 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
        bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        peter.chen@cixtech.com, Gary Yang <gary.yang@cixtech.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        cix-kernel-upstream@cixtech.com
In-Reply-To: <20260313114914.1564115-1-gary.yang@cixtech.com>
References: <20260313114914.1564115-1-gary.yang@cixtech.com>
Subject: Re: (subset) [PATCH v4 0/2] Add scmi powerdomain for sky1
Message-Id: <177433665904.17735.11886295556987492843.b4-ty@b4>
Date: Tue, 24 Mar 2026 12:47:39 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA1OCBTYWx0ZWRfXxoPZC8hjdLmU
 jQOqt7vsCpp5gA8jdj7iT890+b4o/O/IMRQKAxd2ReU0P6HeGFL4kx2INjCc2BkkYXO3zVW550W
 zgMzvHMP6YEfKomnDH7yGh0SqZGSAv9qOwVaH70gpawphNUFpPnBpgeLG9EPAhplH/dkrYFgjUW
 ABkQvpm8xxvZHklDGeOGCgEMGogTmfW5K+J7Zk+7GgRluvWIw4ueAsY0OuhWZkU26sBgczfj19N
 meSLZ6gXNmVRLnevr1JDXLIK20TsWAjj5ZA24oFxojUi+THo1EsceKLACWwp1Em0kbJfxeWcww1
 mP/0a0ESZ0XRBC4nfX0Tq6bVIjTqxVIT1uuHEslR8KWpyz8pAoi7dwPQxO+8PZk/neHvRCXbHIE
 Yy7Xq6wIrIbnHfZmAMpH/1on2/pDmU4zjVO73QNjX++QqJo9uoUANnQqI3b650PBYH/y/94lKd/
 XV16fMXuvS27EddvLwQ==
X-Authority-Analysis: v=2.4 cv=eMoeTXp1 c=1 sm=1 tr=0 ts=69c23a99 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=13ILl30Z8QjaXWZz8Pan+w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=jNwzyYJvxPVIlz3NwY0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: BjF4wawwDBVcUvFGPf9mo_UNg8ePNoW2
X-Proofpoint-ORIG-GUID: BjF4wawwDBVcUvFGPf9mo_UNg8ePNoW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240058


On Fri, 13 Mar 2026 19:49:12 +0800, Gary Yang wrote:
> v4 changes:
> - Pass dts build check with below commands:
> make O=$OUTKNL dt_binding_check
> make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=cix,sky1-pcie-host.yaml
> make O=$OUTKNL CHECK_DTBS=y W=1 cix/sky1-orion-o6.dtb
> scripts/checkpatch.pl 000*.patch
> - delete power-domain-names property
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: PCI: cix,sky1-pcie-host: Add power-domains
      commit: 94c62cf0698c0edbf1f118dd80ea19d0ff5d834e

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

