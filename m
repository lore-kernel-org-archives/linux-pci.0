Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411632B103
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200489; cv=none; b=Sfz3TCSUyezoo+a72/qkqGvsrQx8HemZ2TS80+dSXRXm0TBSn43MFDQrOchiFxGgl2MYQz8p0cZjO/f+N6l/dKfkES9kE/9m7A3ePTP9AvTYWoxVYT6IouP8Tuq+t2qKYtLBC/YZbPLns4HhOeREKizj4WgoUT1m66RRsEJbilE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200489; c=relaxed/simple;
	bh=zOKQRlllMLmKCXzv2AGejU3ZctXwC1JCuU0JmlOE0HE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K45BDOVxHGd0jy8820odbus/HWYYYaFQbP6YjMK0luEzq3lpk0tg3SUZ/fmIZHND43BigH98n7TPHBipYhc4pLwoCaU1x3GEJykoPA4/i2dW+yi/6OYOWARVpljrUa1maRuBugGOlV/b3C9CpeHuBUpawJlFAa3glTjsN3CmmvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W/NYWGEH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dz8o0IKK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W/NYWGEH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dz8o0IKK"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J8ENAp3612521
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9XA93tTPuWK7wYRPBLeS5WApu0YirUM3++z/khPE91M=; b=W/NYWGEHCUvkjA7S
	qIFkP1fgleD8xRhqgkIIcnSGSXFCwM4FPHUuxomJou4G2LRw7kVWulPCqJ5aE49i
	e1m7FyMsuXcIB0VAtmxtEIeXke6GCBqNisTUG2ICStL5q0fOQ3zS80XG/I23E96l
	NwPOEVAHiatUMc3QKU1yaE2pYG+kuslM+oNgcM3aHk+fR7rOoFhhrgZpxH7n7SJp
	X7+Yz8o7cVA7VcsGMLFtDetPm4YhsXgnc4Uj0phGaeCIfs5muzG/vSCJyMYPrO+n
	7hWdT+B8Fc1abUB5GbgzO33bSBMSCnapYn2jgoBHcGseMapO/TpxP9/fZAla/fU+
	wcga8g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8m64sgey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:21:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd00a65673so26430415ad.1
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779200486; x=1779805286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XA93tTPuWK7wYRPBLeS5WApu0YirUM3++z/khPE91M=;
        b=dz8o0IKKBjD9H0+oXL5S5zHCE3K4tqmvU6je9d7IR9/NazoQpSgkEl61e6gPMxLq7Q
         Bk6v/D9eNFXFUn2Cfkb0ZB7ZFvsAiD5P/2ttccEUuvoqRWMw2Uko7day3gEuMr1BZ6wS
         08698kcP55szD1h4aNhWAO6Aiw/FBmxjvbUeA4lZrkqsBA94ElDVibwsSSIEroryMTbO
         RXXlN4KM6JqyM1raz/nwSkNH3WXqrFy4wfn/8lKNivrA0vPG/U4oF54hGla4hKNHAqXh
         o+PCXvonQmeU21AugVfV1ttAaD6PHW0AI1SB0ZWExPyswswnsORPV8DwJjvuRUYL3g9S
         AV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200486; x=1779805286;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9XA93tTPuWK7wYRPBLeS5WApu0YirUM3++z/khPE91M=;
        b=Que0VY6151cIGp1hrBR7XnUL/yYWfAyiEBHzQgCQMx1UWAE3LQkNpeBNpSHYJWJVAA
         JVv0I2OJE8w2Jq7gW1S/CyYjcVoQoPVydZu/vJoBugSunvBd+rB3hN+cAj2hFQfACpfE
         t3FO4JaG+MZFUmaakrxSTg/8qjOfmJ/d2IIW6vpxMNeMaLnoEUx0trvAb0Qs9u1y4x/7
         Qp16SADlBXHyLPwtldKnl91xtz8LGlxdWz49C1ijg6Bo3Lk3fmjtzzXN7IMGYmImW/qq
         Rhjh+yw6cLpblqx/nN2SLov5Z64XzDDfGb8p370iUOVjsuJ6Jax/LjInTRaz+74h2JIP
         62lw==
X-Forwarded-Encrypted: i=1; AFNElJ8Vc5kVbBvGLV3O6t/7DRPgwPFFBQlZ+vDbQIUYBuY1Jsh3TJPOwOYZS3VPxIOhiAC9AyEN89BpBe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWUt8TEt41UEiuncH5JRIgKi6W7tSnpLb+bs7MWuk3Avs4i40k
	86huXVJ8T+frOvd4VPQ/Vakc+xlq1JUoVp+nOTvACW25FfgWW5HWgzkNvBhVwkC++UPe6ENV6E1
	pMhRe0r/2X8IkuYPQ/j469MC6hKXECwaQ6xxLvIQglzZJMQJE93WeqczxX5NEezE=
X-Gm-Gg: Acq92OGHNOfydZUoZSKE5CVOSDr5BzhfKWlqsct6UmulPfrrnEmJMOnrTiR7l31KJMA
	mo7N+7CRcHSSiW4hallkuyXh5F0biCniL8Bz4mycTYapkzgIbzZCzOCGSvJGbeUwqbpdojrdmBs
	D8v/HXMbT+lV7gRt9X1TZm8Z8ShSHnop9t6NDnai9MZxfqasIs5MgKRVeDKdN7tVci86DHLjtcB
	z1zIosznUYl/pYEPdwwxy2IEYdVWAx/d6bP/0yBo19+59fdWBWcwHMEsLsAjHTII4JYvMo/JlLA
	XagFWeLIRxlbnPVNPEqd+AsV/xNvx8QIlzVvr4xWvqKDihOuz/u/lJBn+Ldco2N9MyWBE7wLvoj
	nIosSlpyitnpBo1vSgV9u
X-Received: by 2002:a17:903:37c6:b0:2be:1eb1:eaf3 with SMTP id d9443c01a7336-2be1eb1ebf1mr50819665ad.11.1779200486337;
        Tue, 19 May 2026 07:21:26 -0700 (PDT)
X-Received: by 2002:a17:903:37c6:b0:2be:1eb1:eaf3 with SMTP id d9443c01a7336-2be1eb1ebf1mr50819435ad.11.1779200485796;
        Tue, 19 May 2026 07:21:25 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.207.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05fcb3sm193209525ad.26.2026.05.19.07.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:21:25 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>, Dan Carpenter <error27@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Fan Ni <fan.ni@samsung.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <agL-Uwfn26SI4Gb0@stanley.mountain>
References: <agL-Uwfn26SI4Gb0@stanley.mountain>
Subject: Re: [PATCH] PCI: dwc: Fix signedness bug in fault injection test
 code
Message-Id: <177920048187.96240.16889533145135125212.b4-ty@kernel.org>
Date: Tue, 19 May 2026 19:51:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MiBTYWx0ZWRfX9b9T7UKJd5Ts
 uJSytTNwsJs2IKPZcBDPWq1o4RAFoftDHKLYBX3PTwJCnv5lJCZbnlNGgolvrVLD+WN2kkTFMZY
 aIStKomg+Fksc6pGDgRYxC0Bb863tP1dTgK/GaJikefydmYajK47YI4AwXa/QK00XKckvGoP0kf
 z9n0fnSWwyXW/QXMtbx9kaXzYf/BWKAUS1NGFubBdp+UDQPkd+mkOKMEReOHzUCE1vJ1GQcyqDU
 9WB0/tLAGbce/8dqTL/l4B12BBn8fT2N0JWPG8W6GQdpz2QMQFq10FTzrrByKJ3jEZfiIyjxLru
 Fg2LpTr4ipofMOA4Dl5oeBjnPw9JARdiubKsCyv0uDb+HQng27n5Mkytlp+keUUXkRTCaa0itwk
 zTf/ObsJqZBfDmWc88e97nFaAxdC+M5UFjyGwaGbEQbPkBC8DVXsiLoYv1iNicfUek0z8PPAdoO
 TUiSpZjHEwSQ159cJRQ==
X-Proofpoint-GUID: oZKkwRb8K9tf5l8HfVAVb6o5-6xq92MH
X-Proofpoint-ORIG-GUID: oZKkwRb8K9tf5l8HfVAVb6o5-6xq92MH
X-Authority-Analysis: v=2.4 cv=J8aaKgnS c=1 sm=1 tr=0 ts=6a0c71e7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=1gRTTRxgmbTSdBvl+srOOw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=3QL46bKfHKvCq9Ah0JQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190142


On Tue, 12 May 2026 13:17:55 +0300, Dan Carpenter wrote:
> The kstrtou32() function returns negative error code or zero on success.
> However, in this case "val" is a u32 and the function returns signed
> longs so negative error codes from kstrtou32() are returned as high
> positive values.
> 
> Store the error code in an int instead.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Fix signedness bug in fault injection test code
      commit: 94ac934d2c054fba4a22d8dc84749094c5fa0ec0

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

