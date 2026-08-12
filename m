Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712363783C5
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507837; cv=none; b=K/loSy09HTa8p0H7h3ZXGgWAtIwVxOd8uYyN7HDdf45XdzW0fbRcx7LqT6UJLom6ti2N62sb2BaHxu09rLQyFn4Dbj8VQJwZln0kKM0WzgJVnbuIwXSaUHJWtgNYZJt5uO4j4Spqt+zxMjnrF5YEswE5w3b2rpg9HpTgy1f3pak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507837; c=relaxed/simple;
	bh=gLj1Ji6Xt/i+3gADU6vlqWABAXOi9w/AGkhICO8XBHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKnc3uNWTvVuj/bFU/QItXdBTIGhUOlIodx+UZ9DSdUeblHnxOQ23UvWdoOmvXHHC0hoO8XEL60HN7XbYZ7hz6JfTejKxclTr9QbaN2lBLMZDSJ2nwaXb3IWbq6YqLf8GMqdyf2ED2Xqb257C1FaMn8tmFccxyWOtBIJG28FOKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ov/79yIK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DfyXYrIJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ov/79yIK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DfyXYrIJ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C2g2eD2843662
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 04:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ycqNmOINwoVyj/6s4hroIe44DSPjnnHA0sh0w16wSIg=; b=ov/79yIKXvAbl7rM
	gYND3eTjFUs+JZgPzkNFHZ2Zh6NcHTr2VVuN4Fk/ceLVedJVotBANBVQbk+nafNH
	FpP74DPcK+eZGYkhzyvdTLaA5tkiENpE2Q8oF2BaXL9pf5rtJygxsqijGYWxVfKc
	swTUTIyxfm8TifjW4txS4Jx3VPu5rZEE8J/Ejt7GX6zshvbOlE2s8SJNKEm9i3Fg
	LkRmu1EQLPwlx0HLxXtu2TV7+i6SmN1u1MGjkdXEcfLYR7WR86O2lByCWA7Cg/1G
	Wf5jE0XDF0SoiWhxPMekbJqytfdkuWQQBuDkYBR51iOqUIK1d64bXxio37sy/LQm
	XhWFmw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049euavc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 04:10:34 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbee5bab340so487136a12.2
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 21:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786507834; x=1787112634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycqNmOINwoVyj/6s4hroIe44DSPjnnHA0sh0w16wSIg=;
        b=DfyXYrIJbrbA4vXxKpJ2g2p6WOkTMdSTvPLkMAM6AvcbmLfaJeefVbSKNZGH4xuU+r
         RqjPczCIahF/zU0Fd+N62GNwpmiVTnFtHBPsilMZwGC5Btfba6o1IgfEzKju603I3Z/l
         WTyvHKqGtxdOgqqvxt7l6vwOV+sn6YLBXpJC/RVEaG2AyJ7Y9gAtC15MovJfKxwPmJ1U
         5Y+NTAFpTEfKWVQtnefewEagsDp80XlXGpgKthoBeRKwcgAJ3duu7ZAVQ7jPOv38chjc
         3bzKjgypfN2BcX2HQ1Zy5jWTz5j1roUYhtiOgSjTwc6bh+2chhXWLEm4OoZ2W9w0lnjE
         Bn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786507834; x=1787112634;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ycqNmOINwoVyj/6s4hroIe44DSPjnnHA0sh0w16wSIg=;
        b=rsBGnILhTc0FW1GFwakLrUoEJDHcHXw/pJaSgVdD4bhJn0Ytdxo9Zw1AnzT/QUr46B
         jSXQIa2MhBmVea/bUYKw67R+EUaCQSLLe3DRjHxZJz6LinKACFcXuF4gX6Y6yjKIjiBi
         AF5ul1gZ5VxYKOXyiv0EQolnCg+2U7RjVYrnvsLkiiQlkNBxDPqCAbMLV41R5H1JuNlC
         3XdSC8kJofvdkkM5vIUYd6Q7khSaWxlZ8QmElwGZp+18eqxn2F/rmeFoTqacNvVo59Y3
         +5yecxPBrXXCW8EZVKJR7IEDVfM8BrUj7rxy2obRcIrME7/1QaiUTK6S3IwbH3YAYGbB
         vMUg==
X-Forwarded-Encrypted: i=1; AHgh+RprJVUpBDOIHCoBN5cc/TPtxR/lhx2ovu1WFbLl4txA78wg7Ki0TVkmLetTVcGvTcEoQiuBjDcsqbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Sa8vWr4Psf1y4T/CSHQMtNeUSLTu7B2G95KSU6Tgs4BwTikc
	JzoBWc9+sCNiM08FW9XOPcDruK32edUPvAZVGIZOjiYRLMe8e91XEkTPIWWgTK2BxLKH0utLh23
	WZ+4kPUK02h14x/L6d8JulowXZ8rGNh61LkhwsM/JLMt7Fl5n1fio6GD8+6Q3bJ4=
X-Gm-Gg: AR+sD12IGaUhMzVS0MqACZ/nWlunkkHxbNBuRv9mra/wfFppivXJ2TSfDNYinqDJrk/
	XOKVILs0KXW8hQUtOb7yiOhVYIgxcA6QiAdyKnkon3d6HaacKPjKNyUpNZdAuGCqAs2VTd7J8/d
	ZgwUI/AimGltAHL/GjaoFUcUAz3p/499u1j7eH715Zk4vokhqHbHN8nKRDZXXaTGtezTCsdnTd+
	Jnn3KC2GD7kKkZ9sgDwSG/0O4UR96oYM/jTYecda29HG9vkHuC6qfkIhNOdZARCc0pKkvi/PQDx
	qlayWmRPj7fk2Cn6qKsNqQG0dQkxVV6f9gHf1RiYiCBuMMCpbPQ9Fc0VPH5A3HC7cIKFWpzZ329
	Pp4O/LD50V4vGk2L5pE54vpe73xYQa2lDFw==
X-Received: by 2002:a05:6a20:da14:b0:3c4:3112:33 with SMTP id adf61e73a8af0-3cc3f51c7a5mr2557877637.6.1786507833535;
        Tue, 11 Aug 2026 21:10:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:da14:b0:3c4:3112:33 with SMTP id adf61e73a8af0-3cc3f51c7a5mr2557821637.6.1786507833113;
        Tue, 11 Aug 2026 21:10:33 -0700 (PDT)
Received: from [10.218.18.194] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf628e0edsm5538714eec.18.2026.08.11.21.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 21:10:32 -0700 (PDT)
Message-ID: <3f2cb2e9-d242-468e-8582-26caabba7832@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 09:40:25 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] PCI: qcom: Add PCIe support for Shikra SoC
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio
 <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
 <e2inl7k5gsjj6oomv2k5ximuzpb3gfiz66ufet3b4hvov7zqt4@qz4pifbos7yf>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <e2inl7k5gsjj6oomv2k5ximuzpb3gfiz66ufet3b4hvov7zqt4@qz4pifbos7yf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAyOSBTYWx0ZWRfX4MIqIyXsFcsw
 7IAe00oNytQwXchBXcbzFEZZNX/vTnS5Cdl1TncwWWM+AgHEaiS2hqJwyL+mmwriCmDjy+4h37W
 yvd4a/6QgJECpEF3hNTwPZxuOIGGlPc=
X-Authority-Analysis: v=2.4 cv=DoFmPm/+ c=1 sm=1 tr=0 ts=6a7bf23a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=ee_2aqc6AAAA:8 a=EUspDBNiAAAA:8 a=clU37HkR2gB4O1HD2CAA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-ORIG-GUID: KyicGcRayK6ybxRFZI8ApAvdWTGKTCTT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAyOSBTYWx0ZWRfX96zprBlaRsjl
 5NkbvBpLVF9HUC6nWlR7E6X9Fy9KmYlfc/rpAaJK74jxwbPsSnWx2rQ19S60bzloDM5Haap5S86
 o68jXD8IglWcGaweRSgLQclMOqv5vv2gNmZfKvTf8q46woEpvt7dQZiKFP4uU6EALUP0UjVhmcm
 sHImyLTEm0qnuCkiDf5HDR+9xx46sD6pwXsWddlNGMA40OwIu8tiSKt27FZuW2E5J6fmo4/BfMq
 vtJ++N5avxBBk68PDZWq2i8+Kt9w//1ct3t02C2G+wqsYKV/InA+txGX+ZbDgFN19TFZvEbPciM
 lz/Y9ybyMDxnn/M+y3aM0gWdrjqZfBJfBywxvSO9v2ic3FtvismiyloMjnOVOUUDViOgC/cBp+v
 8O5X9lrQNbYk6MuXmsE8CiIL/kJlIebAOBXFieoHJP1mJS9ksNmcR6WR1kZzvsD77fNd1aLC87U
 s4P7DlnWfCi72b9rtWw==
X-Proofpoint-GUID: KyicGcRayK6ybxRFZI8ApAvdWTGKTCTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120029


On 7/8/2026 1:32 PM, Manivannan Sadhasivam wrote:
> On Wed, Jul 01, 2026 at 12:32:42AM +0530, Sushrut Shree Trivedi wrote:
>> Add PCIe support for Shikra target, by adding dt-bindings for phy,
>> controller and corresponding phy & controller drivers/device-tree
>> changes.
>>
>> Shikra RC is connected to TC9563 PCIe switch on all three
>> EVK variants: CQS, CQM and IQS. The individual downstream ports
>> of TC9563 connect like below:
>>
>> DSP1: M.2 B-Key for 5G Modem
>> DSP2: M.2 M-Key for NVMe
>> DSP3: Embedded ethernet device
>>
>> Power and reset to M.2 B and M.2 M slot are controlled via
>> TC9563 GPIO's. Hence, add DT nodes to enable TC9563 switch
>> and include corresponding changes to configure power/reset
>> to TC9563 endpoints as part of power on sequence.
>>
>> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
>> ---
>> Sushrut Shree Trivedi (9):
>>        dt-bindings: phy: sc8280xp-qmp-pcie: Document Shikra PCIe phy
>>        dt-bindings: PCI: qcom: Document the Shikra PCIe Controller
>>        dt-bindings: PCI: Add bindings for endpoint gpios
>>        PCI: qcom: Add support for Shikra
>>        phy: qcom: qmp-pcie: Add QMP PCIe PHY support for Shikra
>>        PCI/pwrctrl: tc9563: Add API to control endpoint power and reset
> TC9563 should be modeled as a GPIO controller to drive the PERST# and power-on
> GPIOs. There is a patch series under review [1] that adds this support. So it
> doesn't make sense to duplicate the effort here (which itself is hackish). So
> please drop all the switch related patches from this series and resubmit them
> once the above mentioned series from Alex gets merged.
>
> But you can continue with the Shikra PCIe RC/PHY patches.
>
> - Mani
>
> [1] https://lore.kernel.org/all/20260605010022.968612-1-elder@riscstar.com
ACK'd
>
>>        arm64: dts: qcom: shikra: Add PCIe PHY and controller nodes
>>        arm64: dts: qcom: shikra-evk: Add TC9563 PCIe switch node for PCIe
>>        arm64: dts: qcom: shikra-(cqm/cqs/iqs)-evk: Enable PCIe PHY node
>>
>>   .../devicetree/bindings/pci/qcom,shikra-pcie.yaml  | 211 +++++++++++++++++++++
>>   .../devicetree/bindings/pci/toshiba,tc9563.yaml    |  22 ++-
>>   .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   2 +
>>   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts        |   7 +
>>   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts        |   7 +
>>   arch/arm64/boot/dts/qcom/shikra-evk.dtsi           | 152 +++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts        |   7 +
>>   arch/arm64/boot/dts/qcom/shikra.dtsi               | 154 +++++++++++++++
>>   drivers/pci/controller/dwc/pcie-qcom.c             |   1 +
>>   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 152 ++++++++++++---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           |  73 +++++++
>>   11 files changed, 764 insertions(+), 24 deletions(-)
>> ---
>> base-commit: 565fa02f75448ce1ddd18bda6b31ad985cf75411
>> change-id: 20260701-shikra-upstream-14b8668f1001
>>
>> Best regards,
>> -- 
>> Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
>>
>>
