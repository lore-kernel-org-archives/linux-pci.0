Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22950399001
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543998; cv=none; b=V4j6K/l8rGpfTeisQchzGeCKPXPJc/ESOMOey5MAaqIwd5M5qP6axy1f8nfKMTew8u0hgw6oZ+LXXx8xP4xWmt3GDD/bj9M22IhXOLfJ6bukk5DK4yshXDXi4nnz3BqJ7LxkTibWZw05yw/hZA9z1+h1/4yDn07m9QH+Pbuo4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543998; c=relaxed/simple;
	bh=a678yhp3JDTo7rDUkiJiYhzXeFmpJaBVhgpe2Xcw6B0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Knmgdt0y9efQIPI8BjQ6tCJ080otj44YGsMbblaONB9ZQZNyV9I5E1JM85EbYCvTDyVoECRzWITjxjeS3Ic8xDaHIZo8VyX/9tjTVIZo7N3Jm6hD3tfx6mSnwQNYL0nxV2H/RcQHeXSshDgL9Hm7D+RAO39pIZPftPcS6CN40yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PFnsfTfs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pwnf6OGG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PFnsfTfs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pwnf6OGG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9gd8334269
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 16:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fg9vq1NSbflBQy9gaZali+s+bMitFkQSj4SmPdzwvoc=; b=PFnsfTfs6oJ5S1at
	mIrYfJRqq+Skz3Httf6QVckjDdKrcQ8E6KVGx1Wn/Ea6ebujOjTzswIZAtcu5tdN
	zcsIZftZ0cUN1zv4QSM8o9fgqsylETavI24SNdrcYVrxihmcgkD8HeWuq1Snm07n
	K6LIRxu4COIzJy9fAsU7vk2dg2rVfvA1iOshfn5T2+/lU51JQoPeQm26XxB8GggG
	5jaAzHGlmtYaypbYEl3dJxmuhuoybAZsyCjVj/1N7PZOycky66I8bVOcAaeW9lyW
	FsjstywPg4lUJPCYGProEuxjxzeUciMFftCbQhWgIkDBnjUTQCKrKPCJ6L4BLbx/
	XTdstw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d527ysj5n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 16:53:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b079b4a8c3so37989775ad.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774543995; x=1775148795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg9vq1NSbflBQy9gaZali+s+bMitFkQSj4SmPdzwvoc=;
        b=Pwnf6OGGpbw9c5pF6Z+AY3zDJsDzIf27UUkhELw4KpvGEREhbuHh8OuVlivu2VKG7d
         7WlMAZhorOXIPqvHhZrqgRVv+xHuGhgb1g6IVZLZB1nNzDlycq/NNlZIU64mjejoyQCh
         4Yrqei5DOjbKZHQg+JTqg4NmTwQH+yGK+YCgJLiihYB8pFEKlMLTqJNVz3lR0fpHi2+B
         JGNKhbNvU3Wi/qDN5KhgYtRAF475gasi4XE5V+YEthlzzYhyi1A/tpw45S8+rmdDFKYT
         gw8dEH7hCRYbYAkiDoebJjdoV2M28OemNgwgdUwfGyw327e8YKpZM676l4aOOUDi0iHi
         wQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774543995; x=1775148795;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fg9vq1NSbflBQy9gaZali+s+bMitFkQSj4SmPdzwvoc=;
        b=B5np2eKKljPeCUOytWQ3ltLV4rCzHmTXXgWJgugWV4JPNV9abvReMNjCBci/RfjvyW
         rfLb1iTYyHJDN/3rQHd7wwbzA+5IAVeQvjlyR+lHOMcqEGc4lrRBe7CZgE9H/cpuTDk3
         9FJr+Mtl5idb6NCQfVIQ/7WUlFPrY7yyY4u2kUrKsjCEYnHp8hr/pWGjfqcF5VmHsxC0
         DMyVGh3hNPYvh5HyaufJZPR9NMN1zyQm6qmvVEbg5SELNsX2m2qmxy0swSJax9sXcoTA
         /4R4Bxu7Ahj6Rj/bIXUUKZjRtQQTq69dd09OHf+YB5rij40jZ58K/Od+wIwg/PBiGeL8
         dcwA==
X-Gm-Message-State: AOJu0YyarIDy2M26QMVeoHYO1SMRDJlB80no9pbzwq9SSjTflbP+fBBN
	7HbD4E+BgLNwOHvE9PGAy7T7bp6r2e9Gm6VYRPb7wU0gIWIFvF3e3xA/yHqk6V1+1lk6GgIu1nZ
	RMZqfiiBuT5JD16jjVuB8BxX49xtEuafqHUlzutm8VlAPkk4JQ4MLr46A0e3mgKjYwhcli60=
X-Gm-Gg: ATEYQzxsDHEiDGcZnuIGQSdpnvEHGZWxLhHfK4py5E/IFJ4u1VITtESJJ5n7gqQLlMR
	JL+SycVB5Fx0QOsC8RghAyrjtbPhXM1TZ0tYFY+enXnEVo1v2Tu+/1V1doOFAd4BlX/LEC2vPd+
	27Z2sQ6lo4wZX8Xvk7SPoq7+vUx3/HsuOptIkpK0Ciro9DooC7f9sd1lz72rbLTof/l9CwyExfJ
	kRRtk0ee09RV2jrJZ9IPLiyANX2+4ueRwHP/O/FbTOP347jyV2sBvVqvHZV2t3xd5zjdhFKSLPq
	xda7OnI/R/Ar2i+7ghE4BC3UUc80P7J0OSWKtKO86NecfUDyfqcXaVUk0Cat3zKvGV6uaVkGx+Y
	5yjFhqPSxn591yhv4xmOy048=
X-Received: by 2002:a17:903:3884:b0:2b0:a980:367c with SMTP id d9443c01a7336-2b0b0987e22mr93048315ad.2.1774543994686;
        Thu, 26 Mar 2026 09:53:14 -0700 (PDT)
X-Received: by 2002:a17:903:3884:b0:2b0:a980:367c with SMTP id d9443c01a7336-2b0b0987e22mr93047995ad.2.1774543994189;
        Thu, 26 Mar 2026 09:53:14 -0700 (PDT)
Received: from [192.168.1.102] ([117.213.101.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7bbe57sm47090225ad.34.2026.03.26.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:53:13 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <20260228080925.1558395-1-hongxing.zhu@nxp.com>
References: <20260228080925.1558395-1-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v1] PCI: imx6: Skip waiting for L2/L3 Ready on i.MX6SX
Message-Id: <177454398920.452566.5271838432728945617.b4-ty@b4>
Date: Thu, 26 Mar 2026 22:23:09 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=dLurWeZb c=1 sm=1 tr=0 ts=69c5647c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=pjPfvbXasfe8cMZvnaMi6g==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=rcZeYksTzYAZqbyAQKQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: rMyv1CEILbrA16VL9v3RCrB5GdeESCPS
X-Proofpoint-GUID: rMyv1CEILbrA16VL9v3RCrB5GdeESCPS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyMCBTYWx0ZWRfX6Gs2ggG5HO1+
 qNorotFiFvR/Hek++XILMHrB/WeUGZchE8kKVDmFliEK74MuZAkDp6EN/4JqUoGbx2Q5zz2yHjX
 0W6OFTl2mJEcVmHPvKhu/4FPvuYQpbh0QHEt5kw5Twl1TuQM91UYWBdSwsWVosnwr8auDAdd24R
 RHWJWLWJt7VYHmP1Mw593LleZTaKDv0NBAtdhCMwM/8EVemRNFkpX0MSZISIcN5lNYDlhaHOyAQ
 H5jsQz7R42FD375T6vl5NsDtyPG79MB5l0YMmany6UKBE+OEUpsRq0Vg1aYu0tdDl2/Ikkvf5Tf
 sVLZQ42ZPGB8p2r8VQfz+P094HZRccZ6vSCFEuZdP3b0SaDShncbKpEVVisAALDURqrGJKQJ6N3
 nzi5Pw9bmuVz/Z2on6YyVwUwfdenw1nbEAVM9PoR0BkKZmz30gnZXaX+9G1XqUorZ/sdY7mgSPD
 FEUI4K18Y+1BB2hcfmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260120


On Sat, 28 Feb 2026 16:09:25 +0800, Richard Zhu wrote:
> On i.MX6SX, the LTSSM registers become inaccessible after the
> PME_Turn_Off message is sent to the link. This prevents verification
> of whether the link has successfully entered the L2/L3 Ready state.
> 
> Add a new flag 'IMX_PCIE_FLAG_SKIP_L23_READY' to skip the L2/L3 Ready
> state check specifically for i.MX6SX PCIe controllers.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Skip waiting for L2/L3 Ready on i.MX6SX
      commit: 5f73cf1db829c21b7fd44a8d2587cd395b1b2d76

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

