Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2A305057
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693245; cv=none; b=V+6lJMFCyhy2i7TxiPkC6HvhfS0RS47NS9/uF9PUyiBmzyquvyGqYc0C+tyd0eGbBtZEePqrIUGqmyLrFSwWPSipONDxPNAHa89xOkQ5K4qU592S5q/IT+PXase3tndIVsgVng3MvGsaxWct4uV4WLALrx+QcdSFqdFiY0rKwns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693245; c=relaxed/simple;
	bh=3H7FmkjCkWwwgeEGWRP7x/C3R8Co3/Fe5TVbE2aRzZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjIIWpRd8we0j/OyYt6ZUB7Av0UAQf/dNQmE1soTUr8kXYzHIn9k49xANNG2aahe6CP/3g2GkPXFvyQ9kBldR/6/xj5TWjyEnX9rcbl4tAgrPtQ3zUVSW8Jy3ZuS1IYJLaT7jl2+3l283FJeuIMr/RGjEv7CpQkBLMCphuNRb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UylOKhJz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A3v9lY1t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UylOKhJz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A3v9lY1t"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8UQDA1703248
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 10:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lGnwrht7Xh9Kn+cD9XO6GFVpkr4FiE5ro5RtFRSjrXc=; b=UylOKhJzUfSuFB2D
	tszaAHPBUP0fkjtDhquWDQBrzIBgBygm9V4IEiHWj5Ow7BuDFqdlgO9WOhdJ4dEG
	7kkPE1JL0AcUUSNhq7KXm87EYBFBry7NhbWIgMkteBvd8dzkGiCVE8wS0RtBEUPz
	QFcp7usEXQUbWr3jLTAkYUS2T+g5Bdj+rxNTSCbhJxM+k+sMqzP0ZpO8B14DnyZ4
	3a5maNV7yzeqsJqhkJws61J1Zr3WOvvmHc83fQsLW004Atli16FATFSY3gixzezU
	2bf1VCBiBq2l4023uX0FwaSWmeYpuu/0It97rRrGGBDMwxsrW8wfwF1Zj5g1IWcn
	rm0JkA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueet2n8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 10:47:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-914b9d0162aso62909985a.2
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781693242; x=1782298042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGnwrht7Xh9Kn+cD9XO6GFVpkr4FiE5ro5RtFRSjrXc=;
        b=A3v9lY1tVNqSS6ASn5fg//3hqxnzqfE7T+53vYsKTBsbFZpK46bcHf2VJ9rxvPignK
         kD1IaC4vfSWkbtiVrQiC4y3pqciL2PDi8fctHkPDqxxyxurDNyu/4d758TY7G2UWXldV
         wzEHUuTxaPg6jRe7BTA3Ecpk3wAqM0zt4W0IRCJVXJry7jIHTzlKY3RwLam26G7O2OwL
         SiggIlTh1Rz5RxHEI5FQc3xhgWULuTe3M8RQ+obLS86qxieh31I6z29+jKUyxsBJw/rU
         o4GRzkKi5vmEn4elkXiIVqsoU9UaioNLE/2DFAuMzVS9MHUmduUbdj3ht1bnva7teR2n
         wicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693242; x=1782298042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGnwrht7Xh9Kn+cD9XO6GFVpkr4FiE5ro5RtFRSjrXc=;
        b=YI7FSf8ffb8HuNbY+YtrhbeW7B8TMD1+lhdjdcpWxeBccsgsp7OWMjMQEAEWxHFX9h
         v0HhehkS2dGUpZygduetHGdCfqgleZjLcNM6maTsVAnfLofrzJRqTEODkHgWXl9Io3cj
         iIizatb/LbaGE8CojAOIldDlAlCJYcqlWi/aE94NByIU9ME0o2kQTtkldkSsS/nfWLFU
         FqBIvPLYAP+jO80rX6d3ai7MLEcWjnI+Zfr/PKbJJ3ofayaOfR/FXxELifeNJjtNZil7
         7omzIcJNkczlzX1HD/UFAKc3Rd6H0y7mmiLAGL9AEHolsdrSevgjtM1pzWPTeCA1bfH4
         hdMw==
X-Forwarded-Encrypted: i=1; AFNElJ+SvvNvgRxKPQlBdTfiXCEOLYz5N/KdiHRDANjczOUMo8ECZrzei9ajIRv6rJ4OMDFIQ23FWPOl8oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQUwoOBzCawQD6i0WiZuC4Uzg/x2ZTrI4xE8ljJKI+U9obQ2jf
	UtJqb/Lw2I5yivsa0SIf+72Oggz+GOnkz/bxTE8jUyk8D0pUprzdtR8R5EyT2eJFyaG6C7BCtQG
	wgqOfyRTYsJbT1foOVcTbqT/N/WAo7o+gwL+z5up8M98PzEPgUNEhW8ZWSNAhhoPJqm2+GAk=
X-Gm-Gg: Acq92OG9b5fctCCCxN2XdaTm7PR7gbhJbon+o/XQ8h26E7TBlNwVOkfaQp5xmdW60gG
	R1iTUwX3t6VnbQ4Fnz+LXv/PcCCOGWJoa0DG8mPAXWQDoj7Jcdaxf6mbN5KetHoFaOsCedtjAPr
	ob3d0pnbD2pE4xt8kFYpOqfC5GhdLT5mcb7yjpdZf140lYDOJssIupM33eDfIFwF4RMYI1e+SSC
	lYCOxL2LfL/BhxrrW1A1Yzb7XW+XkAVpjNdoY0GLpIk+yWFcH7yLkeQYaLIch3NVIaMmYZeWgfe
	YXGcAIhJ3k+Raw/zlsVRlG+w00TXSWWopmgcFYNl/6Rfcy20bVtZPu8jm668sVPwBooLyuTAbXo
	RwAL96zmmd8G6HDRl+RElKHU0rJAohQybIaE=
X-Received: by 2002:a05:620a:31a3:b0:902:daaf:22cd with SMTP id af79cd13be357-91d876acd3bmr318135585a.0.1781693242443;
        Wed, 17 Jun 2026 03:47:22 -0700 (PDT)
X-Received: by 2002:a05:620a:31a3:b0:902:daaf:22cd with SMTP id af79cd13be357-91d876acd3bmr318132985a.0.1781693241992;
        Wed, 17 Jun 2026 03:47:21 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c06d0179a52sm8349166b.42.2026.06.17.03.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 03:47:21 -0700 (PDT)
Message-ID: <f5fd3f31-9e7f-4f49-93c5-b0a6dec9f4cb@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 12:47:17 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5210: Enable PCIe support
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260514-pci-ipq5210-v1-0-a09436200b35@oss.qualcomm.com>
 <20260514-pci-ipq5210-v1-2-a09436200b35@oss.qualcomm.com>
 <dc7cb371-e94e-4f42-87d6-70f0f94d0d49@oss.qualcomm.com>
 <aiFhZsaZJoXzuMSk@hu-varada-blr.qualcomm.com>
 <d291cd03-ffd1-43a0-b4bd-bbad6a4fcec0@oss.qualcomm.com>
 <aifGReQQ12BdgCMb@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aifGReQQ12BdgCMb@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xUC2EJvG8CwphtX-aNjNXpvHBWSX7tvh
X-Authority-Analysis: v=2.4 cv=JufBas4C c=1 sm=1 tr=0 ts=6a327b3b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=MZvN4AuqtkzAMa8ueUYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: xUC2EJvG8CwphtX-aNjNXpvHBWSX7tvh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwMCBTYWx0ZWRfX/t4bTj8i8VW5
 hrJJRF6PtisVQY51chznEWQ1r+dix2lUQUiUl0d4b1ENLtWoDSg+Pl7Ye+qEG5+Z79rBTCmR3jf
 gcWNBbJliN+CSMRSvDTwgUNOyT6D/pABxC51BPkpUBn2HAES/r1IW9+VQrt6tQ6WTA44XwElWWO
 Mf3E2XcsWjRaL0+4XGvNJJxgmoZebkHifoqbNT73ucqlINVn5xXlkG11GE8j7LQvIq4X6nuxdkf
 C9g3p7ESPwZ5/KYVp3JXUDs7RHQWIwxaTb3/DLyalPMG54G+k59HfLUxEjr3nE6ysKnKDlBnXGg
 rBUB7GpEke3BcmKb8RluMQTj9ETf8m463EZBPZFHKSt0cUiXa+RXa4OcwqHMxY7sF+Oc23pNQ4L
 PpxsxmCfzxyg/YNyW+3w0KJ2T7TzS0i/XDVNCWxPPdnicfDgbLgmJg4xRWJD8ggc/0q06G/FQJ1
 3hpGqZfOyhCQ3svyNMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwMCBTYWx0ZWRfX9Drzf+CIugM0
 kGmO76aGo70+yxwVIh8wTbV0asX/uNtsWKRxqQMF5nZSyxw2TKAhFW5YldXFYqR7j/NYkjNKF1X
 0varSKrKd2u9vK9H2Bodb/Eoe2X0bt0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170100

On 6/9/26 9:52 AM, Varadarajan Narayanan wrote:
> On Mon, Jun 08, 2026 at 11:44:56AM +0200, Konrad Dybcio wrote:
>> On 6/4/26 1:28 PM, Varadarajan Narayanan wrote:
>>> On Fri, May 22, 2026 at 02:24:45PM +0200, Konrad Dybcio wrote:
>>>> On 5/14/26 6:13 AM, Varadarajan Narayanan wrote:
>>>>> Add DT entries to enable the PCIe controllers found in ipq5210.
>>>>>
>>>>> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>>>>> ---
>>
>> [...]
>>
>>>>> +
>>>>> +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
>>>>> +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
>>>>> +			reset-names = "phy", "common";
>>>>> +
>>>>> +			#clock-cells = <0>;
>>>>> +			clock-output-names = "gcc_pcie0_pipe_clk_src";
>>>>
>>>> Having a gcc_ prefix here smells fishy..
>>>
>>> Followed what was used in ipq9574, ipq5424 etc. Will remove gcc_ & _src.
>>
>> What is the name of the PHY's output in the clock plan? I would assume
>> it doesn't have gcc_, but it may end in _src..
> 
> In the clock plan it is called as gcc_pcie0_pipe_clk_src and
> gcc_pcie1_pipe_clk_src.

Let's follow prior art (glymur.dtsi) and call it pcie<N>_pipe_clk

Konrad
