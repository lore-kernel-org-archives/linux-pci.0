Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEFB270552
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603511; cv=none; b=SsfbG12DtvhicZVUitATSCxgeeR7vPQEHoRowXNabUFVlueDsTu6b1hTORSkulu01Hphbx4iUGjW0z6U8MgEOC/UmP9FMaQdpRQohxztGZfHBPeyzULPgbdFHmJgZT1+JS3SLnx2+iZ3l739tbpXQakqWDcy7LnlRQKQZNxFIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603511; c=relaxed/simple;
	bh=tYo9u5QXjBzdVOM3n8bZ3egw7knCKbpodAuAnu7Q7GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3aQBgNnEDDhllRQF8YrFG0qz34tPwgi5ZEfsofFaJzmdIFF+iyKEL4EwaJ6aI5oUImIfduB1cgOMMeu7sfFrtPtwkSWZrJ510P81n5gaHVJYojoSu2+94uU6NpshY7Felib8yvzmPktaZwlvRxgLBD2guyu/3kduXthyyKnLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DnC5nSJ8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TsdCp/J1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DnC5nSJ8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TsdCp/J1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S929tX3921059
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 12:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Aka7Tv0bzP3IlquIu30uTYsQNXrdKO9r+dm+vThfXYg=; b=DnC5nSJ8xHw3Ls6l
	sXORxqrp+LryKufJnflxjHf2BqkJQApT0yFGEkOc2TgNgaCFKBBiB+RmnPh+vFfr
	m8QNZpu3fw3m1q4D5tTdW7ZdhREilMz8ygBx5D41jxRPfFjDPh5OlCEA4nuy1Tno
	K+b/fFKK5w+jqx8JmwHQ+0CT54OsFu9J3QkP8S0uOuVnYzeqasm2GWYrRxOFqpg2
	cPSETPHXQqNGrw1fv4Ooz1JAs3in+f9Waad5FOuJ+H63yCm94mXyfF1mZ3EzMlwV
	IHAf4z43fNvgrxaQmfcrCiDn98nG8Rfo9MUYAMFRRO+S9/PsRy/7xHBDqDBf3aHp
	aSAXrA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by211bb4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 12:31:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c710279d57so50091485a.3
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 04:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769603508; x=1770208308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aka7Tv0bzP3IlquIu30uTYsQNXrdKO9r+dm+vThfXYg=;
        b=TsdCp/J1GaVDWihLD8YrFUgb6PLITj0CbdhuCZZzDCuT5Zplo7ZTN/eyjbNvEjqqal
         K0u8JdjIBLvWmfGwkTzK5H7O6un/sviu4hYUxMNoIqa9wZyjXAoeu/nLEAVLTq4RUFZY
         8HUPxA0qVYOMLg7U4qO1iU5KPuv/CM5Up//eg9XUa76aNadOwLVDL9AplbLtfiX02kCJ
         PNVLIzofODf+QlQBaWOWwkqkbQIiQPjXdfWjB3gdKemQzw8sPeWJEC2m04DG+GfJAmkb
         80SSIHcFpt8g+IIJ/9IPtKrmemXMvpNExW6x6Gas7NiHn9YJqHrjj4FVVqg8NGmmCD2V
         Dc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769603508; x=1770208308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aka7Tv0bzP3IlquIu30uTYsQNXrdKO9r+dm+vThfXYg=;
        b=R9ho2J2hh2AhtSNWlzj7JRQ51XXOwB6FQt+KL3Cj9qHla5r8RmU/7zU2ygRSp91qXn
         wLgFgqP0oN0bRmlhDkLwiWADEA6SjuicZh17QFLrLb1RNU4zLfVsNm1FvoaN/AtzsK2D
         c05TjmFb99nP/TDbjOXH4VOsTew1LRgcth1+e+ZjWjy3CXZvCi13I7G8ACErzt9zYf6r
         9YwKjbZyU6TiKi12bOInpw9mCgB2vqr3exveS8XCO/tXCG5FIWIgBR4RVFPj91f3SwPu
         PZ8HlQN8GacQdn6xG7BZPoL1Bm0qeu78FFqiLiqIHxPJj6YTmia2wXEzd8P+SQQdsGf/
         aPmg==
X-Forwarded-Encrypted: i=1; AJvYcCUZyoZlF8eF6soFqGKssrGbJR/8HdVhRPEdx9UZd881GOpduNALJE9RCJrMjnKQ3xti3JWaJ5OH7ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ITo3VND1rLnjnqc29eL1ZBLqJ/YUv+s9HLijK22bjP6mD0rf
	MbZkiNjao++nKHh4PBfHkPCuDbuZ6NofwgrFzhY9HEMbouDDzfYLGIy08Fp1Tcr6HANqt3MiC2L
	nkSdlnJ1QWUN0K/K85tRxlMsLkUkEY3wRkxTLIqF+sjHgboARbMBz0PGKAUmzdjI=
X-Gm-Gg: AZuq6aIUiNoZ4YPw9QYR7XimfxpsZ+ialQBWQRoXcOFsbU9j6xybsXOwIQDfjRpfjOa
	I9BUFoLWKILa8jFAGuyCGFRhsKU/WUyZsxxrU33QBLeAOz+f1AFohEbr6QqXvwjW8C1mm7hjoM3
	jBL1WAAK720CKbyh7LPR5cVTnXVfM6WQrOSzfIlpmfCf/Aktoo8QMZlZWVOKQC8rXzLywQ9izJD
	dQ/ejO3NNalZbItdKrwbq5U9SMLg29fpUofB9nkAmVulvY4LNjyNartTKpKFd7CpcqgARYWYzZo
	JDtDSbGgCmRwP8reJsQPvh8jzPSwT4PzZR0NXyS8nyDmjrQiwe5i32sKqGrI5Yaqu2V/bo/tDki
	GGyL6xdfanTFEVki9Uz9P5lb5G/y+BXqVkI+9huBlLlE+/XEUdnE4QBhZKqe/hTOZ6uU=
X-Received: by 2002:a05:620a:4508:b0:8b2:1f8d:f11d with SMTP id af79cd13be357-8c714b440e8mr153438285a.2.1769603508296;
        Wed, 28 Jan 2026 04:31:48 -0800 (PST)
X-Received: by 2002:a05:620a:4508:b0:8b2:1f8d:f11d with SMTP id af79cd13be357-8c714b440e8mr153435385a.2.1769603507851;
        Wed, 28 Jan 2026 04:31:47 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf183cbesm117532566b.38.2026.01.28.04.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 04:31:46 -0800 (PST)
Message-ID: <30e971d3-90ea-4f08-bc5b-ff25030130b6@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 13:31:44 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Prevent GDSC power down on suspend
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260128-genpd_fix-v1-1-cd45a249d12f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260128-genpd_fix-v1-1-cd45a249d12f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEwMiBTYWx0ZWRfX5/U2utNdt+ya
 9BMylviJo4zF7ecyJ2uo2LnY2RGDBE4HpfzLXBc9SO1osBLijJVqcY7d1ySLzm3bBs7hBzPZAZG
 /ymWi+wV7rs/v6N0ahgwi9Ltms0xklLQjFYSgyMD0QNWhMELrrfRoZFHiHz1uKL7rYe0NROZUuw
 Kx92HONMEalxTbk3zCTWj8vkBVSdr7pNOS9YHTSkxiG0GuMFQ6KZ09QlCdtnx3VjGA0VspzNg5T
 28xFJ9LVvf8UFt2J6LMwMCu2LDbOkdwVqgYSzUbXTkip3MIiVXGgHeCpkKQveLw8UIKTEySKPvG
 lgVeitID4LcToXCLtQsxAOqFCcedzFRMeK2ubl8e0ATDhMs75IIfV8K+9EeBLMvJTNLF1Brgtn+
 OF44YpXHdnfzHWD6fEPGGr57tID+Pt0w6fxNK3Wum3cGa3bNHfmCMeka86apeWyuo0fqIXJjmcY
 D2HcStHmDlvKskuox5g==
X-Authority-Analysis: v=2.4 cv=GuxPO01C c=1 sm=1 tr=0 ts=697a01b5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jU-KX4cHS3eJyRZ3RZEA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: O3MtzjUpiecB2gK_QFVUboEDrp-o9e0J
X-Proofpoint-ORIG-GUID: O3MtzjUpiecB2gK_QFVUboEDrp-o9e0J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280102

On 1/28/26 1:22 PM, Krishna Chaitanya Chundru wrote:
> Currently, the driver expects the devices to remain in D0 across system
> suspend, but the genpd framework may still power down the associated
> GDSC during suspend. When that happens, the PCIe link goes down and
> cannot be recovered on resume.
> 
> Prevent genpd from turning off the PCIe GDSC by using
> dev_pm_genpd_rpm_always_on() so that the power domain stays on while
> the controller is suspended. This preserves the link state across
> suspend/resume and avoids unrecoverable link failures.
> 
> Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

How does this play along with your D3Cold series?

Is this patch supposed to be applied first?

Konrad
