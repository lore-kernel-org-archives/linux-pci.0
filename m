Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794620717;
	b=HgGliNXLzfbS873qQ9yDjkYcmLiafaNAeyY+KmI3YAwmuLTRAB0Gck4wFxR8REvIG9Vu
	 jMtMwWJqu8zmZA9jMBvaUcD4W6x0ygMKkAtSboQMpueUIgYmAkUtK8AwNbBdTOhKrUKnp
	 fHMkmVhFHG7BpKF7QvMTnFhvXKbW6mBUYZdwhBNWAmO+WLS6LoqYiIhNBe4jXbA5b35UN
	 925XBiU0m5puHhdrXSWGZ97rXwPZxPOT1e36Tshb0D/qLlTMHMhLYQs6aqC6CNxhY3GL6
	 cLGm3NDXrpGaia94SpR66hbG0bD9C7HEqeWHIdLgKw6fdFEUSpAhdGhI1/nYobgPnPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794620717;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ksBTzPL1XwcvZYRdhZzv0YagMSRlW3tMzQ0NkjOTI70=;
	b=HKT+8dHrPkvIGqmja+jRRjEVA4PhBXREf3Wox4c9VT9jZUvyQeU90GQOvT4rw1t7CT9H
	 Rs4LYtoSQqnxz4EJ4iMR5T/k0hZ1VFnH0BbtXn0BAFasd6QQelsJmHBEt6V0ANUtCmdQb
	 p3E7+KJmxCeTGUVRJjNs+PubMofOK5ojccfADq00J2MHWhWuqow/jP89fqbLytjk0o/na
	 0YZBlNiBzAc7KX1ms7wsj3uWDpKF7ftDsyLCSp6NtTNa31qrVqUcuB/j1/DxXS3MJ7sTf
	 aAkFF+Cbl4BP0qMW23wkEq1Ha4H3y1d5V0A/z/d50AEjp1rN6VMS1mhksjVGLyR1xCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XuXxPF+W;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4baPwK3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B19606A331
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B19606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XuXxPF+W;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4baPwK3
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADMbL511645123
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ksBTzPL1XwcvZYRdhZzv0YagMSRlW3tMzQ0NkjOTI70=; b=XuXxPF+WsFPUf+XL
	RcNy/bfXH6Qz4wVus+Sd02r6b+Q6U3vBA4u923cuXJaMHe84uCD9RV7Bqq2430oH
	3wyh8XyiIggE6dMwC/TrAnbVNoFOXkrbuBQhM7ii77yPbVmwvnLAmNwHNpv6cT35
	OR1EhtSOqmKV14AHWKm288/2cOR6R93id3eO4Ij5X7+3YIQJ5c5m+uzLDYWMtP2I
	hz/UKukcIcQi/R51oFM0YiqG6j3WNS9Rn3nDNMqqxSo3+Q4XueGXkqjpIsBfleV4
	/oR+XTeuVKBi4FZYt0P11SWAN6DNO6O2B0jCmMUTvjOfMXi2piH3Od5KxnKK+PVm
	7dCDiA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvjac1xk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:45:14 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2317000eec.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 17:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794620714; x=1795225514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ksBTzPL1XwcvZYRdhZzv0YagMSRlW3tMzQ0NkjOTI70=;
        b=Z4baPwK3Ud/UxDCm1gkEL7ZWUF5pZqNilWM6Xjk72zUz/uxKTIPtk7T/sraG8nfJYa
         92HRmojjuIX20kasfrrgBTXzTLQYLGiwkyjTOOlbVK2RIb68O76+7tjL8birblhuxVH1
         BmOE6tt0UleTjc8PnuyZ1MB9hU9+hZWwSCVBYF1gk8W5KQo64rDmK9M0368t9KmP2tdN
         ypEg+/1Pk9bZLUXyvOQyPCRNekAOZx3Sr3xLUstkS/6Kqt1gjhV7IBO+KRRBDL11qZuF
         R/6WBZJjkilB25xIkPgJ7/1Gl2Luh2dVrggEXUKo3VdvJm2yJzonF2aKGClNAES3EWph
         Co4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794620714; x=1795225514;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ksBTzPL1XwcvZYRdhZzv0YagMSRlW3tMzQ0NkjOTI70=;
        b=YhwsQmRtq5+swK13RaOtJ9J+4Cs1FlPCvL6mh8VC+hC4xL7SPJYCJGAI90ngG75RR9
         SZ3oByhB9mG+TMnSEGzJT38nLaoaZTcXX7Jl8CELcJr88SmmkfL/73MBvYTHufaKnDUY
         SOEqYxXqzoRYNi3y6UptDIIyEy5EZTgF9jFq9+CXHyoQtbeZj4b+OPMIgKBV/4MfR57T
         jG/0PEFxEwKKfXgtnHsYkdKCWB0rmCN/y23tyLsUXdlvdKBXKTBKW+0RWGy86O0qyFE4
         ynHpuxPVlU3sRJZxwugTNyOFE5o/l4RTFiVST/0GZ3Br8KCj4X3r1MpRmuRRl03avV5a
         l52A==
X-Forwarded-Encrypted: i=1; AL+hErGIcbFT0IdnTILTArY7MULBBV8/aHqXKtrd89HjaPcJ68HsVn88yjH4AWkxDvGPVEnzVoPb/SsVIrM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eNIHM7vWpPTklDlLVXoCLlwh70pJrx156zdmOGRBFEbHGtGMo
	JsrmQ8+NamxyZibPo4aSjOORHn/J2L9pyNZFnR7n8GwYv4iBMdkWv/RuDmIk16d/OIN+InPIxlU
	kq06WxnBwQipiazTC6EyVdA2reIg07ITUjM/gzoAVIqr8RhFBE2RqbW3mArY9Bz0=
X-Gm-Gg: AYBFou3FvqdezekjcLx16pvCu9G+s4EXNPYYoAxknefw9/FNVnzC97+7m8MfHnEaR0l
	f+lZ9PTOqNYRnRwUzg0APPXUJ3hYcLdpkC6+YG6gzJurhOR65UfebsbSRLKGGylMyvMmWkv/EKR
	E5GKMZ+5STkhCNpeBb/l8AxJAIC29pUkbTjoVmIXuUWkZzHeYEeM7n3MQEcXbsgk5+6U1Tvtob4
	DYTa09LmhPSP9h0uP0pz065KM6RTpidwtSJOUX9dtjWkuCwLTG5o4xoKV9RbFTN6hOY5E9pWlxN
	30leP2tr1KEX3b6ycp6arJRFY7WFT1EklfQCs7P33GGZP9ugyHBC+ASMAzsEdTGWWz7wr5EMcwZ
	vCKmOu3ZlObHVrVYKElLjKD6D3GB7th8A6K2oT2bxG3G2YEXqzm73jJT4x9uZ1pW+UzfbLXecMs
	zZB+Gg9b+M
X-Received: by 2002:a05:701b:4508:20b0:163:c5eb:d42f with SMTP id a92af1059eb24-1b503060401mr4110626c88.5.1794620713330;
        Fri, 13 Nov 2026 17:45:13 -0800 (PST)
X-Received: by 2002:a05:701b:4508:20b0:163:c5eb:d42f with SMTP id a92af1059eb24-1b503060401mr4110594c88.5.1794620712611;
        Fri, 13 Nov 2026 17:45:12 -0800 (PST)
Received: from [192.168.29.63] ([49.43.231.124])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm12998880c88.5.2026.11.13.17.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 17:45:11 -0800 (PST)
Message-ID: <861b48b3-32e2-459a-a6e1-75d93f10e1c9@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 07:15:05 +0530
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: connector: Add PCIe M.2 Mechanical Key B
 connector
To: Alexey Charkov <alchark@flipper.net>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
 <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com>
 <CAKTNdwG5XA_chr2ZM9qTnr2RaDMzOjdb85bRdCr4aJCr1EGy7Q@mail.gmail.com>
 <398a1d12-c28b-418c-bbcc-170d781223d6@oss.qualcomm.com>
 <CAKTNdwEzbYAqM5ABxU+tfh4juU=wgYp=QXyjvdA1haanU0e8tQ@mail.gmail.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <CAKTNdwEzbYAqM5ABxU+tfh4juU=wgYp=QXyjvdA1haanU0e8tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XTFj7Czq_m-Kk3hXwOYxbpSuFdIDU3QB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAwNiBTYWx0ZWRfX9brOWJyRZxXW
 +2ccTkqMcxT5u8mvobDyOPONDsuD/Jl9F/gP3AdeAr5Kt9Ha656m0P/m/5t0TdFKCnHZ+/57KXn
 2qSQ68bQrnBUr8BMM4uIFYtEaU+iVXA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAwNiBTYWx0ZWRfX9m4Pt+NcIFd8
 5LQWn7zzTvaAi8qxVov9FEGQtuKTYFCS3FUu3N0ODQ4iUzWdLkdpHnXNTTbgr1ggZdu6e9zcqe2
 +yiNALzDVFLqAF1aqkGKyktD0kYi//yI8YOG9rbzSzvZ4/srhBoTO6wkpd3mXSZn7gZvrQpgz9f
 oYR1Q64eRL7wY2pEUsTO4FK6WuhvKHXoygY5A3saS+QM8Po957k9vC8prK67D2dqAq5AaEuPY/J
 9jRG4/5BMx2q9qKTDsrY3ry1R5LxnR8dPdt/OYUlnfQ4nG7GH58U8hIsRZzMhN3u7UFYJWW7TMV
 lyLkgMmOkp61t/yGvuDAJs8iWOh7fFLuQ9gWlzvuVmo5186+ySbH+hDc9azb6EqxbMkOhWQwOj3
 /oltst6hzKJfozYJOCOFnwIU/eHzaKG6PkaJObhABJNoGzstrcx344BvHEFPscCxA/aimSihoqm
 zA2PPgTiYjLJaTz3yGw==
X-Proofpoint-ORIG-GUID: XTFj7Czq_m-Kk3hXwOYxbpSuFdIDU3QB
X-Authority-Analysis: v=2.4 cv=AoN7T+9P c=1 sm=1 tr=0 ts=6af7bd2a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=OgdsqUoHhxF4GfobPiU6/w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=TIDzW1d6nyBAyFx-ZuYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_07,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611140006



On 10/22/2026 2:56 PM, Alexey Charkov wrote:
> On Thu, Oct 22, 2026 at 8:27 AM Krishna Chaitanya Chundru
> <krishna.chundru@oss.qualcomm.com> wrote:
>>
>>
>> On 10/21/2026 9:14 PM, Alexey Charkov wrote:
>>> Hi Krishna,
>> Hi Alexey,
>>
>> Thanks for the thorough review, this is helpful.
>>> On Wed, Oct 21, 2026 at 5:51 PM Krishna Chaitanya Chundru
>>> <krishna.chundru@oss.qualcomm.com> wrote:
>>>> Add the devicetree binding for PCIe M.2 Mechanical Key B connector
>>>> defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
>>>> connector is used to attach WWAN Adapters to the host machine over
>>>> interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0, selected by the
>>>> Adapter's configuration pins.
>>>>
>>>> The connector provides a primary power supply of 3.3V/VBAT, along with
>>>> optional GPIO signals for WWAN-specific power/radio control:
>>>> FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1#/2#, WAKE_OQN_WWAN#, and DPR.
>>>>
>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>>>  .../bindings/connector/pcie-m2-b-connector.yaml    | 146 +++++++++++++++++++++
>>>>  MAINTAINERS                                        |   1 +
>>>>  2 files changed, 147 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
>>>> new file mode 100644
>>>> index 000000000000..a7f4bcbc5119
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
>>>> @@ -0,0 +1,146 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: PCIe M.2 Mechanical Key B Connector
>>>> +
>>>> +maintainers:
>>>> +  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> +
>>>> +description:
>>>> +  A PCIe M.2 B connector node represents a physical PCIe M.2 Mechanical Key B
>>>> +  connector. Mechanical Key B connectors are used to connect WWAN devices to
>>>> +  the host machine over interfaces like PCIe, USB3.1 Gen1, SSIC, or USB 2.0,
>>>> +  selected by the Adapter's configuration pins.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: pcie-m2-b-connector
>>>> +
>>>> +  vpcie3v3-supply:
>>>> +    description: A phandle to the regulator for the 3.3v/VBAT supply.
>>>> +
>>>> +  full-card-power-off-gpios:
>>>> +    description: GPIO output to FULL_CARD_POWER_OFF# signal. This signal is
>>>> +      used by the host system to turn off the entire Adapter. Refer, PCI
>>>> +      Express M.2 Specification r4.0, sec 3.2.13.1 for more details.
>>>> +    maxItems: 1
>>>> +
>>>> +  reset-gpios:
>>>> +    description: GPIO output to RESET# signal. This signal is used by the
>>>> +      host system to place the WWAN Adapter into a power-on reset condition.
>>>> +      Refer, PCI Express M.2 Specification r4.0, sec 3.2.13.2 for more
>>>> +      details.
>>>> +    maxItems: 1
>>>> +
>>>> +  w-disable1-gpios:
>>>> +    description: GPIO output to W_DISABLE1# signal. This signal is used by
>>>> +      the host system to disable the WWAN radio on the Adapter. Refer, PCI
>>>> +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
>>>> +    maxItems: 1
>>>> +
>>>> +  w-disable2-gpios:
>>>> +    description: GPIO output to W_DISABLE2# signal (default function of
>>>> +      GPIO_10). This signal is used by the host system to disable a second
>>>> +      radio on the Adapter. Refer, PCI Express M.2 Specification r4.0,
>>>> +      sec 3.1.12.3 for more details.
>>>> +    maxItems: 1
>>>> +
>>>> +  wowwan-gpios:
>>>> +    description: GPIO input to WAKE_ON_WWAN# (WoWWAN#) signal. The Adapter
>>>> +      asserts this signal to wake up the host system. Refer, PCI Express M.2
>>>> +      Specification r4.0, sec 3.2.13.3.6 for more details.
>>>> +    maxItems: 1
>>>> +
>>>> +  dpr-gpios:
>>>> +    description: GPIO output to the Dynamic Power Reduction (DPR) signal.
>>>> +      This signal is provided by a host system proximity sensor to the
>>>> +      Adapter to trigger a reduction in the radio transmit output power to
>>>> +      meet regulatory SAR requirements. Refer, PCI Express M.2 Specification
>>>> +      r4.0, sec 3.2.13.4 for more details.
>>>> +    maxItems: 1
>>> This seems to be missing the four CONFIG_* pins, which are quite
>>> crucial in these connectors, as they define which interfaces the
>>> module asks the host to provide on the respective pins. Without those
>>> module type detection is impossible.
>> Agreed, thanks for catching this. I will add a config-gpios property  (4 GPIO
>> inputs, one per CONFIG_0..3 pin) to v2. It's optional, not required - a board
>> that always has a known, fixed card type in a given socket (e.g. QCOM
>> glymur-crd's WWAN-only slot) can just describe that fixed wiring via the ports
>> property and skip CONFIG decode entirely; config-gpios is only needed when the
>> host wants to detect the card type/host-interface at runtime. Kept it as plain
>> sensed GPIOs with no decode semantics imposed by the schema - the property
>> description documents the full Table 3-18 state table inline (all 16 states)
>> so the binding is self-contained, but turning the sensed 4-bit pattern into
>> "this is a WWAN-PCIe Adapter in port config 0" is left to driver code,
>> consistent with how the rest of the connector's sensed straps (e.g.
>> viocfg-gpios on the E-connector) are already handled.
> Agreed that the logic of turning the 4-bit pattern into
> enabling/disabling interfaces sounds like a driver realm, although we
> probably need to consider if the connector should accept pinctrl-0
> through pinctrl-15 to hint the host about which pin muxes should
> follow from each of the 16 4-bit CONFIG_* pin states. This mapping is
> hard to recover outside the connector's context.
 I'd put the pinctrl states on the connector, one per CONFIG_0..3 value (Table
3-18), selected after the driver reads config-gpios. The CONFIG-to-mux mapping
can't be recovered from the interface providers, as you said. Providers would
keep only their own default pinctrl. What I'm unsure about is how much is
SoC-muxed in practice. The high-speed pairs are often fixed by PHY or lane
routing, so the states may mostly matter for GPIO_0..11. Do you know of a case
where they cover more than that?
>>>> +  clocks:
>>>> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
>>>> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
>>>> +      more details.
>>>> +    maxItems: 1
>>>> +
>>>> +  ports:
>>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>>> +    description: OF graph bindings modeling the interfaces exposed on the
>>>> +      connector. Since a single connector can have multiple interfaces, every
>>>> +      interface has an assigned OF graph port number as described below.
>>>> +
>>>> +    properties:
>>>> +      port@0:
>>>> +        $ref: /schemas/graph.yaml#/properties/port
>>>> +        description: PCIe interface for WWAN
>>>> +
>>>> +      port@1:
>>>> +        $ref: /schemas/graph.yaml#/properties/port
>>>> +        description: SSIC interface for WWAN
>>>> +
>>>> +      port@2:
>>>> +        $ref: /schemas/graph.yaml#/properties/port
>>>> +        description: USB 2.0 interface for WWAN
>>>> +
>>>> +      port@3:
>>>> +        $ref: /schemas/graph.yaml#/properties/port
>>>> +        description: USB3.1 Gen1 interface for WWAN
>>>> +
>>>> +    anyOf:
>>>> +      - required:
>>>> +          - port@0
>>>> +      - required:
>>>> +          - port@1
>>>> +      - required:
>>>> +          - port@3
>>> This misses SATA which shares pins with PCIe. PCIe second lane also
>>> conflicts with USB 3.1/SSIC, which isn't captured here. Should it be?
>> Before adding a SATA/SSD port here, I want to double check the scope: per
>> Table 2-1, every SSD-capable board using those CONFIG states is a B+M dual-key
>> card (Type 2230/2242/2260/2280/22110, "B+M" key column), not a pure Key-B-only
>> card. Pure Key-B-only form factors (2242, 3042, 3052, 3060) are WWAN-only per
>> that table, with no SSD row.
> Your binding is about the host-side M.2 key B slot, which by design
> accepts both M.2 key B cards and M.2 key B+M cards, and the slot
> interfaces are explicitly designed to support both. So the binding
> should reflect the slot's hardware, not the card's hardware.
>
>> If that holds, is modeling SATA/PCIe-SSD states in pcie-m2-b-connector even in
>> scope, versus always describing a B+M socket via pcie-m2-m-connector (which
>> already covers PCIe/SATA SSDs) and reserving pcie-m2-b-connector strictly for
>> the WWAN-only Key-B form factors? Or do you know of a real case where a pure
>> Key-B socket legitimately decodes to an SSD CONFIG state that I'm missing?
>> Happy to add the SATA port either way, just want to scope it correctly before v2.
> I don't think B+M _sockets_ even exist. The socket is keyed either B,
> or M, not both, and a B+M keyed card is compatible with either. It
> also reflects real-world use: people can and do use SATA SSDs in key-B
> slots. Same with NVMe SSDs, although those are rarer in B+M form
> factor (but I own one, and it works fine in a full-function
> spec-compliant key-B slot).
>
>>> Should the graph also envisage connections for the I2C bus (GNSS),
>>> audio (2 or 4 wire), re-muxing of W_DISABLE2# and WAKE_ON_WWAN# into
>>> HSIC functions in Port Config_3, GNSS interrupt line and the such?
>>> Should the connector node also define pinctrl configurations for each
>>> of the 15 interface configurations?
>> These are all real signals in the spec (GPIO_0-11's BTO-defined functions per
>> Table 3-15, plus the HSIC remux under Port Config_3), but I'd left them out
>> deliberately for now: every one of GPIO_0 through GPIO_9 is explicitly "VENDOR
>> DEFINED or GPIO_x" in the spec text, i.e. there's no fixed function to bind to
>> without a BTO agreement between card vendor and platform. The sibling
>> pcie-m2-e-connector binding takes the same approach and doesn't model its own
>> analogous BTO pins either.
> I thought only configuration b1011 explicitly says that the other
> interfaces besides PCIe and USB 3.1 Gen 1 are vendor defined. The rest
> have an explicitly assigned function for GPIO_0..GPIO_11, as set out
> in the Port Config_0 through Port Config_3 mapping table. Port
> Config_3 is the weird one, with its vendor-defined IPC on most of the
> pins, but the others are more clear-cut.
>
>> I'd rather land CONFIG_0-3 decode plus the SATA/PCIe-SSD scoping question in
>> v2, and handle I2C/GNSS/audio/HSIC-remux/per-config pinctrl as follow-up
>> patches once there's a concrete board that needs one of them with a real
>> driver consumer - adding properties nothing reads yet felt like the wrong
>> order of operations. But let me know if you think v1 shouldn't go in at all
>> until that full state machine is captured in the binding.
> The general guidance is that bindings should be complete, even if the
> software does not fully implement them yet. I'm not sure how strict
> that guidance is.
>
> In this particular case I'm wary of the risk in merging a version of
> the binding which will make sane modeling of those extra interfaces
> impossible later on. Assigning port nodes to all possible interfaces
> envisaged by the spec is probably easy enough, although subtleties
> remain, such as: do pinctrl groups for each interface configuration
> belong to the respective interface providers or to the connector? Does
> the binding allow additional vendor-specific interfaces on the
> GPIO_0..GPIO_11 pins at all (e.g. various IPC configurations which the
> spec leaves to the host and module vendor to decide), and if yes -
> how?
>
> These decisions (and probably others I haven't thought of yet) will
> likely shape the correct binding structure. It would be great to
> discuss and prototype them before committing to the binding, which
> must remain backward-compatible once merged.
>
Vendor-defined interfaces: only Port Config_3's IPC_0..7 and the
vendor-defined state 14 are open-ended. I'm undecided. One option is to expose
those pins as plain GPIOs on the connector, so a board can use them without a
binding revision. The other is to leave them out until a board needs them.
Which would you prefer?

Ack, for remaining comments.

- Krishna Chaitanya.
> Best regards,
> Alexey

