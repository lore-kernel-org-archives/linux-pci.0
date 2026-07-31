Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4DB4279FC
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502218; cv=none; b=CxtTuO1qYaMpUJVTJepgrhJ3rIHTBttDiHLGEoIUZomItf+3sb2i7zkxhaifv1irGrjXZHZkJOX16yuZqDSbQMMAOCnXA5l6ab1Vce7rU2kDR7DGrHzz3+TiUVIBSQTYOg9N+mORXzel6s0x1USco+pd9mdDMrRrbLpLwyFd8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502218; c=relaxed/simple;
	bh=bMraxFGM0J+W90QXiEulwryjBxopJcNN8hylzEd8Yio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boLNG4kvoD9RYr9q7n3f9ZMh9PVkWEU8BiF0Htf7NFovyIf7vmuHCf+qtkrCLhcYetmOAySnDmcHHe1peFdDPo9/1JeARUqnI0akq1SK3iYhgGn9xYKzUfQua0g674ZDw3d9Mgzy6/GSJHnFNZCNeqxXzLxlfTO9ZjOWaSJTZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DhMF8DbD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RmWb/t+S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DhMF8DbD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RmWb/t+S"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VCBv5X3776989
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 12:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5+IvKBWrJ9rDBopNg6/hCtxnIA0137MAlTVPeY6D+MQ=; b=DhMF8DbDbt3vxCq0
	iyxGlzCmmWAF06/zLpDVkaT2T8/hOUFLJKJsLLMOxog60icn7Vs+QoaPZRwWe+5h
	q417M1dixfubNImOM0FEGkR8r77odQzKENzK9STrYkVY/SBSXJnsFB9FrUeWrttR
	ftkMVIy/lJJYuzgZA3yFc6w6Y6254qug/am6g+rASlE3NTgCCjz0xA5DvNdyaCBa
	k4qNxLg8swHhBqZ88o/3hWDYaJr54fBuLD1fuiAPed4eQDfwWwtJISRzUB+2XHOy
	ZGn6ddh+LbpibMvx3m2PJpbHZPbNvafBjURYtXNPYD6QmD/IbB4pPMrI9PWtykVQ
	5MQ/zA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frugh047c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 12:50:15 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-901fdbfc3abso4325776d6.3
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785502215; x=1786107015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+IvKBWrJ9rDBopNg6/hCtxnIA0137MAlTVPeY6D+MQ=;
        b=RmWb/t+SVn4c3JUILviLoGBVWY1AVJyPFQhaARnnqaTVFYJasy3vRMkqzayLmxbspx
         Cgu/f6nildkc1AH2hh/MOcnUBuZYz1xgm1z6HpR9epG2nnmSbZhZ3VYAJCy+T18187v/
         AG7a0+SuFtNeakYXJeseJDPw/Gu9+YsmEHt1Br4GW8jU8YrvMl1kxvbNlOQkNnSmezgd
         WGHLrPd5+PUz4kzWefue3yL5/ImJVlafEW0IpyeOR0t4/S7yw4uk2g76Hc43tucsmepD
         RGK9X18bmU20U5HKkKiLBI3H3v+VDkL5Bbulyu6I3fT2adkCj9wdBd939KXUnYyJkB56
         cppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785502215; x=1786107015;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5+IvKBWrJ9rDBopNg6/hCtxnIA0137MAlTVPeY6D+MQ=;
        b=riYk6KcwEi/sMe1MJiQYTxWLfZVLrIFX1dhkBWJKMtOdcbGqwExLEyu5k2cgr59OjQ
         BokCmULaTM3t6Sgk+41pZBGiNQgym3glaGgXQYPfyCSR2NJq5Fib7PkPoRJvI25IqbiN
         ciUZbQIr7sXw4v7gUuvhMqoWzc0Vr6mglNdCJYT3fjB3bDOk3VQBoIptiY3rm5AyPQMQ
         WhUaoqYXw3TWijnLyp7+cCSUFmsOlyNEAMiBjDDwzx7DK9Rk6dsgLngoD/6QFp8PUN+5
         26I2vEg0eAvH+xWd1RbNj0ITG9OhxUQ2rQQA4O+eTWjn8vcJE5VU9N2cQCLWSznQKIPc
         Bomg==
X-Forwarded-Encrypted: i=1; AHgh+RqhLCKuHEhnq383L7CfAG+25GZzb0zSBmffDQ5WkY9AIWzYeW1zGu+uFB38oK2vqG9ZabZ5/N6JHIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx81V771BI+r+NP2ljOaFAv33m5mirn8/lIwMLGWsyR0zmMANgo
	IkHpcVLHs9Dx5dAumeRm/uiofWoZVKTXH55tZoFFXuNxJfDaTh5rT6rC9+NAkU37p0pfhqZ5vwi
	CgJKxwIinicaWES+d9p0vlAAO34mnVnoH49ndh1hj6G13/+LVeoiVLSm0O77LHHI=
X-Gm-Gg: AR+sD12YrlmROgLQt/7kY3O6JqCBQO0j/a9GGuyEb0fpnWEnk9tL/W03VR4frmGgl8k
	3MUQYjPAJh376lH7mFjImEDvHK/Kym1kWeTrtV/qtwIhn6tdOHEFlEDLZGS2zmfwYxlI+Bah5gK
	LWVePB0eabmYaiBmCk+tNlmiL/qKXGVrFkf66tFI8y2cm2Zl8wFdPud/BuJW2qSFhLz/qdG8Byf
	uMo4y0ZIlePWVp4MRJjC5XyvupDkFwaIdMXRrliwiBnElq+rWwPjxcHsbju99NWfgkhusSyUnAb
	feHLRLLtum00Vu/PKuC6dHZCSp3DeuqU6gPUDe9CZZ3ghu3uDuBtGOwwmYPgPGWr5h0id+UfOSa
	yH/qUts8JtjPl6grD7O9RjCIH
X-Received: by 2002:a05:622a:2585:b0:51c:d8f:d77a with SMTP id d75a77b69052e-52b563c3a50mr470361cf.1.1785502214795;
        Fri, 31 Jul 2026 05:50:14 -0700 (PDT)
X-Received: by 2002:a05:622a:2585:b0:51c:d8f:d77a with SMTP id d75a77b69052e-52b563c3a50mr469771cf.1.1785502214157;
        Fri, 31 Jul 2026 05:50:14 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b0efsm147122166b.10.2026.07.31.05.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 05:50:13 -0700 (PDT)
Message-ID: <6d61d749-440f-40ad-82e5-e1e909afad06@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 14:50:09 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: rb3gen2: add Industrial BT UART
 overlay
To: Rahul Samana <rahul.samana@oss.qualcomm.com>,
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
 <ce283ef7-2460-4fa4-a1f5-9757fd6b42b5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ce283ef7-2460-4fa4-a1f5-9757fd6b42b5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX+c61mfSTj2Lk
 GvM0jjVyVM6D/cVtLGyWwjSaAKuX+MShlOBQwXKHFALX46VR5oExklggPCRL/n6ZcNQdqhoMGvQ
 JyE3TIRI9qQVuQIXn48N21IEmEXr3Ffrx/ppTSnSrrQprsdZixVVeKZbQqboXUTJdN1pAc0dQoC
 YldLj4oocGC6OTaNxcmrXv6qWb/W7qnuqO9wjE1Bm71XNMBktQ2wW+5qH6Q32QLpQ3++pzDFLfs
 DbUzkXoJB9O0YNLbwy/OvfpHQLdgj8xD6Ix49GazP+gAYeCXbZXi+owtT5iFje8s6eYcW7SI4sC
 dPzy5QuPuvP/xeV96VqcZ+MTOdNNwGD4Kg1Sm+A7s4voxCIHps2G2B+iko8tt1Mn3Xt3hQQOK34
 GKBbaADpR/eKlM4ICFlwtVq/9u0wWy2PTXU/wgQFsdJEjKOiJVp/EiNWhYLU1ndp5l7jSqO25U3
 ox6eMCHsU2QZKRtea5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXzI7gWV+pV1QL
 FAqB7BeWK8v+XFzwVS5vijiFj0Pc2xSxXhoTiZ4+rna7eEswc3obQAoSUcXiFLYaQUMTT/aTuVl
 QojFqOSwYZfCPBIE4Zoi4+1SOqIVpQU=
X-Authority-Analysis: v=2.4 cv=U+iiy+ru c=1 sm=1 tr=0 ts=6a6c9a07 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=ejynXRg2g54x_2soN7sA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: iJn0wnTSnFWpVZRWE5VA6jV-dhFVBx9h
X-Proofpoint-GUID: iJn0wnTSnFWpVZRWE5VA6jV-dhFVBx9h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

On 7/31/26 8:53 AM, Rahul Samana wrote:
> 
> 
> On 29-07-2026 18:01, Konrad Dybcio wrote:
>> On 7/27/26 5:45 PM, Rahul Samana wrote:
>>> The reworked RB3 Gen 2 Industrial mezzanine keeps the common Industrial
>>> mezzanine hardware description but routes QCC2072 Bluetooth over UART4
>>> instead of the default Bluetooth-over-USB path.
>>>
>>> Build this variant by applying the common Industrial mezzanine overlay
>>> first, followed by the BT UART overlay. The overlay models the M.2 E-key
>>> connector graph endpoints for PCIe and UART, and disables the on-board
>>> WCN6750 PMU and UART7 path so the M.2 QCC2072 Bluetooth controller can be
>>> used instead.
>>
>> So is the onboard module disabled? Can we not just use two in parallel?
>>
> 
> The Industrial mezzanine variants do not support the on-board WCN6750
> wireless path. The common Industrial mezzanine overlay already disables
> the on-board Wi-Fi node.

What does 'do not support' it mean here? They are physically present
as part of the SoM, so unless the lanes are somehow diverted away,
why is it not?

Konrad
