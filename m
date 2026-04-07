Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0AC3AE199
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561771; cv=none; b=LYQtxgMCapTXJ/J679HRo8Fvl6U+MjPrQHn4EiuS/v3lf92XHNwySa2Gpf8ip1bs3pBuZ27zWbyJTB8nT7FuJMoEB2xyfHvzZrgN35OcsJY4lV2dTInV/Jh+zRvI4chP2H45Mj0ZBP3vBy7nMjVzZ+KdnBHakBSJkCNunM1poEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561771; c=relaxed/simple;
	bh=1j7bzSA/i3wGxmd5mbRqQCOd/HBr3xNh0vLp5u6w8FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dV/YzUIgTJvIKujMeemu5QqGOkzdHiQVpWPF4yus/97wcls6ZGJZOuPvwXv1Nder3qxsjL5omshPmkRIL612wnw4k4Jo6Oh5NONYZ4+gh1QWu1ppTWoy11dDR0eqaYsEdbI9gpoV/RlIXqy+b8e91x0D5bjX3qFj2ayXmoUS9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=npziKh9I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TDztrmqw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="npziKh9I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TDztrmqw"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376d5lG1584282
	for <linux-pci@vger.kernel.org>; Tue, 7 Apr 2026 11:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6pEf6uKvSI6oCJgjhiIfUYBD3yToz/qagAHgA28vUQs=; b=npziKh9IshzOvxRw
	4ac6g+Tl7qNY2JdkQsjtXfEXoIiZIU9IWYE05R8xxQhz2Kbjz84Mah3kwKBYs0Cm
	HgYWJP7/5ESrY7bAM+d9V9BxryDekaVrerw3PI34QxKp8FY8/WWBGteGRcMZlnIf
	MxqTD7jHp3sBmnKZiSN85k2cHuOzq2vThrXxoyIzqi6jKHCpdn0JWRTIDBldO7t/
	qYO/y78bb8ztJxCa8ev/S1QNER/4tVhlotcbCp4kEuW0/oz51/QXONXgtezung1r
	CY62XG8i0l1eya5dFHdgKhYin4xuOw8IltDpsaRDmCL51jc7PspZiNUlyJXhRGIB
	Dk4+kw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr9th1u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 11:36:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b2955cc1eso6931501cf.2
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 04:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775561767; x=1776166567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pEf6uKvSI6oCJgjhiIfUYBD3yToz/qagAHgA28vUQs=;
        b=TDztrmqwtHvC5veDVr8G22ly1Xpk8/bicbf+15BO1C8wwB1pKNSAPkAknmVznN1xVk
         tNgdGMY4WkYezGBshue6kdk19t9QpqU23TqT4oycccZz3AojRxkOjR6eDq+BlhU2aJmf
         mGVtJepg7wa4AimasaO+GdLJM3zSFVmx4K3+t6qNm64BbroJP51z89TyaoZkZjlphU2d
         yhjQrL5hOKnhPZNtFwWs8DP23fTsH6uL+t9sIEQMZSOQBAM4WEcAUdeQoqvs36qNCUO+
         eT0MwD/ns2fbGxtRnfg2kgoj04in0YnEx9EU+a93y3OSnGw7neKQHBIsTCORN9szoGW2
         meRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561767; x=1776166567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pEf6uKvSI6oCJgjhiIfUYBD3yToz/qagAHgA28vUQs=;
        b=B6/FtJkJkaMMpId8th3YPwTco08+mKm/P+mLX9AuodQfWz2zvEr2X9l/3hh4b3/fmt
         bp4tzLtxEBjhis5IgKem6NU264rCECklU+5/s8iMXIvWDHZIlR7fzx1DvQXq/x1MEmuQ
         DyHUe4F7+75gXJM75tRwt8phvnEwsa27VRlOd7xq3DSttM9xgRfZEnWHQD+aR8ynFEv2
         hERXvKvDrYDEIHUZZVr/yHJuQxepRB3ehrwECz1CMvBGE/rkTTXTmRLJvsUA6jrbOwl+
         iUwUtx1371yyfD8dwX2sytSodk5JE6Ujua/9Rb12wfw88bQpx4ezIsxtu+o5qojOqAux
         rK0w==
X-Gm-Message-State: AOJu0Yy0aSuBmMi4y7U9IIQOtF79NxbvYvRHTgrgiPaNerG+pR2Vz56P
	L+D9MuzG+kzHy1bCvw1ISaR1THhooWnhpBmQ/gqBA/0lAjJdJnGrckW/Ja7aB477hmmYRo7Kg8X
	kySrZTzOUStvcNnDMDky0O5v83l1NktjttOg/YpGmLCpwPkSCZYpr8kZQ8KAmk0g=
X-Gm-Gg: AeBDievz/Py4wHdPwicy4mUd3z405pPTWlFSGrKlGiWpYriibhs5iAlqcg/tvx//srK
	SSbzBrQrlzMSYgbqTGdrTWfZ7g/SUMtEVz2VIzDtnQ51kPW5g+PIXvwQoLxd2z6rUU4IRXPyxkr
	X/tDPjlKTBrkvaSuDexg/QnUe43lERzl24Vzw2OkURNM8Z0LPCL1GYIo6Al+cfqU0imPW8fAhZ5
	AgSVZT7EsN1DJFBLtSr/fK3sdw96hzWgo3U3bo7PP2XKHV2GcOD/JCYQxJhQHYMT4AFGDcamW+2
	uCti6C48wdaax30aGNVriTObyk9HxBZauujO1MB6Kv780ZVyaJRQBf20F+rVGlAOtsogmEHvZRD
	Z/827UxD+7CtHV9t2RcdJLv6xsRNDLcSp7snfZS/+NkOLpKS8jUOwu4EI0+d+zXYaDcpgblGvDA
	nXzJg=
X-Received: by 2002:a05:622a:1883:b0:50b:2972:4bec with SMTP id d75a77b69052e-50d62b57f2bmr191597041cf.3.1775561767231;
        Tue, 07 Apr 2026 04:36:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1883:b0:50b:2972:4bec with SMTP id d75a77b69052e-50d62b57f2bmr191596721cf.3.1775561766706;
        Tue, 07 Apr 2026 04:36:06 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3d0287b5sm547504666b.56.2026.04.07.04.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 04:36:05 -0700 (PDT)
Message-ID: <38f51e0a-fef4-46b5-84e3-0138cc5f79c5@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 13:36:03 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4a18abf4-32b0-40c0-bdd1-81ea819c4089@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SMdykuvH c=1 sm=1 tr=0 ts=69d4ec28 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=M7nLEK1OKNC5V3jzK1UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwOSBTYWx0ZWRfX+WImQPrYzRmU
 DWXVwjR6GxsLwYiQ/57lM5vQ82TiT3wIeq40EZYCDOATUz1Xje8lSqLW9402J0nIJhDwfTx6X4+
 ayxI914mEZXI+BMecZjCbgEFcLtSrb2SgyA7vv6tEhlKMlGmAUP7MzvjhkxefW4mzqqyRSdNcCb
 KILrakb408+3oacGB98b3r903chzRwRNWkqIczex6mck1QrwdsCgzaiea7Pmfl/KJQZTB8DgZEa
 Y7D6C48nnwZUUH/kAEz+eqb3tFvc8+HL2GcYE+ndTOSzDWTLjSOLNbEhev34LKazYfj0m0w4829
 +LbiireJFceo2qKxo0vMosl9EwNApVQnbrXjbem8WB2Hmn39iOFZta3cX1ORgNJTcdTCdklySAn
 ycvPtCFw9E+moGp7Piql00tJmh4KmoEu1rBOYF3ZQpTCGbobDnhYM30es3tleGAWS6oHzvvLRPj
 Y6sfYMFcU7MyDmgoodg==
X-Proofpoint-GUID: Koas0iE-N9zFDMOrswNHr386FdoxY2Zo
X-Proofpoint-ORIG-GUID: Koas0iE-N9zFDMOrswNHr386FdoxY2Zo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070109

On 4/6/26 11:08 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 3/17/2026 2:45 PM, Konrad Dybcio wrote:
>> On 3/11/26 11:26 AM, Krishna Chaitanya Chundru wrote:
>>> Add support for transitioning PCIe endpoints & bridges into D3cold by
>>> integrating with the DWC core suspend/resume helpers.
>>>
>>> Implement PME_TurnOff message generation via ELBI_SYS_CTRL and hook it
>>> into the DWC host operations so the controller follows the standard
>>> PME_TurnOff-based power-down sequence before entering D3cold.
>>>
>>> When the device is suspended into D3cold, fully tear down interconnect
>>> bandwidth, OPP votes. If D3cold is not entered, retain existing behavior
>>> by keeping the required interconnect and OPP votes.
>>>
>>> Drop the qcom_pcie::suspended flag and rely on the existing
>>> dw_pcie::suspended state, which now drives both the power-management
>>> flow and the interconnect/OPP handling.
>>>
>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>> ---
>> [...]
>>
>>>           ret = icc_disable(pcie->icc_cpu);
>>>           if (ret)
>>>               dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
>>>             if (pcie->use_pm_opp)
>>>               dev_pm_opp_set_opp(pcie->pci->dev, NULL);
>> Does calling .suspend not drop the vote by itself?
> No, unlike genpd framework for power domains, opp votes will not removed as part of suspend.

Hm, I would imagine the power vote goes down.. is that the ICC vote
that's still hanging if we don't do this?

Konrad
