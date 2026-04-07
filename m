Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9167370818
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564834; cv=none; b=RSNKBcJ/Q3vWk+DY5gQKXwAtFy03fwNqDkfJOL1OZexODrfRXy5gxplSuBqLSajwNIML23dTWe04aF+uFxIGO2xVa6cCgCP4+WbwvEWZxqos22vRQgybB3IHz+jKNApDSwKKdycCNUvKgkO6iET57jpnscVaEwuJNW5QEgANDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564834; c=relaxed/simple;
	bh=PGfxzkueR3nRx1WShdZvaow/9FylWih2gh4HXYnQKuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ve2m/Z8c0WgcactItVds/LNi2K2uzqUmFdT7nJ5FXg+0lUnwvE0Iok0Y/CIf49VfD0fIaGlSech6lD4xkc2PhOa+5R8ETIcv6Z87Sg6xfaMNxcz6ULXoHSx7S1TD6zS7NtClS8K4Cf6u6rOs8r0eKnZ2sm8Pu3kqSUhWuCCk1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KcKAzBGu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PYHZNZCy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KcKAzBGu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PYHZNZCy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63765T9Y492506
	for <linux-pci@vger.kernel.org>; Tue, 7 Apr 2026 12:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DQ/FbsFha5BP0Qq1tyZZGZ3cnWFodwIbFLgBI/EBXAY=; b=KcKAzBGuA+uNFqh1
	GUHpbNgWwIoGNOKORSUj3iVxVDVXXJ1XXA0wQapsFX2AcdjsbZra9geP0hmLaSaR
	V3aroWBEhwHEC3qI4zVaKoFXYq1r82xzdaZarJfxey02dAKR4b6SGQbsywjI9VMG
	gM8tBry3lyZODzTzGOaawTz08sAtd7eOr9djkmht6TahjmhNxomg9NooXhBCBqnW
	hmiNhF+rJ5rijbqYzF8Fra8momDu2k5RPfUA76f1y8ZAPLyWACHY7QzpinaTWT8v
	F45rNtozzpa9okshLJqFFLvv4txyuZ32bipbBkoP4lVfBRL7kBWFKSCQUIuwJKBX
	/R7fvA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr8tmpg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 12:27:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d8c183c2eso19409981cf.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 05:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775564832; x=1776169632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQ/FbsFha5BP0Qq1tyZZGZ3cnWFodwIbFLgBI/EBXAY=;
        b=PYHZNZCyi6OwmEHQDlvc+RSHEMVCPodRL053WNBQksavqGxMFU1+17e43ngC/l1ZhU
         ZVYiNZuTw2BCWd3sDHizVeADCOAYpR7q/I6QrfXz6Ovcwif+96cVmSFr7w5eQ9eaNTi2
         nYZa2DpweedUXY3AFxX7jwssjZ9gdjeDlg8PiMS6kaDYtGQcXjfLA87UhnFTMicGNlaQ
         uteeVKsgj8BEolK4JVutVkch1To2kgzNBb5TW9gtdffpRDFyJEGQ1w3Mb50Zn8mJ4Qky
         VGrm2S+N3QLW2Ye0qr8xgWUO9iDvJuUBcfQ3jRMwlmq5dSaqrWitR1DY/2xdLegsn3eC
         uh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775564832; x=1776169632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQ/FbsFha5BP0Qq1tyZZGZ3cnWFodwIbFLgBI/EBXAY=;
        b=E1d4l05aBiBd5EIPtJcH4SODjLPBG8ODcB4nnp/QFpl5+Tr5UhydQehePnCdM+U5aK
         +25AbEAPXDylJsbk+oxYDAAcfydVdhafOsCd6cYlkNlBUyYZ89OAvMdamiAK1sw4IH5w
         YumjXNeGPpkvD/gU6DVyaLEiK3Df3E2kUEhUgSBs/W++XFvEwIYNP3mxoxFmnczeW6tf
         7ZBOJgInKDDUh5M81GuABZYhw7kyQubZ1yMqVdjnlA5UF/mctq90Y1H5vn6Mlm9wmwRu
         xMUMGZtMaQsCJ+ZC6tpF5vaB0iRHoTbWB1dtU4Y3fnRmUTRwufpQ2hfe0yAqPLVJahGH
         A9cA==
X-Gm-Message-State: AOJu0YxVuEUR+5bkI4Mp0Chr1c1vjT3E4mSq/Sx+REK482gdQmqmj1xW
	f8GYyh1+DCc5fPNmUz0iOPzNWxkmyyKWgKR7O3P1ufgymjiQQfVFrrFffluFROQBQ90b+jFibrF
	b4FFzoUiJIZWigMVyeFeQN2506jOZbd+LYu2wy8bctOZvtVkx73a4msljZk+T8Yw=
X-Gm-Gg: AeBDiesc+js+BoxAbT06ZKsQ5SDdbQDvuUZqVEgBMnSsck8xxhAfzPo7sTF4q2JR3w+
	ohN1qwo6sBz6LkDcoLW9yLatQkHL8s3cfkGLjIrNAkEhAgl4PAXDl/vpba5Kizlf/cLH9Wafrr3
	hijg9QFnL49thJvi3NggUc8K6eif96qRYTFDDS4/yDiJuk6bSQdlukZVozouqZGpU7D0YFCLaBU
	lULQpFkYJydS8fjg4bTUd45MYP3+uMpu89D2judC6ghU85PTERGU8u0iBrZeuxrNv9tGMNvUGH2
	V3wAkfgkuY1uXb34FNky6vNmldkudS+3uybzEyXXDZ5ncTZwk1NoaF8RFO9YlV/NLdTQUkiozhB
	E+zZdVq/Esv3qHMBdh5G4RGD8vZH/L2GXM+aGWJKftgksrkJx7/zu8O+0OAPC9IkgEQXFkSxena
	i04Io=
X-Received: by 2002:a05:622a:15d3:b0:501:4767:a6f with SMTP id d75a77b69052e-50d62c47a06mr180545791cf.3.1775564831688;
        Tue, 07 Apr 2026 05:27:11 -0700 (PDT)
X-Received: by 2002:a05:622a:15d3:b0:501:4767:a6f with SMTP id d75a77b69052e-50d62c47a06mr180545411cf.3.1775564831264;
        Tue, 07 Apr 2026 05:27:11 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cff19c0sm547473366b.48.2026.04.07.05.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 05:27:10 -0700 (PDT)
Message-ID: <7223c10f-6298-472f-97df-8753b8935598@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 14:27:07 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] PCI: qcom: Add D3cold support
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com, bjorn.andersson@oss.qualcomm.com
References: <20260311-d3cold-v3-0-4d85dc7c2695@oss.qualcomm.com>
 <20260311-d3cold-v3-5-4d85dc7c2695@oss.qualcomm.com>
 <f3344006-5511-4f1b-aea3-7dc81a091cd8@oss.qualcomm.com>
 <4a18abf4-32b0-40c0-bdd1-81ea819c4089@oss.qualcomm.com>
 <38f51e0a-fef4-46b5-84e3-0138cc5f79c5@oss.qualcomm.com>
 <2d193ac6-619c-4cd7-b0f1-39f5aa1ec02b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2d193ac6-619c-4cd7-b0f1-39f5aa1ec02b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EuyfCFy0AIaB_9Gqr7dfZVegZeAp-YjO
X-Proofpoint-ORIG-GUID: EuyfCFy0AIaB_9Gqr7dfZVegZeAp-YjO
X-Authority-Analysis: v=2.4 cv=c9abhx9l c=1 sm=1 tr=0 ts=69d4f820 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ZCbfbMl1FPzj5El2ZOUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExNiBTYWx0ZWRfX2djZvpvShrou
 W+ZgGaS/CkYA6+0HNPHO+zxOQk3PhOozmMtBTnKMn8w2XPEenlWwJmOJOWd85q+LagW7oAs6CXH
 cSIG9GE2+cCw/widNVCWh8H3CtdOmvUT84vQrUVmrneNuKE5oV27a6jWKiM0Ovje3oqxFhBuIz+
 U3hhnTxgKdC6WI4CGFe7jKFWt6aGOOJS/adC2U7jdAe6zyE9smo7SQxdC/FIQRz7pyYpToRJKAg
 M1HwvtUbwLN96s1Cl47uKfDjqKACL1HX/nQH+qUfVNgOnenvt6v2q6JaKwpb3uMDptbkNes3BCP
 AEmGZTnLfCZGRlojg1v6dv6b6HTYJvaNd5fFbByksRM4Q3VeFepMHiivQ/g4xOoCn9hkippTJ5i
 dSAzZjgAA0gwZheRRr5rI9XjVJltIQdLCXjXaKFVRymp6XteWcnUp8ssA6WLRH4PQCW788yXupX
 VgojtPXdBI3bEvt0Owg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070116

On 4/7/26 1:37 PM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 4/7/2026 5:06 PM, Konrad Dybcio wrote:
>> On 4/6/26 11:08 AM, Krishna Chaitanya Chundru wrote:
>>>
>>> On 3/17/2026 2:45 PM, Konrad Dybcio wrote:
>>>> On 3/11/26 11:26 AM, Krishna Chaitanya Chundru wrote:
>>>>> Add support for transitioning PCIe endpoints & bridges into D3cold by
>>>>> integrating with the DWC core suspend/resume helpers.
>>>>>
>>>>> Implement PME_TurnOff message generation via ELBI_SYS_CTRL and hook it
>>>>> into the DWC host operations so the controller follows the standard
>>>>> PME_TurnOff-based power-down sequence before entering D3cold.
>>>>>
>>>>> When the device is suspended into D3cold, fully tear down interconnect
>>>>> bandwidth, OPP votes. If D3cold is not entered, retain existing behavior
>>>>> by keeping the required interconnect and OPP votes.
>>>>>
>>>>> Drop the qcom_pcie::suspended flag and rely on the existing
>>>>> dw_pcie::suspended state, which now drives both the power-management
>>>>> flow and the interconnect/OPP handling.
>>>>>
>>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>>> ---
>>>> [...]
>>>>
>>>>>           ret = icc_disable(pcie->icc_cpu);
>>>>>           if (ret)
>>>>>               dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
>>>>>             if (pcie->use_pm_opp)
>>>>>               dev_pm_opp_set_opp(pcie->pci->dev, NULL);
>>>> Does calling .suspend not drop the vote by itself?
>>> No, unlike genpd framework for power domains, opp votes will not removed as part of suspend.
>> Hm, I would imagine the power vote goes down.. is that the ICC vote
>> that's still hanging if we don't do this?
> yes, ICC votes are still present

OK, thanks for confirming

Konrad
