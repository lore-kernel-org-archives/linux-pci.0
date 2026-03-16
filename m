Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64BC246768
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659794; cv=none; b=bMu+tDzIkHmxZwPfsTaXP7TGVAYbFMltqyvzhBoABqOZO3Cqvla2Ui+ITA1w6a8/gMjgqTBX4GH3v/fjBg0pR5BArdvmSd6JivHQZ1r14ysELd9XmrPMKWC2wXhKYC+ufjsyPjdH7oWAgPAC6UhNJn6eS2nK4twQaZAgXApWu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659794; c=relaxed/simple;
	bh=xG/QaDUSOhesRdmqYi6i+Ld8v3fKnFkYqZVWHVNXY3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOP2mrtrJk3y//cLvaIDcMXZ7v/kiHZLUkUfTnW1NkD7KvV2iVCCLiWaeoE0h2GN88/pc8YDWFDr2h2y+HNccDagh8vRb5wX31gF41bIOeIHM1u1VGqBzfAE4rMgG64Bqo30asPDEYghl9+0vpUVEjc8AIDej/gJ3HE0alBasn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cT9zdv3/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=He/rN9Hj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cT9zdv3/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="He/rN9Hj"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64h5I744133
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 11:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/YDE7D97huJARZebmKe+OloJlAk/ia60u5iSeajG+rk=; b=cT9zdv3/LsiK0XOn
	e7DvD3I6uHY3osqlO3yW4WM1DNHhrt9ivqErNILqLdqrcc3HlbpYqebd1yyDxoDw
	thmpW5OA+Kcp1XdQJwWEp996Eg9qFvPF6uF//ba2oOmk/pEKkJIpgp80QR4O9CAy
	J2aHLoEYQLli9hhzamv8mK43lNUrS3PBDOgyresS23A0sgqL+0Fzd/sVPr96gMJa
	yunxfvbJ43lwyHlqAL92D+0LlTaUbEiuJaxpJ3q39Ji7W+HjbLnBaR/GbGdfnpFm
	Xl9m/2CpJzA+wdVPTJ6CcBVjuU7m8BCeuf1EwUXRz4dyr1geJ9DbDT77Mdliw3Bn
	MNvdGQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00bdgcu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 11:16:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd8dc8b434so367369985a.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 04:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773659790; x=1774264590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/YDE7D97huJARZebmKe+OloJlAk/ia60u5iSeajG+rk=;
        b=He/rN9HjRVo1ipfxWsY/CryucRe9OCq50Q1yo8It//Nq8jIWcHQ5Bol0HOx4pEzKHx
         UTgxkh0ys5EIOKsrq/mtzIexk2eIrkm/GgGqAU2ntYAkSKAA3ewcexF7rL20ku6JmzVA
         IbFHHAaQZXVWoXpcPsu3N+Hisn/Zx64Fnn/L0pFHH4Ld+g62mZooZhrdIC7aH5nArxz7
         sp5WsOUKe2zDwJ0CKa7Vr1Dg4ZOE5kRsSCmHxJzTZcghBrd8m7KZRfHBLaE8CDzGinYE
         zfBnPThx/19hYJcBdEVVv41Nornopw0UYZaa9Co610ADneRvL0AGnPoHf3Ivc/dvk/nq
         YEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773659790; x=1774264590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YDE7D97huJARZebmKe+OloJlAk/ia60u5iSeajG+rk=;
        b=Mqyfcmj4goN+jzDGW5tp+CkqX7CbcEtCa79wYjdGksw6BucLOyxphirDhWDv3h7ha2
         rGxfMhw8B++w+X1k6GgJQo9E1wKn1G4ZdLv/D5jAvPzQSOcb2Z+AOdR1cJIsEB7y2RO1
         dVVqVMO2QuE4s0f0lhudeMjQ9pIteMtS/BJRdEIqL9I+8hzYLE9mlXqAFZUlCIAXuyU1
         VIzZK49Rtw1P5qRIscgGH/AxqpjJAlRuIOvh817qQOqJCD1pDCw7zn3vW4c1twScT0Tg
         3vPTRWBPu8sZjK0t00/+eBIZthALJ1a8VZUJ3qXV6mgMcRCo0KAv6oFAFURE5TAU6OBO
         PmTA==
X-Forwarded-Encrypted: i=1; AJvYcCWDSBuUixLuhWcvJlXIczK+E5z0mBTflVG5yrxQCXB7aStLSFAVRdjq5NvWh4nngDBnYdIhpRqrv2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCqebUmO6kc01Y/ikhhEFb0tHEcZEiZih74SGNhr+EIiQ2IqCV
	J097fgRb6f6+91Bq/X3saQ2k/Ia/adsnHcGgFhzxVvRNneaKkk5WL4Vgi4/SeRbVT/h8Zy30wc9
	rXHMsRo76uWumekzhg7ozIquurj+c1dQoQePjZZEZbh8AIsv9ndYk8kL5FhqI4KE=
X-Gm-Gg: ATEYQzxs8HYJnkcROF9dPLpJJppTcdzUjoQk5K7KT1wtKzYqqbsmIJS9GubTy7k1mjP
	49ftq1X7EyFQIGne1M0csmyl73yllIp8RlNXU6Kxo3V3570lB4FajOpIIW9jPEUm+NPWibhUqwE
	qC7BLCdqVnZI1iFEdzMgEIooXFSvB6hCfKJq42tsaNyvkXjqt/3c6mPxTKB3fJ7hslOeSKoCCml
	+1zo2ytz+hC+V1ghvuZmlfUevQqqsqFJ8jMqQCWmrT4LCgIpPI1t+L8qhOA4MsExkfuYeY2mw1O
	0OxSrawpZergQiAWIBaA/58cGkblYfQBi3Y3daqPS6rarYEx4GLNc36vczDpZamCq9g7eyM0Y3H
	2hIjTQJfV4PoMRikn4x1CW4lW1bcyWeieIQng6i5PfxrWJyiRdkN+84QFCShX08EBjuC1R5/Bu/
	u5oBE=
X-Received: by 2002:a05:620a:bc4:b0:8cd:8751:2b19 with SMTP id af79cd13be357-8cdb5b8cb21mr1296897485a.7.1773659790145;
        Mon, 16 Mar 2026 04:16:30 -0700 (PDT)
X-Received: by 2002:a05:620a:bc4:b0:8cd:8751:2b19 with SMTP id af79cd13be357-8cdb5b8cb21mr1296894485a.7.1773659789695;
        Mon, 16 Mar 2026 04:16:29 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976cdb47fasm520697266b.43.2026.03.16.04.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:16:28 -0700 (PDT)
Message-ID: <c404887b-ccc2-4731-a7fb-2e37ffbbaf3f@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 12:16:25 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arm64: dts: qcom: hamoa: Move PCIe PERST and Wake
 GPIOs to port nodes
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20260313094618.1361418-1-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260313094618.1361418-1-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IsATsb/g c=1 sm=1 tr=0 ts=69b7e68e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=hNqFj29UGYf0a7zNkJMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4NiBTYWx0ZWRfX/HbTdYgJVHek
 aLdvLiy7ROvr4+60MvtRWZnD5oX1AFhDYbQ7lYvITVuucT2InmAfgpyeB3gWs92C1ShEbTKuL0A
 ijzsMyy6R4/EC4JKEvJio6kII2B3zfkEw759PeKU8LFpMo/IAE/q9LaKxf2+Ity5XQMTfSx3/iL
 DlO4cFfjwI4EdjXOsbcPI+Pm+LgDN+C2ZMFsOyDKWHe+KHCQh4MDZJ2kDwCjghLrcPJMPvrxTzY
 R6bLUtWNROyIrV1n6565merwr885iV+f45cH/IkEJRTc0YJFEvZyakTDBZ4RGz7zMwcjH1MTlNI
 WvLJWJouu76RAszATyvSAnYJhDUslFdPAvs+ksHSjF5aRRJ3Oh7BCfs79FjDoxRJUvQOUPPnI8+
 M/wqaAiQs9MBvNHcRgTHS/vTZ15ObbEP8lPbGAZHVqtlsKUFLJBxQf+aungWE+eEEfyhOZfa/1W
 PeRG8EBB6FtQnc1otAg==
X-Proofpoint-GUID: Qxyb0Rt-q4fi7q1bDp4QBaYAw-hUrwgp
X-Proofpoint-ORIG-GUID: Qxyb0Rt-q4fi7q1bDp4QBaYAw-hUrwgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160086

On 3/13/26 10:46 AM, Ziyue Zhang wrote:
> Commit 960609b22be5 ("arm64: dts: qcom: hamoa: Move PHY, PERST, and Wake
> GPIOs to PCIe port nodes and add port Nodes for all PCIe ports") did not
> convert all Hamoa‑based platforms to the new method of defining PERST and
> Wake GPIOs in the PCIe root port nodes.
> 
> Without the change PCIe probe will fail. The probe failure happens because
> the PHY stays in the controller node while the PERST/Wake GPIOs were moved
> to the port nodes.
> 
> This fixes probe failures seen on the following platforms:
>  - x1-hp-omnibook-x14
>  - x1-microsoft-denali
>  - x1e80100-lenovo-yoga-slim7x
>  - x1e80100-medion-sprchrgd-14-s1
>  - x1p42100-lenovo-thinkbook-16
>  - x1-asus-zenbook-a14
>  - x1-crd
>  - x1-dell-thena
> 
> Fixes: 960609b22be5 ("arm64: dts: qcom: hamoa: Move PHY, PERST, and Wake GPIOs to PCIe port nodes and add port Nodes for all PCIe ports")
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
