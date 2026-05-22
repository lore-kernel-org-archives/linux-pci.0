Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FE03C456F
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443295; cv=none; b=lojWXNFiH9HQCy3U8XcLjg+uDGut0bffjzOgzIUf1Tm//fw7EYi7ILB5+dTAQJ4Kchp/NMeDdYcNAM9NOYl6CvfKETmO4QpspwtmWE3uKtBSHENJ866Wz/xZydRWzwo1WF5IpMy7bvLoL1jFnKFQqTyupAMbqgv6ND6mBnHyY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443295; c=relaxed/simple;
	bh=fnA6TuXjxoD/qV1B06x19WzNk1sYIqRGpslMrz4epBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEajAtKZK0VQnXL9Odk1QWelhg+c9QpXoVh1dE5XUTX3l9hIWhHKm2MMUxr0kZiJIYTMCgaXQq6H7r0Pof5r/O7T+p7i8yr7LWruj+LP+V4z24pJ6lxHVaCj2xRm/TxDLuekFlZWpa6GXMMc/BcxaoOfyoIMCWo8iwPAHIChy8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KyS96uHt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FWow4lY/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KyS96uHt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FWow4lY/"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8dPZJ3673672
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 09:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nxeYY6u/8efyIE6Ut3SOnhqR/Qrg6Pv6nhSejVY4/Uw=; b=KyS96uHtCkpE5n1Z
	uc5oOH2s/296hUuAs+RcnFf5CRcGGR0W1W/RqqXGXFjFSrCdXpqIS9TQpFRfaeu2
	M7avenXbaIkD36PAsueW5xEC8uNDvHthDDNVtLilgy+0nWZzwuVz666xJIK/j/Ju
	Yi8+/sVa5vCxoSxOIrHUlwGypi5MT08n/aXvSeBo8kr0wYhmiE1/vfqg0nZKrcwg
	iAcRaxhkUC/exClJOVte+fVM0XwOuCpagD46sVONTbrrOm0HxydVxvmc5Csfdy9J
	FVfvpNuMDJCZOAvRJ+3DiSFZBu9muHQ0KjxjoaGirewuTp69oeOZculMhDZjVrS6
	0/QqWA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea4dc45d5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 09:48:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50e62562b6aso21590381cf.2
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779443290; x=1780048090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxeYY6u/8efyIE6Ut3SOnhqR/Qrg6Pv6nhSejVY4/Uw=;
        b=FWow4lY/160LIc+An86OAeZoQBZq5ytgpJNyeF69bMPhbCb7Hsi33CavswpILh3qVc
         7vzvkC9EbNMra2mVPyD5QhNm9ZfJrfs0tmOA+Pc/EI3cqA1VQNdzhr7RglgB/P2AcoR8
         85O6IqdHrLCKS3/wKuvB12quJa4zlG6qmQr0MnPJ12Yoab+QVvDhAQuTQ1SIqcFkQFmY
         B8jB3+cPQroCcMEt2sBD+ByjAtUTfxg9gfQugOUzf1s9ToVMoFXc46Twe/DRIbU5Nd/x
         jpk2La1i9VEmJ2ocrErDwAmDfs2JoJsGujV+oYhBJ9O30CwG4XguJcAtsFfSCcY26fT1
         hdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779443290; x=1780048090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxeYY6u/8efyIE6Ut3SOnhqR/Qrg6Pv6nhSejVY4/Uw=;
        b=FmUNKXvU1FI9iGwdVD1Y0ssY/IpvT41UZlZ97ZU88+chHRu1PTQcOYAL2BI+XNcWpL
         tRYs2E0e1QFM0U6Qhdig+7DEC5nOhXSnqWIuhtGTddEJRS6YnoUKlzMb2wYGecY9Yt2m
         0hJU3k4gIYDKswf7QCgdM0GAFWqd8Armgr9xz/iPAAA9976mLY31TUSi7W3+jC7BOXYm
         bYfKIcGG3Afi6awNcanLlRhOxl3LltnUdUNF+HiZIIuCpT5nJWql9OsT4sYT7H5TlpHp
         bMtXYOsObFDrSN+bmXQ2zuoQkSQ2dfu1BGKiu9Ox/BsdlxzBvDa9Wj3X8GSPpfTaVr0W
         b+dA==
X-Forwarded-Encrypted: i=1; AFNElJ/XlNKSELSQL7932NqXxB03/TFMZmnKNwgoiFCAV+kieMFshYxS4YJ95EsBAhj/S/dLjtaSNc+SNao=@vger.kernel.org
X-Gm-Message-State: AOJu0YywLRBAd5yhWI303mU7Bv8ZmlK9IsIRBe91Hclbves9qO8ue6Y/
	7UWqRqGkA+TwF1qzAtdJBk1ntAM310MTUS5B3GiYYn24r176k+Gn6PkDkazu5wFjvKJxlg3th9F
	a2TjPFx0AWo2emYPETVenjlFoSqVg3jTr/49/20eae1Q7V5f7WU9nXvZD23ilBk8=
X-Gm-Gg: Acq92OEStZsrFU0chc6HRwqRgvv76KR0CACgdkDQqP9XI45kBPUQNlUjmMwqUfMeICB
	S/A6bZagrBGLZAMl/QZvSSrQkSti9YlkniUdlfRPyEnDevc4YtAG7a5yf1a+YnpPO2VcyAzOSqD
	OOjz8SxMMB14ReULXR0QHa0PYNuR+BCHhdUF71DV+6IDJIaLgC2xrlZB/j0ggTvciAXRqG9MKwq
	/RBxjZKgx4U13OftLrJsXjqTpr3ilzoZkZ+Rz+8Z+tMgsQVG6dJlGfoiQPEONuIVq8GEovoz++O
	pR6miw96T1BPanCLWWzDku1zL7yqqsm63iCl1fTvIvaBHlDjyLEtGCJ4a27nyEpAxBDrtFbJts4
	0exLVCK3EiI35ffVc5r5iWdMl1i0t2ZHENfGbfP1SBskFow==
X-Received: by 2002:a05:622a:6116:b0:50d:9138:3322 with SMTP id d75a77b69052e-516d43f5402mr26315421cf.7.1779443289734;
        Fri, 22 May 2026 02:48:09 -0700 (PDT)
X-Received: by 2002:a05:622a:6116:b0:50d:9138:3322 with SMTP id d75a77b69052e-516d43f5402mr26315241cf.7.1779443289307;
        Fri, 22 May 2026 02:48:09 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc3652b34sm36909566b.28.2026.05.22.02.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:48:08 -0700 (PDT)
Message-ID: <24f84ae8-6099-43a1-91a9-b50a0aaeb3e1@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:48:05 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
 <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
 <CAFEp6-0A=LrU44pu2rfUqXW9k9peSu=b2qq_FVs4WZUj-g4pDA@mail.gmail.com>
 <n6kl7y47hztf7tgtdxhakpekwkxlleggv4sbzpsd2ncpill6ii@bdk5esjubv4t>
 <CAFEp6-3Gbd1gzfeu5xdfBJixL6JXaoSFkRUsBjOji0ZEOHHyvw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAFEp6-3Gbd1gzfeu5xdfBJixL6JXaoSFkRUsBjOji0ZEOHHyvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VefH+lp9 c=1 sm=1 tr=0 ts=6a10265a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=aCkQYJryizutyd-nL94A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: NmoEQ-Zx_vkRvOyXR-m9WvpKFXwUwEox
X-Proofpoint-ORIG-GUID: NmoEQ-Zx_vkRvOyXR-m9WvpKFXwUwEox
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NyBTYWx0ZWRfX44FCRD5yzAo3
 K7is3gO9CdqgHXIc0LZeazhGKzrc+bImDy09mbj+Xr6jJI9r4A1kNpE2MgpMchr4eu3OozenB9l
 WpAjPDFiZsrPNCi5Y5WEp+sbQT44qUuinN+qIaL/hFmLJAW8jkizefWz7lvtT7HkgI+JPfeD65v
 EZw5CkBox3XnzdVy+L7xXWCFxdD/3AQAbVTw3uJsYd+P6KYt9PmMiAFN0lKe+6aYlXH76u0PUqr
 kJ/Z1rSGS6apgUR4xsGW+ALttB7XbQFS1iOl+QGGn1mpUPVVdM3eEu9s5ES+h8XpqTYadGN1v4R
 dya1NXCJrKTT+uWRz9/ujp0b51V0Be2paf7oN68gBdqEDEJ7OmGGB675kVeqPXg1IXulODEgH7S
 2GxwtnLy1hK89Yf1OLQu+vqxHuKwyNcEMCWuU8aNCL5lk2gDKlTL/nE6jMZSHlh8UnGo202kC3P
 m4Icwa2dt3FRU3nOyTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220097

On 5/20/26 4:41 PM, Loic Poulain wrote:
> On Wed, May 20, 2026 at 4:36 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>> On Wed, May 20, 2026 at 04:29:40PM +0200, Loic Poulain wrote:
>>> On Wed, May 20, 2026 at 2:34 PM Dmitry Baryshkov
>>> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>>>
>>>> On Wed, May 20, 2026 at 01:01:44PM +0200, Loic Poulain wrote:
>>>>> Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
>>>>> Arduino VENTUNO Q board. The module is interfaced via LGA and is
>>>>> compatible with the M.2 Key E.
>>>>>
>>>>> Add wireless-lga-connector node using pcie-m2-e-connector binding,
>>>>> connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
>>>>> the Bluetooth interface.
>>>>>
>>>>> Add pcie@1,0 downstream port node with pciclass,0604 compatible so
>>>>> the pci-pwrctrl driver can acquire the power sequencer and enable
>>>>> the M.2 slot before PCIe enumeration.
>>>>>
>>>>> Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
>>>>> (gpio56/gpio55) used by the power sequencer.
>>>>>
>>>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++++++++++++++
>>>>>  1 file changed, 65 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
>>>>> index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb6f07244d185abfb1976d9 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
>>>>> +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
>>>>> @@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
>>>>>               enable-active-high;
>>>>>               startup-delay-us = <20000>;
>>>>>       };
>>>>> +
>>>>> +     wireless-lga-connector {
>>>>> +             compatible = "pcie-m2-e-connector";
>>>>
>>>> I think it was discussed that LGA can't be an actual M.2 E-key
>>>> connector.
>>>
>>> I am not sure I followed this discussion. Do you mean that I should
>>> introduce a dedicated LGA/vendor-compatible string in the compatible
>>> list of the pcie-m2-e-connector binding, or that LGA-based designs
>>> should not be described using the pcie-m2-e-connector binding (graph
>>> representation)?
>>
>> I think, it should be a separate, vendor-specific compat (maybe using
>> m2-e as a fallback).
> 
> ok, understood.

Oh, I reviewed this before looking at this discussion.. yeah Dmitry's
suggestion is good

Konrad
