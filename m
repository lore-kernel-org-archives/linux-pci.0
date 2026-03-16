Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137071D514E
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773637563; cv=none; b=icOtCTTnwgDDEEmnB6x7QheGxNWVd6AegrT5LsvQ66o7g+ZenlxfmLMztqkmi5SHxSZ+4yTlAsaWVckfoD3S3M4mEUFLDFt8wZ17vSkNWGho1BbGuYk5h52D9Ed6WIq/dHoapkftOga6jvA+Yft7PXavHmWTtwWhgpptiMeoYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773637563; c=relaxed/simple;
	bh=cmPtJVArbnalVMHL9P77T8r3tp7yP6uMQmEhvHzCmKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtlG/xc7vJppMkjUJ+hjUoDFjdHKX3tNlz0/iDhaSIRnEK7ymLUYYmek3ariQbXZjuPSkKekcagNtYLzFNsRx8uVDW8AMcd+0T0CTjFzYXGyt/kuZKWn0Q26pcV2d5bW4VaxyPASlnIrEoeAt7FZAhr7tO5AQtG0CZxprukDrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L8vFrBIZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SCSJUOW8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L8vFrBIZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SCSJUOW8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FMBaMa1130283
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 05:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ckoWtcCrYvxRiEc6lrlI179D5ZlLt7lkcd6EynuVsNU=; b=L8vFrBIZAu/HqOET
	zGLEIgBeyHgC4UnFqtlqasJdkHE1xX6WRgjUJY2HfhqFml6JfutvqxlApQQZJpmf
	UhHAOxFcz7oad62vWRTBMQ3tYjruNLDIq0iOk9K5BWEwVXPpZ70x/Q2YG4/xV9wh
	qMROHofDmlN7tIeOGW2OMayHQYqKdp/1p5zBFPY4x8W/bQUKnJTLhpCb+4pnmNEa
	W88gJxzi8I5CzLbHBKFO/DgizL75rHPCt1sK1tS3sctjQtxXmOvM2mH7wEkaPu7A
	+NfjLbq3DUL+T7n85O8i9yZLERGavsEGzICpM3eRmuouO/cr2cDTnRrth8+2T6ql
	C+enZQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00am8sr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 05:06:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b0554888cfso9934375ad.3
        for <linux-pci@vger.kernel.org>; Sun, 15 Mar 2026 22:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773637560; x=1774242360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckoWtcCrYvxRiEc6lrlI179D5ZlLt7lkcd6EynuVsNU=;
        b=SCSJUOW85e1Mf3DHnETc5aB0ZEflOS6T1s6CLk2bc8eLNl3KWqSM4z2wm8s74t//sY
         NOO5n9Q8Hfs2Asq8g5n4+MEdLzLxcbNeKn80oh7FH2oVB6HdeLd7ufOyxSJm+l1mNMBz
         M+0EFGnW+XEdQHntiGi33RXFBYgfSr7cNT1uxOPwr2cOpXJBn4HvuwQPiGbod/rV1SU7
         0R4n4iXTsguHTxSvOyxbo+9iAyJMlnr98dCUddh7gcGWXxOoVobLlbf2+L6KTHeKSqq8
         5M/nVWreKW61BZ6O4uu55J0J8K7KJgD9RD+IMUtozt/b5BNvvwYzxx/msbsvtzwQvLZ3
         Qkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773637560; x=1774242360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckoWtcCrYvxRiEc6lrlI179D5ZlLt7lkcd6EynuVsNU=;
        b=fxeelNcZj2zRH8o77rWDU20RbZUxzHi+aaOPDjbBIPYUs7OpQuqsQFwzCxrZTDLHCr
         GYQ9qHapqdM840qqaculcrshhyeZzMXvkgnP4s/V/27c7tVULUhXo/5tLoaf/GpuVUw5
         y3Yk5Zge6LxSM9DrxKyBBZHAzPCvrk529Ouy1sH2WX/hkkYu+Eqdg/6Mwrxs5Y/2nLpx
         JMV88nnEKntznHXc07MdZY809sDHpk8KIubvJeA3hJlkAmSp52NVY+sgwHn+7yGRQLUG
         iSWsfEIzE+5IgcXABQxgjHZHds4soTrubtrPR5yzswyq3EVGXGpZND+v6z0JFinyC6Ms
         Jicg==
X-Forwarded-Encrypted: i=1; AJvYcCUxZxNWvniTk/lBltdv9bvy8BRMAF5B2CkwANgOj1qyopzOUfcU4jAUZZSxS6JHUrUx0oReSpXt9wM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvh0OU8ytqizwK0v8+v9Nlgni7UUtV+PgEJvNP1W/6tkc51b0N
	8H+jKXpl/pK3HX3TR1LEPRZ5bOGeilT0pI4vrAcwZIgkdbNbIQAfeu7Kha75ddXE9SfpN6dZiox
	9j8EYzIaxJk2/l5tJGc9Y8H7hbT+9fT8XIG8nZEr9JppPqlKyMDMy3frA6SRNuGY=
X-Gm-Gg: ATEYQzwH7lx9KgCZ1yX65r1rAD5Z8tfhs6zt3BADLz9HHFvpsE7mmfYAXwATlWEv+0V
	9fRxJD03Rz0V3ix+hykeKD5BTNI6Q8is00PVrzXDMjQkUrN7djkFXTP5etvB8HyGYOxILLTBTGa
	jLehOguPDE3Qhca0wrw/q8xBrXAK4EAsagd4vfB0G0p4UXzzTzl3o0WXb9hUvf4Y1Qz3dle7aVG
	N69ZQ/z/jRp8xv+Xay18cZfF2wKVvS827eoDx9ALYokVmw4GsuzWYOEV/hEmuCXMh2vvljLNNWw
	8J8g/1ZpvqmmmlJMgHLN82sxIv2zOAldCh4PU6ufN+s39R66XAEh/siVkhBmG1qgOAAeV7a2zpg
	YnSmhpWANOY+GOqgZYu/Rn55FiVFBW+aWmnh47anZR/1GTGorg/l5KA==
X-Received: by 2002:a17:903:3905:b0:2ae:3d7d:d905 with SMTP id d9443c01a7336-2aecaa18fb8mr132302225ad.23.1773637559927;
        Sun, 15 Mar 2026 22:05:59 -0700 (PDT)
X-Received: by 2002:a17:903:3905:b0:2ae:3d7d:d905 with SMTP id d9443c01a7336-2aecaa18fb8mr132301955ad.23.1773637559455;
        Sun, 15 Mar 2026 22:05:59 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece83ded9sm92962095ad.81.2026.03.15.22.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 22:05:59 -0700 (PDT)
Message-ID: <7ac68128-a3d2-4244-9435-a39f6eec1d1a@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:35:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: qcom: Program T_POWER_ON
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com
References: <20260311-t_power_on_fux-v3-0-9b1f1d09c6f3@oss.qualcomm.com>
 <20260311-t_power_on_fux-v3-3-9b1f1d09c6f3@oss.qualcomm.com>
 <wofjlohumsdyyfhndrdwf4ujxiwlrajm2rpobd6gofpqyasttb@ze54bm6pwbgq>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <wofjlohumsdyyfhndrdwf4ujxiwlrajm2rpobd6gofpqyasttb@ze54bm6pwbgq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fxBv3JrgvfKnkN992A6jSIOKcvF_3GAJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAzNiBTYWx0ZWRfXzUqS/A1e2BuK
 31A37LM6VVpP4+z2VVbLsxQkHoFmDfT0OwmVC6tJIob6MPGe6x3x0auOgWEDZy4sY2oWDR7te8d
 40ci+PRnsY9zpusgDdy7ktNiS8B2X02v4KmvGO55WVNzag087PkiGA1lOxzj1hHjMjv5novWLuf
 b1U3Ri2smtQlR+tjwokojIWZyw3TcUOq1WE0k1kLmB7JB3KMZi/qTdc7QldlgIThz+V7CGMhO2e
 aX5p1R+suSJ8pLEzBbEOAqegYDp1KtEt05mIpBPLWv46V6UqDfbwwO9EQ6Us8JrP5uLHPQc0iuw
 3H7GXHOt4xtrIBj3B4cmPZqU8HVqEh7GYVREtRFxJ5yjfTX0DnO6XFJk4JV6j8/dW4fHZO6stq3
 3ncShDXZ8RN4BcSEPaHHs61U2B3D/g28NUgeLQ87ZR+n0fvtjFaDc+DODiUwTJKFzXnlLHPq/wO
 ZDbGNzYp1E+cjL+ZHqw==
X-Proofpoint-ORIG-GUID: fxBv3JrgvfKnkN992A6jSIOKcvF_3GAJ
X-Authority-Analysis: v=2.4 cv=ebIwvrEH c=1 sm=1 tr=0 ts=69b78fb8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TGbq2H1_L8zW2zdi06cA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160036



On 3/16/2026 10:23 AM, Manivannan Sadhasivam wrote:
> On Wed, Mar 11, 2026 at 06:10:40PM +0530, Krishna Chaitanya Chundru wrote:
>> Some platforms have incorrect T_POWER_ON value programmed in hardware.
>> Generally these will be corrected by bootloaders, but not all targets
>> support bootloaders to program correct values due to that
>> LTR_L1.2_THRESHOLD value calculated by aspm driver can be wrong, which
>> can result in improper L1.2 exit behavior and if AER happens to be
>> supported and enabled, the error may be *reported* via AER.
>>
>> Parse "t-power-on-us" property from each root port node and program them
>> as part of host initialization using dw_pcie_program_t_power_on() before
>> link training.
>>
>> This property in added to the dtschema here[1].
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> Link[1]: https://lore.kernel.org/all/20260205093346.667898-1-krishna.chundru@oss.qualcomm.com/
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 67a16af69ddc75fca1b123e70715e692a91a9135..63d5628e988d3c07f42099c0d86e6b80fd54ce32 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -269,6 +269,7 @@ struct qcom_pcie_perst {
>>   struct qcom_pcie_port {
>>   	struct list_head list;
>>   	struct phy *phy;
>> +	u32 l1ss_t_power_on;
>>   	struct list_head perst;
>>   };
>>   
>> @@ -1283,6 +1284,14 @@ static int qcom_pcie_phy_power_on(struct qcom_pcie *pcie)
>>   	return 0;
>>   }
>>   
>> +static void qcom_pcie_configure_ports(struct qcom_pcie *pcie)
>> +{
>> +	struct qcom_pcie_port *port;
>> +
>> +	list_for_each_entry(port, &pcie->ports, list)
>> +		dw_pcie_program_t_power_on(pcie->pci, port->l1ss_t_power_on);
>> +}
>> +
>>   static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>   {
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> @@ -1317,6 +1326,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>   	dw_pcie_remove_capability(pcie->pci, PCI_CAP_ID_MSIX);
>>   	dw_pcie_remove_ext_capability(pcie->pci, PCI_EXT_CAP_ID_DPC);
>>   
>> +	qcom_pcie_configure_ports(pcie);
>> +
>>   	qcom_pcie_perst_deassert(pcie);
>>   
>>   	if (pcie->cfg->ops->config_sid) {
>> @@ -1759,6 +1770,8 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
>>   	if (ret)
>>   		return ret;
>>   
>> +	of_property_read_u32(node, "t-power-on-us", &port->l1ss_t_power_on);
>> +
> Since this is going to be common for all controller drivers, it'd be good to
> move this inside the dwc API.
As this per root port, we can summit changes to merge first so that we 
can move this to
dwc.

- Krishna Chaitanya.
>
> - Mani
>

