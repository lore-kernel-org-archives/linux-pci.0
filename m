Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FA0407CF0
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902157; cv=none; b=Wt5Jobc3xRLYNaQJR+6L1wGx/hUf9mnPgiIWrqrMn5V/p1Nhs/vmGF7RPSPlHMtwimiA8yPx22JH2nV/FIfxQ690XSPeu5MiuDhY9u0slOQIvVlXglTTjpo6SI6QUc+pefIAx9j9feKhwhyNJ4UnYTP7W+J3JYmgR9srilEdMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902157; c=relaxed/simple;
	bh=ibzGN0UnickCjHY9cF2/FSKFRK1vfLPRIBwk5Vf6y7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLTDb/DpIXZmJNCfoc3+T5L5yqSriUzlgJ04lMkuepL33BxCjESbwMmqoL9jQgdrtzlf5fy/+7OhGQrxPbC7t2ZBq7kbDk4tZda0ETL4OFDVBI20W/zQGsdo8X+RuRoir+Kx2/RPjddq5Ct6imwdYbcJP3AjzCn30NFDRsWfBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P3KY1ZzW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X7hh7D88; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P3KY1ZzW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X7hh7D88"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8WFA744296
	for <linux-pci@vger.kernel.org>; Wed, 1 Jul 2026 10:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sp1BW3QUmZcO7rug2uWKHnR0pXWl/4bf/P7UglPwEP4=; b=P3KY1ZzWVReNOhM/
	D6Ye3yqrlxmRkrCYf9SpQ7JO2ZvZR6oI023xwSHtmDaoMdPXlmlrFc/CxspbyGvj
	4gXnqgr0ul3Nru+fOHlI4Lj2jpZIRihUTMKD8jydjfhLLFgnQE4+9fCGk8nmvqDa
	7twj80oGQT72H+bAE3r2nV6HURaY5PzV3ggji37VrRWzEjGtuUILVKYUcanXlb3o
	DvRL8gbW/kMuNseiaKXelCW6j5yUvVpIG5q2HbQzQHWv2iJOmG89l9ClKA5AqZZ8
	LbkxutJaq92h/6dGQx17Uks/kR+hQqS9trB/kcn52rovEUw1whSpJ2+68otN+t9s
	/+lGgw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4x0th0w2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2026 10:35:53 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f2747d334dso1899466d6.1
        for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2026 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782902152; x=1783506952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sp1BW3QUmZcO7rug2uWKHnR0pXWl/4bf/P7UglPwEP4=;
        b=X7hh7D88z1UNKL/7TV9QYDfRWvPCT1o7q6hfBtMXR7JpqbAZaWS83j7sitxYqSbKlH
         YGNPW8I8qdxh+o5uAi1nJma5WRSAMVHGQHA+vItDt/npi0aMFdTPYR1/axA38ROpEmnb
         Vu8JbVpIdIFomuTivPF4likoLZMEJOqdsNweWI1YapyKHvsXRkE6U+t8jwdVz31F5kBW
         1YSrNN6PO6eve5TvjRKppEitT/JIh6fNbhZnhTQxbgVBzJpx4AYi2d87G2Z/tyV6t3Nc
         gjVsTyvC/2Q1jF02l88349Wi0DOGAf9MrUg0GAUgJ2mdp7r7mFXUCSVxQ4pyBL56HHg0
         zjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782902152; x=1783506952;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sp1BW3QUmZcO7rug2uWKHnR0pXWl/4bf/P7UglPwEP4=;
        b=QhEl9Wli+s8sOwMBARa917ormHuRmkJs8icnPHJu0+cbuFmkHuJMpYfMKFgwdL9yWs
         tsIPeBdH3qF+O5DLDqTF9Xpqc5kipnm4skiktELGhp2ZkvrhnLRwWZlPJsIKprNZKmoa
         Oelwy7FnooyGa+RtH5cSQ48I2eqLSOgmUlb6lAUjYywPUKXtR+B1YvKfvDsrG4llVXXe
         mBmoWI+gjulYmkWehn8WGpn9RWb5JuE0zNwnSW1NfPpdiVZASdwfvdy0FMfpFq1oiFH4
         xXftbHRYQJ4ORK90TEZEjNfbpQm7RTYFw5Q1Re4lQvrcdqqz+FSXiR2ZWmr2+ytcuU3Y
         dKKw==
X-Forwarded-Encrypted: i=1; AFNElJ+WMef+pyytVpgcrU4df+Ymns0xuyjv/iVT7dnyFH7uGkybASNrdBNjKGTpmAPQkt662zdkNc5cVKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbOELF/L/WReMJG3xgO75oDZVbTwP7Kg3JvCPZfPT6Rbm/Q7ou
	fwX5UN6/g6RYCOXgGdkD/PFXE5W3t1rVvY5R3mSCcVEUvMif7U/UNOonHrvGx8hI7qyenbKsw9f
	mFmDEbTtE87WKcuLx3ry576HLYt6Ah4zKViVXdVgkGoZPiDiOKRpXMTkqrrXcP64=
X-Gm-Gg: AfdE7clJjselo8l0ve1D3WPjjPEbVC0pKIv9XR/KmSHIsX4mZUINT6ADLr8XLNKMRU4
	+W9iA+EMpC5x7XIWpY3pN50V9HEjJOvh73y6EwAFGYQBvPRbystN7ht5vCbTJX4w75979tDcGv7
	UQjasjctos9rTtx4C/l5TXbzEWQjR9UxlK8gCEJe5PXMsBt+ekQyl+ubDUjalLP+5rpCaHAi04F
	gr1374HW8/tjNV5nnXFqF48C5yAdicgGvM8Q+ufTGPD4Ozy8MkiY362XQC/Q57FkGZI3mmChfiZ
	S1axTfIqj0ShxhftgD6BvVeDjX2OVokxwArv9OCR0Io6/t203makccltY3YSfzEH9RZ9rvB05HS
	VUNLSSEpr7480/uncK9DG3lvOhNQPTUcTuok=
X-Received: by 2002:a05:620a:4587:b0:920:798b:e290 with SMTP id af79cd13be357-92e7851d0ebmr89816885a.7.1782902152576;
        Wed, 01 Jul 2026 03:35:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4587:b0:920:798b:e290 with SMTP id af79cd13be357-92e7851d0ebmr89814285a.7.1782902152181;
        Wed, 01 Jul 2026 03:35:52 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1289176eb0sm255472666b.63.2026.07.01.03.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 03:35:51 -0700 (PDT)
Message-ID: <2efcd4b6-0a99-4bb2-b428-4cb4805c20d1@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 12:35:47 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] arm64: dts: qcom: shikra-evk: Add TC9563 PCIe switch
 node for PCIe
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
 <20260701-shikra-upstream-v1-8-e1a721eb8943@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260701-shikra-upstream-v1-8-e1a721eb8943@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: B2ehO9RcTrqSM85Pul8TIFA_miOUDqA8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExMCBTYWx0ZWRfXytacH/HTsaFQ
 Tcx7810Uq6I8A7ZfCWlxytPwFKQ8SQalVoeP2OqGk9Sr9Vrn63duACUTJjRWuE16BV1yGrI1PMs
 4TLVYmMua9v6SeIcCbYnkDfcJKyPchY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExMCBTYWx0ZWRfX8Rcn8HQzJRhP
 KBifXFAGJvwOGh/JrnTsBAXE9IIAwcHPk+V/e+m/YxBFiV4knKwc4nLT7tzUWboWg81vm0YseWE
 ZREuRXFiEiBnbOSGAX6Q5hqDtYLR/BkyK0lNRyKyDngH8WZCfFVmDmSbN4Iq9aM0CAm0kPL+Y5W
 qed1XPYLQv40f+SYRIWelO+TsUL/D8tKi3XYBlVvSgrGFo9+5hRchZ5BVwD6bWMaZj77DYGkQLx
 RG3xf1kW1Cq3vCQ/qh51xkI1gZus5HA5uEUac9fHNscjPQRaE2Um2Av7kallMwZidvOsTPe2Q3w
 NCfPQcYM9oVefVI4xJLUHovM+kHlFqISfILOLDZnwLof6VfLKiItj5CQ+eb/DauWk+3EW00kdJp
 ZLwo8wOgxRtf08tNhur4Qy8bsmRHrFDmBAHKY1GaUcqsF29ZFJCJYRxTUnPmTO2eL/QcSmhXYS1
 U2Yd7fhmpWT+U+V107g==
X-Authority-Analysis: v=2.4 cv=T5+8ifKQ c=1 sm=1 tr=0 ts=6a44ed89 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=qSWERiRezZrDuvaUYp0A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: B2ehO9RcTrqSM85Pul8TIFA_miOUDqA8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010110

On 6/30/26 9:02 PM, Sushrut Shree Trivedi wrote:
> Add a node for the TC9563 PCIe switch connected to PCIe. The switch
> has three downstream ports.Two embedded Ethernet devices are present
> on one of the downstream ports. All the ports present in the
> node represent the downstream ports and embedded endpoints.
> 
> Power to the TC9563 is supplied through two LDO regulators, which
> are on by default and are added as fixed regulators. TC9563 can be
> configured through I2C.
> 
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---

[...]

> +&pcie {
> +	wake-gpios = <&tlmm 119 GPIO_ACTIVE_LOW>;

This property belongs to the port node

Please also mention in the commit message the reason for the
PERST# pin remaining undescribed

Konrad
