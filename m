Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091873F787C
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092613; cv=none; b=D6KylbaUN1GHTU2p4nhJQWSl24iHMb/pKhjaMqp3Ru2WPYD515bX0Mspj8tJjfHUBI7w0lYC6/F25i7Ru1vH0+6c4kfiEnbocuiMk+053d7T2t32mz2xt/VoRJ0zh49YHu4RNFakTjtGrt85CQsoaob71tuScjGd+5wZJY96/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092613; c=relaxed/simple;
	bh=66IqBveo+20pwhaW9xb1axpWXAYkohqaVG/7jNEU5hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnT/sBNtRuJMtGKFcpzA4COr85gCGAIyUyzsN7w3c0KTVYCelhFWjmZq8FoPZU6dCicUYYz+aS5VC+YUoS3HFj00MU+aRoLT6cOlHd+XPuxfbZFUxcesQDXyS2lVVqrmiPjbVljEhMHAkxr26ljcbvSGP8hO/H4hsT++KE3rbSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q4ZWUh08; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jrb1dlnR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q4ZWUh08";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jrb1dlnR"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ABNZx41031557
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 11:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZD9n6XhJmxub7zVMjUNqjPaNd96A5hGk0u4sEFo2yg8=; b=Q4ZWUh082/I2tJxH
	wcsRsAAyztNt94BTZQfa0qye8GdRn8zj/iD12UJIwq/wWRsaJpk85ZHgK4Bef27A
	79XqY3MBHWIiPcZlijG5zbQX4pySNRxHBxexbrCP/WNJBpRU2mpQoxgDpvEujUMv
	igx18QQsEIQUxxzmNuPL3mrVHcHYXVdKKm74DzfLmJ1/f8+jUK0E3KVClDiBdspK
	R+wJCRttcpPNGJqtlmyOBuR/oWDUfpkr+7QyynfVKMTYa16bqFxVeVRDfXUS+GiG
	X5tPqYy/gZtBE+iQrpf3R4jeUA79Zger9qyg1JOVx5qIJjzPoq1OiZV658ONZPAu
	HPJYcg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq0m1snj7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 11:56:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-915732517cdso90611285a.2
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781092610; x=1781697410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZD9n6XhJmxub7zVMjUNqjPaNd96A5hGk0u4sEFo2yg8=;
        b=jrb1dlnRsFsuryTxRjq9gufADuopSSQD/a0KKjoVZ8wXLS/YOMA6+3VK+51SKamggD
         +WbipCuQPcWYN1Ju8ifIB+kv8PRBXAgw7Xlbca3/cxWrPTnOhPMblGArcziW9eYfDPHW
         WaAo9Ci96ZPxZfZ0SQAGACbtrvtdhTrT+dbrIXBUidk8h/By+4vfBEnNnWfC422MgxFF
         8oAp2Z89D4fK7GuQmODZjkyS6rVlmwRUHQm6xjU3E0nDBQjs4wJ2x07ZI/z31McV52f5
         h4faXkMxN79diXFrLs+T5SwtpUbsMQLbxOwRLSATmhl3+QUexV3tKMtycxJ13Ga1Wohy
         vnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092610; x=1781697410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZD9n6XhJmxub7zVMjUNqjPaNd96A5hGk0u4sEFo2yg8=;
        b=DFJRxDzz5Ee9RnpoiPiubPqgJVghqRDFPXKO/1tPa1+VKUG84C64g3/XaQlNVZE5XO
         NQF61e6p11rLC8ZRVNPvEBZXOCJkEnAUMbBtLGPxlqC/89k+fReHV22lpSn3nwzDULBU
         HDyUAzvbNiExLkwdeq2qIuj4voyGJW9bpgzCugJgmOptAtg7XYAAiHARHdJ5f4P7QEia
         T+i5GXnqAlE3DMX2ozXIEvKnB5ZaQET46964OckMU+0XOQuatGqOEsmDeQEciQYf6J83
         ts/sZaRJqNKTs1lCBX9GDfKXqps+4/uZlS7vyhJrERLd/1xvI3Gh/HhZ/rrcaA10jB3h
         lTqQ==
X-Forwarded-Encrypted: i=1; AFNElJ86tMNuzvsYjcXguNtsWENDqgwqROdzzwiVIXYN7vmleqzWZALH5YAkUnpNO5A/8wnFKz2yR4FRXDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzwYrPdz/SRoybvLb0qZNu7XWzsXnOPtGkZr6PTgJut7HSm1aa
	XjbDzTQrhuEEnwzF6+MtG3USc9RvLE16G1Ae5NZ+4itocM7NZZDSONTUbJqG2O9gu37s4FHUJbd
	HLFNAeafxr9fg2MEOtmoGTGO3j4MR+5sAn43mxL6L4AUJS6pN8SdRq0U2T+k5gWE=
X-Gm-Gg: Acq92OHzagBrt/ce8bh7AJNMe54FIKVb9P+CcTdzyU6UblnLrAovyZy8QFcEF1yJKHB
	vLd/EbLA00B/KdIc34tpoDfy5AbOKdIbBinDqW1t475uEbhCZ+izAG0vRkA+xaI/mW3Nw++f/Af
	gnxuiFfIXo0O2vw5sRsOvKOIW7tXpUYNuZVVAL1wQ+XU0h1GWKfxTMeWyzWaoOvjKX5QKWCNNz3
	j3I5g94LHWAkDMEIjCWzs/4GVjiyW60euxK0Wsm3Ln9JJ801NAn1LL4Ns2RgHOTc8fBj/2Hbw/r
	NiEPT/taVle6FIHFfLJgweZ367wgHdRsYH4lNBsglRJO6WplQY14aGYtM/y350Hmldm14ahjwWo
	UI8aqhBGrL0TPQ1dLoO/WMAZPcC+haEMRz6+wvU7zDE4wZUiZv8jxa3TX
X-Received: by 2002:a05:620a:3182:b0:90f:7ce2:3019 with SMTP id af79cd13be357-915e6dc038dmr698586185a.7.1781092610281;
        Wed, 10 Jun 2026 04:56:50 -0700 (PDT)
X-Received: by 2002:a05:620a:3182:b0:90f:7ce2:3019 with SMTP id af79cd13be357-915e6dc038dmr698580985a.7.1781092609704;
        Wed, 10 Jun 2026 04:56:49 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65867e7dsm9878414a12.20.2026.06.10.04.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 04:56:48 -0700 (PDT)
Message-ID: <affc72d8-1906-41e7-b889-c5b09d1bdd5c@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 13:56:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] arm64: dts: qcom: enable WiFi/BT on SM8350 HDK
To: Rob Herring <robh@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-bluetooth@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
 <20260608151835.GA2707238-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608151835.GA2707238-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExNCBTYWx0ZWRfX9MuX8n4teKX1
 Yl1A1FVIMRvmL6NAl/Wi3y2pZnZX6AdG5VPpOY7e1DIWzgtSXPRMOa0IzciD/H+ImWoJjukOm0F
 LkjJ4uiHDFkWnHurap2tJkCr+4qkek6bojpUTIeIP96Xp4BbjqWcyjCeKUqCrcE2B1w02E78u8H
 Fw2VaOEon3qnS06u471HsJbfXBQ5ErH1E7Nz6UJxz3e5fGAzxvhRDQ/7FoB6ptosvNIuuASrFr7
 rGlmhC+wWGCR+mCOP30KmCQC9evexyVAP85n8alkGygZMuX57rmL4uKt6JwgMWZIn01B5rb1WYX
 OMbXcgxuXHyLA3efOBkMJsX1nIe1sMjK8fwENjPqddqGxu8R8m38/elv0LUmdO72If/H6JzYvUc
 lOX8s/4EKWkKTffuyOx16HBzsaySBJKjc8pSPWQGSO74apFn7tz1jQ0D0BKF7i6F2FxaAlsFjkG
 KXjs2OahwmKQbvyjBjw==
X-Proofpoint-GUID: QdAxORH5hsgQVi_oklKT18kZqPL__Ju0
X-Authority-Analysis: v=2.4 cv=UdJhjqSN c=1 sm=1 tr=0 ts=6a295103 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=PJdgiX8PLVy5AUVXCKIA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: QdAxORH5hsgQVi_oklKT18kZqPL__Ju0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100114

On 6/8/26 5:18 PM, Rob Herring wrote:
> On Mon, Jun 08, 2026 at 09:59:18AM +0300, Dmitry Baryshkov wrote:
>> The SM8350 HDK has an onboard WCN6851 WiFi/BT chip, which for a long
>> time was not supported. Bring up different pieces required to enable
>> this SoC.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Bumped num_vdevs to 4 to follow other similar devices (Jeff)
>> - Link to v1: https://patch.msgid.link/20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com
>>
>> ---
>> Dmitry Baryshkov (7):
>>       PCI: qcom: fix parsing of PERST# in the legacy case
>>       wifi: ath11k: enable support for WCN6851
>>       regulator: dt-bindings: qcom,qca6390-pmu: document WCN6851
>>       dt-bindings: bluetooth: qcom,wcn6855-bt: document WCN6851
>>       arm64: dts: qcom: sm8350: expand UART18 to 4 pins config
>>       arm64: dts: qcom: sm8350: modernize PCIe entries
>>       arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
> 
> Before adding new devices, can you (Qcom) fix the all the existing DT 
> warnings related to QCom WiFi/BT:
> 
>       6 (qcom,wcn6855-bt): 'vddrfa1p7-supply' is a required property
>       6 (qcom,wcn6855-bt): Unevaluated properties are not allowed ('vddrfa1p8-supply' was unexpected)
>       2 (qcom,wcn6855-bt): 'vddwlmx-supply' is a required property
>       2 (qcom,wcn6855-bt): 'vddwlcx-supply' is a required property
>       2 (qcom,wcn6855-bt): 'vddbtcmx-supply' is a required property
>       2 (qcom,wcn6855-bt): 'vddaon-supply' is a required property
>       2 (pci17cb,1103): 'vddwlmx-supply' is a required property
>       2 (pci17cb,1103): 'vddwlcx-supply' is a required property
>       2 (pci17cb,1103): 'vddrfacmn-supply' is a required property
>       2 (pci17cb,1103): 'vddrfa1p8-supply' is a required property
>       2 (pci17cb,1103): 'vddrfa1p2-supply' is a required property
>       2 (pci17cb,1103): 'vddrfa0p8-supply' is a required property
>       2 (pci17cb,1103): 'vddpcie1p8-supply' is a required property
>       2 (pci17cb,1103): 'vddpcie0p9-supply' is a required property
>       2 (pci17cb,1103): 'vddaon-supply' is a required property

Most of them will be gone with 

https://lore.kernel.org/linux-arm-msm/20260522-surface-sp9-5g-for-next-v2-8-dd9d477407f5@gmail.com/

a single dt generates 2 DTBs (one overlayed) that throw almost all of
these errors.. we should be able to tackle the rest that remain shortly

Konrad
