Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BCC3AC0CD
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 05:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783576550; cv=none; b=SUsbUwNlCefyCysNEAZeZkksUchMBmGgp2OXif5MDL+xeP/D/Msfx2vgj54FwiTSWXzXhY+nMmZXfk603+0n4+wus/7D/bCAlvrh2YC6C2IBzF1cQWVbVbosuZM53CskDtteTnHwo/cf83n5lq4TIgjCIackixY1FRpaeLBHb2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783576550; c=relaxed/simple;
	bh=sXgLEOgI2SCOJhE/tWVh0lCN5/y6oBCIOWbl2fyUefA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghsOzjqVfn5HGYXbh5/GlzERPeXwLwIB6l8W7pu1y38e0YfOg0xQwvSyYemkNr0zsysOD08peV3+ywysz+hMj7Xtbk50Vic7oXfaYWq+E3zz574sdbtuymekckAEloCxAlw/cHUcmMM9aJg3mw/Y//TUohjLQNiMUFcH+FY/C74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ze1fMsuR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Miuv8mri; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ze1fMsuR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Miuv8mri"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668N8RG94053793
	for <linux-pci@vger.kernel.org>; Thu, 9 Jul 2026 05:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2SdAfcm2bDQkGugOuxGblXVTFcWe/K4asZRKOKIZkDM=; b=Ze1fMsuRHeyn4W+1
	YlNA0umD9w1RYyTxkpudsWTLeSj41d9e84zXLDUs7viAdwxrEhh2WYMHBFVNifIE
	Ovoz1mrUgyDnS9fHEZTzq7xBFlHc09jTvgQiopbi2Wbi/80trFxWhuQhTwjmMt3j
	9QwTLRz79E4OHy2wHH5erokMvSdFOQXIhbjEZw+vitdotq5aA3BaqwHUI5mIAa5O
	wHqDOfueNVyP8oceBmnYhzm+QM+1lO3MIjG/OjxQ9NSdXs+NW8oiXMWcczfuWSAF
	I056P3DAF7oMcrlALedj+HiSweMSOEI4iVmDWOEns0xpsGLjsLEedmzInBCaPVTB
	cxztnw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwfsh27-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 05:55:47 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8924f4d0a4so2159441a12.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 22:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783576546; x=1784181346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2SdAfcm2bDQkGugOuxGblXVTFcWe/K4asZRKOKIZkDM=;
        b=Miuv8mriS0v965ibXFgEV/if3lXmWgpISmlSeWEdZa2zvWS1eM926/Qw7t3rRdp3XC
         swJpHkJokTtOhjDxHTYQYkkIlQ+piEy1V/+N770m/7HhAEYgsOPjViTqv9hg8CSIYcpd
         mPwtqa0CtVbMhOqgMMgpErRnf1u4mUclRpAuhwIqsZgC3R4I0fSb2FRW5NiGfUN/QSDY
         B2dg3pYN4xn7/3VWQvI70Gfx7381HodfZ4VV418QigL8kbwVARQyVoW4lRVxOirwzFRj
         TQdGW7OMRfDWsSV5dhlyoqPSYbE+D+Mrw9rmZUQjrhkfr99TRpKBeS+8rQFrx7RNSjUA
         nfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783576546; x=1784181346;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2SdAfcm2bDQkGugOuxGblXVTFcWe/K4asZRKOKIZkDM=;
        b=X858pUQZqXsAqoMqnNM6rgRlYHnInwSp1+L5G2qhvPIVI4bpZjGe9CJxDTNJ39oXfc
         3oaXASa7MeTokhYNlwNrPsjGfnircgT9PyldxZCVoXBzQ2gkEse9TlB2ZJ4QvbD7bPDc
         YvbSssHzMv+D+G1qsh0DBnM71QPhtqxgsO31rfPVH4EPdCuKTN7D7OGDircoRj29E9eV
         eINJtj/8tR1jKS8OLGAdX7pO6pm5YxAnboHluXFf7/RSVmF3kL8C1VnIc8Fs0coebIhS
         FMsU8DidXHosz5aCoh4GUSWSZY1BkiPsHApTZf6VBTIpzyuWjFuFhuEOXyLlpqPCufow
         eVFg==
X-Forwarded-Encrypted: i=1; AHgh+Rrfwk5aVT0RtGX2A0ErrkgKlJs+ZqZ61jTaIZoxQgDCIIexX16GdIxwGK+FZop8SBeB7rdorxjAiDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9rMgW9rdjPDqxRXl9kv/58Bk3f+ThC32hTfD3Q1g8sqFwiId
	Cun3GoxYGP5XYaBD9IuyQ9f5BlOlIiz6Ck73/qXiK6nyShLhxyGuqpIAbqK8ZJYCgwY0G27UaTj
	Lg9oY+68zbeF7uX620xvEsMEw2EE+HEAY62JaRYBRz+10T6ENtRgX83WV2KoJu1M=
X-Gm-Gg: AfdE7cl5peEWjOk+U1c+optAXJYhd3Il5QturxIGYrazVLVB13ckthqnhGJ8CwqZCgO
	d+hWAmPMmnnxmk6U7JJ55KMaIcWL2zcujaJqfMlXLqyJ17gJDAiIjS+1fyOR4Kq/PEDrSOOGYH0
	BiJX6Lv9tK65ng6lGZiBK+rt+VdMBcVWTSGzbs7IPQ4tVLHBDEo9ZXcF/3yXGMxBuE/I+9jUiWh
	cOMDBW7aXE7qog/rpftSy/Ye3r44234WaDid6VbXSRFBfv/i5wLd0WqM2TdQhePDSewqU/LVttd
	dI+ulZAxIfaBTp1RmSl/SGwBgDptvG83lDJwoKH+kd2OKFAnGtxzH6PhC/pQHXzyEEksSl3huOC
	NtBXx9vCe/wTGr7t0UTVGjyzo09lTupGMaldCfhE8ZcA=
X-Received: by 2002:a05:6a21:a96:b0:3bf:d0c8:2aa7 with SMTP id adf61e73a8af0-3c0bcbc5172mr6875955637.47.1783576546154;
        Wed, 08 Jul 2026 22:55:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:a96:b0:3bf:d0c8:2aa7 with SMTP id adf61e73a8af0-3c0bcbc5172mr6875920637.47.1783576545686;
        Wed, 08 Jul 2026 22:55:45 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d5946sm3184667a12.7.2026.07.08.22.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 22:55:45 -0700 (PDT)
Message-ID: <04365920-4abf-439a-816e-3ae6ff06521c@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 11:25:40 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: eliza-evk: Enable PCIe0 and
 PCIe1 with M.2 and TC9563 switch
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
 <ak5sfkmrhorCY6lf@baldur>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <ak5sfkmrhorCY6lf@baldur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1MyBTYWx0ZWRfX+yoU0BGGl4iS
 XjYxklY0ygd4vNkgUZ0iTf40MsmMqsFLuKUcF/Ehs99FttwmvbKyGGFae0ch2rFCZZxo9mcXqHL
 LzYJDgNx1/DC5cdfJGxGWLcBKbXkJhgmRq2u5o4gnSmF5c4NAEqyV+iJeJ56ieKMNJsGGzNdb2V
 hQRFCfvS+1mTiCPzVdDoQdBjcgKQxafsAmc390JVpeBlNMX86okS17iKkuB9x7EyhHCai9cePw1
 2Y2f1vssULg0TmM1i7UfOg/RzlzRnaDFCPBMQt5LKVkekX7DqDjQV1nVihzX3wqvWvLcQJUmsk/
 AFN2TYVBh4K70KKpGIaAPNLFwVpRWexQzbqDkDkZQgzY1vtbcQcCAslTt5XY3sR6j0TRs5j1h97
 LaTITlECI6upDk/7N8Sfe27g7WZyIXWV3hCDPFehNTx/w022ldGRdURfALIBEDN+KVPRMfUZYJA
 W4eaA3Ums+7ur2pAx1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1MyBTYWx0ZWRfX+Q4dDJ7mCcqg
 0JJ+rgaUNnEzPrDi51KXr77pVRnMBfLVaG7cV4FCjGfAeVGkkAmPtv/7BB6g8baDAIayq5aodVm
 zhUhf57S/RHOq62esiy3qmCJkwygKek=
X-Proofpoint-ORIG-GUID: GwJgAY00VVLVlWRu-pkWn4oLn9625GNv
X-Proofpoint-GUID: GwJgAY00VVLVlWRu-pkWn4oLn9625GNv
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f37e3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=UtvHBniHWTLL8wGpZJ8A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090053



On 7/8/2026 9:05 PM, Bjorn Andersson wrote:
> On Wed, Jul 08, 2026 at 11:47:15AM +0530, Krishna Chaitanya Chundru wrote:
>> This series enables PCIe for the Eliza EVK board (CQS SoM on EVK carrier).
>>
>> The Eliza EVK exposes two PCIe ports:
>>
>> - PCIe0 drives an M.2 E key connector. The 3.3V supply is GPIO-controlled
>>   via a TCA9538 I/O expander on I2C4. The slot hosts a WLAN module
>>   (connected over PCIe) and a Bluetooth device (connected over UART5),
>>   modelled with the pcie-m2-e-connector binding.
>>
>> - PCIe1 (8GT/s x2) connects to a Toshiba TC9563 PCIe switch, whose
>>   management interface sits on I2C4 (address 0x77). The TC9563 RESX# and
>>   PERST# lines are OR-ed internally; reset is driven via a TLMM GPIO on
>>   the RESX# pin. The iommu-map covers all downstream switch ports
>>   (SID range 0x1400-0x1408).
>>
>> The M.2 WLAN module carries a Qualcomm QCC2072 Bluetooth chip. A device-ID
>> entry is added to the M.2 power sequencer so the serdev node for the BT
>> UART interface is created on PCI enumeration.
>>
>> Bluetooth is enabled with this patch https://lore.kernel.org/all/20260529175822.3366535-1-yepuri.siddu@oss.qualcomm.com/
>>
>> This seris Depends-on:
>>   https://lore.kernel.org/all/20260610-eliza_dt-v1-1-7bb72b75fc5b@oss.qualcomm.com/
> Why send this patch, when this dependency is known bad - when would I
> ever be able to merge this patch?
>
> And why are you sending separate series concurrently with dependencies
> between them!? It's one thing to send patches saying "I depend on
> someone else's completely unrelated work", but saying "here's a random
> bunch of tangled patches, good luck everyone!" is not okay.
>
> I expect all three patches to be rebased and send in one series that I
> can just click "Submit" on next time.
Sorry for the mess, I will resend all 3 pcie patches in a single series today.

- Krishna Chaitanya.
> Thanks,
> Bjorn
>
>>   https://lore.kernel.org/all/20260630-eliza-dts-qcs-evk-v4-3-18cbbdba6e7e@oss.qualcomm.com/
>>   https://lore.kernel.org/all/20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com/
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Drop patch 3, as this is already applied
>> - Rebase on top of https://lore.kernel.org/all/20260708055017.A90C91F000E9@smtp.kernel.org/
>>   and remove pincntrl as pincntrl is added in the eliza.dtsi patch and also remove
>>   pinctrl for resx as this is covered in pcie1_default_state as perst gpio.
>> - Link to v1: https://patch.msgid.link/20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com
>>
>> To: Bjorn Andersson <andersson@kernel.org>
>> To: Konrad Dybcio <konradybcio@kernel.org>
>> To: Rob Herring <robh@kernel.org>
>> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> To: Conor Dooley <conor+dt@kernel.org>
>> Cc: linux-arm-msm@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> ---
>> Krishna Chaitanya Chundru (2):
>>       arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector
>>       arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch
>>
>>  arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 228 ++++++++++++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/eliza.dtsi     |   2 +
>>  2 files changed, 230 insertions(+)
>> ---
>> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
>> change-id: 20260629-eliza_evk-6f30686b161f
>> prerequisite-message-id: <20260708-eliza_dt-v2-1-e6281da26408@oss.qualcomm.com>
>> prerequisite-patch-id: 7654ff4f899ac0094a2e791e7f208998fcc7d5fa
>> prerequisite-patch-id: 9e10dfbe360941cdac0300aaf163149755952f9f
>> prerequisite-patch-id: fecce0170351baf00cbe8f6b302d1def4d99bbfc
>> prerequisite-patch-id: 97cd6cb495fdd198f6de7fbe45ef32e4a638ec9c
>> prerequisite-message-id: <20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com>
>> prerequisite-patch-id: f3615b5c1e2222a2491f862a7fba3994058ecc53
>>
>> Best regards,
>> --  
>> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>

