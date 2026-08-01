Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C54823DD
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785598277; cv=none; b=DjoBAeQqq+hq1FsRovKXRQ1/SbPbcEyKJDR+lMHGGUy51QPP5+3AsVwf9IpOEHjgPJsD7Jiwu30AKzIr0kHPFuVfLkI6cRcssDvx+fR9ag/pVviCE4UgJ9eVhzSFhV47JkSzTmy+Mo3Ps1q9wx6Pv6VbypGFH/GM7eyM5oIVvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785598277; c=relaxed/simple;
	bh=cllhpSoTBATTCyh6elfcpjdRCcZl+Fb0bW4cyY0RKsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVd0xltTUxomxcOi8GryeCEP+UcWdSUwpqXHVpvnqY19EciBDEk5GrJ111McHa7oBRz1D04UMMaTTbqaWL7DPQq9IUwpRAlZkIjeEp+CtS6TvBEDRSKjSnUYUdcXihDresY+uGeaiePX1jl9SyI1vFtMf3BZ4pdKh4X0R5+z4Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k+adehg0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P59OxlqQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k+adehg0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P59OxlqQ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671CaeqF4116929
	for <linux-pci@vger.kernel.org>; Sat, 1 Aug 2026 15:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nnbFUSqoIn3TJyknzi6e2bgEnjK0MawKfFYTi9Tjhgo=; b=k+adehg03UAUr5n1
	JctvDcfY7rn0lfO2WuMar7imWyopKdZHuuXBuuznxhnOvYvd2s1mFKu0NMrssH9X
	zr9TL3LutGkMa9OMj5qMxiJNAHET4EHvjwihg43cMC9Vjz/YMNkJKl2A/DmM3GmH
	pqaUCT+jRyt5Dh4F11r5dD0Dulwxd6DbrLzr5iOpogeDrO6FgYaD6WYufZDBMN5l
	pnKVetdDJz685cfI04X2l0e8kNJUCvBm2ZLRoIMkliQKnquhhCYREaDhYTAU1fCN
	/HVLV2YJaNJtA02YiO/IOpm/lEidgABwr/We9V6G2LZKwIDfAGBRP0F9aXVlpDKe
	iSIwZQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8pg15ey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 01 Aug 2026 15:31:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb6ef846b33so1315843a12.1
        for <linux-pci@vger.kernel.org>; Sat, 01 Aug 2026 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785598270; x=1786203070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nnbFUSqoIn3TJyknzi6e2bgEnjK0MawKfFYTi9Tjhgo=;
        b=P59OxlqQ+LClSh3B6RUS+jF6Hc4uugXp7EYwp5bBDOeNnpKswxOipoxKxfoEz5tpNn
         +w0+3JljZx+GPZVHAzHSiWuQULZovwUlVHFmtGf2kGT1RaxtDNeXRvy/ZYSfL0Vws/Gs
         b8+CeachvFP2Vg41Y3cjKiI8aLszJnOYrIV3GyVqx61K5GQMd54S3+Ul23iufZS98bCh
         Qk/o/YkUIiQdzxwCt8MOlMrpLSre7uNOA0a6w0mgIT3qLwn7Yy5arl3w71f+eoA7Q43B
         wWx5Et3XzjNVDtUCK9KBcpKlksw0eZ0EHnEUL0bYgsfKOuOBO4CB5IFdKeJzX/3yWGhi
         7DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785598270; x=1786203070;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nnbFUSqoIn3TJyknzi6e2bgEnjK0MawKfFYTi9Tjhgo=;
        b=ZCxqhV8gPCFQEAllrOEnavhCjyl857ZK8FOGd82u0rXkogRaHVP9OLwEISwDzXYIuX
         JWGYoNVetVZVEEU0vnshC5H2EC8sy9nI76wb1KlgEEOnyaSMeYXhwkDkhijLEc29Av8g
         jxzQpV6Ps5l2OLOwAztjHJ3i3GGLypTcKs+o8m9u9ok8mXPHTyk6y2daWi1tzip72+Aj
         iwEPq28Kh2JXPuMI20arjiLiTHjiRm0OdSWC0WULpRRtdIsEjeIeGU39r3yVbEGLBhtV
         UGqzX5p1OopVdOxmkZtijbFJ999FbkSxX/wRyP3xpOYDxMTD0nTyjdOoec4WLiYNxjzc
         8/mA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8tHgaKVFHuEDBurHwMg1RGVrfeFsVCs71Qn3K4sN67h5GsPmZiZjXs8E428R2pcQuX9vsqTJem+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDvq/xnMCbme6GqHvVo1Uq+xiNKYmOYzOD0bBVuesp+wHZahhS
	kMqfvLedrrnOKZxCWMM1iC3c4GVVwv8cJEn0zqf2HjRqxXXlVy0yE2DKRl0YPRcOHQ8kLsUhbnR
	CpnMsZEPpuUxSBe1FHLHE6zVEM9z1IJjm6RKLeNZiBJsxp71q716861ZZnNGyIGs4KWsqtGw=
X-Gm-Gg: AR+sD13pj9e/lEXcUTqg7vXmpfrc6KMMeLfBRNtJ2/7QyMPCq3EjZWTuCQr/1sRaLRf
	m8Qune1wR4EG4Og8DFPM+z/CnYJmQN2UdHev+GWHj6C//RKsO8sS/fLqWVeHcjk6AUj4v8fWRn3
	a8UbQ8tLAVtNIN31Ni7Sc5Ui5EnN1G+bf4TzpZqAdc+ZMgKUkwIH3bnEhRLjspbqp6iDNQV1NXO
	CnJZVcxXOVfMQ6zx8I1jx2hnrNArnT4/l9youjuI864zkKHaILGx8lv5IXxYt+QOJUPA3O+u1FT
	aZ9C9fZi3x8JonFg8Pdqlhl+ZcPxArnV2s+g78MZx2o08fbqTBSJHEglVriPax/DRP2O05uDgVD
	G8Qn4QpGvjCCNfIIynLOj5TFjDp3B
X-Received: by 2002:a17:90b:17c5:b0:385:39ac:fe4b with SMTP id 98e67ed59e1d1-38fb263d5admr6158885a91.17.1785598269573;
        Sat, 01 Aug 2026 08:31:09 -0700 (PDT)
X-Received: by 2002:a17:90b:17c5:b0:385:39ac:fe4b with SMTP id 98e67ed59e1d1-38fb263d5admr6158843a91.17.1785598268995;
        Sat, 01 Aug 2026 08:31:08 -0700 (PDT)
Received: from [192.168.1.7] ([122.177.240.1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4e44bcsm20902752c88.12.2026.08.01.08.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 08:31:08 -0700 (PDT)
Message-ID: <4523441f-498a-4bbd-80f3-97a7a9206c00@oss.qualcomm.com>
Date: Sat, 1 Aug 2026 21:01:00 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
 <20260731-first-righteous-bear-dd72ed@quoll>
 <712f8a14-d2a1-4a90-82f9-05cd694f2658@oss.qualcomm.com>
 <c1875dd6-fe3a-4a69-a6fd-b461c8fba6e4@kernel.org>
 <6d6465bb-47ac-464c-af4e-0ca72325705f@oss.qualcomm.com>
 <8a388310-d3cc-4d02-abb6-0eb98c24cfce@kernel.org>
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <8a388310-d3cc-4d02-abb6-0eb98c24cfce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jHmj-E7TwX4iniDSbUiaburaaxe8tEBA
X-Proofpoint-ORIG-GUID: jHmj-E7TwX4iniDSbUiaburaaxe8tEBA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDEyNCBTYWx0ZWRfXwS/p4ezJUtgJ
 pFo7CheiWmxtm55NbNG7TgdjHvqHulQ8PCAwC3Yfy1FIEP0JJND46Yi2AVjZDI47RL1/mDE8D6q
 1hFY2PcAeV7+bzNFFuinOoZ+CyAPPHw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDEyNCBTYWx0ZWRfX8Dj/3YwNQ/LD
 CP/JITTNYGMyPAj5kAN8Ws/G26qBxNLIY/R2QIqcmKnXMiz+6+onuD5v1tRUJ13w2Tq0UIlf6Ng
 5YlPB33AC8v8RXDMHFThjYHO6Xl7aERlLV0JYdTOTqC9dSc3iP9pJnUFDwFRpA/wOlYppQB4wlu
 9ezMhiGUF9RCvA8Dt6z9CZvypLc9gs9cpuo610oBtisFCMxLkTGvTbrq7XfXHDpYnULCo18fclF
 7yEeBRQ8+m7/Nz+gnBz7YLWvszWETN/RZnN6l0UJpY8vcdFv6bLQH2EmJ3d+HZC2v7lQK/ggI13
 WiHAZxevOslk9uHTIipM9fgWMuKsAz3UZXl5M+qN1a1Ramrlzd3h+QuW/C82FsXhBTxmhrU6H5h
 zMsht/e3E7w3dQsT1tOI9ftRyk2Nthh4VXjqKJ4a0KVXBmksBKYV4RAaSpMbKrMZcPfnSPoz3n9
 ry5epWD/8wr0WfzZGrw==
X-Authority-Analysis: v=2.4 cv=U4Oiy+ru c=1 sm=1 tr=0 ts=6a6e1143 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=2skDqgroqaW2kJZUe6+7Kg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QZOgD_54N6fV3tg6C9wA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_01,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010124



On 01-08-2026 20:18, Krzysztof Kozlowski wrote:
> On 31/07/2026 17:51, Rahul Samana wrote:
>>
>>
>> On 31-07-2026 20:34, Krzysztof Kozlowski wrote:
>>> On 31/07/2026 16:45, Rahul Samana wrote:
>>>>
>>>>
>>>> On 31-07-2026 15:16, Krzysztof Kozlowski wrote:
>>>>> On Mon, Jul 27, 2026 at 09:15:01PM +0530, Rahul Samana wrote:
>>>>>> QCC2072 can be used on M.2 E-key cards where the card power resources are
>>>>>> described by the pcie-m2-e-connector node. In that setup, the M.2 power
>>>>>> sequencing provider creates the Bluetooth serdev child after matching the
>>>>>> QCC2072 PCI function.
>>>>>>
>>>>>> Integrated non-M.2 designs need board-specific power resources. Document
>>>>>> only the compatible for now and leave those properties to be added with
>>>>>> matching driver support.
>>>>>>
>>>>>> Document the qcom,qcc2072-bt compatible used for QCC2072 Bluetooth
>>>>>> controllers connected over UART.
>>>>>>
>>>>>> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
>>>>>
>>>>> NAK, exactly same comments as before.
>>>>>
>>>>> Nothing got improved, although what is weird - original SoB is gone, so
>>>>> this is legally dubious work.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>>
>>>> Hi Krzysztof,
>>>>
>>>> Thanks for the review.
>>>>
>>>> For the binding contents, I tried to capture the current scope in the binding
>>>> description itself. This series supports QCC2072 only as an M.2 E-key card,
>>>> where the card power resources are described by the pcie-m2-e-connector node
>>>> and the M.2 pwrseq provider creates the Bluetooth serdev child.
>>>>
>>>> The binding also says:
>>>>
>>>>   Integrated non-M.2 designs require board-specific power resources. Those
>>>>   properties, together with a static devicetree example, should be added when
>>>>   integrated non-M.2 support is added.
>>>
>>> Bindings must be complete and your driver support is irrelevant here.
>>>
>>> If you claim this is a PCI device thus you do not need any resources,
>>> then the binding is not needed either. PCI devices are enumerable. And
>>> to prove it: look at your DTS. Do you see qcom,qcc2072-bt being used? No.
>>>
>>>>
>>>> We do not currently have an integrated non-M.2 QCC2072 design, so I do not
>>>> have board-specific regulator supplies to document for that topology.
>>>>
>>>> Could you please suggest how you would prefer this binding to be handled for
>>>> the current M.2-only use case? 
>>>
>>> Drop the binding, you do not need it.
>>>
>>> Anyway the problem is that more comments were ignored.
>>>
>>
>> Hi Krzysztof,
>>
>> Just to clarify the reason for adding this binding in v2: 
>> v1 did not add a binding because this series only targets the M.2 use case.
>>
>> I added the minimal binding in v2 because checkpatch reported
>> qcom,qcc2072-bt as an undocumented compatible, and I interpreted the request
>> to fix the checkpatch warnings as requiring this compatible to be documented.
>> I also had the earlier feedback in mind, where the indirect
>> qcom,qcc2072-bt compatible was pushed back because it was undocumented:
>>
>> https://lore.kernel.org/all/20260703-eliza_evk-v1-3-7624440bd76d@oss.qualcomm.com/
>>
>> Based on your clarification here, I will drop the binding patch in v3 and
>> keep qcom,qcc2072-bt only as the pwrseq-created child compatible for this
>> M.2 case.
> 
> My previous statement is also valid, please read entire threads.
> 
> You cannot have undocumented qcom,qcc2072-bt.
> 
> I ask you to drop both, because they are not needed. But feel free to
> prove me wrong, see my first paragraph in the previous reply.
> 
> 
The PCIe M.2 power sequencing driver, pwrseq-pcie-m2.c, uses
pwrseq_m2_pci_ids to translate the enumerated PCI function into the
Bluetooth compatible used for the generated serdev child.

For example, WCN7850 maps PCI ID 17cb:1107 to qcom,wcn7850-bt, then hci_qca
matches that compatible to select qca_soc_data_wcn7850.

For QCC2072, pwrseq-pcie-m2.c matches PCI ID 17cb:1112 and creates the
generated Bluetooth serdev child with compatible "qcom,qcc2072-bt". The
hci_qca driver then matches "qcom,qcc2072-bt" and uses qca_soc_data_qcc2072
as the controller-specific data.

That match data is needed by hci_qca to select the QCC2072 soc_type,
firmware/NVM naming, calibration handling, and capabilities. Without some
identity being passed from the PCI match to the generated serdev child,
hci_qca cannot distinguish QCC2072 from the other Qualcomm UART Bluetooth
controllers on this path.

Please correct me if I misunderstood the concern or if you are asking for
this identity to be passed from pwrseq-pcie-m2.c to hci_qca through a
different mechanism.

I can drop the binding patch, but unless there is a preferred alternative
mechanism, I think we still need the pwrseq-pcie-m2 QCC2072 PCI ID support
from patch 3 so the power sequencing driver can pass the QCC2072 identity
into hci_qca through the generated serdev child:

https://lore.kernel.org/all/20260727-rb3-industrial-bt-uart-v2-3-2d100f30e202@oss.qualcomm.com/

Thanks,
Rahul


>>
>>> And why this is sent so many times?
>>>
>>> https://lore.kernel.org/all/20260218114955.3970974-2-vivek.sahu@oss.qualcomm.com/
>>>
>>> https://lore.kernel.org/all/20260529175342.3363935-1-yepuri.siddu@oss.qualcomm.com/
>>>
>>> and now by you.
>>>
>>> How many times this will be sent in separate patchsets and asking for
>>> separate review ignoring previous review?
>>>
>>
>> Regarding the repeated submissions, the reason for carrying this forward from
>> the earlier QCC2072 work is documented in the cover letter. This series was
>> intended to continue that work for the RB3 Gen 2 Industrial M.2 use case, not
>> to ignore the earlier reviews. 
> 
> If you continue the work, you do not ignore previous comments, so I do
> not see how this is any sort of continuation. Looks like duplicating
> work without looking at previous discussions at all.
> 
> Best regards,
> Krzysztof

