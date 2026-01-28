Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DC934DCF2
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603312; cv=none; b=P3pjEKSf+hd5fgvkBZdvdk5JUmGv0nOZ39a+uxPXINKyZbHU2MNYklrlVFS5jDStWtoOK/3LiJpfKnaFewVhqgrjhO6LEJ5UKbFv3RBXISaXj9LYLODLAYeddjKl0C8sMTd4XghzYjKe2KEFj8vWxV82l8lNyd9mro24jf7LmqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603312; c=relaxed/simple;
	bh=ZUX9XnVeoQciorqnBH2esQT3/fsNfcIkrEvDlXEi4gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8FL3PV+Zfmvz7YNd9Zb7QZL09H817tTPaCBE43UpKnxEIacqiOGs+Kwo8vu9plYu5mwm34KxaIW1kLM/M0D45vXtomem1K2rRlcgvBAkC2xM604FI2qpGSZpbGS4FkVMiMMzgXuys52msVlAX5W61rKYZAHA+YBxDicqmU1kH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aoe/GZK3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HLf1D8WX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aoe/GZK3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HLf1D8WX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SBdt761750353
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 12:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N07p+s1dUgvFBMxNpW2da12jwTaJJ6ibvwkL6xYgEWI=; b=aoe/GZK3vTUzRy/w
	MoHBh8zCcW3mXfkwfyhi/TU9963Zu9VzJ27aTykGkNqRPURJ7+Mj+G70TYN3Kfqp
	qvCdottrWm3epCbfL9lhgC70jAvXY419vKb07waHP+Hpsod2FueJeF0vLwdB+E/F
	mnwc5w+NScWcERrq3VLamDsv20gfaNjcUndJ93W8JS0qGOLCjEWx2+X2EGSFCQgy
	6fvk1t95Q6aWj4OrHf/Z/bp+rHDpPqNIWEQIe3qzJlXWOGjwSrO0nxOaegpJ27NE
	9GjQESAS0mQUAvInGR0BOUVrQuDUXp6GYrk4dC/fGtenEeuqufzHaBWemYku5qpP
	ZBy5aQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byhsj85a7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 12:28:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c522c44febso103606085a.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 04:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769603310; x=1770208110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N07p+s1dUgvFBMxNpW2da12jwTaJJ6ibvwkL6xYgEWI=;
        b=HLf1D8WXbaElre1ZRkHnCEXAHUVKhkiACYVcPnj3J0olPBMksE5k47X4BiSkTTLNG4
         LONzq+GWJjdbP8ALyXJV0jc3OBMnK02yeNHGl/850s1Ixxp/y6wn7wrF+UFe+uNBX/ln
         OTnmvLbIhAw7ecNS1WuBmvUB/61BvTqBv/L1E9NWmTlNtZ1bxi0EmDkO1N38nMlDFyti
         VreJj/BuxGJBiqnc5zpuvd2bC1ZZt1acaN5sDrwfJZJcyb/63dUgy9mQNgMlTxRw1dEI
         PsZykW5ZZYGrGiLlWu1pMtMXG1quL8lXO5T/LQcC2l0tjsghIvy0n81oVq20TrvpiFTV
         OOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769603310; x=1770208110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N07p+s1dUgvFBMxNpW2da12jwTaJJ6ibvwkL6xYgEWI=;
        b=WNHoPJK2HhaE2v6wDJ2MY9+TdOAdblK69/aLO+lC0NL1rYdSv6cgGJyOBu5KuCkZpj
         Nq9MX3bGWLSwHKrDyaHSg5sPsjHdfnOuz1VWFe1PucOCYulv4MNUq6EkLKuxgxxruOv5
         Bi/o4ZwlaBpGTrARRL4PNHM74uwrzpLOZ4NqeVul9lhoJ2ssMQnpH6fQJp05iraGtimz
         lrtTj3ex9XnCqKxp0Xqt5ePtrN1e6IqMV7oQbcKfKcnzchmkuNKykYzXhUJo74wYIRnN
         0CM8e0pcPTv8IRzr15g4G6K5yaHoVr2aHe9g+qrclbHLkc8ww841c2Bs9mDJvagVm0Av
         3dUA==
X-Gm-Message-State: AOJu0YwhROaTW/vOYYibaWtYcMJxsFudK7AzsV8v4dy5RNYSGSJ7s8Dg
	cU201USQ4rdK0rjWt8RkNOQ2lxc38rt0CeYY0FM9O6+ON5GVPCEyXBf8TFjvB8Ezu/neD10x985
	AjKRwMoWZsOxO7TIQP1CpKwTv8Utu3UOVcoS4bqNR1NLQMGaKpD1GSHwpJW6LRwk=
X-Gm-Gg: AZuq6aJdY1x+MwF0hd5UTU0V0ETcf4qApCRnr3NXq9wy12z1vQggytNxdpgRVv1nIYD
	mKm/Og1MBeHfn6YhtbxKFUsD5J9Q/ZZSJUEMuPZzuvcAfR28c0Cc1w8zVizIoOysNBX8nN16o8a
	YMKoo06MGu3ZsugCVnHKgrXo1xwER8z7FFT13StELlyv1lvswidJVaw4Bk8frrvoiU+GyhulP2n
	0ki3wQ1TZwo7ueNmypyGeRMqe6AwHaGH6TYKoMz8xyZIzAxmk/9wiigylY0HZxzeaFlD919T38d
	q0x4gsN5R4YgEsuJp5yN5TGa7LTanbVYQZjqqfUsc7PrxoWvtjfoPSIfm4Bfe/YEdcy76wsXNjF
	TQ+sMckkW0VnmW6sLG1CqTlHOV5aZmCAZNND16u8jid/gjmH+d96LemZ5m3dIpVuwyPk=
X-Received: by 2002:a05:620a:46a0:b0:896:ead2:a657 with SMTP id af79cd13be357-8c71ab1cc92mr355485a.0.1769603309693;
        Wed, 28 Jan 2026 04:28:29 -0800 (PST)
X-Received: by 2002:a05:620a:46a0:b0:896:ead2:a657 with SMTP id af79cd13be357-8c71ab1cc92mr353085a.0.1769603309287;
        Wed, 28 Jan 2026 04:28:29 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dcb4b1186sm60595566b.39.2026.01.28.04.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 04:28:28 -0800 (PST)
Message-ID: <63531057-ea7c-4a87-9848-04e502bffc32@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 13:28:26 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: qcom: Add D3cold support
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com
References: <20260128-d3cold-v1-0-dd8f3f0ce824@oss.qualcomm.com>
 <20260128-d3cold-v1-3-dd8f3f0ce824@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260128-d3cold-v1-3-dd8f3f0ce824@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: s7ktj2tGdyFwA0GtFoWSH9O5z5EQsWfy
X-Authority-Analysis: v=2.4 cv=GbMaXAXL c=1 sm=1 tr=0 ts=697a00ee cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gkRObvzxmN_HJK3DEhcA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: s7ktj2tGdyFwA0GtFoWSH9O5z5EQsWfy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEwMiBTYWx0ZWRfX06pBGUvOKtio
 LbqU92wBoZ8kFyuIhbavrUfUkkaGXYN6JuYMfXs2H/TDZddlmeGTIXAMJ/sV4Zm81EEvsBOPL6B
 aE2VUq8f62Zqq69VqRlIiJkEtLN31M4wXflXEdp8XTY0CSqRckcc458oVq1BNSVBCPoHeWamtrr
 IyUaFGOh+opWaa3RH88QGl05yVXvJovmqZjqC6CsTXbVh934VbpIQpi8Hhck5F+MoJ3LLITBkI3
 s4Wt5ttc4cdrx03uby06bZnskrRDo28nLHqyiAR8TvJO0dve3H2Ovq/KhqFpbmjMxlOM07qX8iM
 PmL3HHMExHUzfTZFAZ4vNlgQmIoTzyJaM/TAGOw9BDctiuTmExT+OA9AYkfShTMCNWuws8Pl9rB
 uHqunx5flJ6BiVqxrmzjYQsNd7j6vTHWxkEapLhJ+L3jxNwD4+o3gMJBv3FWOjtEoOVI1265kJ/
 y81Wx09fa5bI6flVjeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280102

On 1/28/26 12:40 PM, Krishna Chaitanya Chundru wrote:
> Add pme_turn_off() support and use DWC common suspend resume methods
> for device D3cold entry & exit. If the device is not kept in D3cold
> use existing methods like keeping icc votes, opp votes etc.. intact.
> 
> In qcom_pcie_deinit_2_7_0(), explicitly disable PCIe clocks and resets
> in the controller.
> 
> Remove suspended flag from qcom_pcie structure as it is no longer needed.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

> +		/*
> +		 * Only disable CPU-PCIe interconnect path if the suspend is non-S2RAM.
> +		 * Because on some platforms, DBI access can happen very late during the
> +		 * S2RAM and a non-active CPU-PCIe interconnect path may lead to NoC
> +		 * error.
> +		 */

I think someone internally once tracked down what that access was

Can we fix that instead?

Konrad
