Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1959E3C2BB9
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443244; cv=none; b=dLGUOBgWk+3QA+z/4ldG9bV+2J6qcCugeVyY+fi9lXQbUBoKm/9axuqJ8GoZdGVM7M9JHG7lOvRlygnFzb0lZ7AHqCpT/+QZPF3Vg3zbOTBD5aL+5HaygC4ytETCajmqvq/mGR34YS3H0GGm1QPtUrg6jDZo2RkjcmPtTJ81Xe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443244; c=relaxed/simple;
	bh=zhynE7fpfbaeCJI0HZCi9xd50jHaLx72XtaP9KIszcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsODo3SnbYMS2iRYlXQqS16s0HBn0HNZnX2Y+IzYqCmb50CuSaxpddaLKaZlfue6Eni4JnY8214MQqIxbkmr+D86/8QXrNCJUhSYi+D1owMyIj//CSNqS+API5ZOQ/Tj5kzdBx2BT1EjGOIKgJvP8T6awjPHbO3+YzazuNQoylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oe69dqVu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EuacJqW+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oe69dqVu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EuacJqW+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8RSnE1657991
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 09:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pLasbVuHWA6jDYVcffIJm6ecP5zXaFFkBR4wHX/Ep9I=; b=oe69dqVuPm9wpef1
	KJbK8or45bMHeDFGIaO2/+EHV5bSg8BPin9KWxe3iNSTBcfROaix82oZM62IPfQo
	5Vvq8FgB8jA65wFnus46C0yUUQkIa4E1ow6P9R4a5X1gqDZydpgGNArsufDwedtl
	53r7jJ7/b+oi8ttOGeLC/aZbLOdtMH9Ozbs015q1+ZX7epoy/htO1aKTYW/xVTyg
	WC/WwPqbiQhVygtnZbtFLhPsEZP+qm79/CMaZ8bB4r1jAnm63MdXB0SYFa0tlIQ9
	eqEcxk2rthKglyr5ve+u+GkbC/It9xArwAYLBdRF3pVmTj9g7VAZGBFUWdzuu8ik
	kQp3jA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea0dkn6d9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 09:47:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb39de5c54so171461585a.0
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779443241; x=1780048041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLasbVuHWA6jDYVcffIJm6ecP5zXaFFkBR4wHX/Ep9I=;
        b=EuacJqW+/bSybIH4/TYayaudd7NkOQFSO9TreQV7pRSDMvcYTwyqftqBNHd6308CuD
         HoA7uXiaPU6X2Xl5QP7zKtx26BM4jfUF5aJlcwJpr2YqvdRsbiYNf/bE8WBEP1KrGYTN
         wU/TW6D0/jsMXaDNKy61sVOMaeOmZUVgNhgMwks92NedyXEirxaAHNl0jdnHJpRFphog
         MwgjWoHiAEqi/ZAYGVR1xc/1ha7NwoaMBrypRQBNttZ2KytIJrbT992cN0/pWEPkM5MH
         3+uLVBNlXi+Fd/5N0pMFjkmOyy2h4+nSGXy+eKBWI0ejHZlxbdiZPlOhvYFlTx0OtwWQ
         /MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779443241; x=1780048041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLasbVuHWA6jDYVcffIJm6ecP5zXaFFkBR4wHX/Ep9I=;
        b=At3pL8RYkQWwyI+YALBffr8mw9wXorDusGd6iAf2EzayT4pipMTpZ+vxfCMTgj3dkr
         AfcH0fId8RhjA3FVIhS9GyoZovcgdDPiS8ome9nFIXCV7TdsIR+UpIGfgG9LFRHaQV3R
         H1GHM5j7gXlcoFn+1Jvtqpg7ioPVpzs/7C3+pW8CyY6WViZd3FHYokweC4PZoV65aa84
         qVoHKnSJ5hQ9/UrF+cvHwQn1OIUaSTZM1twrSOijanCCiZgECXQ5VKeGJuPHePU6cN1/
         aiIAH6vs/7ys7hSB1fvsRxWj29JClc4QM5m7GctopyOng6tBdzoQ9/4ZHa66c31k/0Si
         NgIQ==
X-Gm-Message-State: AOJu0YzuFixX+MPB8puwKHOMQB0WFtzgkhr0uqvGFqeq/oLTXe/W1yYy
	4JOQjWKfIT22wVzfFQ9PMJ+kz9hMm//jFCyNbJD9EB5Qs444arXmUjeELeTGiqH9bxnOknKUpp1
	NKzw5b+rPTiiCYkoiNa/npgMKBMY0RtT7DrZdq5+rt/hqEIi8LMbCnX2iui4ekdg=
X-Gm-Gg: Acq92OHFlfEheUpwB2Kympag7X4Dp5u/l6h8oTgWEB1u1SEoMCMJ7FrzFqZ7ehpmhOc
	gZKsntZwcgTfhLpvyfoe69hMdfPj5o1hj6DSen4zB2lj9NpJOhKrGnVrz7eAZBUk1K8phj5lUYU
	2/o3a0IiZxjgB32hxAqMHLPyzOVaORE9gztGh4+SsPsdAig4cI6m2sTn9lN2PfPaEJGT94xFnu3
	zWgcj/aHQ3B8Q6j+Ai3XXnwwsLy2p2UeYbLqqWWywMqekw8zlUqympJwC90YbTni2/6pl/wLsZn
	T5DLBtrJxbCScJ7T3SgClMSRxx5reFACKloDX50frYXJVOoXy6wIhN+KYRSPFHegL942ANbIb0x
	TafiQrhr6uRNixKSLAj614TTXOugRzwYLw3eDVxryL3RFefpF0aA6qR24
X-Received: by 2002:a05:620a:4711:b0:911:1263:fb35 with SMTP id af79cd13be357-914b4a3f840mr285197085a.7.1779443241337;
        Fri, 22 May 2026 02:47:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4711:b0:911:1263:fb35 with SMTP id af79cd13be357-914b4a3f840mr285194185a.7.1779443240934;
        Fri, 22 May 2026 02:47:20 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688bb62b6dfsm465344a12.30.2026.05.22.02.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:47:19 -0700 (PDT)
Message-ID: <20d202af-7a63-410b-bbfc-cb695d0f7f46@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:47:15 +0200
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
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NyBTYWx0ZWRfX3UM7a4h6Dp7w
 Dq3elTSUYgvjS/vObl/Ghl9ihthk/5Cvt7nhRePgYPz94ZzMP6ygQg+Uz9Ui945qSEYqgHts6Zv
 v9kB3P4rTyw4L7r4uQRH6MiemSFFgp+DxpFBVn9HH9WDr2WCHxsphSNRECR6BNFQWPqqBGwpcRn
 /S5/4bqItUxSZ3SSqFs71Nj42VQl3nkw5GcnwQEAukbVb/FdwcsWYimXnjjRB4owIswutNAlY8V
 GSVxthmPz//ALf+UMNs1H1BK+7gepwicJE8/q1YiDDElw6jMlLAvFXOLcSqEw6XdJ+vKmsdnBQV
 Wybpr3y65OfCovTLUhyYKVCfcXfYYdfAdWTiW9r0MC/AnrML7SNtHfc3kPTLXDuCPjTGRXlE/SD
 TCUxbsnwAPL4ULLZEQt/8FdsKn7GEtTpqmj2FrWY/z+nUbSuT4UsiANldqaRjLRuINsmwXX1vU2
 dvHwIDTBQw8RDT6WCQQ==
X-Authority-Analysis: v=2.4 cv=aueCzyZV c=1 sm=1 tr=0 ts=6a10262a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=vtxEUVkT7waMBiOsAPUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: b1G0GEWijC2oQyYSvegTG_P_G5M4O2F3
X-Proofpoint-ORIG-GUID: b1G0GEWijC2oQyYSvegTG_P_G5M4O2F3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220097

On 5/20/26 1:01 PM, Loic Poulain wrote:
> Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> Arduino VENTUNO Q board. The module is interfaced via LGA and is
> compatible with the M.2 Key E.
> 
> Add wireless-lga-connector node using pcie-m2-e-connector binding,
> connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> the Bluetooth interface.
> 
> Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> the pci-pwrctrl driver can acquire the power sequencer and enable
> the M.2 slot before PCIe enumeration.
> 
> Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> (gpio56/gpio55) used by the power sequencer.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
