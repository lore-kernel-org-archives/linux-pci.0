Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B9938BF61
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402790; cv=none; b=VqoYS6J1SFBPdydaFro5M3CyX5rLvaRA9TsxS0u2iGlX0y8FK8GJXw1Lbc2ghLwKBsRdbmouGY40Yt02a1R9xXtDEqa0k/N1v/ZhvQilYllH03Me8RtQefqAM9lZ/yP02LFihywajO59kflmHOeN81F5yZUSeKguQyRjK8MZAzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402790; c=relaxed/simple;
	bh=X2kVkngOoCYbBXfNxwdIGv46Mf5xJujGo6Rws6X2rz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOZAZO4sDrjB6jQORdXmv0KsYGBwjNMXc6n1/614+KvDGNyI/XcAYPCuyWfUedhT195H26lQ89j6S4PPd4Zw5bHTRIOBFxIZWkN7NpObnBwgaTNB3NQyX9TLcCKox2THCGAIgGzYZg7LRwPgKVpRJ/xeQ5K/bNEfbsdF16vb0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZZBOJGyy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kk9Yi4Pz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZZBOJGyy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kk9Yi4Pz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66749LxH2676758
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 05:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PsFzlIWDFW9ufDJ3y8kqOTwL3T/qjE2N2Ba9kxqY9L8=; b=ZZBOJGyyIdQ+k3Xs
	B8ufPh8VDIAjkZceS5Kp8fsEj31YL42T+42IbzUFyZ4Xe9JjMozB6/BG8f3vcQra
	/wtX0s+ajO48sTUiTe4z5rPcDnAfyUoLEXXuv6XS3/hWB2LuduX74fRZXxReP0av
	XfV3fg6jb04J4JhvJKlwZ+lMCHR+U6CJDoLQCP8AGIGASRqCabDUusgvREIqYuuv
	i8QafkKOFtoC9P8pEzKItlJv1LgK4sy6UI17Fp6evgG652tfTl6/cKyKeoVbk0fD
	bYsFbGvR75hqkiFn1foyaPhvq0pMNbhva+JPYZVRULy0HtZ3zC3g96YmY9X2k1jU
	tYVgTw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8qj78ses-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 05:39:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88d7a75507so6324286a12.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 22:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783402787; x=1784007587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PsFzlIWDFW9ufDJ3y8kqOTwL3T/qjE2N2Ba9kxqY9L8=;
        b=Kk9Yi4PzjGzZ/VWfrwxlEiATS5nf4a/FwikC0t0uqT7ycC382zaJdYk+eXw3chl5KZ
         UsGHXiV4OPwBAWACXuW1WqT173dHFckDyRMqtiZ2z2Vl9mFlEYxuCXk2eKu7FFE/CMpa
         WlLrt5Q9OUbj5z6agdn9oChPo6cEoQEjahuJm8+VHaVZGFF/0gf9mfWkeIuexEPd9UjT
         Owbm+ok+HoAspDSamGiunBQ2e+yEBB2D7q2cGgVt+qveG8O1dUdGTy75YrN7l2n0EGGg
         jlf9iB6fNjklBahSWq+y/v/2F2Xud65X4Wg/fa3b5CmN9ZQniRUt+MET8qxDI/xEeB4R
         VaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783402787; x=1784007587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsFzlIWDFW9ufDJ3y8kqOTwL3T/qjE2N2Ba9kxqY9L8=;
        b=mmrEJxjEAB2CPupZJKM5z7d/ZfOHIGyftialgZMDAr3nv0eS444DfT1N9D4uzBxkPP
         duQg9c4zHP2XGOhh3KfK4pMQAU8BHJDf5uF0L4U698FCpF/Zfvx+Jgah91AbnfQ4lzyU
         p3tNxpqMg4oKbT3XYRh7om6K18UCBCNqwc405eSCB4TDDogaTyw8GQvXu7z6As/PHOVM
         5SmzDhZxdTzZz4iuYkuns0a9UDin0b+NkACeUxQXE1kvTByTBWyZ1kyk9/T1weUlPBDa
         atKuFnU3RZiVr8DPU3Q9hTCuqodbsf7KCAgr5tJhEvfy1uJfdp51LYL9l8BKNNoAjkxl
         NlyA==
X-Forwarded-Encrypted: i=1; AHgh+RpOla5iu7PeHAlEU5+LQgpyABAvVLkDDa3k6ggM28oBiB/4bVhihv5wK4mdNRKUfpSvWbbqsDGqcGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRav3Upsu1KK0/RCq1LzENxG9mSAUTREEB0JHCW1mgrMBq9vSK
	uQBlfd6YSE1x4GboFwR+KmuPhvigrAskXGdE06N/e949sj2Z3viMAWSGVvuiqcCyboBSfeXYEjj
	T7KHQNtpEy5gOJGOJNli0B4tDFhfeNp50VSpMGiQ2aBc3x6MTcjQA7vJoXKU2roA=
X-Gm-Gg: AfdE7cnvbKSbb4ltTGI2osHceKpn7BAnxTdG9dwPDnLmozfaGVplO9w1s8qLzGTXC9m
	LA9Akoo98H8l9B+fVL+ppsIBx2Wfd3vdByWNJZbjAY2w0JJWEeHsDF9e8vNCyDa4wkP5MQ/zgvE
	vwFFDcdkiZunRdZvXlbHlqYbQ6987exh3z6m+lAe6246IkEPaynn0hULGBk2WHUaPQfRm7buKN4
	Pm7R4P7NvwKg35TrY2hsrDvKVePtTd8HSLcSNO08j5zJ3GBMFlGKzWzeP+mzwc/wvHANYAV3n3C
	VqGn3+ssDebTMZtE/cAq1HGAbx9LYVkd7llMCUnkV7imrTNyUnjxx6FL/P2XqXgxCk61/CoIzCl
	IHptTApmDASGfXsftO4Py1pO0XpOWEuS/7DzOfzhBC8xPlVaCPEeaocjeGzVzGFyquNOvWXZ7C1
	4g5C/1
X-Received: by 2002:a05:6a21:7d04:b0:3bf:a9cb:b794 with SMTP id adf61e73a8af0-3c08eff110emr4454000637.53.1783402787024;
        Mon, 06 Jul 2026 22:39:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:7d04:b0:3bf:a9cb:b794 with SMTP id adf61e73a8af0-3c08eff110emr4453972637.53.1783402786623;
        Mon, 06 Jul 2026 22:39:46 -0700 (PDT)
Received: from ?IPV6:2405:201:c409:b03f:6d0b:bb83:7a67:4093? ([2405:201:c409:b03f:6d0b:bb83:7a67:4093])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3643ecdsm405895a12.24.2026.07.06.22.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 22:39:46 -0700 (PDT)
Message-ID: <86812216-76d0-473a-b1d6-a7a923235755@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:09:39 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dt-bindings: PCI: Add bindings for endpoint gpios
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio
 <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260630192236.GA222338@bhelgaas>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <20260630192236.GA222338@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aCSQzkviAzKci97RhNXRWV2Kqzr6mpjm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1MSBTYWx0ZWRfX9nBGWc6ttJCw
 icn6sct/O09Lqwpx2wXQatUU5tQP/2p9s5Iz5nO8Q8N6j7RW4zjeZ+PM/mCp3ahfbZW/m9WmUW0
 SzMCSIu83c9EpgZiwIDYElAc3gXDj6hBytAYmF9uNGmB/svcTjFb/pgyJlwMS5pKR+lv6BsT5On
 XQDKDb6mPNi6+FEw+sISF/p1EU54CxVp7UpQ5J6Z7d9xb7SJ5xeunXNKNZnesMYs1ixL5y9sOS5
 8ZbNxV4ahvfE8gyiRQ6XqCoQZGN15rGEaHkHYbO3vboQsRCiSdhle4D3wSLeKF4F04FO0xB+Pds
 mGXCuNNwl2wmp28jn2kG3Fh2v1UdAxwRKKfO7guCZfVbd5y5fIV2XJQqrgGxKnrwpBSfBPySZUw
 UJuOiVXySMOuOiXq4C7fyQqKt+7HrfDfaMvbFONskMvNicLNTsTBNE5CnIAWIRu24iAMxHD85ac
 yg75EMUvOvQJL7K5SjQ==
X-Authority-Analysis: v=2.4 cv=PIM/P/qC c=1 sm=1 tr=0 ts=6a4c9123 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=8PoPPqR4NMsTHzUpfcoA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1MSBTYWx0ZWRfX12E9yNHTzGFI
 vvdoeRujfozP/5du5CTqZr8bDfEEZVvYBxv57jNsva+sm7flRs9pY0x7gMk/8hkKOU/7XXsKxzb
 EOZzFvmRsImL7A+30J911H8jUR1ZPBw=
X-Proofpoint-GUID: aCSQzkviAzKci97RhNXRWV2Kqzr6mpjm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070051


On 7/1/2026 12:52 AM, Bjorn Helgaas wrote:
> On Wed, Jul 01, 2026 at 12:32:45AM +0530, Sushrut Shree Trivedi wrote:
>> Add devicetree bindings for TC9563 GPIO's which are
>> used to control endpoint power and reset.
> Include context in subject line.  Regrettably, previous commits to
> toshiba,tc9563.yaml don't include that either, but I think something
> like this would be good:
>
>    dt-bindings: PCI: toshiba,tc9563: Add endpoint GPIO bindings
>
> s/GPIO's/GPIOs/
>
> Wrap to fill 75 columns.

ACK'd.

Sushrut

