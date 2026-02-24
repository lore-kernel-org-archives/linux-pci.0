Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A06586341
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 05:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771910518; cv=none; b=DCyc6I1fPWwoctTUgazophhGO2Y60qC8iKdlTpbtJqhDwEfK3pogK43t8tJHCpZvA+yomr2CxPKl6Z1RxsCtuz2IjuJ43xGxEInDc7ip7wrc7/ozlAfFhilf4VEPLbBlyJyBaSmBbi75ZfJh29gBhJ3qABKBZ8eWcXhf18T4/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771910518; c=relaxed/simple;
	bh=a25WP+ngxKefLlm8Jp1uY8vdc7iKypL8diS9ipgcoeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/f52oqbzWRgDvkNwz5iUFElYYhYsue3ckcqNoe71B1p7bTCpYih6j1T2iYwXG+bCNv27AJwUfrAlAzoj4zuqvY+1ztkC6K4BgLixQ4yE0GWQo1QABHMyy9+ps6mK6KSaYEHBQtCOWsRQAGunbcsw4C9HIke9m9asenSf6M7CxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iRxKoKTs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BcUCd995; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iRxKoKTs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BcUCd995"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O4Lh5W2013672
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 05:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YG6onlflqKPuqQmGvxCA6a0np4eOgXb5hoigKK45+9Y=; b=iRxKoKTs/YvRnSsQ
	qE0JKPWqB92jnJj9+PW4LWjuaul5x1mOtzx/LEx4cYLZIpuUG3hBJwVQZsSEKjNy
	gLLKYkHeFH4lQRRRvXEmNNpCAHLCDKEXJj63KCEPWTnz4plt/9g53u8cjmvBviNO
	nCzwmru1wOGCMr2qSJXmNNC4KkeX97YD6FHpEgV2DJW4BrUgTAe/I6ANPr85KA9y
	PSNcJMsqLvb7DydY7c6ql+k0bHeOcV1p0gYJvVI/o1RIeZUcqaay2F9pJd98kXhT
	I7Tm1DsVTWtd7PsRoiujffOhZvACQ37KGmBv78hVq6+nm9sq3LiIJJZCNuhjvbOF
	coPv2Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgr69je1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 05:21:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a76f2d7744so56124115ad.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 21:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771910516; x=1772515316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YG6onlflqKPuqQmGvxCA6a0np4eOgXb5hoigKK45+9Y=;
        b=BcUCd995w3vNontPg6/KEg/uZmDkxz3rfYrrbdnI+SlqTUFZw1OWR0vEGQm347/Fd6
         fUWu212yttZVwJ1DsSqsWLX3KB5P3k8lqwkGluvTh+lz2ZaikHduhP896SRsL0gbGIQu
         FQPqVJyuUQ0v25tX3sV5LMUz2CeXrNbZ2+IjyNcVyyOA1qu0ynlNUkpBWUZJBC2X/RLw
         VKz32cvYm68j3rJLzYs2ZHU4k9EvTarXLVEWjXDS2NW+M+AiqwLIvbCvxBrEw9BSJjzR
         d0AO+DyVjxF1df0TJzQWc42Dd8tmqBgcnnM/CU91h7a4fyRbyhV0V7bKyt5coRFk/MFq
         An+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771910516; x=1772515316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YG6onlflqKPuqQmGvxCA6a0np4eOgXb5hoigKK45+9Y=;
        b=CZSzTiw6GWNuB+7tzB3z0dBP54hAfFECr1NHw6zIaAJHyObG3snH27Sv2FnYoF6ra+
         veJla9FQx2PLy3sCG7rJ6yU1PTHLw4Sjydn4RClK5aG8BXssxsmT+TrwsjPr65kj/Sek
         kvi1rpNmjg19lqFCx/JIiB0rDjCGShlTZxfbgimk5VJnQfP3q1OUiKFxIbBAJZVAgjCH
         oDTopQgd7LbiBpvRIDTNlBAa6vHDRhesOcIMTNCNeZeLrxJlFUh2+8JY1LF9MpTPzml8
         h7S69ZFWvVz7OAPDIPPaVfAgBbbxzkFauCMlAB+sMC1OMi0NEw1eJaL3VcQYEqI+6K5O
         MsQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkucKgmVOpxEPgVniknCiia4crG76IE6QcesGOrfAD5jU3DKSTkUxECa0CYjLFRcPuc5MSTnMDnsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqyFiHAIgrSZEtzkPifaTokv0QabLit4LuuNa8orsO82B2ByZi
	NsRV2Y4f3ViOgTXlj43PoFkSIuoChnHgEhhHO4f8zgiXOd03nzbmJ9Afl8jzRkCezQaZyFytqna
	kTwaUXeIZV1kgWYHBhrgnCM3bb3QyK2S+u7UgXMrTbfecDNqDr9Uqmkd+A/oXXjg=
X-Gm-Gg: ATEYQzyD98ejKlO7Dkh6kOiLVc3QLk/qhkz0BTRpbWuWosKiR4ekP85bMtcwICMejyN
	HrQx1McJqSdKTDllSXToGjOrMiSSD27hasP4Pnioz/lanTKI5+1/3rNKzEYVnIILtJmvcJgmU4a
	1p/2z+ocCGW30M5+7i99pFh1pi5pNoaseUjs2m1XzSDplMLRWHv2ZNMKAHo0GcKPIN9O+oJosqw
	PKKClvh0mm9Br/IHAd1D8HiMP7bAcSrISUd9dZI998vxVVClcLbIlTZnXs8KsesLdysM5aLSy1z
	3A0HyjzqOCu3RnroD3qQKYRKlPGN/GEpnYQmDFtNqObcW5dpAb+ZpYRbVHD+M7Nijoc9ML9Eaba
	qZ5UvYrPcszlk+3T70utqSW6V5hoQDCYIOnag1S7woAUL5vbzXctUEQ==
X-Received: by 2002:a17:902:e544:b0:2ad:9421:6136 with SMTP id d9443c01a7336-2ad942166b9mr18014665ad.1.1771910515817;
        Mon, 23 Feb 2026 21:21:55 -0800 (PST)
X-Received: by 2002:a17:902:e544:b0:2ad:9421:6136 with SMTP id d9443c01a7336-2ad942166b9mr18014465ad.1.1771910515316;
        Mon, 23 Feb 2026 21:21:55 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34e9csm86344475ad.3.2026.02.23.21.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 21:21:55 -0800 (PST)
Message-ID: <25e50619-6695-4630-85b4-79c4c88e833c@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 10:51:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: dwc: Add helper to Program T_POWER_ON
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com
References: <20260223153856.GA3695024@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260223153856.GA3695024@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O6A0fR9W c=1 sm=1 tr=0 ts=699d3574 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=wBt9fhMRhOodALO6grUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: TVhHR_JSrQLIAZ9X2VUDHHi95O3XfFKL
X-Proofpoint-GUID: TVhHR_JSrQLIAZ9X2VUDHHi95O3XfFKL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA0MyBTYWx0ZWRfX+EvDwdTwBtFS
 qCEUulRbeznSbULfsXWVpfaT/TbU5ukyC1A6TSPUD/QXka8MRPrCq+mQ21TORWoFPRABD4PT+3f
 QO+u9kEkchibbNhCYRekGXf26PqoSaZgFL79UPIYfZo+Rrfz7HaAfhkWLFjNQG2WwyFrlIFoK31
 0F41qaHRy/OT7qNPgnYYWdJ2uXR1uWFSAGHvtPAUbL9zw0Gfe3CdYYpZk0BGxjUSrSRpWTu06tS
 lLoEPG+tgK+jFIOsPx+YEbKXNsIR+tog0y3KVplQ9lzSkDLr+aWjso493xywnCXNNcF9+O+yMyF
 v85wp3RXtmnTx7CFyrcOo3tDAxO9Rje79A4g5DGzCxcglqmgninAt6Hkkd38wELfVkd1BCeAdN9
 tFO7jGWjBQNILC78PtJFzhAw4Q/9QxoCG1Egu3a9WvYi9deH1XIdZvFxCnD76CWbyeVav2n2Tp0
 qxgVjzYZchT7G7mU7Jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240043



On 2/23/2026 9:08 PM, Bjorn Helgaas wrote:
>    PCI: dwc: Add dw_pcie_program_t_power_on() helper for L1SS T_POWER_ON
>
> On Mon, Feb 23, 2026 at 04:43:31PM +0530, Krishna Chaitanya Chundru wrote:
>> The T_POWER_ON indicates the time (in μs) that a Port requires the port
>> on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
>> asserted before actively driving the interface. This value is used by
>> the ASPM driver to compute the LTR_L1.2_THRESHOLD.
>>
>> Currently, some controllers exposes T_POWER_ON value of zero in the L1SS
>> capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations,
>> which  can result in improper L1.2 exit behavior and can trigger AER's.
> s/some controllers exposes/some controllers expose/
>
>> Add a helper to override T_POWER_ON value by the DWC controller drivers.
> s/a helper/dw_pcie_program_t_power_on()/
>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.c | 27 +++++++++++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-designware.h |  1 +
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 5741c09dde7f40487c6da6dfd66f7c8d96a74259..f56e2c07ddc57bd84882c14bebc7d4b4961f601a 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -1249,6 +1249,33 @@ void dw_pcie_hide_unsupported_l1ss(struct dw_pcie *pci)
>>   	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, l1ss_cap);
>>   }
>>   
>> +/* TODO: Need to handle multi root ports */
>> +void dw_pcie_program_t_power_on(struct dw_pcie *pci, u16 t_power_on)
>> +{
>> +	u8 scale, value;
>> +	u16 offset;
>> +	u32 val;
>> +
>> +	if (!t_power_on)
>> +		return;
>> +
>> +	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
>> +	if (offset) {
>    if (!offset)
>      return;
>
>> +		pcie_encode_t_power_on(t_power_on, &scale, &value);
>> +
>> +		dw_pcie_dbi_ro_wr_en(pci);
>> +
>> +		val = readl(pci->dbi_base + offset + PCI_L1SS_CAP);
>> +		val &= ~(PCI_L1SS_CAP_P_PWR_ON_SCALE | PCI_L1SS_CAP_P_PWR_ON_VALUE);
>> +		val |= FIELD_PREP(PCI_L1SS_CAP_P_PWR_ON_SCALE, scale);
>> +		val |= FIELD_PREP(PCI_L1SS_CAP_P_PWR_ON_VALUE, value);
>    FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_SCALE, &reg, scale);
>    FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_VALUE, &reg, value);
ack, I will fix all the comments in next series.

- Krishna Chaitanya.
>> +		writel(val, pci->dbi_base + offset + PCI_L1SS_CAP);
>> +
>> +		dw_pcie_dbi_ro_wr_dis(pci);
>> +	}
>> +}
>> +
>>   void dw_pcie_setup(struct dw_pcie *pci)
>>   {
>>   	u32 val;
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index ae6389dd9caa5c27690f998d58729130ea863984..da67beece3f11e33d9a1937fa23d443feea3bbc7 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -602,6 +602,7 @@ int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>>   				u8 bar, size_t size);
>>   void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
>>   void dw_pcie_hide_unsupported_l1ss(struct dw_pcie *pci);
>> +void dw_pcie_program_t_power_on(struct dw_pcie *pci, u16 t_power_on);
>>   void dw_pcie_setup(struct dw_pcie *pci);
>>   void dw_pcie_iatu_detect(struct dw_pcie *pci);
>>   int dw_pcie_edma_detect(struct dw_pcie *pci);
>>
>> -- 
>> 2.34.1
>>

