Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F024037F733
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775299380; cv=none; b=mhSC4FgVo1N5WSS7dJoQIlojRdU0Cxhko2IudiZW37XuEkccL+FLHGT6pITQQDvXRrqz4fWeRxMyq5vr9S35uB+M6DFSSHcdrsKMzv2CeyQAc+kc1glH52P4JwUHCzwj98z/sxHQDcD+bFAO53qIXlf37t60IHdguuoxv0uOQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775299380; c=relaxed/simple;
	bh=pYfcGKdx0Rryej21BO+C9aP0J1cNhKpphMroUhH0wsg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mCedYG6JhQRRXf86nvYPM9nKvx3QhHzpvZbYu3Q24vYRHKwzjvFTUlhvL2HNxcqDxUt20hv+INuJKqYiDWIciuQ1R2CQjvc7gYohT0NjgGsM9266rduZ66omfRFKnZrzDwuXeB3kc7K2AZHlTzcPFORClQysDmmsq/qLYFGjtz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bS/J3/eg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HHOkCqbI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bS/J3/eg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HHOkCqbI"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6344BZMk3883559
	for <linux-pci@vger.kernel.org>; Sat, 4 Apr 2026 10:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e84297XhT8HmGfOAGvVKf9pMmA+a1FqZAkjsY4N6Eoc=; b=bS/J3/egbPRXKEyd
	vluVPleDYVVweuaDNqrB72HsQf37Qocy6KhZhVk/8ZFalQ60sv513OllyiFnaDjG
	ify3GMbq5HAHrZqBIQe90a3atcPOtIWAzFEjRV/+IigD/vvsNcqMQLegK1oujoN2
	8+4xLXEcq/DT2+HD1Z8GTjP9AAIQYabw3PN2Neo2OP7mw2R/4klrZTf9v2VCYKoO
	mv7+A4oPgrSnSDEjaaSx2d8zJ9jw2Jz9NSEwtsDzAa1ndh2R9OPQT3p7cLnUJCqD
	0stfdctpdjZdjrReB4LvCp4ydTf8giNT/AzumXk+tOj50QampxPWd1lPORF3rISW
	I2+cig==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daudd0kay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 10:42:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b24e9b4d82so36506135ad.1
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 03:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775299378; x=1775904178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e84297XhT8HmGfOAGvVKf9pMmA+a1FqZAkjsY4N6Eoc=;
        b=HHOkCqbIROIA2qj5IVX/le4VGSB51GNkdaqiiYgKRtS6cIpAmSohjReehrsh/72hrs
         UHy+wAwnxOU8pUjhR4Ba/HZHTR2SalSggfKNDcwhqzl0UgnFNJ6pDavmAsBeIR4piqjV
         F/iFfucxApdH9ZFvL+g/RNB3dmT7LP4eoYu9vsQex1xEcB5oEhP82Qzyc/P0U60ZJWPK
         wulFLr94nPzaOUVwp8heEjDGIBU//O1SK62s2tzKt3hk06W1L+V1moaVhwh46LO8fOL8
         0ZR/nrkJEoQE9yAh709htEyUDqaaRXRNniAOPL2X4fEu1BJVOEMV9js35m5MbbdxiJXo
         OMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775299378; x=1775904178;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e84297XhT8HmGfOAGvVKf9pMmA+a1FqZAkjsY4N6Eoc=;
        b=MSCFcGBPQWiCmJlZ2tx0zY0ZS9ZmL5joKdtmYyY983kKoNsfJ0v9A61P8NNzzq3fGg
         fLOfKVf1Mr5rQwjpelmDbqXCZ8fCcULIZ8ZmIBbyrF8y+vOTNQsrB1nPFcXwZEmLfK6o
         c50Bkyix3zGiVv4G59eouVoB+vZyCuBPZm/buSkH+hfBd1kCnNJJscgSS0vbD8SA0Apl
         6NOQvdil8pY1tMSDRIWp0ljH8+juRDN+OdGFOzauovmDVtpa2jBPeJmI/AQYb79t2sHm
         daWnNPDfCCTa4Q4muyk6BPmIQFj4eJgFohQ+wdnXSDPWk8CSGo4Hel7BCg/UqGKN22C+
         ypow==
X-Gm-Message-State: AOJu0Yw3lOZZ94QVxO823uC8/CGntun3+HeLkOPoZBw4PCA2P2cK9/o3
	dkdX+YEttE1g1lCJqRcCVakFjVLizkerJai9mEpSVOGKpIbOuzpj1JLQdU0Q4UYIar/Xfj8xtjy
	St6rkXq78LziDFWKt1pvkL58Z++2eZlwWFKIEupsczv2B5JCC++ND7r51ae3lhDg=
X-Gm-Gg: AeBDiev1z5kzPQmofeQbDeTENFdu0KGS1qDqcRFRDeDh1DHr61uBfO80DyX4mDPILkc
	j9TF3X21Qss8E+IJiLlLvAvzaNtxbcRJMRllpRlH/1JSCXlrvy4oIe7tZ2ihT8hZjud/l5emflQ
	VeUQIzOIWVWB1xuS8yyFYgaF+iWFAUYKpjxy6OjNdYJarUAMh88/PR8PFX/jST7BCoVDXI7Ew6H
	8gGUypbpbXa8MfsYAgx+MzYQ+PAKO95VKXHeOsH1i7jgtv9m+tiWXBSHby6Eiz97iNQu1qPFQVo
	L2l4Yeo5C/0zHZS8dPpzpBxbQBeuvsEC3ZUf8mPAYMyr9APEUZkna/0nbM4P72J/ySObm2gUT0x
	phdTTkR5/H/1IRUM=
X-Received: by 2002:a17:902:f709:b0:2b0:ac1e:9730 with SMTP id d9443c01a7336-2b277e36491mr84232405ad.14.1775299377488;
        Sat, 04 Apr 2026 03:42:57 -0700 (PDT)
X-Received: by 2002:a17:902:f709:b0:2b0:ac1e:9730 with SMTP id d9443c01a7336-2b277e36491mr84232055ad.14.1775299376666;
        Sat, 04 Apr 2026 03:42:56 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:d6bf:182:1f3d:df20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749794e8sm88066315ad.53.2026.04.04.03.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 03:42:56 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        bhelgaas@google.com, frank.li@nxp.com, l.stach@pengutronix.de,
        lpieralisi@kernel.org, kwilczynski@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260324023036.784466-1-hongxing.zhu@nxp.com>
References: <20260324023036.784466-1-hongxing.zhu@nxp.com>
Subject: Re: (subset) [PATCH v8 0/5] Add i.MX943 PCIe supports
Message-Id: <177529937123.12054.16299397232734906774.b4-ty@b4>
Date: Sat, 04 Apr 2026 16:12:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: esqr_QKPSMh9rCfshZ-otEZm1Is5RTj5
X-Authority-Analysis: v=2.4 cv=JZ2xbEKV c=1 sm=1 tr=0 ts=69d0eb32 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=8QGBsu52YCFcfEt-ioQA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA5NyBTYWx0ZWRfX3udqc0yigsJU
 M6J0r+ggyc1+MU5wfiTG/VTT3+uObKriDthzQAkjFGhCUzZ6c2oXUm++IBtcnbmOyDLEzRoZmT9
 LgViVXJTmym/48oxiSu7M9MT47MJ9FfoTNvhJjv4NXMt4H6/HaRCv2yAZ5/AdFKZoompRiGiTYt
 jXviat00a9EJ7voh8y8nXu1+cqvV95QdAGOFAthMJ65W6+rXu2MC4RRRI74kWl+RjtVkH2TNLHL
 esBfsNEZcume0olHQy+UN8tlW4CO7HJWkDCFFdRZExLkr8onwY4fsEvNtnf2+VMHuCjM97GdAmk
 fuJ1aL2IEIdWoD2V6E/Kcaa+S3qO1cyMDY0Eibm5zrHGJWtsF8Yn4jp4QTiYyk70YnEYQo2mCv1
 oPGJkp4dso9Lj+h/YZOT/HYWtMNz6qfoSyopuu9g9Y3aHJ/LpFTaXlVDytA/HNIsFtDgccy8gCI
 Rs9uAKH5/UN11aFWCng==
X-Proofpoint-GUID: esqr_QKPSMh9rCfshZ-otEZm1Is5RTj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040097


On Tue, 24 Mar 2026 10:30:31 +0800, Richard Zhu wrote:
> This patch-set adds i.MX943 PCIe supports on EVK board. Please pay
> attention to that it relies on the patch-set[1], and the PCIe1 port on
> the EVK board relies on the [2].
> 
> Both of them are included in the v7.0 kernel.
> [1] https://lore.kernel.org/imx/176649331066.523506.9443864112044699350.b4-ty@kernel.org/
> [2] https://lore.kernel.org/imx/inzg46tc2fwsajxq4vzdyuiq7krzy6xtcg2mjaieninz7zsmgm@mtdjr4tuegpq/
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: PCI: imx6q-pcie: Change maxItems of clocks and clock-names to 6
      commit: 401359ef44af43b6b775dc01bb7b31396db67aab
[2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and i.MX943 PCIe compatible strings
      commit: 4d7937d8cc32b027a14cb8152d9df64d17e9392c

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

