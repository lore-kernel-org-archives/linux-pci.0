Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A88E3E63A8
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998205; cv=none; b=WGcVDovLCP7HNTq5WTl3JILl+XbGkM7uoBtdtravOXfiwd356CWVXoBlxHD6d8vhJAPNe/lkYKe4u0N5xCz3kvpnPlOO/DYw2RGmIPohrHKhlScmXQu27t/O+AsHg4bD1m5lkE3OZxXM21xJ/tFV1LdewX5Xd14zHhmP3KxZuPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998205; c=relaxed/simple;
	bh=TvfIy379vvosIbtFVABd6KZoCjWl1ycLVvMkhEHVkXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdOkL2go4lTSFCjv6sXD401U5U3il9je5481LXkR7V3KYU/lMuEpgi7v7MtUGr8/24tlGH3zaNUkkmMCVQnKtFm+Kc0K+1xjMrF/fGsVtXz/3ZGNMcZLLEiK5/r/jDN5N7HPBsA8Zp0jUXzapmSNEhT8vUiTCnoZEfK89l9jnYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WagcQjIx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W/7QGWBE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WagcQjIx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W/7QGWBE"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rRbT1517727
	for <linux-pci@vger.kernel.org>; Tue, 9 Jun 2026 09:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rUl8Sy5GMTXVRM2Bgsp87utS1pWmPxlAyMGccJDOZ5w=; b=WagcQjIx0QvVxsyu
	f0Y3jnVqGW0Qa0D8NdNr0HTk77L1e0cjAlNx9i4to7lq6VSddeA4P2lACS8SzVc+
	Y0W9oEFwoLjk965Gquwj3y2zcMIiSK2GIn/RR0Gx0rCdrXtt4S+pZkUDOPa19lin
	KpOGuBQ+yFoXZq34SLBz9gMb8QvntiuuIEOQxJuRsHWgD2PoKnzpRMgFHMUkL+10
	iJKjc5oNRyx1UDEHT0Ii6hp4ESmbZa7mUymk24wB2+0Gu6xKd6NcgnbcOq89iVrR
	A4mrH4uL62npxOG9onJRoDPGAFLcR9qVq4/8B5Kcp2Fsl/9g07SnO+wYGpdqbas4
	qxH+eg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epenr8g7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 09:43:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85a366b61fso3117413a12.3
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780998203; x=1781603003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rUl8Sy5GMTXVRM2Bgsp87utS1pWmPxlAyMGccJDOZ5w=;
        b=W/7QGWBEfD/JBEPhIrcFl0bPMlumwZqi3QKTwt1K4dGjYTtBvNrUXnILqv/WeuTO5X
         w+8INYeBjhryYYm81jVsgxAFTo7L+4aIBgooMpbCgHGGKbUvgEztQrYeqwLKTPpXUs/9
         Fok/2kk5N3INCyTWlHyLye4oOf8qOgzy6+ZvTsfbN7GZmPBFFxbY/lWdP8lye2ek78y6
         gEkpIMhMgdrsYji9Bx5uADxCM4mw3kMEtQc+y0Cc1TtLWtvxFxkm+vPSdm4nIYgqGAdQ
         ubX6dnIOqn90CVbIb8+1Oq5l2PYzhAooIw7YnQVUY5T2Qk6WM6WAG1moWaNdWLmKtsb7
         BSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998203; x=1781603003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUl8Sy5GMTXVRM2Bgsp87utS1pWmPxlAyMGccJDOZ5w=;
        b=CtJwv5SAp2JaPwCeBfsZTxYhoOBktTmJkQUkbjQqHMyyDczioCQtcO2WFPW0I1n6VG
         5AbRlT9I96VWPfog3av0EzQ1OaNzNWZT3AwFLd5kalpAskTdML6BRbn9jks7eIVpvHl/
         5FKl3GkrV0Z/2/8eNRq5Il6BTvvE6wuU3cqG5+WiZey/3LnviGNzOheqUq9D1Oc0AjHE
         Mb+AVerrPSqvm1P2S7oXRVMJfmcrJf7IUhauMAA06ipbH5+6gGKCKEDD43R6p1GGCDsg
         Bmskudr131XEJzw1VZ/teN5LlrUFWeTHNL27FX9eicvu6uUWB8iplthVQ2GBCFiqExzJ
         S40A==
X-Forwarded-Encrypted: i=1; AFNElJ8uOFQXbvXveZ58oGvCe+BRNI+P+p/S5ZfGP+GxAEUBFQYaAdjMewAiegHOq/sIypzdXRcK06x/wiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSmzfiQkqahYZNLbMc5aLth1dKGuWhsRaTkAKRdrfaaC/iC5vx
	0ttOZKFTGbudFZJSze2wXtuqD4e13PCUX9D/+WOlfiEhjekpKRO/SqAgCcw8wNmXJVFU9qgWgAS
	mMuBqfgM85xq/FqbR9O1K+lqFk1+UoMiLSyOL0jH3DCIILtWVOFlUI0Ifm3gQc/w=
X-Gm-Gg: Acq92OHMQG2ZSHMN2uYghTY9QTAl4KW6K+qC4zq36dxPeQX/ASEmPeNYMcw4zzP8tOq
	JMs1AjA8oo2kK6hqKoAEzvH4V6Wq5sl0EZuCjaQitKb0tzho01jfJJCupodTYiRUodMbS+frr++
	3r9GH1Gj3U2lDECz4n3yo7bD9xl8cQs4rptkYXMN47p1l0WO3jtj8AEL47p+fiIwiNjw4Rvdhm0
	Zv/rbTB4+uwWq0uIHHxB9dk2vs8wiDz5zCZj8+8W2VJA6n3kzpsbVSH/uqnPRSnRcl3gP0NkwVR
	O3ef3Jaf4/LcculCp5zWgUCy/j0ChbUMsL0OygH27FK+Vc5xbf76/W333BVzV+1WKqXw+ZRgD9B
	mydNl+oGAx6zOo6NqO/9euLp86/oM10qLlpt9j+SzxXRJ3RBH8qIbMAf1Od3dIyBhP1tp/lQNyH
	/w
X-Received: by 2002:a05:6a00:2d07:b0:842:4bf8:cfdb with SMTP id d2e1a72fcca58-842b0f83825mr20435898b3a.32.1780998202845;
        Tue, 09 Jun 2026 02:43:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d07:b0:842:4bf8:cfdb with SMTP id d2e1a72fcca58-842b0f83825mr20435867b3a.32.1780998202391;
        Tue, 09 Jun 2026 02:43:22 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282374300sm24783245b3a.20.2026.06.09.02.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 02:43:21 -0700 (PDT)
Message-ID: <585db96d-0c65-46ac-93b3-67107a6159e1@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 15:13:16 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: PCI: qcom,pcie-ipq9574: Add IPQ9650
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260602-ipq9650_pcie_binding-v1-1-486a535da8c5@oss.qualcomm.com>
 <20260608-wonderful-controversial-toucan-daab4f@quoll>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20260608-wonderful-controversial-toucan-daab4f@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IcU94nXhakG3OJ895UisGHjsnh0dZ0BY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5MCBTYWx0ZWRfX30bLjmW1hK9y
 9bO8Kd+SI8RYY9vib5lKjp8Grbe1sx5tkx2Cg459z1rD3sfctqs1QFivnkk/VfB2ZRgu2/zDu74
 py3mwb2AOfHs5m5DFn88C0FqPAro6ACaVrgrcM22qeQ7Yx/CFWuPKihYU5Ih80O5OkmTHvLqo9G
 g+XoRRHvzk3t4BmFixYZIFjgkR2Eh94OwRS8+0wyJI4ew6FF7jarjlStTzpr2GzOw01X79a4WDj
 OPEWHdCkcl9yyq8HijMwJYdcclzUd/yDbwV20KGDoGIs/zhy9o732tBR5UZEWYEtOiEasr78aRS
 V3WcQmtjA+FpNQMuFjbZmxTDYz4WgIZTLy3Dt3U2M0ygx6TiWlfzNNmBhga2Op1Ne0A68TczTSO
 0OTzDjb/Yko4qU6vTc7t1pJV1/xDfRlzjWO+8zdL3vPfT+I3X/FJCT9juQyo6/V+ycohxLaLi6c
 HvxTsUc+MK6UJSF7E/Q==
X-Authority-Analysis: v=2.4 cv=NKPlPU6g c=1 sm=1 tr=0 ts=6a27e03b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=4EjJ1Zh6womSNn8TGqsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: IcU94nXhakG3OJ895UisGHjsnh0dZ0BY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090090


On 6/8/2026 3:48 PM, Krzysztof Kozlowski wrote:
> On Tue, Jun 02, 2026 at 03:06:18PM +0530, Kathiravan Thirumoorthy wrote:
>> Add the IPQ9650 PCIe compatible to the IPQ9574 binding, as the IPQ9650
>> controller is compatible with IPQ9574 and uses it as the fallback.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml | 1 +
>>   1 file changed, 1 insertion(+)
> Any reason why global interrupt is optional? Older devices were
> incomplete, but new ones should come fully described.

Sure. Let me add constraints for the same.

>
> Best regards,
> Krzysztof
>
