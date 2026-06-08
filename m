Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407A379ED2
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 05:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897344; cv=none; b=sTbF9ilkAyhuY9D9mtD+v83ufa8W8JBrrxXOXM/6hqyDwP5OghBD1Utsp60NQ1jdznCiCzf8D074MjONczOONQFVAIruEo2L7suEKqLYYntYr+y05SdVsf1z+N5dnA5JCAWp4k/IEwUPF3p3u01VvZCTXE4ITeNF7raENsHx9lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897344; c=relaxed/simple;
	bh=2SVr+LQoKjw79sAsIlmnjAWviMMqD7mQYrJApeHgLGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvehetHPdr0DvJ6CQmcZSQfMuR2TH5oTvzBV6ItQXs/pMQcTwHHLtO7rXOgeU/LvyCnWta7bS7F1El1X4+J29z+sVGJWqpLhspzqyU/Bmh7taQ0jMXRtbEpCigb88v9XmCIk9tUFGcvsYgw5aXP280+ANUZ05Ce1N/Vc5ymQUD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hR5qDZcW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a5kWCiUL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hR5qDZcW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a5kWCiUL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580GtFR1992379
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 05:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ufzga7I+3z8dNmCbn4BCdf+K+wlImg+ptma/5JYe8rg=; b=hR5qDZcWrXC+xQzl
	P8Sk7oLb7CBCBqsjwOM8rNWjxfrxvPLgQvSocdvmltik6PU0ywkw+Ce1V4yO94Rn
	u9BS56x/lpCZqPsYPOzXrE1ef2NgOk1O8hNCH7w4rB+AhwpSMr6aOF9zeLp9tZop
	yqujksUDezZAj97s7BhinXFewTL7/fo7HShifnnCv/xLAUDHGBdLvawcIX6MJJLn
	9nf1oq0yPobzc18BfDOVDgGc4HVVTST0kt7SPnayxY0jlV4tjE0GZbLPGe7mqZ6B
	ndtFPuz9odBZ2WvlJ9FriUVzN+6NTiePOQ17NEreafiyGMrNirBLPm3S2Ras0OS3
	/PcoKQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9k3pdmg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 05:42:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2beff6b6e74so41018795ad.1
        for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2026 22:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780897341; x=1781502141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufzga7I+3z8dNmCbn4BCdf+K+wlImg+ptma/5JYe8rg=;
        b=a5kWCiULdI0M1B70/xKsOlws/JqysXPgj1wh3NM7ktuGCx2uYmFMR9kULz6lUZbfOS
         TyuCdP4LWNoirwmBtuTU84Oz3H1qfxwSNtOwIcxH/LAjEiBt0CF6D6jOP/cvV8J5y/nL
         odawfSSzb+mGf8KsmDEpv0hZQeP7olh+T8rPKZo1LqvUPGp7qQSjzrel24IBnZrwmdb3
         X6b9i6LY4CqZ4BuPkn1DknipTx/EURH8OUR43EPsu9Ib7cCWei/9OHUNYhkajgFczQwH
         IZGDI/yrdebqDkSo0pQ/WEKlpf4xL7KoyNx4vlxFUyMoqdW7VHVme65UWUXJhBsPmD8B
         TNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780897341; x=1781502141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufzga7I+3z8dNmCbn4BCdf+K+wlImg+ptma/5JYe8rg=;
        b=KpK/PP+VcbcB4RBD0octWpXUktROlmiWFrUIQXvsiQGKooqDOlM8yu/tRyQ0ym/FwG
         axK7T0PL86qDQo+SMaJr28dbIDVGRQjcKOd7lz2RqEbhg1NzVKYbdjlQW6Pf84v5oPOA
         Nm47rj34KWBkcAr5GjOdJupXihaltvtSP4is0iSbqOSnchop5kyWG7L11yq0JIHiCzjv
         gCAzMmQvI7yfAfIklDCWLS+E14GMfLYwB5ww7N5q773vr86tbZ/j6BUv6pTt4WmNkC/H
         HqmgQ0AsbkXRfjd0pjFg0yHDmyrf/TOLM0lPeQTBCCucex7TUM3UltpJOyrSW+okG6oL
         2mgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+JXX3lckuTlx0pwnHsYXi4b0W4MSTa2/pBcy6J3r1hhKd3P8Qqgpq8m2woJcpp0qLR2AcvN5xoITM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb3/CmBGaNizyOT8fHU38wFPmeZTwkkGzLum6UWZ7cNEkLsqcW
	jPYXW8hDdj3rhTqOidRuFeKaXGMdaugR4ZQpJtXYIhjhoIFU9f54VpbYIG6CdTjkvSDdVKJR3Ij
	KChXvSH7irMuKixXD98I9snyLyo2m5IFgL12Ixd0/BIqHuK8hKPyp5tWkc+OyEPo=
X-Gm-Gg: Acq92OGaYqUlsOLCYUO4REal5vyujeLj6i8ldAQYQuYfzZsL3/rkUj+vjM4clB+aKj8
	sXjX8GquqzZgLSqhnZ69p+rHpfQefR99NoFMCpSXgh9Z+X/ijloGni2veyh6vTPJuv3f/SsHPQn
	lyKNnQB6isvsXGQmPaH87zMGxca1N09jVidiQvLQEKev5pwNY/aoabkXSsblIirNe5tHdt+8XbR
	B2mVbmyEE25HasZgE6yRHlqhcz8ad9jL8vOfwqFUYZD5NtaqOsxKYIUS6cf1xT0Q7X4nIdSntze
	jIE+0a2iS6qTmWnFaOkMmIg46I6gJS0QggaNRuEbIRrjkBXXTNllwj0gM1cni7rB+NZR79ABJiz
	b9mDyWhnznp5BfacVVVi8KeMivtjds/bRCIR5OQ+uaT3eGcschgmMdGLbBEKoz6Pb
X-Received: by 2002:a17:903:2987:b0:2c1:88a1:9830 with SMTP id d9443c01a7336-2c1e7e74ecamr162938005ad.17.1780897341521;
        Sun, 07 Jun 2026 22:42:21 -0700 (PDT)
X-Received: by 2002:a17:903:2987:b0:2c1:88a1:9830 with SMTP id d9443c01a7336-2c1e7e74ecamr162937775ad.17.1780897341107;
        Sun, 07 Jun 2026 22:42:21 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edc8ad7sm40507255ad.42.2026.06.07.22.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 22:42:20 -0700 (PDT)
Message-ID: <29763928-2301-437e-8787-916930b64a88@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 11:12:13 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] phy: qcom: qmp-pcie: Add QMP PCIe PHY support for
 Eliza
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260601-eliza-v2-0-6b44c9c23d5e@oss.qualcomm.com>
 <20260601-eliza-v2-3-6b44c9c23d5e@oss.qualcomm.com>
 <k37nby6lnczb5qajku2shpff4rsisyynlfmzu46lhojl5eiwqo@wkpy2tbeoa3b>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <k37nby6lnczb5qajku2shpff4rsisyynlfmzu46lhojl5eiwqo@wkpy2tbeoa3b>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfX75JmkRzJ/7Da
 Ixcz7v7i6lIkFnoj+EUv1zQ8Taj4VnMrJQQ5rvjlazn4ekpAatTRfNZxW3Bo/iA9sPpT11XLK6Y
 F1nI78XrBIX42/vHuTNeQ7uYAbZlnGn2ilty1/fg/S59bBsRUVItTONllQTVSAbeJECsH7gnbp5
 zmgSMCPTvFrhwIHx8KFiXT9eCQXZopMZvDbUiptHHkus9lmYDDywIg9eyOaFYPJncA6k3SlXRXD
 +Uj0RStpK44lOfPFB2io9f3H31Dm7/RI7NkYRkAstey3CJxLD3US7XbrUtZA84zmiuCKKaD5IgX
 9EyQNJ/8BX7GZF5azu5LbbuF2unANR64YOqaLSYh9e9dFslQ1sVMNnltX7ju2ZSSMg94tsYLSh9
 2M+aPmrq3/xnfqVUDwloirxWDNqFA0cO1QD5W4M/cyqBr3EDQVjz4DlOksgpwh4Onb3ifCyeAvk
 bUG0p/QClyaXp2OXTLw==
X-Proofpoint-ORIG-GUID: 79kX9fJZvHbdz2t4JoSmQwOxV0sSzJjn
X-Proofpoint-GUID: 79kX9fJZvHbdz2t4JoSmQwOxV0sSzJjn
X-Authority-Analysis: v=2.4 cv=TIB1jVla c=1 sm=1 tr=0 ts=6a26563e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=jbukJSVhv8iEu2CO0E0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080049



On 6/7/2026 3:59 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 01, 2026 at 10:59:46PM +0530, Krishna Chaitanya Chundru wrote:
>> Add QMP PCIe PHY support for the Eliza SoC. Introduce a new Gen3x1 PHY
>> configuration with Eliza-specific initialization tables, and reuse the
>> existing sm8550 Gen3x2 configuration for the Gen3x2 PHY instance.
>>
>> Also add the missing QPHY_PCIE_V6_PCS_PCIE_INT_AUX_CLK_CONFIG1 register
>> definition to the PCIe V6 PCS header.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c        | 139 ++++++++++++++++++++++++
>>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h |   1 +
>>  2 files changed, 140 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index fed2fc9bb311..257b4df965c3 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> @@ -198,6 +198,112 @@ static const struct qmp_phy_init_tbl msm8998_pcie_pcs_tbl[] = {
>>  	QMP_PHY_INIT_CFG(QPHY_V3_PCS_SIGDET_CNTRL, 0x03),
>>  };
>>  
>> +static const struct qmp_phy_init_tbl eliza_qmp_gen3x1_pcie_serdes_tbl[] = {
> Thisis exactly the same as SM8550 table, except for three extra writes:
> QSERDES_V6_COM_VCO_TUNE1_MODE0, QSERDES_V6_COM_VCO_TUNE1_MODE1 and
> QSERDES_V6_COM_VCO_TUNE2_MODE1. What are the default values for SM8550?
For sm8550, the default values are different than what eliza is expecting

*PCIE0_QSERDES_PLL_VCO_TUNE1_MODE1*-  0xA *PCIE0_QSERDES_PLL_VCO_TUNE1_MODE0*-
0x53 *PCIE0_QSERDES_PLL_VCO_TUNE2_MODE1*- 0x1

- Krishna Chaitanya.

>> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE1, 0xb4),
>> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE2_MODE1, 0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE0, 0x24),
> Other than that, looks good to me.
>

