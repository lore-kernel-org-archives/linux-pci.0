Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EE7399359
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561853; cv=none; b=RaSKfBlpai3h+wdmxzN+KyZ9mcWTeIiaJ/MmA4ek5ys1p5EW0KyGNsFGNYHQtcAOIVgrqkTM11dwfR8UGM9DcUgM5NsWSka/XDRdJtmTFXojaf4M9ozw1dOViFQxCL/Oworyx2HJ8N0QdeBCiVEmjagGZJeXH/WiMTJyy5ZDai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561853; c=relaxed/simple;
	bh=f7UJQkkG+/fsSZcV3S5WdK7zwrMcxYvVIRINClEe4V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hS0rAHIc0a4o5BsA7pVGeRT/UlrvAIQDvWIQ4C59SFOeCxTuXZUa6Tl+pk9bGwvOD8qb45xmCkqcKMSaWAxTFCpyKJXJzTRYcDMMeG7I4S7JSfta8KAK0NnPTudtWRQ8FX21T2VWh6NOORGbjZ5H+Kye9SibFvZHHkc/SR1sILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hW6JDQ8C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HhqTFnPC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hW6JDQ8C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HhqTFnPC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376ESTn3537365
	for <linux-pci@vger.kernel.org>; Tue, 7 Apr 2026 11:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f7UJQkkG+/fsSZcV3S5WdK7zwrMcxYvVIRINClEe4V0=; b=hW6JDQ8CE4xQnYxT
	qqy31TKUnwhwrXoLkAMm2bSXgIXhPPvHRnBnx6oKcvUpBDB2uCOQQWAeZvAubsDM
	JdGEeDzz142dCXAoL3xA8QxIigULTLuKpiNHlfOC4QmLIcmfqcbOXg858MdVXJ2h
	6GUmGqTKki6pAg77R1kfVZXG6KNDwMRxGRtJ3p3XWBvZT/fYL2uq0Ilk3g+Q5ah8
	NbQ6XwvSDH6CvqPfLv3VVs5iurC6wdxOoyLL9aaAr+a6Cl6qN5GZHaSkJyLWl++/
	ibBtv2UrvXvWpGAUh7SjTLPcDE/cbT5WUEOwZazQooXJf94hKYsRCfioBaJ6cfEn
	vFC31A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmra2h2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 11:37:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2454fc131so87890505ad.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 04:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775561851; x=1776166651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7UJQkkG+/fsSZcV3S5WdK7zwrMcxYvVIRINClEe4V0=;
        b=HhqTFnPCWS6glRxCVXObmpKDYF4L+BnAya8056tfEbgOtbui/pTI+ky/2YCCGJIG4H
         R4CCpntfi4tbLY8/WCOwriL+m6IlAfyhkZUKqMAitADpwaFmV5S4VvZvB+mUS5mErrhh
         fTB4ZbmkRg5Xdwt+f4JlV02ruHK7dgIltjiR9KPYQS86Vw/KqlWPVDt/bgnNVCKFNVyP
         SlDe3dq/FteiS9fApQvED28Qzesbw6bhFMJEMzAmRA8o29UoSrexjRvnZbEfllhsTCTG
         mCiaAaXrWgwKpbGxjnfCo5CU/TpSGJH3axrKuOh2TY8XwD5re9SmQJhTiknqan+ptXCX
         kFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561851; x=1776166651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7UJQkkG+/fsSZcV3S5WdK7zwrMcxYvVIRINClEe4V0=;
        b=N2bxc68ZBhrdvr3OR+5X0h/6FW41CcRsop8SwqHbMwy/9papMUDCuVAQLUrOn56K9d
         Vq1rD7bnPa37AclJWTN7nV4ZOTJnn4ti/RltoskYY3WP4rYcxVNajz4SOYnt51bp4eI9
         jA4YiAWKYSIywyOdnxQvcqafbtbi9gVx3pPLjwEKfUso8LxUykzBKLGBYuI+VRLum2MO
         7SBb1RJTB9dsbwKtblH6NnHu8R21kvThwWQJN6KZVL01DENWIYytwxngqXT4LNsR+aDW
         vlV5+PqX5IkzVc6oXGkrUtpharvkWQWa0WnajDyJ0zjQRWO9+BSE3wriP3u2b5JSwrO7
         s5mw==
X-Gm-Message-State: AOJu0Yxti8/WssDgILG3308qW4lUfhUZwXpBlwpmFo+VsCZkI4HLJCIF
	rfqXezX9+oQHltbaib+miJEOmUOaPRUFDMcRozTVuY+W4FYSTNZWKgMjxQGW6lPpYP6wgUF/pK8
	D/6HRWa3GUKrILXxFRYUzQJKjDTuiipiNmfhARFpM1YxycRam+HJAPwsZiJz1fgHx2ZgZocc=
X-Gm-Gg: AeBDietP802iSJqGvhI+J0rUyMvYrFCTYNC+nQKxRL349CDzFfxbrQ43Tfd+dxmgkvg
	6A4ifyp7L1sYplKq9ZGakSu8TFvkA1b8PNPsUhsE4LYDtjFrW+cn6hMryJcp0cONtKKvlMxiCzC
	rcznR+xmRPGUb+hU5olX+iEO/h/sG/6KoZNFbe7tCBQv6Wi7L2C98SCJThiPL59NgmDXRcGmdMc
	9wPjQXTpjHQijhl80ogBk+aOXUq8jd5zwwg4EdoiTXRHKIolKZmLUs/i0mF8C7pZlafVdxjp7JD
	7DTc+kOyLczEQVqSm6rDnDmhNqNThEIBJ7OUv7ijjbCoUBUhUHcolr4AbmlNTpJDFjgm8myuVTy
	S2VkVxMNmeNRqKv75gp2p7NdyaHMVS8j2OwwQyPd+D8Oe2vAAfQZfVA==
X-Received: by 2002:a17:903:2c05:b0:2b2:5840:809c with SMTP id d9443c01a7336-2b281828136mr176408785ad.1.1775561851208;
        Tue, 07 Apr 2026 04:37:31 -0700 (PDT)
X-Received: by 2002:a17:903:2c05:b0:2b2:5840:809c with SMTP id d9443c01a7336-2b281828136mr176408545ad.1.1775561850792;
        Tue, 07 Apr 2026 04:37:30 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2af067a59sm22227085ad.10.2026.04.07.04.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 04:37:30 -0700 (PDT)
Message-ID: <2d193ac6-619c-4cd7-b0f1-39f5aa1ec02b@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 17:07:25 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] PCI: qcom: Add D3cold support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <38f51e0a-fef4-46b5-84e3-0138cc5f79c5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vZqo40mRrPc1Hdlu_9CKYHWMsOSVi3tt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwOSBTYWx0ZWRfX+SGuuInNL3Jm
 Tl3fnvsxB6K2bL3y5t69EZ9qN5tr9wI6LEnrvMJW/CQLD8zaCKewWfUw1NTcBFhUjFT3Ka340jP
 pjmofnOC969hAY5+EQ2+Fzfe3F3sH1Q8DO5Uj+xGjcMXQJrHYTwQmOnLq9B3SXZrvhxktGYg2Kr
 EZGGGzlWYUl9lVtM3BU1SyptDHRdfkxTH1dqH0dgYM2eWwabuIJ5z31c/BVg1d8VzhoNWMXuivD
 /E9MMC08By/7DjfYNaP3f94sGw9Rtd4GTbzvyH4Qc3YvlC4EPecjyr3THhGxMrc0r43/gee1SrR
 ZTg4QFGXKHE/gW2phrnkzRf7WACiyRBds6aRGn9QV+DJzIIoD79OJjsJsJNAsa8+dJ5OZJSEQ+G
 V4K5+RZ92vlncjwY/vtAz6rKmnMPtQ+ot3ho4JRNJ5MbERVJNUDaGC/1lcubhbEskS4EHGcAKsV
 vIRZeX199671PmsPmPA==
X-Authority-Analysis: v=2.4 cv=BKGDalQG c=1 sm=1 tr=0 ts=69d4ec7c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=MaFP3Q4kykvwS0bM9pgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: vZqo40mRrPc1Hdlu_9CKYHWMsOSVi3tt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070109



On 4/7/2026 5:06 PM, Konrad Dybcio wrote:
> On 4/6/26 11:08 AM, Krishna Chaitanya Chundru wrote:
>>
>> On 3/17/2026 2:45 PM, Konrad Dybcio wrote:
>>> On 3/11/26 11:26 AM, Krishna Chaitanya Chundru wrote:
>>>> Add support for transitioning PCIe endpoints & bridges into D3cold by
>>>> integrating with the DWC core suspend/resume helpers.
>>>>
>>>> Implement PME_TurnOff message generation via ELBI_SYS_CTRL and hook it
>>>> into the DWC host operations so the controller follows the standard
>>>> PME_TurnOff-based power-down sequence before entering D3cold.
>>>>
>>>> When the device is suspended into D3cold, fully tear down interconnect
>>>> bandwidth, OPP votes. If D3cold is not entered, retain existing behavior
>>>> by keeping the required interconnect and OPP votes.
>>>>
>>>> Drop the qcom_pcie::suspended flag and rely on the existing
>>>> dw_pcie::suspended state, which now drives both the power-management
>>>> flow and the interconnect/OPP handling.
>>>>
>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>> [...]
>>>
>>>>           ret = icc_disable(pcie->icc_cpu);
>>>>           if (ret)
>>>>               dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
>>>>             if (pcie->use_pm_opp)
>>>>               dev_pm_opp_set_opp(pcie->pci->dev, NULL);
>>> Does calling .suspend not drop the vote by itself?
>> No, unlike genpd framework for power domains, opp votes will not removed as part of suspend.
> Hm, I would imagine the power vote goes down.. is that the ICC vote
> that's still hanging if we don't do this?
yes, ICC votes are still present

- Krishna Chaitanya.
> Konrad

