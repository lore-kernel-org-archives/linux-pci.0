Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115293346B4
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480846; cv=none; b=axu1ZwuNAf/PV4Sx6mHQpIzPgv5Mb8kT1W6QaRYpAjl5gbHFz9AOLgsFGMrXaDdsT+VoT7gjwaKz4Q0xw1WRwMrEO0bED1EINobqw2jxIcMtbGtIeDdCOtBiTw6JKJMiVDzbb+/XgyHBsugmPztf/qaIYqGw+5uYuo4EkNgFlHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480846; c=relaxed/simple;
	bh=X96EtKQGRkx+GYgOWXgKTsQyCo1hlz/5BogBnNd5Okc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EeBAQQBDJ67wP3uFnXYzwpFhfEHO6jmAirlns5gqP/xRtMJN5EXWtr7vmM803BdytOhqJ3Tia/Cmv4PeZqHjUaAhBOo/HMzf5U0WK8ThZGSKglXeMo/G6wu1RhmZ2XfxC1zUnx9cJQPlYFnbjTxSeW447j9HDuQ6FMc7SnSxs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E3yeNwWs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KceN5XPx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E3yeNwWs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KceN5XPx"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V6bZuj3703746
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 06:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x8r3nwsUV7dCZxExVXM2EEkbrRp98mWiLhmFsQB5NK4=; b=E3yeNwWsxku+9GAl
	R0JtsbAyXzjwygvQHEnG0ZBGKHDLqgfWSA1gE0prS1AUGtVVoA2CZVxzoeohqhXg
	0aDSvP5g6kFJTG0ed3U/Q9uKLbzr88R8RANTNVz+qOM6VkzfdROnqz1JNCYFIRzD
	YBsOMFaa7LqueSAN0fLZoN+12gnWBCtIDEdFxfiKlpoGZljQAOIBxb5aSfGLERoh
	vwveEzaRu4Xt0T54nVZs4kRK/rR460u5Hwbr30ku3f2fuaY81PzLTjt8dUd77gCI
	QrA1HwY3+UF909oGPG/nApXK+7jlVljcG0ynykbPloZwmVgAZb33aRrVbiSwJrC4
	AssJgg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frpkt01u6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 06:54:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc5faecf01so12432925ad.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 23:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785480841; x=1786085641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x8r3nwsUV7dCZxExVXM2EEkbrRp98mWiLhmFsQB5NK4=;
        b=KceN5XPxSiI6Hn2rDCzvs+ARvLWbldxL2P4sFU82VJ9N1lnjdwtEwkWoN/BnDUL17k
         v/K0Mm6QrMoBN7J3L3BD0Xl8IBPRX2UnZYzZhlRuFqlpf41Yxk7IGShyzhO6JtuhGaS9
         5CECjCpGq50o8MFog0DnSKhPWqbERt+Xhlq70Lfxt8SGHCM9Ravy//BX/gVbyNabFB2O
         qLQ2RjgXJ/q8aPJZHfjJbX3NCh6A8cvpCsUnEXlZxuvGabTP9ANkwVzK/H89UXnRdW+G
         kLWugH1mNaNuHXsVNQ4lw9mqMtMiNDV5zFI7xhAVTWs6g0ULHAa7JzxVOO6EUbR3r7vg
         5wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785480841; x=1786085641;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x8r3nwsUV7dCZxExVXM2EEkbrRp98mWiLhmFsQB5NK4=;
        b=k+pNNYDurIPL//wp5gX60kXHMUWLoFdMs1yOBAOVg7BYh1CYY0Zj+bbN8yByx/MIur
         5AmDJP6FDDhCVOnyX4oOTB6DtPoGV4tZmwKeKUQLnNHgjhOEKbAyrVxli8VUprcY4e5N
         QLD9+7+Om7TZ10eul4FYVeczi0LAYJCwiB1d/5cjOD5T6gED8trRsPYOExMoGQ7vZLyO
         QcSPzfMb1l/e+yEgMtnDJCyW1E/DdaGSe8Sr0XbhXdpIAo2V/lGFq7d9WKx7CDbpwfGk
         snnLZqk04YmKGkhxqhv9PUlUcXDEPThQNuYu70uY25qP4gFKqj0jXwfJascDICsFUtB5
         P/Zw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/wMQOHXjOlsmOcg+5pxXEe2DfPPc8fUBcR6oTx5RVdmoPuevvOPQ9tbwnnQoz+LiEzjS0eVC+y6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzadvqyO5lP4mbOOvkxF6gJ+RGM5jgAgPqN3wNSDo/hZZubepmV
	hlR4qGAo7QFdFM/5nN+CSdt2TWfhDMgJtfZ4D6mHtni0cYu6omnZz8YcyVmNlUmn1DqU1B2UsdQ
	uqE/Px4Lv+nkheqdimwg3Q5hQm2g2xJQzg76TS/NQQw2FdkHiXffwX8a2GM4tsz4=
X-Gm-Gg: AR+sD10P8FuQJOqYiguINwmMv04jxE4Edyyz8yrK9CV0dkiWpni0hhgqFrpPijHD6wh
	NR/jJ3Cw2/UorGp74sewKMQhTn3mfL0zzBmJsW6N47UfcteDTC950/tdAeRasASFPOQJYjA+92h
	3Zjua5MycuQDoPZlAqKjTPxLhIxDSWWrY9ZeKgZhDr+A9KModdihRGr1Wd/YKABrTwu6ZEa+WEj
	fHrsrYIyBE+ic5Fq8nqPsu6qHYG+y+/yodQWIgJm60gjJvccRTl+sReIPQmsXGR+BjH8Ddt3IuN
	gZMNW1yBjQWM6P8tIBEIKeM8tzQLdkbvIWR0wK+lDsVdvnoTCwiMdXLMQKKelr9ZDQqfDVQay9W
	NRIyT4g1pusfdDmE37dVLwX5cIRV6Lsa9
X-Received: by 2002:a17:903:4b08:b0:2bd:8395:fedd with SMTP id d9443c01a7336-2d046eadb8cmr9012145ad.37.1785480841634;
        Thu, 30 Jul 2026 23:54:01 -0700 (PDT)
X-Received: by 2002:a17:903:4b08:b0:2bd:8395:fedd with SMTP id d9443c01a7336-2d046eadb8cmr9011935ad.37.1785480841193;
        Thu, 30 Jul 2026 23:54:01 -0700 (PDT)
Received: from [192.168.1.10] ([122.177.247.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b15914bsm1273885ad.74.2026.07.30.23.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 23:54:00 -0700 (PDT)
Message-ID: <ce283ef7-2460-4fa4-a1f5-9757fd6b42b5@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 12:23:52 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: rb3gen2: add Industrial BT UART
 overlay
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-6-2d100f30e202@oss.qualcomm.com>
 <794424df-4714-43a4-b4b8-e960998ad1f1@oss.qualcomm.com>
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <794424df-4714-43a4-b4b8-e960998ad1f1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rDg4IzhV4cGEoAylFreQfCODAyoxTT_F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0NyBTYWx0ZWRfX2+YAtwpAi0p7
 Qq1Xq9KseVGa7tdeINaRZXVyTycbYI8DqQ1RjR63CgESC9E6QEVeGM/Ax+9tyJfv+KrWohkWGaq
 Y+vpqyFcnyQBFpw6A4LDsVUqEW21OoWLL6uomrfAnAXzYm8Zsu1CwiIkZxAneYt5xf08bvsiCWb
 9KaflcovJROVoUfqwS2wEqfsdHD6JAY4j2RKLAzacl4SwnfHaWgkOzWyB/S4o1KWA+q88cziZrp
 2JgvLTrw64fPaiVy91TXmml5FV1qyeXZsoXdDgkkitzyeNzR+YtSR/hoFe8gL2Z6qBBwrq7cB+7
 zJc2GnvO30LS7pYd2iAE2tjkTfRK97AIrr/IHTjLe+YDHqAaQBAx0OOm0NDnrR4CKuNxT7Gon7i
 aWCKeM+4mXglqO4npO57Q5c4vr8EsREX6P9Gs4f1RDw57j5ExPwqQSdlb/bwd7buqpaGCeBKk4N
 cJg7MhlYHysM1CKBarg==
X-Authority-Analysis: v=2.4 cv=XYa5Co55 c=1 sm=1 tr=0 ts=6a6c468c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=wVA5pQU3D6HtJETKl3oCcQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Lfqoa_9HXnV3lTQsdxcA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0NyBTYWx0ZWRfX9gaT52RGZRhn
 uvZvlzcPUzTCjisx9h+dhTWmSE0Bz4Mm2Kxi7SgFu2qn6GLTV52pKBu32OemfYEskgMpx/EcYO0
 CSZl8Q3u80oEFn0zO0LoIS+j8A1bywo=
X-Proofpoint-GUID: rDg4IzhV4cGEoAylFreQfCODAyoxTT_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310047



On 29-07-2026 18:01, Konrad Dybcio wrote:
> On 7/27/26 5:45 PM, Rahul Samana wrote:
>> The reworked RB3 Gen 2 Industrial mezzanine keeps the common Industrial
>> mezzanine hardware description but routes QCC2072 Bluetooth over UART4
>> instead of the default Bluetooth-over-USB path.
>>
>> Build this variant by applying the common Industrial mezzanine overlay
>> first, followed by the BT UART overlay. The overlay models the M.2 E-key
>> connector graph endpoints for PCIe and UART, and disables the on-board
>> WCN6750 PMU and UART7 path so the M.2 QCC2072 Bluetooth controller can be
>> used instead.
> 
> So is the onboard module disabled? Can we not just use two in parallel?
> 

The Industrial mezzanine variants do not support the on-board WCN6750
wireless path. The common Industrial mezzanine overlay already disables
the on-board Wi-Fi node.

I will move the on-board BT UART/PMU disablement to the same common
Industrial mezzanine overlay in v3, so the BT UART overlay only models
the reworked M.2 UART wiring.

> [...]
> 
>> +&pcie0_m2_e {
>> +	port {
>> +		pcie0_m2_e_ep: endpoint {
>> +			remote-endpoint = <&m2_e_pcie_ep>;
>> +		};
>> +	};
>> +};
>> +
>> +&uart4 {
>> +	interrupts-extended = <&intc GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>,
>> +			      <&tlmm 19 IRQ_TYPE_EDGE_FALLING>;
>> +	pinctrl-names = "default", "sleep";
>> +	pinctrl-1 = <&qup_uart4_sleep_cts>, <&qup_uart4_sleep_rts>,
>> +		    <&qup_uart4_sleep_tx>, <&qup_uart4_sleep_rx>;
>> +
>> +	status = "okay";
>> +
>> +	port {
>> +		uart4_m2_e_ep: endpoint {
>> +			remote-endpoint = <&m2_e_uart_ep>;
>> +		};
>> +	};
> 
> Let's define both PCIe and UART endpoint sin the SoC DTSI. And don't
> mention "m2" in their labels.
> 
> Just pcie0_port0_ep and uart4_ep respectively.
>

Okay. I will move the PCIe and UART graph endpoints to the common SoC DTSI
with those generic labels in v3, and keep only the connector-side wiring
in the overlay.

Thanks,
Rahul

> Konrad
