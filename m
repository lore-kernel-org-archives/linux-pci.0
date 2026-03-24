Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021403E0C47
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351674; cv=none; b=JSgU5/r2PWGD+c7y3qiul+EAeEAByzD62I02oUrkP1FOrSkT4lhu5DoUmTi+F4CH7xqTuLbBImSM+8XKkFILM+7TlPYUPZmmkS6fYb2g8oHvdrXob0nEPVPlFMnVX0zqfKeRxqXP9ViutcXjrgiwfDvsgFPz9vB56sql0Ibwx7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351674; c=relaxed/simple;
	bh=RwJReVeMr7oOhdwBTDK2bsllqWVHSJC05e5UZgDQsZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=setkqX81PkVMRLv+FRsNRjcQb31sH2fqY8o9jyFWQxzi87U/o10Ic3yLcjr8vTWnET1vxD9M4b9ABtdeW4U9V6+f6+Oa51vcNEvcZhtEhBrfcSYI8weu65T6JQIHgAd16KlU+GaMMWdoRUfJJ1DerFZIh/7YX2g1GGKvNYigvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dGgwys0S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jv1ie7U8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGgwys0S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jv1ie7U8"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OA9uE73634389
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 11:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oafjRMkd9gEOQWb2JRWS05Xn+cKR98MMSWwCJ3aCD9I=; b=dGgwys0SF9G8AiNf
	vPdr6j0h8O6G/27iH8Hj8FBKuADTGuew91wMl7N/+vPKnCnFTEfhlRCl7PKUzLuz
	PBo7NxRHiKONYWULZzZEYB7Uk0XwBrHeT0CjXDohAR0hhK0Nb4UyC96v6Hg60pSO
	2QKmgO1U1yIChAUZVKN/C+/CvwK9WgoJQh01pKydDpFSVXF0xN3iglARB60qVNwF
	9uxUfz/InPEGZzPEkm0NUIf/bD2/ZN3r0eJQ1IYuKWJXDtB6G6IeuullnEhjUWPA
	g5LkaJe5Xn/W2m8RwyUYbfDuBkpFlGve0LEytNxOaDSApGfZcc786z5QnPOpDNYz
	7wYRFw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34k4msqx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 11:27:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b2d15c360so40343671cf.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 04:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774351671; x=1774956471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oafjRMkd9gEOQWb2JRWS05Xn+cKR98MMSWwCJ3aCD9I=;
        b=jv1ie7U8LAKILmJLzFe8h+I4axEhu7gZppPY/zM/dUXNj2PcEknfnra8dyftbHLk16
         GA2zPh0ccT00sjWRbXNQUUSjnx2WtgHSAuocZt1+GI4Heb+bMQ8PeGH21Bq3unRfAnI7
         C4iunpEB8myOI9476PtxxOHNhu7vq8N8MUQkICwrp7MHs9Z6reVyH/na6ToCF4t/eBzK
         cCOPkE13Fho4JJEnFg4Xw4YsWkluZh3l71i3MKupCTW5N2sEWpduOv1oE73knqdgSOFS
         bD4K/QMAOCo/K6AmSWgXIyVQYRV42fo9icS+Z/ecMCUyvws797gif3N1+eQhwOLDYz/Y
         Exkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774351671; x=1774956471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oafjRMkd9gEOQWb2JRWS05Xn+cKR98MMSWwCJ3aCD9I=;
        b=UqszvQLM7odoriWapNHWYb934INjV+iOVpQfcerPk5sk02SRYQ2iVISmS4zLwYBagI
         /GM08anubW3L7iaQI6MVM8JYgEpIHIrplSEG/hxmvPGmVU9tb4a9hDMRWLbNFlQAo65U
         C0l/t+JLhomTJ49UFXziFtSlJGdTSCq0GdcbsoeOamQV4tpjUkoxc1aWG0LSh9Cyd4oU
         uB35HWO0wIBewTjkQ1KPqo/ibGVpTmwtCa7bj3a9luT9bx0Ns+JFioODC3Rfw+hMSkXd
         XIrfwcMUShl1EO7ET5/bx+G+aFX8cCSETNMqtKvgD7i4n065s3z7HbxmWzDnUqFOnhu+
         0x8A==
X-Forwarded-Encrypted: i=1; AJvYcCWrWxK557iCe1gauXmeVxC3OY2tekeCOAMpeZ/pKwgVQNnAvY0HlMzlAqzxeKWFuyQzIqwLDq2wKoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0e7M3+DLsXAq5lHrB5KQdtlrXwlsHDomrF5THK4lI/9HyuX8
	/jRaBcqYOFanrMClbRRopHq4Uuv7FYT0VRHg8Td0/dgf+Cd8a65nv4ZlSjxciBcQ6ct/3LC6xsI
	wPDquXmI2+6blPRyBupDFWE0elLEUiyeO8IH96I9qcfA3F6F1bzmTGqR76r8Opkw=
X-Gm-Gg: ATEYQzyhRBnkMIC22jqvz563Wq5L8JzE+fU2H9708Ftrs/snIJn/Se9BPLtTveDP/Uy
	oKEq39An9GJdUFcBbDf7JPETc/HIn/kzfgkyxjcYg1UIp1bQvx0/IciNicEMzACZ8GAbvURSo9+
	SuWxSR5nO82U+81KcQG9gZynaC8ZbCA/jwI8EyHmH01kywHrtWSjUUbO8dmKw9D/Bx0ybrtu2T3
	YvFVVbjc+8zHT8H8yT11WY2Ja2R7R8TThdYWWkUyStguXOjrjgca6UuUEg4UBVlnIcigj8Tt2Gx
	oQnOdXDjv+8OA9BWHVS/Rjb3AgZFVwkZP79oZZLhhYl6rjpRvWf5vrReg7Wo8mv1f2WgLhENZXV
	rTXtfKM3/vyrjQNnmACgK4IhAueLtSbxDxtI/6sGORQ6+DvTirH1kibF0D/9kZ4yrOP6eO99jqS
	wl4z8=
X-Received: by 2002:ac8:57c3:0:b0:50b:2f83:b702 with SMTP id d75a77b69052e-50b37505109mr184563701cf.6.1774351671161;
        Tue, 24 Mar 2026 04:27:51 -0700 (PDT)
X-Received: by 2002:ac8:57c3:0:b0:50b:2f83:b702 with SMTP id d75a77b69052e-50b37505109mr184563401cf.6.1774351670653;
        Tue, 24 Mar 2026 04:27:50 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285305085sm3104682e87.59.2026.03.24.04.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 04:27:49 -0700 (PDT)
Message-ID: <e07812c4-c618-46e4-81c5-d387d91f615d@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 12:27:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Advertise hotplug with no command completion
 support
To: Manivannan Sadhasivam <mani@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260314-hotplug-v1-1-96ac87d93867@oss.qualcomm.com>
 <t66kmmr22z5anjhhez3mwfbmy64pz5246e4oepvpwf5j5l3u5o@i3gsh22x4dst>
 <015d00db-9ed5-45a7-83f8-1b10bc2ee457@oss.qualcomm.com>
 <e94f9da7-3daf-4393-9455-6707cb963e0c@oss.qualcomm.com>
 <4649cbd8-7128-4c24-8d8d-c12bfd2a677c@oss.qualcomm.com>
 <jhh5xvjssci4z53vsvskyp7327sgit2z7gqu7kra7e3nkaa2r7@rhe74dh2z3sa>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <jhh5xvjssci4z53vsvskyp7327sgit2z7gqu7kra7e3nkaa2r7@rhe74dh2z3sa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rzHYNWS6JXpmIvrL8treHU2vRAF4nuwK
X-Proofpoint-ORIG-GUID: rzHYNWS6JXpmIvrL8treHU2vRAF4nuwK
X-Authority-Analysis: v=2.4 cv=c+imgB9l c=1 sm=1 tr=0 ts=69c27538 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Ca1UC_GKNUODAY3tWcwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA5MSBTYWx0ZWRfX301A7TFsRlPi
 GYW/ZprGo+H4YMb27dMprG11xlBcsVDzJJbIFzovBGbJNcvt1uWVOD1ieM1mpgDpHddaccidak5
 mgE0qyJi8jQTaWdKHi7kc86jnGMUrcsZ4r8jtAtPOD1wf2Sy6N6P2jXY5e7QsT4/k26LWKYGQTk
 o+YChkob7BT1TPVFCKU3BXfAa8nGz1EmdCH8foGKdKseKxBPuB6tN0fIPz16ElxsAJAG6oZixwq
 sZrHjWmY5hlpFkV1MlVQdkddFpCBFsmC3o9arrA3O+1WFg9GeoXcpGOzzQLwRNhfjPkZVOxTEK3
 GmedyJ6eMt/SITq6mPvzqEiNBw/WJTdt5dkC19rjAbXW9y/sy8v89QeLyPgUqTjAhV9bDX0K4+y
 bf9+cnerXzxK7as4/iVgRkSUNIG30Lcc/3IM6bcZuY8F+4MBZKvV9PtDM+AC8KHq2dX1QrUv7Q7
 QV+I9PlFiet/2wmN03g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240091

On 3/21/26 1:01 PM, Manivannan Sadhasivam wrote:
> On Fri, Mar 20, 2026 at 07:10:19AM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 3/19/2026 4:29 PM, Konrad Dybcio wrote:
>>> On 3/16/26 1:22 PM, Krishna Chaitanya Chundru wrote:
>>>>
>>>> On 3/15/2026 3:39 PM, Manivannan Sadhasivam wrote:
>>>>> On Sat, Mar 14, 2026 at 07:26:34AM +0530, Krishna Chaitanya Chundru wrote:
>>>>>> QCOM PCIe controller advertise hotplug capability in hardware but do not
>>>>>> support hotplug command completion. As a result, the PCI core registers
>>>>>> the pciehp service and issues hotplug commands that never gets completions,
>>>>>> leading to repeated timeout warnings and multi-second delays during boot
>>>>>> and suspend/resume.
>>>>>>
>>>>>> Commit a54db86ddc153 ("PCI: qcom: Do not advertise hotplug capability for
>>>>>> IPs v2.7.0 and v1.9.0") avoided these timeouts by clearing the Hot-Plug
>>>>>> Capability bit entirely, which also disabled all hotplug functionality.
>>>>>>
>>>>> Just some background: I added commit a54db86ddc153 to disable hotplug for Qcom
>>>>> PCIe Root Ports since we were seeing completion timeouts for hotplug commands
>>>>> and also the PRSNT# signal was not exposed on any of our SoCs. After checking
>>>>> with some internal folks I learned that hotplug functionality was not exercised
>>>>> in Linux. So these facts made me believe that hotplug was not suppored at all.
>>>>>
>>>>> But it turned out that the Qcom Root Ports support "Data Link Layer State
>>>>> Changed Events" such as DL_Up/Down events.
>>>>>
>>>>>> Instead of disabling hotplug, mark these controllers as not supporting
>>>>>> command completion by setting the No Command Completed Support (NCCS) bit
>>>>>> in the Slot Capabilities register. This prevents the PCI hotplug driver
>>>>>> from waiting for commands completion while still allowing hotplug-related
>>>>>> functionality such as Data Link Layer state change events.
>>>>>>
>>>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>>>> ---
>>>>>>    drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>>>> index 67a16af69ddc75fca1b123e70715e692a91a9135..a2924610f3625f2456a491473c135840e31bafb9 100644
>>>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>>>> @@ -358,7 +358,7 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>>>>>>        dw_pcie_dbi_ro_wr_en(pci);
>>>>>>          val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
>>>>>> -    val &= ~PCI_EXP_SLTCAP_HPC;
>>>>>> +    val |= PCI_EXP_SLTCAP_NCCS;
>>>>> Are you sure that this is the only non-supported capability? What about
>>>>> Attention, Presence, Power Fault, MRL etc...?
>>>> Even though there no signals required for attention, presence etc in the hardware
>>>> there is a way to generate these MSI's with these bits set through parf, so technically
>>>> so other co-processor in the system can trigger interrupts.
>>> Are you saying that the RC itself will not generate them based on what
>>> happens on the bus, but they can be triggered artificially?
>> Yes there are parf registers through which msi's can be triggered
>> artificially.
>>
> 
> As Krishna said, it seems there are ways to *inject* these events through
> platform specific means (through PARF register space), even if the associated
> signals are not exposed to the slot. And we might end up using those events at
> some point.
> 
> So it is OK from my opinion to just disable NCCS. But this also warrants a
> comment in the code.

Alright, in any case, this is required for PCIe-over-TBT hotplug without
tapping into the "global" irq

Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # Hamoa CRD, tunneled link

and with the comment added:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
