Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2901C43B3DE
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 05:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449798; cv=none; b=CxI7ICswvppEOH8KHg5lmYJY1sDNcS2KeoK6PUCfNxPtYSWvLXgQhdmOJTsQefsDr/mU9PrfDS15iKuOiaKyDcyhJP1aWDvEzT0sRgClIs+ZcfDSg3qarOH2MPBNvShcSFTMS070t0Q4C1ZQ/bWi+NP31ZW5hu15n3b9zW93WBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449798; c=relaxed/simple;
	bh=tI4DS4Edvy3z9i1bmkDFio0fZbfcmUH+lpsjB7VpXlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWIhs+LgiPa/9tMQX1L6PjnlJHcXwYGwiy5FJDVgKsiyZ/Q+yOd+IiEy4syebq9N/Iv9QuL26Rs49IkfvFm1g03xMZLFAfUJC+YTi9K3ENvcC8LXwVIFU1bf5XBb3l29PmrjKqizxaq1DYfkJQ/WC3ASmpZ82PMH5qC51dyNr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FLxnoxmx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K0UlH1ui; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FLxnoxmx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K0UlH1ui"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F2nRqm2477904
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 05:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ahgAtWxFRwy6cq9ng7VxTyalhlNA7iHoeeWQVniYX/M=; b=FLxnoxmxl1XZ9BBw
	QGUKqn7DwFY+nscNlV5bzxzE5NYptx/u/ZetxDR/DgLEXefEfoq4lElggx52WT0W
	WzYRzr5x+bWp0cGDSYDzLWPNYrXpq3VXboGjrFcYsWps9HwrJC2upheBRjYPVRwi
	oinwl4uZMM1Rne54+hldIo+E36rnd2Fj6r6YFrLRlHKz0d5LBh6nQHufFmGuLNi6
	A/qxihasUaHfrc8tHFRMAAtvbk0T4GPrt1893cotV7QMPVwx/H+TLo69Zw2m+e4+
	58YPcFlU51DoJP+0tzZLgA/3hm0OsSWPL+KgM8eolcsLYQweqqNPja/0kep5/f9r
	1ncUsw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpnet2d37-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 05:23:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dd753a52bbso15608055ad.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 22:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789449791; x=1790054591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ahgAtWxFRwy6cq9ng7VxTyalhlNA7iHoeeWQVniYX/M=;
        b=K0UlH1uijS38bLbCVGbSC6qJ9Kr3n0BggORQZn3VHX1aLZyj/ovgW1sGcd4SezUC2u
         FuwKV4tEpeZ7U3ob3h/QQuId2XVrL/W6S/0uxn21CXra0Xg7WgMK0wKH802X1bfjwaS8
         b14w9MOCqx1HYVG6CcPAfQw1wG2S8M1QNy47yFWeMUQjp4GJ3U9SA2FqtaYyFoIMgwX7
         rqzhdGAWtQAbkzde3IGUGDb0bKwfI6PEGewB+lm5ba/2/PqcFzuTpo95QyTeUHyEirAx
         wZWocQnGk5HCIISPQtCd9ae41fffBEVrPsIBJvtFxirR7phoMxCD8DcjLoDtEm1JloS3
         L29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789449791; x=1790054591;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ahgAtWxFRwy6cq9ng7VxTyalhlNA7iHoeeWQVniYX/M=;
        b=izFHHKtjczorkDnqH/YZL8aUt8zpRUk4H9HJxcIdVsPq8tOyi6CZs7Wu8ZZkYR5tnj
         uuB5MwVJ5SFIYj6ZwGFxN1nQZU0sxSJaEXnfZu5lH/SfZgIIzMmAJdKKVcE9fasyw7zU
         m8sy6rVXGklJosVKA6jyuse0bsXdOUuDZqpKtQBHoTAiSKBxZRzdtEye2Nlh/sZq+QZC
         pvjPvNvuTjq/ATk3KFmIbXXWQV4S0Dy4bTNPqU47WTrG2XI0hFStMnDBQut7GHS/0t07
         zi2QNox1uBplJlGrFttfAT/tGjiATQryejPbi/3wGDB/gWi+riqgFQXIKhoQVUcaQbbs
         K3IQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYCwuvJ5u1S+XldKKhBgDCaJ+slu3YJq/OmZRWD4Yvam8gNs91Ach2m52vi7djhB9qEOc8MTdZsiI=@vger.kernel.org
X-Gm-Message-State: AFuF++mQx6GiRQVefa+obtb9Zh5G97zBEBrl4nNTyXwknoP2MNch59iq
	wPfirhc9IacQ2IST14iH6S+qSHJRSmC130X1wShcbaMJZQovSRLRA6ri1zR+0KfmR3A7dDIS+DZ
	g762vR0h7uvIor5vkuNZKop4iP+5Z3cvnE/QDmqgdkf+fq0MLyG1JAN8rjLokKWg=
X-Gm-Gg: AYBFou0UhB5YOQvtq2Mj07tO8FysAM8RV3g9FzBIvRHhesPp4FWPSDLkPKu6tv3cgtN
	raPuM6bG35NpsXL3enbCBf2+8Qkc+8rLlM6eAdoKr4RZuvSl4RPcCPHBCgW+DOdrbtzeNpoPsHs
	Qggfa9wQTSzx5sXe8EqAqamfG7fay/k0HJRML13oLPwOqnLG2C1XsVAq2EutaZRsjNhqSqI/zlG
	qxjnTSrSZb5gmmfHkIXkVkztllh6IoUzkDzMvEjSg2JfT2Dy6ZvTVuhgWvFuL/dD8D+e6VQ45Lg
	2lD632Rsv9JE19AdDgAgPPo93XklBUDjuyEpaHINSH/3gnr7lbIA6WsvIsx40W5ad2SJjvemz50
	x7ux7NV5TV4ZT9kdW3B1z5YwcRGEIbKTd
X-Received: by 2002:a05:6a20:728e:b0:3d3:aec2:4dc8 with SMTP id adf61e73a8af0-3db4059257dmr12375119637.20.1789449791085;
        Mon, 14 Sep 2026 22:23:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:728e:b0:3d3:aec2:4dc8 with SMTP id adf61e73a8af0-3db4059257dmr12375051637.20.1789449790628;
        Mon, 14 Sep 2026 22:23:10 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4cf015csm33549798eec.4.2026.09.14.22.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 22:23:10 -0700 (PDT)
Message-ID: <3e28ec09-4378-4cd7-b786-ddee520db5eb@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 10:53:03 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: phy: qcom: add Nord QMP PCIe PHY
 binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        shengchao.guo@oss.qualcomm.com
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-1-b0a82721c547@oss.qualcomm.com>
 <20260910-neat-goat-of-prosperity-eeecaf@quoll>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260910-neat-goat-of-prosperity-eeecaf@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA3NCBTYWx0ZWRfX9q5wzgAVc/eL
 LwgM/wA5vpgbavyTuqIo9tyvDeXJ8viPCfFoJIIVQToCZ6YU8iWdpJ472t9iBsfhH05YnbKYy+m
 HK1arhkNR8bwKqIVagfla6eOMARtFgE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA3NCBTYWx0ZWRfXyYRNsvo+Mh2U
 VlY3JIb4ctH1TqyWz9gXQpXJLBceLwG5UqSrufZbDKYPckT882yKwZbZiKJPGVcEV+0PyB1770V
 8mqk3DoM0bKFCUJOfycwaCOGiwSTY4ObsiFEBvaMO7zkvrcMrLA97oHGSUUWixzHVp1TKwU4cz5
 y81r/2+pQataU0ypYxaer3K+bNy9sQinoYuFyQCxOmaw2V3UBzXqnWOOGrQHbD8hQmExKmgDkpz
 ET7A6aJosl4wVjCjNoHOKjHfF2Hmmn6olqTDmbhAC/e87/xkRYhIP9Is0it+MWlrpTTVc+fXMZv
 mjS0hZknjFtKnjWZjs4Pesjs2QKyK063cLUcGTgizgxq9dVjnb3za9VMGeQIRihcNJYH66XVCKv
 YPafTwKzepORdXOWDTcABTh0lga/P+NIiMwyB5mFYe/r/OT4oyJDTSlRbFuvcfOSp3eDBb8MY9z
 HHMPEUtBT9GXCO34SwA==
X-Authority-Analysis: v=2.4 cv=PKKaavqC c=1 sm=1 tr=0 ts=6aa8d63f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bnyAZr9--xUIB8vRdWUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: HAqC80wtuqweqQ13y-js_9Uj3_g75x5Y
X-Proofpoint-ORIG-GUID: HAqC80wtuqweqQ13y-js_9Uj3_g75x5Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150074



On 9/10/2026 3:33 PM, Krzysztof Kozlowski wrote:
> On Wed, Sep 09, 2026 at 05:18:16PM +0530, Krishna Chaitanya Chundru wrote:
>> +  vdda-phy-a-supply: true
>> +
>> +  vdda-phy-b-supply: true
>> +
>> +  vdda-phy-c-supply: true
>> +
>> +  vdda-phy-d-supply: true
>> +
>> +  vdda-pll-a-supply: true
>> +
>> +  vdda-pll-b-supply: true
>> +
>> +  vdda-pll-c-supply: true
>> +
>> +  vdda-pll-d-supply: true
>> +
>> +  qcom,link-mode:
>> +    description: |
>> +      Reference to the TCSR syscon and the offset of the
>> +      TCSR_PCIE_LINK_CONFIG_MODE register.
>> +        0 (QMP_PCIE_NORD_MODE_X16)        — all ports ganged as x16
>> +        1 (QMP_PCIE_NORD_MODE_X8_X8)      — x8 (port A) + x8 (port B+C+D)
>> +        2 (QMP_PCIE_NORD_MODE_X8_X4_X4)   — x8 (A) + x4 (B) + x4 (C+D)
>> +        3 (QMP_PCIE_NORD_MODE_X8_X4_X2_X2)— x8 (A) + x4 (B) + x2 (C) + x2 (D)
> What does this mean? The phy working mode is defined by phy-cells
> argument, so what are these numbers above?
I wasn't clear on the description of phy-cells properly, we need phy-cells to
be 1, so
that controller nodes can reference phy with index indicating which port of
phy being used.

I will update the description in next series.

The TCSR register is the real value programmed by TZ to tell which mode we are
currently
operating.

- Krishna Chaitanya.
>
> Best regards,
> Krzysztof
>

