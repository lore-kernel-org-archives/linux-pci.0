Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D5E3EB104
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338813; cv=none; b=hiZly39m6nlAfhtIwyY0m/8nk7wLMXbvWZSJK2cYbnnGy/TWmDxr/s1N22r0iRAYr6oN9sXw+aDj1rdISlP1nj141R5sGd60fhxGySTgu8GaiNYdBqSFe23gPQ7oZr3LjWj/WChCmeWA2VTDSDFRRpuWKV5Ue6kUBebpVOfCuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338813; c=relaxed/simple;
	bh=pjKHKY/7dk+MEWJF4cjV5fozlLxg++kp+foLwZ0lEFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpG4qERdjNeMvAVr+HNHM3FIDQ7VgARA30dLdL4xB1/Vyw1T1MTFUUB99Q86Gs9hpx3T2DnRFURi83gs96E99mapCLDBxh6NTx7NchXc1u1XzJMNKs9mWVqrN7OWOsOjIVFgL1Zz2fIPPfOMDdhO/2qEBbKPqgWC3FnYL+uShjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Te7QxGIq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MUgkV0iR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Te7QxGIq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MUgkV0iR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826VhMt204985
	for <linux-pci@vger.kernel.org>; Wed, 2 Sep 2026 08:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yWAwr1smx5G37cCcGObS8HBICH9bF7+jGSCJzShr35E=; b=Te7QxGIqeNWN0nZg
	ujfTMcuJSwyxPGFhWkUXvtcudiwoeVuA1XrXm9X6EloA9hx819tM1mw6Wxr2O2LG
	RdM5e5soQZTKO9DVl4+zY1u8JV2sU3S/c1SEEbm+E/GeyAkus6haAep0i2ZLXocj
	prTkwKqEjGo01Q8kfdsW+kP9R+jmFOS07MUdpqrMuXy97+7CDWVdvR3nnrv+uML9
	qkR96BXCf8/+IPXjhK2roUI4AtRj+GbihDDkqgwoAOFhKSuXuCpPV3wMQjGVykmj
	X/J53yQkvdxyzpz4IAt7VIj2S298BWyafnFxs1E/kFAWnrrjlY9TpNMbrf8H+KL1
	p6N1UA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge1wpbh8t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 08:46:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e661ce1dcso21514185a.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 01:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788338810; x=1788943610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yWAwr1smx5G37cCcGObS8HBICH9bF7+jGSCJzShr35E=;
        b=MUgkV0iR84n49rq15z25h4e0bC1RRlzfiGclthWAI0lC8SGHtgXFBGRtebcxbS6Edk
         ZtKJXfrNdHl1B8xeFr+TF5p2kJsGNYbW1Ct8dFXUzAPJu2lfwUT8xRI/qkNwOTEnkuT7
         885/l/l+gKbDq0HSLmU7FM2aKFoFIuVkeiUuB5V5rfjH+nxI7fDKM9sf01QtW6t5M4PU
         +nCOqhBjXonE+BqhGuUbjzkbpgbjpURmu7fh/4NTb6d4mmhtpfPCVM3nA+Zz+uPOqX+i
         lCoXx02KVz2MZXYOoQcFWtFQBvrHexx5r3wAOyONomErQm6Dwd9tWZRgdWaGT8UDaeUs
         DWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788338810; x=1788943610;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yWAwr1smx5G37cCcGObS8HBICH9bF7+jGSCJzShr35E=;
        b=QqsnjO9cA1Aboehq/Kk46/aDx8cMzo1dPWkj25OfbsW9bbTrrYuSNzrILxSU/wpiKF
         E+enQsYlFMCWGaZ1DFnyNTvpS2la/rJhr0fDFCyzpkYtrcSCJ9llD70L1RN9IJPPfvqw
         Ks8JC0JkjOs1tPR2AN9w15SwS02jrY+rVMAKZrnZQxzSE5IBKrbSAlTA2rX9h++7qMaL
         s4F6Ev2xTuGW06czv6UiZUe1qgrbdnhsVWLqS6uLdQX9T4fllOuU5saPu2hg6smH9Wy+
         VpvC5cpivJpVtdlxQ6fvkVMY56U5q4XqwM/pXtbJsDMxP7cgiKKbOIsthgW0kLjO8kpX
         y8wA==
X-Forwarded-Encrypted: i=1; AHgh+RrvED+prym0C34G8XA+HIrnS3rz2fxDZ+Tr+GjEEYhWU/DpYYwXM2wUIQspCVVDU9+/ahkXOAhDTDU=@vger.kernel.org
X-Gm-Message-State: AFuF++lcHKfg9a5Ek5IiAtdJXAjGcSwA+AEDmDu+rSAYs1wbNYi/A8GH
	HJGqPqB+b9saVlmosHsnZJQSHy9LXjI4OQ0PCZboFep0g50uzf1qm4M8fv9Gzl1N34qVZZZnmWG
	I8vUxgzk/SXC9Tpbky8K53/FpVWMCRyZNm4EGW8m91wkTuPxBZXjm1KO+F0ACInN1Hxmq0KA=
X-Gm-Gg: AR+sD11xCkHG67QAwUneGJcZlXVBkq1lxiJDO045lwtwaqpb9zUcIVSPvifcEPbvBpD
	9XciA/2XlOuTDcN2kvPBK765CoTUt4TBTzkcOU3z7VbfiHl5kR9/D9dN74CHTdhvVQifvl5dQdl
	uRe0YOvaxyIZQoy1V2XhdMzzRd5C0kthYPwyIkayhrrUdVNPSDf9os+Zdg/MxtX3qWL0uSahyZ0
	zMqOC5aqJqrWlA0xE9cyoUmJHEQAi8K42d5HWskzoivffghKh2LhB9mxZwWyURA3xlgYVgWKiiw
	UYQA2pRJRd5tp0CQv1p7v6GGfud+kyUAUzvOsJtNFE9pCy18Ra8Zro5qzPEb0CVOEE/3K+OOpzY
	qYqOtJC/fph8+yMIE6HTXXQ==
X-Received: by 2002:a05:620a:400b:b0:939:46cb:25df with SMTP id af79cd13be357-939611000a9mr217654985a.6.1788338809656;
        Wed, 02 Sep 2026 01:46:49 -0700 (PDT)
X-Received: by 2002:a05:620a:400b:b0:939:46cb:25df with SMTP id af79cd13be357-939611000a9mr217651485a.6.1788338809155;
        Wed, 02 Sep 2026 01:46:49 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc68a2sm92433266b.11.2026.09.02.01.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 01:46:48 -0700 (PDT)
Message-ID: <e03f3b9e-e98f-4505-99d7-1bcafbc384b1@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 10:46:45 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PCI: qcom: Add PCIe support for Shikra SoC
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
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F8JnsKhN c=1 sm=1 tr=0 ts=6a97e27a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=x6ikuqDAs4aUxygX8wUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: XYbeSNBZN7wy09gnkIslZqPi1INwn_ST
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA3NiBTYWx0ZWRfX71ZroAtKSRta
 qs8xxByQjzY8cifUTAxVz/mX1F/P5INJOyxOr6O/WTJGTlKLv+KoqEEOyUkG6lUViPVRewNHZR+
 06ABN1qMCrTzV9pre4sqsUlNUstlkEU=
X-Proofpoint-ORIG-GUID: XYbeSNBZN7wy09gnkIslZqPi1INwn_ST
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA3NiBTYWx0ZWRfX4I+xFiONTlkD
 9XFnyDcrCLaJ0knZ9fmOBhNxYvQi6vKN3C2AZksZI8wPZIaVF7BFmQph4hQYix2FT0OdEhMPF4a
 t1d2gUSkqjhWlQwxVElFLA4j3IqLn6OLCJoJ3MExBDvty9OMQ0F0rN1N9P8kvF80tk3DseOjt9F
 rUCcG//+h/kN9htWGscPfs3pGyDx1xSIZbnJxde/uvqNrO2c45oSqXJZTQhulLFYxoMNU020UXW
 m5NyeuBxHthl8xhfJw71U1XpMK+b7k7VECcBTNFuBgRi2QCDJdKu2Pf/DfLl7YYSWpO5vHvj6Ki
 q7BQyMAM7ZcbBq1cYN0uI7NPsM4gShRu0gKSKQKrH/n4PE+Uge02sPAjdHy0qIDHDJO98A/hcpk
 W8+xBFaGHk9RY24wSVQ/orX2SrBssRYbCMVnwanzxGSkVTUZscrbxqSQ46jc/n6BB25KY4by+Ra
 mZUCqMfjBN062w9ojUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020076

On 8/31/26 9:26 AM, Sushrut Shree Trivedi wrote:
> Add PCIe support for Shikra target, by adding dt-bindings for phy,
> controller and corresponding phy & controller drivers/device-tree
> changes.
> 
> Shikra RC is connected to TC9563 PCIe switch on all three
> EVK variants: CQS, CQM and IQS. The individual downstream ports
> of TC9563 connect like below:
> 
> DSP1: M.2 B-Key for 5G Modem
> DSP2: M.2 M-Key for NVMe
> DSP3: Embedded ethernet device
> 
> Power and reset to M.2 B and M.2 M slot are controlled via
> TC9563 GPIO's. Since TC9563 GPIO driver from Alex is still
> under active review, current series only contains basic PCIe
> enablement for the controller / PHY. TC9563 enablement changes
> would be posted as a separate series once the GPIO driver is
> ready.
> 
> [1] https://lore.kernel.org/all/e2inl7k5gsjj6oomv2k5ximuzpb3gfiz66ufet3b4hvov7zqt4@qz4pifbos7yf/
> 
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---
> Changes in v2:
> - Remove TC9563 specific changes [Mani]
> - Fix commit descriptions/subjects [Bjorn Helgaas]
> - Fix PCIe controller dt-binding errors [Krzysztof Kozlowski / Mani]
> - Document PCIe Gen2 limitation in controller node & commit msg [Konrad Dybcio / Mani]
> - Add GCC_PCIE_SLEEP_CLK (which is actually PHY AUX CLK) in PCIe PHY
>   node.

You also silently adjusted the OPP levels in the DT patch:

< +                                     required-opps = <&rpmpd_opp_nom>;
---
> +                                     required-opps = <&rpmpd_opp_low_svs>;


is the lower one suitable?

Konrad
