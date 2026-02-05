Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C613C918
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2026 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296219; cv=none; b=GyzJZoJ8oiLKspNL7+Grq56MQOPpeHvNsaduMaMoX2nNgtPz2v4wGddr2mx99c/HL1Hla5k2xhEmT8M6dWpw59FAQUzjH5hmiLdyhfi/quwcmGEv/nOSCLqMEH4YOoA2M6XZdg8cPkjxXs9eB1GzT6CB7hCfjleRjbHr6jp82Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296219; c=relaxed/simple;
	bh=OClRf+9wyP6OX5GcXsTjZ25sW0bwxcq9n/Z8EqdvmmA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rpGeVvxiYjTCS4QNCvWCwIU8ncjPq1r/UsjyEJcU3PfrLPwsj8yRK37XKqfQ3jqzsY3KTe8ieZ1rN7OpulSV6nCVQcvp9VbE4eDz19TArXFE4FwsjPQ61feqUxUmjCu95w/SiXaHbj2aqF2MmI0njoRF7Wj6iSPwwdrN1Wqz8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=emUluuRa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QvvPygdU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="emUluuRa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QvvPygdU"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6157misc2945197
	for <linux-pci@vger.kernel.org>; Thu, 5 Feb 2026 12:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uQ5HVDXzyDPK58ZP2N+tAIPJygylIopZJLAGRXwXv9E=; b=emUluuRamtNLc2wA
	27Y7j6IdZGC3UCFtFGbJmTT9+8IEGzKwQnGXeOCMHsR2bTAqgefsK0UTyHJLDoPE
	UWsSd/bkkGvQmV+zk/xmyr7lNI7czJcO8TBZ+1lvRsMWmYtKRb+rnpqgZ8VgzjWt
	WIWY6v4RbRwMdkged79LEgo/fdUp/xT8Wnk29HrZz/6JL2rIfX9Kv4sGfJWuShci
	OOQNGdXYCLWk00PLUMfcKr4Vd/jxTABWG4sJN93XZQ317PsrypdjIssJWPJwN5Lp
	iAhMWzkk9YIEVFE2Re4n5qGmdgFh1kCpXESnqY2S4VMsjFiDEQnsQ3H8P4VpyYpi
	/3xRRQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4q55rwhn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Feb 2026 12:56:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-352e6fcd72dso1664551a91.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Feb 2026 04:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770296217; x=1770901017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQ5HVDXzyDPK58ZP2N+tAIPJygylIopZJLAGRXwXv9E=;
        b=QvvPygdUPM5/D6BoJ8/k+VtGGBwJ2bujuDjgrBS33HtK/O/K5sCpQy4qv0PhpvTAqp
         GeMnofuUakRAUUFY44MTvhzDES8fOB51p1M0EJrEYKPB1ayBDmoeIJndJ7z77+ckj+0S
         apnE1YMpIIAxinHLNLLNEAoV5PVE8o07fi2niWyo616+1TPMObGGiSkfheuSqeOjOcDd
         nxZLgAbpICd1AeiqW0soksX2CB9hWFt2pkjQgWBj5p+HsfWM+EO4e8b36FIvXqCEoOaf
         HgkUPpdI8c7McqxAbUHFpo5lgxRL2t7d2AKdeV2c5q+YcB0+6iXeyz2SnvU8/Ty4/wg0
         E3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770296217; x=1770901017;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uQ5HVDXzyDPK58ZP2N+tAIPJygylIopZJLAGRXwXv9E=;
        b=DrMV/KjSEauMkYVVouIS59E5PxyFmqt9w17Mnc1JqAFjvRTcMACgFFLVS6bRRvGETK
         AmiLkD69TlJiAzGbVwQDljzCF1+HPOOrjsXIWvTsvV2zRFG4Le3IkWA4ydiRq7xTKI8L
         DxwFJPfe/ivhRFJZLu7NHghqoo01cPLyNXIPcnxyd2HP5MF95NyUqMfXtJZpd13wodpv
         5eKJNqSuNSflUZ/JNgieJubsxypl4wDF5n/R09b+6L3xPyav1VthUyMPgm5ioeu9wlT2
         1IlsskJzCEDGMJK9Kfz4vA2Ss+vC2nJlGvSJoPgzDBoNFD8e1fzvYmOMTxUW7P2UAytX
         5tlA==
X-Forwarded-Encrypted: i=1; AJvYcCVf5nDxA58wgoDkKQCNk/zitarBg5caS7aqjanLUhtnq9EzGhIDTVj2+0I/gWqDD1PADbEVPwOLb4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZyGnW5yo5DpISKVPVjL4GLTcflV0aVTNg7vSO7J5mYJF5GkNu
	IEy1ztxXNiPnSkCzYYM/ndEJsv4i8vCZF8cMRwYtPkErxYt4aQWPRPWOFQ8ZamWMN9tpB6G9vTt
	imxUTafiPfBmrzVQQDVyswvYL4u4tYjd/ksONgWWLaAJv0pLM0g4lFfPFDnCXlD3f7/3r9dA=
X-Gm-Gg: AZuq6aKwRhuW90PXxEqMDIrezJx8eoPRE8y9MrQgmnV/MkbMtPR5xl4/0MVr8ahjbr7
	S3wlNceyYpVcHy/yhGG35M750MbL2lGc3yrp8k9ki7aJrYbAYsoXmcYw3nWDhwtA3gvxXF2xzLv
	wchRS1kZeU/+A/lTA/B1Gvi2cNGfOVKmgZuJIojMBuojORUFWyiZxRTNSAVD87R+UqFLzat9CUr
	28C/K81W6VmyufvNCndzGqVLb5sG3P0PTA6XbYLUs3U6u9k7a9weKIZ/5PRUK1lj62bJF4SGYrF
	dkvxJENSyeU+4xiv9ZgYDV/K2rTGjtHssH6/5Q858BcgnjqyjhW3Awh6fxfigyc5k7sNsnz0xri
	eUKF/inO5NA==
X-Received: by 2002:a05:6a21:a42:b0:38b:eeb9:cbb8 with SMTP id adf61e73a8af0-393724d8b8dmr6453385637.65.1770296216757;
        Thu, 05 Feb 2026 04:56:56 -0800 (PST)
X-Received: by 2002:a05:6a21:a42:b0:38b:eeb9:cbb8 with SMTP id adf61e73a8af0-393724d8b8dmr6453345637.65.1770296216277;
        Thu, 05 Feb 2026 04:56:56 -0800 (PST)
Received: from [192.168.1.102] ([120.60.138.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d4a5c28sm7270045b3a.62.2026.02.05.04.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 04:56:55 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Niklas Cassel <cassel@kernel.org>
Cc: Randolph Lin <randolph@andestech.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
        dlemoal@kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-pci@vger.kernel.org
In-Reply-To: <20260127151038.1484881-5-cassel@kernel.org>
References: <20260127151038.1484881-5-cassel@kernel.org>
Subject: Re: [PATCH v5 0/3] PCI: dwc: Clean up iATU index mess
Message-Id: <177029621115.8023.3797281385109418780.b4-ty@kernel.org>
Date: Thu, 05 Feb 2026 18:26:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5NiBTYWx0ZWRfXzxSJtRtBb8Ho
 c9WSjKVOvS6ANTqEPtH4njzwqBEjR9l4vpDVRcgF8hy6uwTBu9TP6JCiv2ksmO8zHQRz2O1/3Zf
 SQHTxy8EIPGAjiSjsJVjAELZb1QULleBBQFfScXaUX4XOEShvXlRa6AOr+XahkPODjmHwUCqTSv
 5m1MBugP0vacQ/z00LdZ0QonoX1t7bFzmWRn2sp3C1h5W/yHDtWoXtrLbW8oAOUPiv5VPP0ooG8
 VLC1uvcOa+6biKQEM2nIxgYi6my49DD1FFLx1yuAQaI2qem1VvPLNqoeIegVWMZpme7SEnRelre
 QHYZZB8CmMI8VoFcvqn7eMorMPmRUy3gXIgJWXTeku79fFkH+obY7dX+FDlfBKD3WruJ5ioaqKb
 PdcsXfjxODPsoI9QoTI4jSgZrLmVUSFNHa9tLKLruX+kCULphLY2dpzsvi5NPJYKZES+BC5EZTR
 +oeg/g9yR6nCl9wic7Q==
X-Proofpoint-ORIG-GUID: xyK18t4XOXIZxc-IxXXMgnmclQT3TLMv
X-Proofpoint-GUID: xyK18t4XOXIZxc-IxXXMgnmclQT3TLMv
X-Authority-Analysis: v=2.4 cv=Z6zh3XRA c=1 sm=1 tr=0 ts=69849399 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=jlLsFvayJqIAUwzeXwRY/Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=dDx5dzlMtpr_2FQ5wCgA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050096


On Tue, 27 Jan 2026 16:10:38 +0100, Niklas Cassel wrote:
> This series tries to clean up the iATU index mess, by treating
> iATU indexing for outbound and inbound address translation in
> a consistent way (increment the index after assignment, and only
> if the function call succeeded).
> 
> 
> Changes since v4:
> -Squashed patch 1 and 2, as suggested by Damien.
> -Added Cc: stable+noautosel for the ECAM patch, such that stable
>  maintainers will see the dependency needed by this patch.
> 
> [...]

Applied, thanks!

[1/3] PCI: dwc: Fix msg_atu_index assignment
      commit: 58fbf08935d9c4396417e5887df89a4e681fa7e3
[2/3] PCI: dwc: Clean up iATU index usage in dw_pcie_iatu_setup()
      commit: b5dab9b38da0a05949458276dde9227c38aa1b39
[3/3] PCI: dwc: Fix missing iATU setup when ECAM is enabled
      commit: 43d324eeb08c3dd9fff7eb9a2c617afd3b96e65c

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

