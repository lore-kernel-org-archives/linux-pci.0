Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CE12741A0
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775322028; cv=none; b=oIobDMMg95H3cYnHaiXldbH0riI7o+8QwanDel+wU24p2gCNF05yZnhwzu6o4OlToTfO3Y0amPrAS1AT5z2mhV4nQsOKCwmKD+mA8rWQBh1aaF3rE2zueY5OAlAJ9oFjQoanEo8XYsw2ar9oWK3BDtjtfx7YVJK4cDmFWY9XrWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775322028; c=relaxed/simple;
	bh=gjCBGAGP81EOH2oljnu2NmddwK9MeX+IixvluhZ/qRk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e0gX0PZ4yKd/RehhZFQJ74gIV8BjaJwYSCYS72TFb0bJqU+XN+HbZIuc6FIjoiUtDsfIOCPQpumvGmMP7psD7sZjpIJNTcCHkNDYITa9SVzvZNqETB0hWDSRpNkcBu5SiTOkBSX0vqG0MCXcjPRg3PIkLVh/SGmmgDo7cD5+SVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pH6exHM4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CwSvSlTm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pH6exHM4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CwSvSlTm"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6344dn8f2971843
	for <linux-pci@vger.kernel.org>; Sat, 4 Apr 2026 17:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BHYoMiuT+hFy3l8CYUd8tWmBQMWoLPghXx653KocS/A=; b=pH6exHM40Mb/jWHv
	EoF7X2tC/uk6AA9v7E9Q/VuVuKiLEkYBvoRmtkc1E+RiedArGBAhQ9IbgkB5fT1N
	rOnUeRcbJSgBNTRFneYmWNKzG0iykmLfa1NqQxZcC19ab+1ZzhkX8kTpOu2Vbbc+
	zf0FSZ+UOlAbmmEI4KtUQ4ZHbIaWMn8rl9EDflmN1FQV77v0iJCkokF2KcPO3UCe
	HM/JmqM4gEMyWre32+vTQVWNA82Dkjngur1J+STLBCllNnPIpXOBDFvNwOOwfxJp
	Y5IXnWteBbyUqmwvuFWeOo0epAbyzj5unJqzRoNWxYgKY52trakJgqP3bTDjSdUc
	vOVEEA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dauth937b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 17:00:25 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c7651644975so1664711a12.1
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775322025; x=1775926825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHYoMiuT+hFy3l8CYUd8tWmBQMWoLPghXx653KocS/A=;
        b=CwSvSlTmGIwLtwNnzKQjIPfhOj2aA1NLIPrOKRc3kxqGpa8LLF+DmlyJwo3wyLAkFI
         YW7236IFYOZc1XDMYIxjFvvIyn+4NMr8n43nTqNfJXfU0ThO/e4TFR2l1iIn1w/jp9+a
         MXWi22GjUKo55gAfGNmikPp4zQBHczsd7jJlXJ3r6qabmuiTM72/ZFougyCdMgkNpEKE
         28YoV9KLSgrRBeA4vdk2qfdilKu59DcA19OUjd3oCIxeErWTR6wPtimDOLMGx02rwEUS
         dm4krNKfAUOv9tfYjQz8MtVsZNxZfyGgQHqFQcqU+8qTZBFNKz59/1PoP9dMFWBOplO5
         +7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775322025; x=1775926825;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BHYoMiuT+hFy3l8CYUd8tWmBQMWoLPghXx653KocS/A=;
        b=JkAwKy7ZN+Nf6ASrGo5k63ujJoGolm9+fYUU93f8Za82qYZrGx2VwGzDXH3Ev8XhDf
         0JlWBNdXsuVjZ9cZyQ0l7KeaESvP82D8V1LgMTu7t+wclIbTLlBwwtVEZmrK5M5X8L1D
         S7tMaSnUx/SVz8WMy7a24tLfKbokyXbGSJo6vpxSVYc1T+XNsP1DD4Uhll6tgKT2fIrp
         Jh0EAFCOva2dm0ZsuH4y+D6vbhxRRq3xPLgSVsbWK3UrkuSDdIlmXAdyoFgHHmp6d+4n
         u7eR2s8yQLYpAv2ithEPiVeJokB8d8mxvUqc0rMKUp0wzPeaSpD2wpCDHhjE2oRKHwAT
         NhRg==
X-Forwarded-Encrypted: i=1; AJvYcCX9lXI2NKbfANdHgPeKcedmK4E/45XExzCZGpLO3tFfe6z5uY6tCRW5BUHXJEJpBwYSN0er+GEz908=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1KhGG8gU3IjSUM1B23l1Sy/1DtwEn6r80kapLWSe5MOb937w
	twPefO0qZ+8oAAxNyN3vo0Vj6mXZDwFkThpzJ8cxyJjprw9AG3HPwBWNm3uiBSFmL6BUI1eXiZj
	evchitdbkh7OWRkuVsPQrwUk4Tb+S+75QExbAlqTiNVuprPF5bWPG+ga7fOAEACs=
X-Gm-Gg: AeBDiesou5vo9gxr+yeNCy0a+tFQ5pG3oMQKIrxfF5yDw2BQEnsl6okqhIoq3UpFamJ
	AVt1tO7/c1yS6dtPsotpFtY+gP9W+jdVZPOk2SKRQ0iYf0vS1F0Hn7UaMPtIpm5vc5EyzGJtMDc
	04IWm04iDyOcw7QWkoOJXTs9qPynEG8GGW5azyn8L+WCEOvgg9C33zCEzQhgmqA74KB78krVNbH
	6QC9EMh7WMQYqXAYMIkmAiuimHO9o/JJiXuPuuCGiuNcPmXPzvbq/S5IqNpC8nBxXGnm/zsuZrs
	a8FYAEg7jsRO7P7+R4kkv6R8ZCtMB81N6C2xJhQnSq2YaxUCiMSgPfcRtEtcSsU3yOSi8ND4Dj4
	oy8zuyU4TkgX4KI3aZnBANDTX
X-Received: by 2002:a05:6a00:a0b:b0:827:2c79:fa84 with SMTP id d2e1a72fcca58-82d0da45d27mr6277596b3a.12.1775322021788;
        Sat, 04 Apr 2026 10:00:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:a0b:b0:827:2c79:fa84 with SMTP id d2e1a72fcca58-82d0da45d27mr6277559b3a.12.1775322021206;
        Sat, 04 Apr 2026 10:00:21 -0700 (PDT)
Received: from [192.168.31.133] ([2409:4091:a0f4:6806:b530:cb:a537:434d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c41bc6sm9368133b3a.29.2026.04.04.10.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 10:00:20 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Franz Schnyder <fra.schnyder@gmail.com>
Cc: Franz Schnyder <franz.schnyder@toradex.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        stable@vger.kernel.org
In-Reply-To: <20260325093118.684142-1-fra.schnyder@gmail.com>
References: <20260325093118.684142-1-fra.schnyder@gmail.com>
Subject: Re: [PATCH v1] PCI: imx6: Fix reference clock source selection
Message-Id: <177532201484.28194.6879238704665681982.b4-ty@b4>
Date: Sat, 04 Apr 2026 22:30:14 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDE2MSBTYWx0ZWRfX8GdpQzp/gUMF
 JTrA/D6VA6IXBuQ3iJXS4++hjUCOOxkl0+eK80HKUxjjkDUkK4DxjDrEibLy6i6vupnHC4/FDt/
 J7IbhZ6G19SvAPLObP3JIJAZZGIVmnP/gN5MlkX1PM1vayF/oiZW8ptlgdMly7IdXPYEA2S7OUC
 OEXiq+BD/tBtFVMu4LnF+c6EpTv/sWNyrRw2e5dqj1cnfpAalq7DmVMO/xzCuYenuwHmT17GRSK
 cgXdR7ZNOQ/bS9QRyOu9SEddmvoIEomWjHUTXHf6t4mHxEfcbNAQ3rQWWAi3UMTuDaHeRNvQBl7
 py5OpJqadCdrMNe2vNDerQ7iEIAmfNOjZJ4aesXTsTJd+1kPqbPNQ+CKihpTqRphLsdfs391xha
 yMXt4nLw4SVpHBdfyMlrCjM1Usd591Ku+BiKb1y8wSJbLL3S8tuF+RQAi1ea1N0wgIb0UkT1TTL
 n5jALRaomP5sSMOOjkQ==
X-Proofpoint-GUID: 4l52FHJE77cLNKRBZy0Ds80wSDKfPA4C
X-Authority-Analysis: v=2.4 cv=MIptWcZl c=1 sm=1 tr=0 ts=69d143a9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=d2OGGJ5TCE6yqAnRVzwA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 4l52FHJE77cLNKRBZy0Ds80wSDKfPA4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040161


On Wed, 25 Mar 2026 10:31:16 +0100, Franz Schnyder wrote:
> In the PCIe PHY init for the iMX95, the reference clock source selection
> uses a conditional instead of always passing the mask. This currently
> breaks functionality if the internal refclk is used.
> 
> Pass always IMX95_PCIE_REF_USE_PAD as the mask and clear the bit if
> external refclk is not used.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Fix reference clock source selection
      commit: 575d7268ca07fcb1d1a50399e1399ba60df3cb27

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

