Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278642E1EE0
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088403; cv=none; b=KU21QPs5Uo9PqLgyQOHt4KSdcxtWRPAH7hIO6Qe0r8XDn27vACKZAM7pexh5S+LPl5iUORPdDwuHrwDp8ooFa/HLmfTRZ2c9Z9KjLqfm5pQVCzPu0lK9AhPxyz9yxBLMzyVuNoQYqfIDJ16j3Eco9PHbKy//7R9aAze+q+XaUpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088403; c=relaxed/simple;
	bh=MHprEKGJ7TJgPffHT6hB4hfpFsv6f68mRCwU1c78FkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yr5fVPgjnmbV//5ll/r8sueLEgg+YgJvzG+VQ13EhEkZrmIE90jpUaEBVzF4pONI13atDTEiV28kEGMuNUSu7q+F+ZvoFRJS4kXAcvHM8bRWYfnsDxWOFhrxemAnXW1lciHPWZ9e9fImgpbMFIJgKqlbEGLs4TggkkTWidVAW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RzUw2lE6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JFnJYkvA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RzUw2lE6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JFnJYkvA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4V3dM3226132
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 06:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HtW2bFRzDCHNDseCd5JWULZWJjDZJJs0SedB2d4noy4=; b=RzUw2lE6O0S/GDw6
	x1tDc46Jr/9kjuoNhiTy2WNhpfLHRrh2nGDD59kj/i52bvXE3U5JGEtY0uS5iJUX
	cp5bxZm88mj4YILnU9VZtmT82AI579sfS79xQQDkHY5++1oP1+mZ+PrDci76Povn
	s4Syvu87xc0cmdUwfzQsXbXvYv8FTmjQK1TncyhVjXS+DTl+RXJKM9pN+BPAWMmg
	AEb3j/6cOgnDm/c4nTfxHx5jInHsuZzDLnh4W8wghEX3zbldubqudhyr1QQQB2ti
	5DkXMD5oOLP5C0z/ytkq38k6/s0c+y78XuGRiaAokSxXgPK9nuAEXuF+YfOs4kXM
	M/QBGA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjdph0ka3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 06:46:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adae76a9d0so6100625ad.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 22:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772088400; x=1772693200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtW2bFRzDCHNDseCd5JWULZWJjDZJJs0SedB2d4noy4=;
        b=JFnJYkvAqHKJ+bbMgTPBx/VVc2xsmpfIfBIA+k5LGzNR20C7L6oXwAjY2u1pi+c/40
         M2u0ICMXUMwSh+Qux8UMD0UR90ALHMscntv0KzIKgrg+GAVIXQ2eyBWIyzQm55DiQqEw
         LdHXWPngrwAavjJGz6YLdLmTJsC9y2DGMTddRrkZB1CQSf5o6CrVnJcqoA3aLh+g/Buw
         ZaaRKoQ3Sd00v1nqLYkCXokQy+Pm25trgxr4lkBJtKwY5OzDJ6qDp0ZguxV5jhaySxro
         H2zZkah1cjMK2ch9wwkL/6m/Wo3Lb762GTJSI5d6pJVo0fD3JuiQQ9lpuBXe/lPfiTvb
         OOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772088400; x=1772693200;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HtW2bFRzDCHNDseCd5JWULZWJjDZJJs0SedB2d4noy4=;
        b=H33Scx7rnnOCcmKpf1kDmsjYiOk+bEO5kFGFh3RIRe4/SU5mKkkqEOXknO0sjtu1XK
         7hV6zMl9RZoM/JXGsqCZidpouFscsuScbNqQxv21tO7/y//PfoIi9FFNKdGXL9mM8Mx1
         +N+rxSFqR090IcEV05fComLG6d2zby3yWunLqDsBO/CZviVXDBgAYJHvXVFRG0mjBBv4
         9rW+oYnVDaNX5kgNOSivtJinwiSFKP13mNj1GvCek97Iwk9oBicgOVB5pmeCcPtdMmlN
         s2LDjXJIMAriwdT0lW92O6scRgtoW1oDZgfn+cXvvC/dZioP1sG6kqHJKaaDCzi+Q4sp
         fc+A==
X-Gm-Message-State: AOJu0YzvxE85Q7gmm3/o5096+M6/V2aoaebsjly4ot/KolFGER1iDpwn
	jYrw9mgJho5lJLyOqnxNKiI0b2kP6refOjIEWie+ScbhBpLP5hPqC6pyx4348A3gFMYZm2N8dTl
	X52ElncZJyihRhjuArH4jW2hG4NZvJ+Z5Wz4quLBEwWeoNhaegOKO1xVhBBumbYY=
X-Gm-Gg: ATEYQzwSH4f0mTxZ11eacINE7XqjED93UxePme7Yejdr1aBrq/PUWC/FrI3SKEr9JYf
	XilB+tbAJ8ApnYPGgLSg/3euMvH3QnTVYrJm+cgAEbwqYpPGQwg9qK+orAgGpKGNDSB7zS2bpDu
	Z+udInXy0hWVpEGC81BC4J2Tf77FpmdOGg5mEXlH4ZeWiy6xWx8/aubUOHqjGBBeOePDh9VMhFa
	PKo8RajAJ8JoLH3l28GXT3C7+ypnbkRwgt3EYD/AENduL13GBz+8GddKgf4G01pTZKcHiZ6i0RY
	MQeqaadmwEHukQngDk+3/+5g3Jvt/aMY8dfzed/Am60X7UshPvSgzzXXRBFMfLat70uBjcYQuHM
	v1GZgAVODRtCSrKCTC8ET/7g=
X-Received: by 2002:a17:903:1a28:b0:2a0:de4f:c99 with SMTP id d9443c01a7336-2ae0305eecamr13245735ad.9.1772088399991;
        Wed, 25 Feb 2026 22:46:39 -0800 (PST)
X-Received: by 2002:a17:903:1a28:b0:2a0:de4f:c99 with SMTP id d9443c01a7336-2ae0305eecamr13245475ad.9.1772088399484;
        Wed, 25 Feb 2026 22:46:39 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:8fe5:3076:521d:50c0:367d:1d7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5db596sm14382225ad.35.2026.02.25.22.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 22:46:39 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Trent Piepho <tpiepho@impinj.com>,
        Felix Gu <ustc.gu@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260124-pci_imx6-v2-1-acb8d5187683@gmail.com>
References: <20260124-pci_imx6-v2-1-acb8d5187683@gmail.com>
Subject: Re: [PATCH v2] PCI: imx6: Fix device node reference leak in
 imx_pcie_probe()
Message-Id: <177208839386.15535.2535030930377494480.b4-ty@kernel.org>
Date: Thu, 26 Feb 2026 12:16:33 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: SuCvGPkRxiSUiSGb_qUifCA7-ndmYFXX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA1OCBTYWx0ZWRfX1oMTaDPonK7J
 1H8rolm+R2NMyTfQlOSdVICk7y3OTTNeMqpxoxvqou90JggrGkOAVOaliUG9/tIn3jKfQuTON6K
 CCSQzQ+tBy6HEBQdacJ1qTCbmnLkTzi91+K7G6B8k5GLtAcapE9Fa+2eiqP6rQrAy8CMJUcbfuk
 kJP8deRbQuyHg7w3Zgm8524KKLr7HnN8uieTfgBaQiJOsgzVo6NuPptmvCQfCLHybEfQ/mT3TSP
 c+tgY6z68ge/wuWbHXlVl8olfSpEgYfDKGPZ54l2vaeIOKsT2y2OWVCjHmPPIPhl7KKT5JGhExb
 GXoDCDNA2b/oKWJiureV8eQuhk1k1+VIso90ytcwT8jaHyvHujVV3hoPVM9vYK/fYeU+izWzcyd
 d60a7s9WW4tY6UFUx9cjaCbaiw4DJ18kHvNUNx068wC1PZ6CwHYyqTU+9fjMyaiDmnm6y0bMSJK
 8raPUn1KTkP3pFsIY9Q==
X-Authority-Analysis: v=2.4 cv=NJLYOk6g c=1 sm=1 tr=0 ts=699fec51 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=vwxMJ2_kboZHlRSlzigA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: SuCvGPkRxiSUiSGb_qUifCA7-ndmYFXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260058


On Sat, 24 Jan 2026 23:42:45 +0800, Felix Gu wrote:
> In imx_pcie_probe, np is obtained by of_parse_phandle() and must be
> released when it's no longer needed. However, it doesn't release the
> reference, which cuases a reference leak.
> Fix this by using the __free(device_node) cleanup handler to release the
> reference when it goes out of scope.
> 
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Fix device node reference leak in imx_pcie_probe()
      commit: 4836ad727486563370b213ef594d644d1bf85b8d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

