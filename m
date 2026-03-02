Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095E4387372
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460776; cv=none; b=ryXWW41Spebamao6m9J5+DNKN3BKvyEefrla2P/NUD2Yf7Hzsjax6A/rJ17IolVixbU8+jqO4fxdFWZZaQssh9dk3VbKBZEYJ+0wZNYHaH0678bIxEBMaX/NxfxTlXUWNGgIlZxkGM9UOy9/T4XmYHqsKdcZ803si3gZGfeOHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460776; c=relaxed/simple;
	bh=tkXHw/T9A4+a2nEYlgVBfLNKfaPlQIzgol6SweBQFV0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=biW+CcA+Cf/K5S19Cppsho/pUZBNvRWy/5jgFxs/k4sMkNhqHCT3MdVAn+Lghbam1RXrERIC33xp2NjmjG2oJ3Q7GtOMHQICyghEwLLTJ7uOYfeNCW1nddW9comedXOuUBFGMWczgYf+mLED3919OrXK2qPdhl1r8RuBPhM47pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z9thOwad; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WzyFPiQn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z9thOwad";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WzyFPiQn"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229K5wu782876
	for <linux-pci@vger.kernel.org>; Mon, 2 Mar 2026 14:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TONc3pqyOTNHCuS9zVMSY7iiruSyRVqmQKnbEj4Cu4I=; b=Z9thOwadEWaUhnI4
	6oI35xSKYG0a3kZZ4NrzEh9SW+gVOAf/BXzZSW9Sjhzq8Vy76bJ+/BFs25hXsdPq
	oElduDfn4/LaljSQxa0KZQKVbs8Zb2g8itkohDuX8sTQ5mGS6fbpw+n0xe5qb+Kg
	i4X9ymdt8X5ak2PO2U1Qa+L8bMnBfGOl0ldUhpfN3Mv/gzgAdGdyoPVDFekFr8Ie
	6R9jP6XIx+kDNf53Y0FM4cPcDdb0x2TTiHnqPiAw8yK0lWleQxKxiuQG/zjQ+7cy
	EaUcv8N7XIzcr//9XBJY6b4wWRRaUV992YTaUruO/54fYhh+a4NhmLXpDOfJYUCD
	N7xocg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7u00wvw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2026 14:12:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso3640033a12.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2026 06:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772460773; x=1773065573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TONc3pqyOTNHCuS9zVMSY7iiruSyRVqmQKnbEj4Cu4I=;
        b=WzyFPiQn7dBgnoUC84mV6TBNfHG43NGDG4EugZZnQu8IjYPNp6Lq0R3iywKz14xaib
         D7dks7yUGwjt0jcQDkzGmyzS8FbzEq4z1rRPiSgjh4JlGq7+xGSB/JX7cFlotj0CmuYO
         EhcUiPcjEyesOUt2DTTcd3t5efo84MqImVLuglzJaG2HHE+Yjtgr0Tj9zMNJKLk8PG1M
         qvTStWBm8e6RSqxiIUNptFoHRRbHNwJgrGouQzd50194y6RFEigGsdM4oojZAugbhmqi
         NwRmpdR1tNZbet2OgpBgRnBhwUNvZEGxOLAGm3f8anz0Z+bMk9Q8dIAsQgtMS+sb8nAm
         9Hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772460773; x=1773065573;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TONc3pqyOTNHCuS9zVMSY7iiruSyRVqmQKnbEj4Cu4I=;
        b=w9xNQJXecfJZaNwkOLB7adMwKh4T6d80LpTXC+oTIzjFhmwkYq3tUl7rzV4evy7MtJ
         qXvSjKtfMX9TwBjk2SD5TtYiwi7bH8IAlY5t5dz3Vj+FP6KzT+tKuYEftvwKlS4gTrwV
         eq53QP/0hakAkzozWTGDLokE9xAlo7Nm9lIWZDthjNzbqNaY/y2nfGqKHnTay2ClOa41
         rlkO+GR6vT+tcUoRwnG322XJEku0Z9p/lwbwbHP3ZW9xigtOWz+pbJMeuMfBeZ5mBYEh
         UXoYrhvWlSRe574v+cBFMpvtGx93qZ509baRigvDWSUpcJEIEjr95ClsQJt1qnrue//C
         TU/w==
X-Gm-Message-State: AOJu0YzGu3a1Xv1FgRUvUAF20uf9C4VUmmmm6NtQjrU8zoO0yWS5a+AI
	hAXI0WBMbchLrigeGPSLRZY+TLaqK0G1XS1ONNg9OMVoBm5xtlBuebugQ4RJr8TH5d0voZZL90/
	l0S1LQgxGH2TQgvl/zoKBuW70sD2g6YDOnxFQbuLASMjZkOQanWvaRxLSY9NKW80=
X-Gm-Gg: ATEYQzySWc+xeknaeqOI/qWoyYsWeT7W5/5ARLClAbjy6oJdBVGI8GN3lt7F2RkykQo
	COT6GC8uLCbTERM0z8J7YxeKjEun3YlNDBGsUJG1Nr6JxOvLfDZLZi1+SR4r/DgcXCg3/0VCrPz
	DjkB4gN0TzfHTESs4h/toaglv3uIUw25hxBkw3VowZdPqVo4clb/VIeK7UVnaP7IIz+WxVxd1rT
	RzkaKUuUhRSV4Tb5f5sKoE+MChvsIGJtPkphLmtCL8UiTwU3TTDshQzNB6JCctdlOCFzrGlGfwT
	6cMr+f3j7/35Xh9LbmOszKHspETLkYf0KesYDhvx3uHrh29g7omh75y4/+DZGA2gjqPmgLGjxy8
	Jx0Lhtfg3j7okBa0MWkqz188=
X-Received: by 2002:a05:6a20:a103:b0:38d:fa67:e87f with SMTP id adf61e73a8af0-395c39de580mr12110974637.12.1772460772911;
        Mon, 02 Mar 2026 06:12:52 -0800 (PST)
X-Received: by 2002:a05:6a20:a103:b0:38d:fa67:e87f with SMTP id adf61e73a8af0-395c39de580mr12110932637.12.1772460772353;
        Mon, 02 Mar 2026 06:12:52 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:88da:227d:c631:5c3c:695f:8a61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c9f79sm154372085ad.33.2026.03.02.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:12:52 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
In-Reply-To: <20260220142600.2397070-1-andriy.shevchenko@linux.intel.com>
References: <20260220142600.2397070-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] PCI: dwc: Remove not-going-to-be-supported code
 for Baikal SoC
Message-Id: <177246076798.21083.15234625230035154971.b4-ty@kernel.org>
Date: Mon, 02 Mar 2026 19:42:47 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=GMMF0+NK c=1 sm=1 tr=0 ts=69a59ae6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=I6R945aIQUyn53Zyx8AA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExOSBTYWx0ZWRfX72MvkSWqy8kU
 d8dxK5DYCJX1fJh70xUze7tQLS/18nB4fuo0VxhTjfGAf5eZl3qbRN4p+askE4+k8omhIW4My5e
 Zkfp/y6YqK8AkglgYZbeeEcOYloCMp7rP5l2e4i1yj5wUXuVOcD8gW619vcoNI5UWlkho/HWBaL
 eSgBnvceLQTkhpcEI8Lq7z7a2acx/IGaqEVTZfQOcEhAhTLoGX2DSDHUM/Fomj3/jCTEIWQMJ47
 z2CWuGishR6KoKG1QsyIrbOmf4YRviiAe5mBqJSWtkDe3s9ZulZtdguOWq6g4rHzCvEBOF5RL5b
 hyYsA3RgD8AswrykYRDlepbde/ibGIyX4+7VC+3vHWHVQ4zC/WPkytq7T+l4ZqcTkHkNSAK8w/i
 W03/uGQBdaQ/DtAppqfbDkCF0GSXtg4wAtXTmsLHBLUvuBsAGIedJxoVjki7yN4qg2UkkD1x+rW
 +0AIbt/Zm/1oA4mZ/yw==
X-Proofpoint-GUID: XZFQaie1Om8fIIo2qAIyQvo-4i5DOPAb
X-Proofpoint-ORIG-GUID: XZFQaie1Om8fIIo2qAIyQvo-4i5DOPAb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020119


On Fri, 20 Feb 2026 15:21:12 +0100, Andy Shevchenko wrote:
> As noticed in the discussion [1] the Baikal SoC and platforms
> are not going to be finalized, hence remove stale code.
> 
> 

Applied, thanks!

[1/1] PCI: dwc: Remove not-going-to-be-supported code for Baikal SoC
      commit: 5e5ea39ff55297fc9d6338f26346c2a7738a78ea

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

