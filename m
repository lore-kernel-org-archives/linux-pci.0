Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972666;
	b=2ekSnjkg5QWM6/SRHUXcSw0gxPHsMOf899inRSlsvjnzw4eLNY4uCCiDyCTdGCLkqhz5
	 CiB008WO3uCCaHdM8gO2L1cbHYMN/yuvcvcZMHGYy28a2b0I26DzBnY/kucnDvK4JSMM8
	 7FszHMMXC7YohPezdOxuBPWsvLTxP/R0ZomAmV7u8vQkE/aHUH0jTr280bHSjgc+yGLeb
	 MnBHVwzQt4N8Qn4Tzz9cQnSQ+JkzIo8LUmcTNvUvJ9MjTI5XiAefYOyvv4kR15f6c62tL
	 8tqynogiqCwdJf7OqHQE4ds+sdasVNbYS9Tgl5ppwVqij53FHPZCRPda5xnBeK6soFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972666;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DLrT5Mh7fC5h8PM28yHTHw+H7Tw5FCOseBcBKNYwgUk=;
	b=k/X6F9FijLmyg2hARc7iiVM2wLRnOlDP1aYhaHL52aPT73eQpk1ik960MzC+2n3PmWVi
	 ZaFn/sL1xSEyUwPifSu++s/mV0SfN2QmLe9e4z/zxJB/JXSE07g0JLGX4Nb8Eq1P/6vSg
	 X0r39oh9yAZtjy06zivxuOepwsTbzmqrvdkEox9QE4Ga5ivqwrUPoyn4Okw7tO2am0BWk
	 APHgqITHAE4lOTzMxtmoDz5ydkEDq/Wa4gncfykIhAtk8Wv3TtSAxUJBypSMtaECksvtv
	 6Zl/LLSbzrCnWxG9kg28a+eE061OzQUhIbpfHDTMuouV502wpPa0ATo5RVLciiXGF9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VvsUyW2m;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KpV9QlD8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76313606A325
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 03:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76313606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VvsUyW2m;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KpV9QlD8
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2V1Mt3121825
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 03:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DLrT5Mh7fC5h8PM28yHTHw+H7Tw5FCOseBcBKNYwgUk=; b=VvsUyW2mxCoem6Qz
	k52PYDF93mU2kFdVyPVt1c46WNx3vkyQPzJXLm6a+sOGs0D/nCe5RghCLYt4FoOP
	+iq29gOgHgSa7zsVGaLbmUEUCOLJfwL63S51QuTpO078sL+0L27+EliRUVhGXG51
	7zJHalL2eUH9FTib/3fEFpZmrM+LHG2cTOjxd5I/iKXIvtX73gy8rfRSougUgbc9
	BgoW8+coGFHqvj6HIw/lPh4eTL+ihAAPd7ervl3trCRFRd/n1H/qb2lhjqX3uRX9
	MjOVbCgoUY/vKZEdvjkyXlGFluNj84eYJ0uJYa5gNeE/NxUcfRQr2umUHfjfi9PS
	s79t7Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9gy3b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 03:31:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eaf8ea208bso4606125ad.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 19:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794972663; x=1795577463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DLrT5Mh7fC5h8PM28yHTHw+H7Tw5FCOseBcBKNYwgUk=;
        b=KpV9QlD8kNJTkzacr6vCHk7+67iQ0xgsW0dXYWJwpL51reCUcI68/MZVhItl3s3EQo
         CrOSud/Dnxxt2gGgalQUStFZu8YK/5vpNBJ22ohAnJoTyi6X8/mvAzthrmgHqLm/3urm
         TZyhjxoe3dn5piQsUtSESDCezaNmlgvfUdEeowUlmaLSY15FKl4ia4vkt2wh+1gP4O3X
         E+yrVx3w1XMi3yxEkz9Lr1w6f7KI5UZFyYmT00PZDQG6beZqoR2kJzgUVkbxvNAyoZ3y
         r7kCqJ4n6ENkoXE7Lxe1k1isoCRGWO+G0kFkp1PVr7VyYuak22fUzUEo7M7MS0gfDNXj
         A6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794972663; x=1795577463;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DLrT5Mh7fC5h8PM28yHTHw+H7Tw5FCOseBcBKNYwgUk=;
        b=s6su5YDFuTdSkQpgfSTJ2t+G2cMOlAVcq4aSf6F7gPZ5jHxZAMySjNRHlI52EknD1F
         glFxk1DHShLTTOdp05Y67PznUm5uOnPwCR3JT9LfVS+xjVmg4srUA5S1SrZgR8/mWwLF
         iBDcT+xC39zHpdc3/NsQJQVycV62g7cVSRy8FFvPI3q2/aBG1D6iEFKCUzp57//OAOIy
         N4xW4CznnfeQoJISjLVua59ExtEAM04Tg5TOFTgIP2zQ/izugTuKVfVMh2OdJrUNb47n
         VLdnpfc82cR0zAlhCNnogHB4TcbHsHHD53wkREc49+O7lw+ougZ4XMSfMF7BbVa8f3rG
         C94A==
X-Forwarded-Encrypted: i=1; AL+hErGcNvbuzB4Hqujh+T8PTs4qOpbnU0a7rLS+0eClyeSryL/v72ALK92BCoCe6qras9fFJDbB/Fs0zms=@vger.kernel.org
X-Gm-Message-State: APuU4Z9901BVNt2cRAO2cta9PZwzh1Zia2Kx5sPqHCyTYJSH4eEG6a4c
	DkRtKjpLONn06Lzqmi01QuijtztbEB//zmsPEYu70YFIxOONVHC4pGBzTw3/b3MsRgHJsXW9sJC
	Agbk3r6VzCIKXGILF1yljqwArdtaHI0XqhQZ/OoYzRG8PYkkpbEo2xL0jYEZeRGY=
X-Gm-Gg: AZFdTZfnZXWwCtYNBMqWzvWEYzqVi/6/VKc94sPs/XSvqKbCVVCYle1HiBwVzKqCz38
	UagWyHKAHVHoFL0K1nd5VxBV3oAIAyyru4Kx1gsSx6Er7bIhOKe7UazeJX/IbhC2FwHpd0rcnuL
	FQBP2PXjTJWbvhDGRq1BQm5chh4GXPG5sgXgjndqEWDzHEo0FJoSutL4M5uUSRWi/sZ6ISROMCd
	pq95L8eAPpks5l7Y+QiqWxf2Ckrm2+4G8ewsJrUIuZX79wHFrnGh+MMqEwj6ALN+y7B93Iedb1/
	AUdcErEsn7B04Cyinw+Nt6tmcVRcMEZ28dZY7LsOTgc1jFU+BKf5XmOQnefN1OzNsMT8w3nI/ih
	redfYWuV79BBG7cWZHJJaVzLQoCPXew6uIIqD+vIbNj0zw7ulzGvklUoHeLGcCBCgf+/MhZHmHm
	/Fsih6w4E=
X-Received: by 2002:a17:903:1aab:b0:2ed:42d5:e682 with SMTP id d9443c01a7336-2eff751f06amr11721395ad.41.1794972663136;
        Tue, 17 Nov 2026 19:31:03 -0800 (PST)
X-Received: by 2002:a17:903:1aab:b0:2ed:42d5:e682 with SMTP id d9443c01a7336-2eff751f06amr11721145ad.41.1794972662720;
        Tue, 17 Nov 2026 19:31:02 -0800 (PST)
Received: from [10.218.42.145] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff61162d0sm5287935ad.20.2026.11.17.19.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 19:31:02 -0800 (PST)
Message-ID: <1844d833-caa5-4a35-a601-2da1700c0d9e@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 09:00:56 +0530
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
Subject: Re: [PATCH v2 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add
 qcs8300 16 GT/s PHY
To: Vinod Koul <vkoul@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
 <20261019-monaco_ep-v2-1-852cb9f5d012@oss.qualcomm.com>
 <avWZJr2eIE9KrV77@parshuram>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <avWZJr2eIE9KrV77@parshuram>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qJ_lfEmaRAwKkOzwtnXic2erdEMaivYo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxMyBTYWx0ZWRfX9cFh+CvEAcc0
 GvnxPvWoc1bj7VwWYPbdEoSorOfBKhrP+odwHafhGxQrhgDVgn9xWAoT3jTOMfPSeeqRMqTsuY4
 jDO2Gf3TiJ/bVqdiLTMEG3Gl0f/JiDw=
X-Proofpoint-ORIG-GUID: qJ_lfEmaRAwKkOzwtnXic2erdEMaivYo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxMyBTYWx0ZWRfX4/SE/rwIW/e5
 mN3doig+6MHGAnjySxTnXUQUM2wGlcmVZU/b6IFC1w7SSTSYfu881lbAE+tEgWdrsrBJ/c9T2X1
 vlDOTqYhMfqa1BS3+AYq9XXZszHPkGKAklqvepi1w39sUzKkjJyKJqRWz/xTEJKr28hcAKw+jdc
 QAAEmNvsULzJCxgZWUwNn/i1NSRYYQHXV5BVtDaD5mAe9Kf51RHDjU2/F7qNbhK+L+2uqtoIn4f
 wCgVPj8A7zw52bOUFSGtabmiHGw605/tH49xcudRBEs6mSKOjFC7GGaz9nDoN6wyVHeiStdFh5U
 GkU9Q83tzmn8wy63JBJvAhBMpMS7PapiHJNaLy/t9S5XxEQv0X5oDvEAMHe1Na7KcDdTYrw8xXN
 M4uYHaYf4KJlDBChnsHFv3qNp67HyP2rBmYda6i79b80zQ2+2LOokRMMDRSMFG67AvKzp3z2qUq
 FU+/ObGFFUMZtM4bZDw==
X-Authority-Analysis: v=2.4 cv=RYIFmFtv c=1 sm=1 tr=0 ts=6afd1bf8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UoCkNwF0umAWgb14yFsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180013



On 11/12/2026 4:17 PM, Vinod Koul wrote:
> On 19-10-26, 14:55, Krishna Chaitanya Chundru wrote:
>> The QCS8300 16 GT/s x4 QMP PCIe PHY was previously described using only
>> the qcom,sa8775p-qmp-gen4x4-pcie-phy compatible, since no QCS8300-specific
>> compatible existed for this PHY. This was a mistake, as it left the PHY
>> undocumented as QCS8300 hardware and indistinguishable from SA8775P in
>> the binding.
>>
>> Correct this by documenting a dedicated
>> "qcom,qcs8300-qmp-gen4x4-pcie-phy" compatible, with
>> "qcom,sa8775p-qmp-gen4x4-pcie-phy" listed as its fallback compatible.
> This fails to apply for me on phy/next. Please rebase
Sent V3 after rebasing it[1].

[1] [PATCH v3 0/6] PCI: qcom-ep: Add PCIe Endpoint support for Monaco -
Krishna Chaitanya Chundru
<https://lore.kernel.org/all/20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com/>

- Krishna Chaitanya.
>

