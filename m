Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48FC33122D
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575769; cv=none; b=r2jbYrdbneBveZTmeQ8NPLnjHoCCSewcrle9m+uowb85Ds4daZunIYqUR2EEX7PrInEYtIz5nXpI+xEmPYuB11yJ4m9JGlLquWF14nj6kfDgqDynQrnpGaS5npp3QNwEf+s9h+5pEBy+bfRpiWgbpGpXGzwdzy7pVjZW3xRZVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575769; c=relaxed/simple;
	bh=kxE7z7lCTZJMfdC0VMVr+zdZMIIkKpe/SkkBc7Oedpg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YsWToOoU2uh4XnH557871PTOKnpMNUbaTNCfm4GQWbmPa2dvEwE2dYp7RmcKAHxdFRXvSdK6Ph2FGvYXWhdGgQgAWxBqbUvByv3JYLWZ2TT3s6t7KOMpy4o89UmGS9Zkf1Eupm517HjpDeM/UlxqSP+gAcLs3S739VnPcgJBZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Me6nH9O0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VlY+53BF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Me6nH9O0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VlY+53BF"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C5K7R02994873
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 08:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DFIMQq5sZaAx7AxbAUXAmZ3pH2PXw1sOxfR1/xNVXQM=; b=Me6nH9O0sIbzDsal
	serlx21cCIX7bzitKAfRNBNhbrnA+SIJSl+egG24pmiEEet6ABzehV9KN1h9JeGS
	Rq3uUaGVltRhJb89ua52c6tNnF42qxUnBdUJBVQbU+2hpaJ8AU8o03y0lkJOqdzN
	amQCMgkSCGfPEWcla6ivFd/1ZexXmKqaOt5fhnVPJ/1kCFtziRwSbhO0VBv79Mw7
	tpYnsQLsNGQoV5loCcXydI4Hq045qh1MQDoTjg3Dh/dwPNFIK2IIOiShW7grkSIw
	skmHtvXEsYUvYBJMsxXZsncfMtsbu9aDgjYpjlxIciNjmeyg9Bbp1H31gWPkrC2l
	4S3hew==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0tbev-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 08:49:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b4654f9bb6so57172245ad.2
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778575759; x=1779180559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFIMQq5sZaAx7AxbAUXAmZ3pH2PXw1sOxfR1/xNVXQM=;
        b=VlY+53BFPzGvjDt+JpwD84/qv2rbnvDiDaM88i3vMOSw8kCgNAmsd2WvfCo93tUytP
         wHJvTTHCqRHPFPZiolNjTV8WIxwqzv0hV3/qeucnfkR5hCMm2Ubk8Na8TjwEe4xu41GK
         o6ph1hHE7ZHalwH+DeMNLmkU1o3J4bZir4LqE4G/a4dHHA4ttqdOsduLC2mZoBF1k+Mc
         gEimGfUMKMtqSNpRjthp6URhkVut7Fok7dohQ+8NQjLNJRENEJG57UT1jm/5wR25pfUQ
         ZzYHqOAoBK8oWhYHtcTr/ntqPbBmma1vZevUK61lpwFgu8aIBK2/nZZP80WzzvHgHiog
         5rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778575759; x=1779180559;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DFIMQq5sZaAx7AxbAUXAmZ3pH2PXw1sOxfR1/xNVXQM=;
        b=OrDNbdVZDng1ZzYOZ/WVVtQ6TWD3osaQouqZraRKfUUUhltpKrglJkob/d0T4M4W3Y
         tmXR3uJTTZCaTMOiqrVqRCCVgTnOvWAgx5aHSKCYUfOlxaMlNbS734K2c9rbMGVDSmyF
         C+MYlqnmr0BjvN6ei3qV138EcPVPRkh+yqvsLQXItbhE/2VqPFm8I4dja7GxASUYkvtS
         5eveofKTdpWETQmK6uItlOCefP5bD96PodxgjuyVN9WZDx4HOzrqE190qe7KRGx4dBKD
         Hg6pwrklsUxh+d0FdXZqx1UURo8Ehl6xRaqu2lemva18Kl47Dc7oBtrWSJVvSPTJkev8
         wIPw==
X-Gm-Message-State: AOJu0YwC8/2DnLypgFMDK+Kw4WRTzcgqFejIMdQurcBTYCf4R8DFnScj
	Hvg/QBfasUPF7hQQxXH7uEcI8Ncu/pekBX5PLkyOneV+n5L/yMB4FyhmdmDLgOxmssh8zfw9cxo
	/0vn9EQ+VPbWZ4wsLhQeTgHWDkssmTOFOz7aY9LD51n5DmX925DECMlv6GkqUJZo+ZvhdNe0=
X-Gm-Gg: Acq92OGFS2XObUCT0JnAlzocOeJ3DP/MN+km8Lty9b2H7ayhjS7qkULYfiXAq0BaDHP
	Di8RWLqoz2FHUEaXNyAVnZnPHEyjhV9cUASmF3XHlZhw7p7qPf9WcPqaVbuJiVtqTWMi7hxbQsu
	JN6aztl2BL1CtVlU5XiTjbIIhz4TD5L5F7rJ3ycmKHIBw5l5LYmrQQxUrIqYSmP/noUTbvlgSkQ
	20tUOB2pDqdFhA5K5/mbJQBKu5w+487YGZbWitN5kRbINyk6v4tAYD6G0PdB0WUzP1ePERpx59R
	/nPi4CgAPnZv6Wbe2/ZiwBDjh0ABMA3iqSO1VKKpx8RMaJGejOAbdB7BSgit4opSYXoa/e2Plz0
	BuscPphryeTYQfHzwJRNJ
X-Received: by 2002:a17:90b:184d:b0:368:cefe:ddd0 with SMTP id 98e67ed59e1d1-368cefee0bdmr754874a91.15.1778575759346;
        Tue, 12 May 2026 01:49:19 -0700 (PDT)
X-Received: by 2002:a17:90b:184d:b0:368:cefe:ddd0 with SMTP id 98e67ed59e1d1-368cefee0bdmr754854a91.15.1778575758795;
        Tue, 12 May 2026 01:49:18 -0700 (PDT)
Received: from [192.168.1.102] ([120.56.206.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368acbdea2asm1024252a91.1.2026.05.12.01.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:49:18 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Huacai Chen <chenhuacai@kernel.org>, Rong Zhang <i@rong.moe>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Lain \"Fearyncess\" Yang" <i@lain.vg>
In-Reply-To: <20260501-ls7a-bridge-fixes-v2-1-69fa93683805@rong.moe>
References: <20260501-ls7a-bridge-fixes-v2-1-69fa93683805@rong.moe>
Subject: Re: [PATCH v2] PCI: loongson: Do not ignore downstream devices on
 external bridges
Message-Id: <177857575510.14291.11844057354546678918.b4-ty@b4>
Date: Tue, 12 May 2026 14:19:15 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=PN0/P/qC c=1 sm=1 tr=0 ts=6a02e990 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=QuRtzvr4xB5J0le8HPcEzQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=tdyrT-Nty_aWwaTIZgAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: LmGXB42azFshZnO1WVb778-_3uedHwDF
X-Proofpoint-ORIG-GUID: LmGXB42azFshZnO1WVb778-_3uedHwDF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA4OCBTYWx0ZWRfX8UKbUnBbSucU
 Y3alLpXsoEayF12yscJfeSub1/MZxBe0uBOpUiy5acXR/EzEJVgByD1i5bPEXG3STApSzo0blro
 Ot/mGLQ5FtEwpQCaYNxraFX/eg/6QtnJ8niC1OacbRllXksAMuiQmSJ2C0/z40c5ivzFo8Zydah
 ys0UZpRjlkvPgkeO8q42fTljfK36ABkug0O7W3/iKfP+mVhohJMYRi9B0r6U60t3Qha1GOWB4QB
 dd1P5SA65pkjY3aHTR3+cGexrML7PU/ZleriAoPH33PIf2rsHub/6Jbp95knp/SuPFb8wH160Rf
 VupqSBwVlexbbl6UyrhYEhhMeGU5P91/fc0fQgztSiWplr2R9y/oxedqsIwKbOQ0at4VRCnaAGS
 VIEOsio45Ah6/pEqddw14ZdrvAppXYkfdTbhqLJTFlfXDdE99LNKyTZncka0yJKYNlBO2K74zUH
 uGRLs1Y7zBHuM11pocQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120088


On Fri, 01 May 2026 02:45:23 +0800, Rong Zhang wrote:
> Loongson PCI host controllers have a hardware quirk that requires
> software to ignore downstream devices with device number > 0 on the
> internal bridges. The current implementation applies the workaround to
> all non-root buses, which breaks external bridges (e.g., PCIe switches)
> with multiple downstream devices.
> 
> Fix it by only applying the workaround to internal bridges.
> 
> [...]

Applied, thanks!

[1/1] PCI: loongson: Do not ignore downstream devices on external bridges
      commit: 1389ab9bf9f627d4daed86f492091b00f110aa86

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

