Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E8383C92
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783401802; cv=none; b=gS3BEkaiznTJsaeNbqvyuzC/9X+oiP0KIqdxldU7rqKUGAe8eK7YUdPR327mwufLFNo/pto7nbAaExm59jvsjNKuCHLq2dhJGfKvxALKFq3wzFu8IFEREg5XRL9YICA6Om7h6f2Vhmrx/dEEK1OZILrv2/uN6VrQ3JvHjOFCthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783401802; c=relaxed/simple;
	bh=peGGlS9T+0QGAn4WZoFX7AM8oGcbad4sPBi8yOdOmGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ex+1IiKO1ybJzuvJhbCTYBlcj18TmXEhcakgVy9L7ENAnBKDvHjp4hcwrObPE8gz4dmigQz49y6Q4K08oLsiyXEHit3HHWXcDUT4CrAtkaXcq96bTHU1oLCSLGVKzY8XjQJorbebiaXwnwjHPcfj5gQnnWFaL6y1AlRNDa4NFbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gqYbHEkU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GVBNju79; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gqYbHEkU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GVBNju79"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748s822629803
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 05:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D7pRZOt1/C2Ak+fJkICIGu2A8CugiPqfodDTcjzFu/g=; b=gqYbHEkUQi/BF2lr
	aJXjM8Ba6jvYOnAMaU8N+HK1J2fGyzErKUM5dsZP6kzQTDJTYvsg7/edkE6J/6ob
	/3w+y2HMcQ6uQZt3jCup/rtCteSYNFhGTo9hzUDqEEG/JBByTw8P+42LSGkBVwut
	cBFM44qOZI2sPVtwzawpk4vxVJR5Ap8T+R7sp9ZSKl1QF3DcLdse8SkR1s16dy52
	vW0eX71WC6z3XcYM4LlTTIcwumWleJsC3P2EQN78yeqluiDX6ng5ur0wsbY4pdjR
	x4JhsBwHoHFiaT0fQVShvt9XvzbNl4y0rnZTB/ILlVWMRBdahdjNXWeZg1FH+bTf
	CsrsSg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h54mny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 05:23:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccbb61893fso7795955ad.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 22:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783401799; x=1784006599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7pRZOt1/C2Ak+fJkICIGu2A8CugiPqfodDTcjzFu/g=;
        b=GVBNju79Q9RbhfLvoecjoI5W7uy+3+xnN1j7/6tOG4eA25zLCce2fVqN6nQ+TuSzG0
         4DKpvmUWzvIRyIU1DKUaIW1bf6d3JIcT7Rf7DJdveqkWeKocjP2igBpJAwO5ajt+q9Xg
         6OCABIPsk9e1g+GnIRUfsi2WttAvHPa1KDs4N9zDl33oblhe1JjqKbugkUZbGQ2v+Y0T
         K7IoeITBV5VcDjZGUO4EK919zGVjGKccnBoprwrOzCNDvZLUwffsxkuVee73cRS6XOrd
         eByjxxYuZrPj7vn9jVhp4dhqzvmriji6RYX++Z91Q7Gw8+nk96lxFAw262clHzOdk+lH
         duIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783401799; x=1784006599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7pRZOt1/C2Ak+fJkICIGu2A8CugiPqfodDTcjzFu/g=;
        b=HdxSyZ1mjLFMbaJagmypnJQcPDnz/dwbi6AtCQSvkbqykCj50rLejbyZnaACBKDCsQ
         G/IFnC9kGfUOZJ7ptEAv5ldIBpezxQVzdD5x4YCtUn1Gg9v6Hi/l7e+NJ/qc22iPRG1s
         ifIZHUno7O/hEnXbagIeRaZQbb9MT39fi2tb61mloyL0cSxv6FRnIY6HyWOwyphoJgNn
         MK+LOad8WHVCytx4wTTz2knnKmAJYJhX4iT+YwmrKhbdRJWnTE6E2k9dh/A5JkiQ3xqH
         IfptNPEzJyXYmSWEwyTdLGBW9PSsB2/Cvbonip27YN4fXvQdGsaz/atblKyxBFDR/qmg
         34eQ==
X-Forwarded-Encrypted: i=1; AHgh+RrSLNDPDfj9CVxtpcHY0LraWYiiw+M3Fp+G4FRSRWc7pDkas6b4/mkIXjZOcRJaXacp0NwBt35Fq2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuOMSTOntydRU0gfV+l0TmP91ZvYGSZC+kUGrDZjWTKA33+Rmx
	B8D1+F6PC6bP3rYBisVanMdHIFEvb9jO3JzWJpXeq4lJ8Z1W/qQKY3kMpcgDtg8WUomNMA4LSfL
	QDiUX1DXq7KuGFOnHX66i6u+bd4Z2yS1S1Fcy9wG9wDzK86AdmxsLu6wbxTAsb6Q=
X-Gm-Gg: AfdE7ckybZNZ0R19iHAKWVeKzsxnKBog3x7V1wR3lfmNmLuCPwI2U3OP+ml3GQY2V/A
	/htkkftMD2ucxwRboF+lbgvZJ/oCuYI9+amRMLmuKc7+3+L2v0AUt9p6SfJVyP9lQJsVc6HQhQ0
	JS+VQ2qLgzqvaeLovY19A6ys1Q1PdyETEm7+DGGgpU7SkhGkPDh82z4EKJxQC9D3/MSmMWG2z/a
	GeBL4jKmG30jZqjoDG8BVgLHdR7f6KYIVfNakMYkaC11WknKTle1YAD8MQsmb54jSWz/DRwIfh2
	Fdza6HB1QoWsIgWkrlIllBcHv2suqvku4CtB+1gU5bgZjfta89rPSGQK/viWnjR+fUqTmM81jUR
	d3JM8TSZGTVIfANIze3vlyk9OohhOLqeyzxqJ2QYrg6NlVx5YPGwnMc1Z8myj3xz7GdjZUBZylN
	hRFXnR
X-Received: by 2002:a17:902:ecc7:b0:2c9:abe1:c352 with SMTP id d9443c01a7336-2ccbe6134f4mr39951915ad.13.1783401798790;
        Mon, 06 Jul 2026 22:23:18 -0700 (PDT)
X-Received: by 2002:a17:902:ecc7:b0:2c9:abe1:c352 with SMTP id d9443c01a7336-2ccbe6134f4mr39951445ad.13.1783401798269;
        Mon, 06 Jul 2026 22:23:18 -0700 (PDT)
Received: from ?IPV6:2405:201:c409:b03f:6d0b:bb83:7a67:4093? ([2405:201:c409:b03f:6d0b:bb83:7a67:4093])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e0c4sm5020325ad.49.2026.07.06.22.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 22:23:17 -0700 (PDT)
Message-ID: <7e4c6924-f217-4b43-a5af-827cc3c517ec@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 10:53:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] arm64: dts: qcom: shikra: Add PCIe PHY and controller
 nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <20260701-shikra-upstream-v1-7-e1a721eb8943@oss.qualcomm.com>
 <12e86cc4-d96e-44f5-8c87-87a6df321115@oss.qualcomm.com>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <12e86cc4-d96e-44f5-8c87-87a6df321115@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kI6wVDMbewBms1W8g7AgCxMQIh2YYCZ5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA0OCBTYWx0ZWRfXyuOl07UYTSaE
 me4Crdmi5Qrc43OiF6vtzy88DOxhZJj8tWJoki0lkcMJSUDYf45DTtxJz1VJBlr0f61JIoEekzZ
 UQR3ScFgCYhwSMeMbKezvNfXyOGAI8w=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c8d47 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=A2pwc-5Qy5RiWZamnY4A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA0OCBTYWx0ZWRfX0EF+SiZCiJIh
 h+Y2KEykym6Dc6fREr2DT22vnxPpXoDlcL32X7tz27tG+RzKobKLPHQg4rbiAS6wAEZL0lZwbaY
 /f5XDRHgY3VCI1whPfbzm9d7iJp//vF5ERv7zB+oyVnQVWsXy4FEajQMeh95edmTl0yHFLeqGhV
 H3UBTrtU7ul22JJKZFD6HeBkJxIaXdMeeI4/CaNURMnd6Y9YT6gX30sQMaEzxP4YIssoChIpuJN
 VpdkOZZ5RQ5xJAEKIULsFkIYkt+MPvI2Cez3shHPyW3UPrkYElOa6Z4wKEaPAtmJKyOgGxK6CJf
 orfmYk6jbReSR9yk9Mqcv0LxsWS48J2iArdVF2eTpwCA4kg+0QKgrRFDltB4O5X3dq8r5ZirEHa
 6voihMMz95hBpZzIDDcZSR/WVTpyOL3OqrF8jtiopGe6gPxNak98TKlPM3m2dbdeyxEl1MVhxyQ
 q6hmOYyYZVz+Pik28MA==
X-Proofpoint-ORIG-GUID: kI6wVDMbewBms1W8g7AgCxMQIh2YYCZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070048


On 7/1/2026 4:04 PM, Konrad Dybcio wrote:
> On 6/30/26 9:02 PM, Sushrut Shree Trivedi wrote:
>> Shikra supports single PCIe instance with  5GT/s x1 lane.
>> Add PCIe controller and PHY node for this single instance.
>>
>> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
>> ---
> [...]
>
>
>> +
>> +			max-link-speed = <2>;
> Please add a single-line comment right above explaining that the
> host supports higher speeds, but the attached PHY is only Gen2,
> so we need this manual limitation
>
> Konrad

ACK'd.

Sushrut

