Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8BC1CAA78
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072360; cv=none; b=I2QwmNADfXQiDwWTjfy2/xRvpCvwr6uqZN5g5lX4lIlWjLoNJGDk+KAzkxlpQa8lQPIbfCU9GPkFZCQCVbrGMYeNJTosG9Zy2wLZL8ptqMp9SQ3xIJaOZZFqm3jr6EYMflDo2VG8f8/0jJyAf/A+ImYL/zfJTzM3MriyAPy66Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072360; c=relaxed/simple;
	bh=3lbPi/bsw4Cc3WZOQXzyvTxdHo6csw9mkEk8ZHixWx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8WyVhXbRM2VmLwysl+X0vnsoXF8dYxM6/eiw9L+6x7E9Ylm8LhTnNj8A3A999KaokLtrEaZoS21Kg7S/NLv6R4xLj+7KFjOqeP7ydnrdEO0Sh6iRGKWYLJQKxZqoQGTknHWWV4iiOcAqnn64AJ/WBGe6a0O4YbDR0A2Dxy2Hec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pbz1iPxa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NRxrEGhm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pbz1iPxa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NRxrEGhm"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M7mXQw107161
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 08:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CqVbn3OLR8tmVrU+l6rvOR1TWMyoigyowuSm5THHMRg=; b=Pbz1iPxaTE4GI4Gs
	Zm+n0a7sozcGDQOj3vyYcd3jCFG4ly/VDl979dj4prFlQif7qapLfKPWqwiNAsbO
	mY3df+dGaNBZ4m7ExLvMiVwlHaalTiy7NkU6E7S1GNkXyVVKshlN3eduS/AQdmbt
	jgnXe5p3uzO/dzboV2dof/C5Bb+K7tmO7g6YoRqZEuOh5AnscSiHknZ6RxOILVpM
	dqxra9V1cnZcN+s9i54PlMNRE2HKWjQ3D1PtK7xSXi1lTP57VImSt6OHppJ4dUve
	BnyOmZLsQnMYsjyy4uNFtSd4XunIdvrziugDJ2K6SQjYsuJnhbzGk34Mpzbi7dUX
	L61spA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu6pgss93-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 08:59:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-352e6fcd72dso1145438a91.3
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 00:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769072355; x=1769677155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqVbn3OLR8tmVrU+l6rvOR1TWMyoigyowuSm5THHMRg=;
        b=NRxrEGhmU42C1x5cMeybU8nKZeLtaZSlQsZSRpk7yABSyYowrEY/rzdCzDbgFI+rxb
         azkE4LBQH5mId2yGbiBEjnomJ0ngYdLsBZc3t66QbLMWmF5sIS+5OGTfnaStRXy1nDDj
         KmqMgFZAvag8hitCfgGWWCjx0GAC6pQltoJ+OUz9zKpKTIljPa88CMqFKLPK3e8nsiaY
         fTy91Md7GgbehCQolwD2T+oSyPt1Il54yIH6t6vUEbXQUQx9teSjkLrolJKHD9rqyCem
         qZ1O6ZeABqFlUstWJZr7NpQq1qUnxZIDe1uO6OlbuiAd6GZELdqltpjedVI/Hb6p0hu6
         kEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769072355; x=1769677155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqVbn3OLR8tmVrU+l6rvOR1TWMyoigyowuSm5THHMRg=;
        b=ayx0EJsFCE74o66HQOoyZSenMBzKHEPDkTFhgm6+7M+S02Ovh1p1ucjxjZCXos62Jp
         9nHfM99TkLwu30+cXt4U3JPZzellTXx4zTNPOzVSQkxbVc/bNP1SqkAdkqhGpPt5k9pG
         gLlT/R5pdjJo+dp/8rSKNmZD1lWYt/z+yEDMncXcyq/ih16uMYnD2XIqw4qbvfgb9lm/
         dCuyPpQktoy941DPwET+MWR0cYxhZG974wN7lMaWxBhQ74P9FxaUZEmPHE5Dtrstv+kT
         wXwgmSQj5/floWZgaKKLcLvCwksPhXlijYRzWqB01wjHU7MxBkflK27dwRg8nOqmPcqU
         GugA==
X-Forwarded-Encrypted: i=1; AJvYcCV58uqjPW8etJAcdKqjXWSG1Hdbmkgzmxo7PjAFOO2WJ8s68nCnYbBQm2u/cQ7SRN1IgdsXCuZGLg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYsU7eHgg0JVnxaJ2WcDyeT5Cf6kEmMoV1DRE60bt0R3OkQV0m
	X2UE+qOHz6f+DpaUuFMDiILgg79S6fbDQohtE1O4+Tr8sXs+G5DtoI+Jl7oPY5QlNAGjaiOpS5S
	f3LVHz4HXZIKY1JzLp7iYd3eU0rd1Zy0stICw8C2lya2P9IyHgjGoK+aDY5tzjtw=
X-Gm-Gg: AZuq6aK6rQCiSHQpcwtvnjrSNGn7mN0wg9pmtLgxIgoufJtKIBCPnLZ2I1cNKuFQ1+k
	a88eiLjaG+/wk9lQfiNtvN34+VW5FitlfaLtb0EOGCyJ7b+RGTGQr9x/MvjC+2DSEQ/KzDnIh3F
	q5sA0by052tUuFw7nc9tgSgbGuzlyAeUlvGMPSao9KgbDWg1/UHzVPyfzY9Se84XhntXIuSuNa6
	/pjtMwGg9X9xxxGVQYzBgTBa8U2PJd64Z5o0Wxabr/oiIVlAN+BIAt3dcKys+NoADNPs3Bxdyax
	kpaTtkODtJdIyUQC/pSFCQ0Ynir/2cqI/TmSbraqKi1dgnZ1lsT0yU9Dj8eRhfQd9lEewgnBLRq
	2Gv6y5KPodGpiz26IZI2jg1E0JY3VNALPAZ6Z5j8lFA==
X-Received: by 2002:a05:6a21:62c1:b0:37b:98c3:4250 with SMTP id adf61e73a8af0-38e00c2c914mr19744974637.19.1769072355156;
        Thu, 22 Jan 2026 00:59:15 -0800 (PST)
X-Received: by 2002:a05:6a21:62c1:b0:37b:98c3:4250 with SMTP id adf61e73a8af0-38e00c2c914mr19744955637.19.1769072354680;
        Thu, 22 Jan 2026 00:59:14 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf264b9csm16483068a12.15.2026.01.22.00.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 00:59:14 -0800 (PST)
Message-ID: <98e0f3a2-2191-47cb-8c7c-e80f012c83b7@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 14:29:09 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] PCI: qcom: enable Link retain logic for Hamoa
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
 <20260109-link_retain-v1-5-7e6782230f4b@oss.qualcomm.com>
 <woztsrvxwkgi34z3yop7nja6ojbxdboyzz5xpz4xlym75dtyja@iopi7hvw42v7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <woztsrvxwkgi34z3yop7nja6ojbxdboyzz5xpz4xlym75dtyja@iopi7hvw42v7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA2MCBTYWx0ZWRfX+a0qMm16e1pP
 olHZwyzEAweqkGfqWNKsB4kqcLP473H1ld+AH07EwQPJxdJqKd/S3opMRK2NXz5jGQR2ezvpxCw
 ATba1qPgY1KhoRv3i9Gm69yQjN+GnEzMKCs8JEBY2yP3ZW1eW2F7XA6/qJPyxZhFrEH5OOJ0OdQ
 0YWV26/yEx241JhrjhrK7ddbsjnZlHyE4ggejQRtvIhjiaYcUAu1gJpnWLJnj2JvPRbcgnyyxDy
 agw30RBZ/TODexRyIQXrkucunC3PJscI4npAznXJwsTExlTPsrL2SI3CMmMfeIe7DXE/zZFI8e3
 Ik95KVCdSp0g9Q5EfG7iOBqACsbbPLc4gxMZzl92T8q2DQD0A5o5Kmonwk/pxtnjKBew8JBAg6d
 0+I2/YLe1qbLNTZ1A0MtGpLXpw7e7Gof9CR5QG+3rTU/WePFjHfvXj12R4Duars1B4IpHdlOSDd
 JHCKBPFz34dWadGrlUQ==
X-Authority-Analysis: v=2.4 cv=OZGVzxTY c=1 sm=1 tr=0 ts=6971e6e4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=21QzX6uEHMqXofhgfOUA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: wnZIwXigsov6GAt-KTXLFHQqhg9hXA0e
X-Proofpoint-GUID: wnZIwXigsov6GAt-KTXLFHQqhg9hXA0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220060



On 1/9/2026 6:39 PM, Dmitry Baryshkov wrote:
> On Fri, Jan 09, 2026 at 12:51:10PM +0530, Krishna Chaitanya Chundru wrote:
>> The Hamoa platform supports keeping the PCIe link active across
>> bootloader and kernel handoff. To take advantage of this, introduce a
>> specific configuration (cfg_x1e80100) with link_retain = true and
>> update the device match table to use it.
> Why are we enabling it only for this platform?
As mentioned in the cover letter we are not trusting every platform boot 
loaders,
which have initialized the controller to max speed. That is we are 
restricting them to
only for this platform.

- Krishna Chaitanya.
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index bdd5bdb462c5f6814c8311be96411173456b6b14..975671a0dd4757074600d5a0966e94220bb18d8c 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1531,6 +1531,12 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>>   	.no_l0s = true,
>>   };
>>   
>> +static const struct qcom_pcie_cfg cfg_x1e80100 = {
>> +	.ops = &ops_1_21_0,
>> +	.no_l0s = true,
>> +	.link_retain = true,
>> +};
>> +
>>   static const struct qcom_pcie_cfg cfg_fw_managed = {
>>   	.firmware_managed = true,
>>   };
>> @@ -2168,7 +2174,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>>   	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>>   	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>>   	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
>> -	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
>> +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_x1e80100 },
>>   	{ }
>>   };
>>   
>>
>> -- 
>> 2.34.1
>>

