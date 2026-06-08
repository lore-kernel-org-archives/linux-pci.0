Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0231F988
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 04:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780893341; cv=none; b=Gx32Rt6+6/LMvqNgQ0gDgI431QlRd9RDaw/4yvmZdBR18oH4j/h+CYXYNzpXHWCZjnEqXfMV5BEwtgtUxtcAo0NQeTXqX8l/oF+ICginHPYEdPNFjc2UQ5acXUykeKu/oxB0BArL11mVDdtagSp5zygy2Gtw0O87pTE9csul9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780893341; c=relaxed/simple;
	bh=kD26G8uJeDiGn93yq3ONwoZDPErjIr20+ejuLcBB5Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0g8pSWBqnjhAqHuY3bt8vYiD04FAe6WwCF7qtqC2qdmeOk/fUHizwfgmlch8Vo6MQ9rOR/UX3sPAClkLwDA5XKLirKiI6a9MHXKel6X/DVLr9lu3rrYCNxi07HlqQpJaRd2sgZJVqtDuex41EeEqUUdrmnG9S9L8r8pGL0CKsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R1yQn3+s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EC5moalw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R1yQn3+s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EC5moalw"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580G7B22026891
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 04:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kD26G8uJeDiGn93yq3ONwoZDPErjIr20+ejuLcBB5Z4=; b=R1yQn3+s8FvlBOVO
	Cpw7APe/1PI73ssw382rmFFUqPPGvdFVRDD5eGwk3NHkinvZ5Ch4sMHIWd6cJkJ8
	a2uR1JvVD9Xa0q4D1R65I/AW7Wwv7DMUS5WRR9qTeP9Iia8lMivv9BwUxITOsN3G
	/w20jE2DMvQiQPCNoT2wnKDZseD5/21dO3wKYdIiR2SWfDSZVt1kph5dBlMB4NGS
	ymAQUXQGsKLsr6eDnwru+ngU4WBhznz3SRe6O/wZs4D/wcapoTElRAqsJ0ujZboA
	R6E+Ns5l3+4P9jWmdK+qHWbzMKXlUzO/USjhVK7hEFHoZC3TuVL3SFXnKeFYFDRH
	VxojsQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4x3t6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 04:35:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf1845bddfso47383165ad.1
        for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2026 21:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780893339; x=1781498139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kD26G8uJeDiGn93yq3ONwoZDPErjIr20+ejuLcBB5Z4=;
        b=EC5moalwOfHXBb49OmQfyI5167y92h+qMXydweiQw2+lUz4F/J4cI2Goq0MGCnkKi2
         gb7q7p9saz2d+Y4DPa2sCeXIksaE7qD812Xbqb41C8Qz5D2BuZg8PBVWm7w+jhm8k98J
         hWT1QRD5GKp0/YkwdTtPV+T2oTosBdhmHjhB16D4V+eDUuaEUUI4uNtGG4HPx4egA/CB
         aWhdWFGIcrht0EgfsPFbCzBIz7IiY1uBtGP/DB523/fEpGxIMEz+oQKobSIh8C9pZ87x
         Uu3XX8zFAvAM0NfhnSDJBLDYdZ+Qiw55uTD2/hacVLf2H9xthk2XSYDyaWlD/eYe3h+H
         lc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780893339; x=1781498139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kD26G8uJeDiGn93yq3ONwoZDPErjIr20+ejuLcBB5Z4=;
        b=ME2S9Z7p1+oP+TNAx7+QsesvhMbeMShN3kyGn6clm25OIxLgXDrvp/dKix0Ah8wwYA
         kVAzktsAonWTRHOuH9XVzOtm48ofQIeb6Kb6RrhyXkFdy8DLAvDOgpBfy8dm6zUMth+c
         Pjc4zk0mK+8QZH0kO7ILbhe+ly98Ow2d1L2mX0sDZshyZqU/oVrE/jvCgC4DP/FYKs28
         Hz66/AE7mTbWM4q4wwpC90ilKm8bZMK5Q22bKb1ptiyxeIyRast5Ufy5n0PEkbNIQxsZ
         QDFq6o2jxiPbxGGw2FV6ImMskgKv4temw0gKxDxoA4xhvKUSLE1zjK/Zxe/XTGahwYf1
         018w==
X-Forwarded-Encrypted: i=1; AFNElJ+ai2uZ4XEELhtOt1SIIjGVshN4BwUc/dLTag2n36tvHUtaZjzEQzps6M5OEZq5MKZOekU/keUgA0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX8t6OVtPCwIzV6HOsxah7mDbXHDsb+Q84I+DwmWxbg+GSHZp0
	IVG2uXqi03wllLWgUq0QcoZ8rNffPfr3j+Gp6GjFJM6/OHAYPhORR7k/A04Vax+uZz9fHvFgjvd
	T+4QCircESiJ/R+O8yVpZ4zx5F8Ei6yEXivFz/DL7gNfadhzKfWGuFmrGwakF/y4=
X-Gm-Gg: Acq92OEqG12Tb7nh1TqXlOcAPjOTlQusPcboaQVd6c/S7KNnipLgNBfHotDJlGrboFC
	/HzEjgZhlhiZi5S9SBf2zJkOHXkApmQeupXP4sJxgUezjMTHhJmP75b0pf47CypdBO+5spPHdhc
	e4LoZZcf7X4aP+nXbqhAwPAvUQbV6M8Kf+8BJPaNxXJLVkCI6GO1ljn3NmaMVWzBrDgAudmuqPN
	GqguHYRDQ5eQCSxRQ5yqm0rM7RcP5M6HqCHfBHIvLXGYGL43RvBPhAZcqS8W6fOrkvXymMUGlbj
	7fTWfO8qtjS4e3OUEdumtye93M61fPdkrZS6OgwArJU5kqlXf9HalHXHzG8LYZIdoVc7WhDuPaI
	CPYbMezQTxgmDGZCqxAR0TcLsIVif27Ncncum/5doQAIgKHzW16ZI4XsgLUhMM87P
X-Received: by 2002:a05:6a21:2c11:b0:3b4:81b4:9b74 with SMTP id adf61e73a8af0-3b4cd0cbd08mr17473629637.42.1780893338665;
        Sun, 07 Jun 2026 21:35:38 -0700 (PDT)
X-Received: by 2002:a05:6a21:2c11:b0:3b4:81b4:9b74 with SMTP id adf61e73a8af0-3b4cd0cbd08mr17473592637.42.1780893338160;
        Sun, 07 Jun 2026 21:35:38 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8630b2fa83sm897691a12.10.2026.06.07.21.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 21:35:37 -0700 (PDT)
Message-ID: <aab3d70a-4939-4f55-a343-4cdeea8915b8@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:05:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: qcom,pcie-sm8550: Add Eliza
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260601-eliza-v2-0-6b44c9c23d5e@oss.qualcomm.com>
 <20260601-eliza-v2-2-6b44c9c23d5e@oss.qualcomm.com>
 <20260607-devious-active-bobcat-1078ab@quoll>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260607-devious-active-bobcat-1078ab@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9n_Go0LPfcs6_hSOfTI2UsK3kHkuQfL1
X-Proofpoint-GUID: 9n_Go0LPfcs6_hSOfTI2UsK3kHkuQfL1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAzOCBTYWx0ZWRfX8OsLqo3SvDMi
 vIk71n/MLkQrXGpQjeU1i7GtqWNpz4X87g2JmqWju/xxAJ0vHe5V+obhpWQiDchLu0YIo3l4i9T
 y6OpdZktH92DrodXDkX73SE3pK/P3dr9e4WAzAk4q4Y0nQRww1A6BkBRDw5r8lIBEA44U7ZyKxv
 pMiMENY7fCQsLDZ8Q9yvbU1WrQ322m1Vw1K49Dt+8o2zx9tpuZ6ai8+sAzFIe/Cg4sBzUmTxiu1
 CKBAR5+GOSH6qp8DJE7H8jSgSgL5p8k5pfdKpRCnTR0MAxm7pHcI87Xj6kOuv2pIOj2xXzPVfIf
 F0FeTz91giyZPWzxe+EWN05DeNwfQ/h9B1iLlkHZeBFp4lsfTeV/Ky16C7eFkoNNyBBEom05TPo
 7HxFOqF4kOrKJrVExtu/Py/uyrGBvoYXNxb5pbfS10wGrEp3ly4cr7kAiEHfGW/jitjjFWji/XM
 rJCGWoH8oNemiZioNig==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a26469b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EOzwYm5HH2NjlfyU_mEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080038



On 6/7/2026 2:18 PM, Krzysztof Kozlowski wrote:
> On Mon, Jun 01, 2026 at 10:59:45PM +0530, Krishna Chaitanya Chundru wrote:
>> PCIe controller present in Eliza SoC is backwards compatible with the
>> controller present in Eliza SoC. Hence, add the compatible with SM8550
> Eliza SoC is compatible with itself?
 Sorry, that's a copy-paste error in the commit message. It should read:
  "PCIe controller present in Eliza SoC is backwards compatible with the
  controller present in SM8550 SoC."

  Will fix in v3.
>> fallback.
> Why reg, clocks and interrupts are flexible? Are there different
> variants within Eliza SoC, e.g. one without msi?
There are no variants within Eliza SoC. The flexibility is inherited
from the SM8550 family binding and follows the same pattern as the
other compatibles in this file (kaanapali, sar2130p, sm8650, sm8750)
which also have no per-compatible constraints. If you'd prefer explicit
constraints for Eliza, I can add them in v3.

- Krishna Chaitanya.
>
> Best regards,
> Krzysztof
>

