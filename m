Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3659A30FC26
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700993; cv=none; b=QR/wN+HOceyV/4npR4uhcnLKv+8HWFLlpx+fdGPW8uL5WcRdMj2LTRLLn4/yEDjdwv1GSdK2za6qeRyNL/9irnXJLeMvT7U6j7L/v+lqQ/T7LZQXFA3K23OsHAXr9H4hZ+A4nydO1E9h9LoAK2blGpAT8OijiDUBWFdr7kkRg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700993; c=relaxed/simple;
	bh=XOUtMxJmY/xukrKRhAKSN7CNtGlaNNQUyMKgIxDbAXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxTUQUSNY4vquxzKcuYFPu3zS08o1168iU8WKekqzRcL1wceHhEQ4dPjPbKdewuKj0Z5IoMA7/yU7iNiYHT2WIyoYpPeMNPQuvWJ1aN2zyWSZwWOjjCRAmkf5ITBqi3HSCGG7R8/cn3qkhPD9utbNJQZjXYPmvJM2NOqa2DgCps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jLlZPU/X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V7tSsJ+c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jLlZPU/X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V7tSsJ+c"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6251Bktv628707
	for <linux-pci@vger.kernel.org>; Thu, 5 Mar 2026 08:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V3eDqJ6jpq/KisFt7ksH/4aFqk3PdilfLAwISDAZsjU=; b=jLlZPU/X1OCwF0wF
	1UcdeX6avnQUDkUN05L8dAbQAN9kQJSjq1JuhbrHdM+l0bcNeZdPLU8AeldOtikO
	ZVO/yTrlt5W9h0Rhr0Ny8zDx8jqgypT4tpQcyCWAGhLTewI+FGp36qDakLgCIFNU
	crO9KULtNdiuY7AZUmPC2gP4iHSR3OMBCC3I8ZFsrcccbimQiZOOAdq0czBVP85e
	0OIkIVYunJZcU3D2vRJ3hh/P6IiYn++rOdPecUFwau2+hGYGmKNgti0f1qqf1uiJ
	Ub14ovt9Eag1EA9ugWUu2vNHof1rl9P147S+TtZn9m0rEiYP6MlRne/HpCcAWgpJ
	9gQimg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0m2k7v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 08:56:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae502a1dd9so55127425ad.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 00:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772700990; x=1773305790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V3eDqJ6jpq/KisFt7ksH/4aFqk3PdilfLAwISDAZsjU=;
        b=V7tSsJ+ci4kYkR6nDVOlrXbnjPtSqw8fW+DItokiuZ9O3T0GPFk3VC5rhWiEvmWmPq
         qDZv1HWomA4c9vHLX/LAZE0fUDzyCQ53H3nMpjmNeEXpYOpSpUQxjaDSN5W6gk8eXLNO
         EgqhNV3hZ0RGQ++82arUJkfIib0Wa8LZtPTMXi8bRzMya+ePGOvOSIcR7U4V45JloFu4
         Ippca9lXXaCMp3fnfsL0GrLEvg8H7BOIdbmIL/KuLjvjo5Wu7ftwI4KHrjZxJgSxrszj
         4lHC1WebHMaDGCTr1MW4z/vD2TJJ+4kAswzpl+a8+qbSSdx2jIhdFjzcVyamPUa9oBEW
         QZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772700990; x=1773305790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3eDqJ6jpq/KisFt7ksH/4aFqk3PdilfLAwISDAZsjU=;
        b=I3CcZ+dnu9zvWxuA7FCdiclCTJHny/jLrpJTmaKhTP9wwWD5tIM4Y0i7k8hKYakXMg
         EGtfeE13PGVaUhuLINbE7Z3Dinl+HlrHuDAgSgmCQD645Bzcshtr9C12aP3B9rNOXoro
         qfZjql3SbYo8sV7npFTGIbNROMffYi5NFHfKvuwaxvkHLCu17Talu6pscYy87cj68gOD
         kqeErVlLtLtv6oD5Ju6x5I5iBZKQE0iFM3nqXeB9+stUNiHJIzBnciEVBe3mfdPAmy6F
         g4iuEVG52cZeb+NHTBOB/k0VtQKbXg+Ve+Eb3hlC5qPgzOwSHjAobqYD+RyM237u5tkP
         6ehg==
X-Forwarded-Encrypted: i=1; AJvYcCXexvOlYW1tffjXCda87zOMl9HFApdFlN2gBA3Rr1JgnRKIOoRlqxZ1P1bIKwFNgwg8LCgzs/0ub9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEBDUdHwxphkiEG6cXEFUsSMmi5ryFWV9X9wwSn+9hXsBXLmmy
	/mkqNcnHVVMe+A/m+mL2GpsOqNMBGp/V41l9IpMt+GFY+gSZBnWVio7RGoIgsxOMc29HFfukWXk
	6mYaIwjIlKw68vOrFIfeutpG2G4BY7KbsvgK3LMynPmuKff3+MS1WlH9m14Nczqw=
X-Gm-Gg: ATEYQzwoFi3VGGCcFM6En7Dwyg8JCwdRzkmuzDtaBP4JK34tiu13DjSB+a31Zl9OeQa
	nI3X7tUcH5Mvae4Ycpyf97szNHdr+8blbL7wFYnLPWC8AM5wWr6zB7iiRflCcgrjb5KYEK4+5VV
	RsnD3WBufX6UPcRY+yAzvGIedQ0phQZn32N6VhjzeTwgjgIckPqdTjEtoZG4IdthSwAwxD7mN4o
	soSdTdPZCWCQKtfXcuFqc07pqZXWfFEY89SimWmi+c1pvWcUbJJ4Gi3wwecmkMLl9ZXvt7ApVo6
	Sl/Bk4MXf8HSsEpwGFkaastwqa7NzIs0k6oIr/FBuUqcDL84IRnWgYTbhkj7t8VGuAc3BB6tWZc
	CqxPyeGZrQH/4SKlWU9N73aaHa4kAF1MAYYEu9juxJra3AEVS3vmxsA==
X-Received: by 2002:a17:903:388e:b0:2ad:ba80:df62 with SMTP id d9443c01a7336-2ae6aae8d8amr47956825ad.37.1772700990103;
        Thu, 05 Mar 2026 00:56:30 -0800 (PST)
X-Received: by 2002:a17:903:388e:b0:2ad:ba80:df62 with SMTP id d9443c01a7336-2ae6aae8d8amr47956585ad.37.1772700989632;
        Thu, 05 Mar 2026 00:56:29 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6bb5b2sm224434525ad.69.2026.03.05.00.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 00:56:29 -0800 (PST)
Message-ID: <313d2262-56e4-49b0-8455-2b46d0966976@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 14:26:22 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] PCI: qcom: Power down PHY via PARF_PHY_CTRL before
 disabling rails/clocks
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jonathanh@nvidia.com,
        bjorn.andersson@oss.qualcomm.com
References: <20260217-d3cold-v2-0-89b322864043@oss.qualcomm.com>
 <20260217-d3cold-v2-4-89b322864043@oss.qualcomm.com>
 <to6p7yf2oo5qh37hsye4zpputrc7p4bwgqvjc2plieuyapjdhp@7xshxghi4tzd>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <to6p7yf2oo5qh37hsye4zpputrc7p4bwgqvjc2plieuyapjdhp@7xshxghi4tzd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e6wLiKp/ c=1 sm=1 tr=0 ts=69a9453f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=kJBpcOZ6olZWUerAqwAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: SKaFR-dxGPwi4Nk6_PmY9Z3W3niu8FT3
X-Proofpoint-GUID: SKaFR-dxGPwi4Nk6_PmY9Z3W3niu8FT3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3MSBTYWx0ZWRfX5G7HFr1KEHCS
 q7dse4/yGP+K2jKzS3s4QTaD3MsxA2Kekdx5oK7w83OSWJofI6gdG/0oOllX8QFppnkybYUPjo0
 C3DPutrzPddV5DUvq8+/dHmR4QtXJTkDDjc/XVwtXMJ1MstgwhZ+7dSprnMNV/9pkfIUtz0Mupm
 2uiUOgq1/vAEqm6tUXsCh8fv/rtK3rULQJ8jXYweKCVSfiiyuIvnkTIDUQTrsLKm6WBOe+b2qtr
 n9lyv/FdhaDe6gDh2ZwcQLmj5WJSCvPHtMCWR63Vsa564TcpBzbkvQo2ClM5xHfNhsFOUVRFIzU
 f4JKP1yd09hwtRBSqAqX7b9HXjuT9WCjDKj4ObrsgYaYownH0sNo16/+c00hBM91gpDiYccj+DF
 O919NZ/VUnBxq94wJn3BANQ0LphPZTM+vKWGbXSGKrhIV9LHY6EougM1LKce4JaPL0YXcizVs3D
 YYDKX+uNE9mMC4pqiCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050071



On 3/5/2026 1:19 PM, Manivannan Sadhasivam wrote:
> On Tue, Feb 17, 2026 at 04:49:09PM +0530, Krishna Chaitanya Chundru wrote:
>> Some Qcom PCIe controller variants bring the PHY out of test power-down
>> (PHY_TEST_PWR_DOWN) during init. When the link is later transitioned
>> towards D3cold and the driver disables PCIe clocks and/or regulators
>> without explicitly re-asserting PHY_TEST_PWR_DOWN, the PHY can remain
>> partially powered, leading to avoidable power leakage.
>>
>> Update the init-path comments to reflect that PARF_PHY_CTRL is used to
>> power the PHY on. Also, for controller revisions that enable PHY power
>> in init (2.3.2, 2.3.3, 2.7.0 and 2.9.0), explicitly power the PHY down
>> via PARF_PHY_CTRL in the deinit path before disabling clocks/regulators.
>>
>> This ensures the PHY is put into a defined low-power state prior to
>> removing its supplies, preventing leakage when entering D3cold.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 30 +++++++++++++++++++++++++++---
>>   1 file changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 2c4dc7134e006d3530a809f1bcc1a6488d4632ad..b02c19bbdf2ea5db252c2a0281a569bb3a0cc497 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -513,7 +513,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
>>   	u32 val;
>>   	int ret;
>>   
>> -	/* enable PCIe clocks and resets */
>> +	/* PHY power ON */
> This comment is confusing since we already have phy_power_on() API. What does
> really happen in the 'test power down' case?
QCOM PCIe controller wrapper has way to force the entire PHY into lowest 
power
state by turning everything off, without this bit being cleared the phy 
will not be
powered on even after phy_power_on(), we can think this as a kind of switch
from the controller side to power on phy.

- Krishna Chaitanya.
> - Mani
>
>>   	val = readl(pcie->parf + PARF_PHY_CTRL);
>>   	val &= ~PHY_TEST_PWR_DOWN;
>>   	writel(val, pcie->parf + PARF_PHY_CTRL);
>> @@ -680,6 +680,12 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
>>   static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
>>   {
>>   	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
>> +	u32 val;
>> +
>> +	/* PHY Power down */
>> +	val = readl(pcie->parf + PARF_PHY_CTRL);
>> +	val |= PHY_TEST_PWR_DOWN;
>> +	writel(val, pcie->parf + PARF_PHY_CTRL);
>>   
>>   	clk_bulk_disable_unprepare(res->num_clks, res->clks);
>>   	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>> @@ -712,7 +718,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
>>   {
>>   	u32 val;
>>   
>> -	/* enable PCIe clocks and resets */
>> +	/* PHY Power ON */
>>   	val = readl(pcie->parf + PARF_PHY_CTRL);
>>   	val &= ~PHY_TEST_PWR_DOWN;
>>   	writel(val, pcie->parf + PARF_PHY_CTRL);
>> @@ -844,6 +850,12 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
>>   static void qcom_pcie_deinit_2_3_3(struct qcom_pcie *pcie)
>>   {
>>   	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
>> +	u32 val;
>> +
>> +	/* PHY Power down */
>> +	val = readl(pcie->parf + PARF_PHY_CTRL);
>> +	val |= PHY_TEST_PWR_DOWN;
>> +	writel(val, pcie->parf + PARF_PHY_CTRL);
>>   
>>   	clk_bulk_disable_unprepare(res->num_clks, res->clks);
>>   }
>> @@ -994,7 +1006,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>>   	/* configure PCIe to RC mode */
>>   	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
>>   
>> -	/* enable PCIe clocks and resets */
>> +	/* PHY power ON */
>>   	val = readl(pcie->parf + PARF_PHY_CTRL);
>>   	val &= ~PHY_TEST_PWR_DOWN;
>>   	writel(val, pcie->parf + PARF_PHY_CTRL);
>> @@ -1065,6 +1077,12 @@ static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
>>   static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>>   {
>>   	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>> +	u32 val;
>> +
>> +	/* PHY Power down */
>> +	val = readl(pcie->parf + PARF_PHY_CTRL);
>> +	val |= PHY_TEST_PWR_DOWN;
>> +	writel(val, pcie->parf + PARF_PHY_CTRL);
>>   
>>   	clk_bulk_disable_unprepare(res->num_clks, res->clks);
>>   
>> @@ -1169,6 +1187,12 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
>>   static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
>>   {
>>   	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>> +	u32 val;
>> +
>> +	/* PHY Power down */
>> +	val = readl(pcie->parf + PARF_PHY_CTRL);
>> +	val |= PHY_TEST_PWR_DOWN;
>> +	writel(val, pcie->parf + PARF_PHY_CTRL);
>>   
>>   	clk_bulk_disable_unprepare(res->num_clks, res->clks);
>>   }
>>
>> -- 
>> 2.34.1
>>

