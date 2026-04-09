Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD85199FAC;
	Thu,  9 Apr 2026 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775714193; cv=fail; b=kuXyu/I3fu9+aUAIXuPzqq/eJwRpA3DmnyODrkXKJuj2YAsIKQgOstmokyS0fzJYhw/I5RgmnTgSQTIg5oF8sHyjWBWB3ZzmiUYmhIjZEXVi6EK1fBML01cLk7WwABn8LM37cic0i5dJkDefRYTBk72BSPaKECb8rdX/jMGHkn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775714193; c=relaxed/simple;
	bh=b3xeJ9zeOHyKZcaCwr4IdDv/Yb8HfNP5+Saiv9qQ9dw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yy9dMPFe7CmZBwaY6/zJBllcLWDhxjuECnEIfDqMxcM1r4s8toF3+/wS4iCfmNc+N3NJ9ntaXL2bQWafRnNKckZoQUcMIMR0ph2ctsXV9xnnN8AV2I6eit3ktcSLnpg45KlUMMULZQqca/jfenyknEJ4fB9Ol84HhvKTgsNK9bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NsiVjHDR; arc=fail smtp.client-ip=52.101.52.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NsiVjHDR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlMaAHqtEP78GVv5mb7jV3WN4JrYDEbECK/wxYvXI591vv+b0etVqaOmN2trjilP5v0Tv2tShGUeZr6eYBA/4RGKebY34jBWtC1WX+BfNXdLb+prloi77MXhCfvwagcB/kZk2BpQ1GrGx22Ynhc6xesFfdwzxL4HqpBhiC8mZ5gFHHxp1heogHEJhMp4klPM5diPuSvn8N24dZYPpFZ+aNJ86+JA/jGzkf7QZrCV3oWI2ZUdxPV6uxPiyoD4LyJPjfzP03iR629v4qQitKPlBVQJJVEdK5AUl7632eAYlinaM/yOj9ELlp9xui/UFoy70AN9fB41SxsFjaPJhJaaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn68mtQV97IIIL50SIyuZJ4s8TqyrzXH7JoZ77E6//k=;
 b=hU0iSvafy0od8NR6xn9JBbsYI7SgAMjKMqy9pEaXDOLOUclAQQBWvlIdqUtq+TWKxkvw+9RTzRKt2i223UxFesA8g7EyUYtjpSIXhsidtPp/xVNS5unO4HCGNmgwI0cTK1GAu5OdT0Yq7aWrj1aDujJxil/loSjQBSkhzynr+Bocro14cyn0i0FfoOJj+6Y8G4xhZKmF+Hwq1w3YHivnXhIV846SltIzLaoKZNGRM5jNlbCv51L9aV4u/qwORPvlHiK3bb5PvwUWCMIHZ8QuR31L1bbxuTHYEPIl0sgDwqw0Q2xlqwdildbU7+mX9UP9bAStCzcvfEf3vWnk2aLi8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn68mtQV97IIIL50SIyuZJ4s8TqyrzXH7JoZ77E6//k=;
 b=NsiVjHDRmG2G2hpeW/l8KsPnU7dCaa6lIusvs6Tc2Pzzy/Jry5hwMp4Z+J/JnWnAd7r0YdFrlwzPTv/cdTkeP5sIelnWcAEiP9e5kL2G/QrY++KcGTDcVMHE4m3F+8k+sgQMIAYzwX57H1pXEojPqGjMqKqvXa5Bq2iOIAgbXCk53DjkfIxSaz9o+TKYBmEjKkVDZXraWAHrcBWMlG/P10sSJFv8Uvgvh5ZzpLkbyE8rbsK7P1/boo4POnThPZAMAbQWAInLH1rU/047GGhhW7IG8DfM+45EO5LBPsAlKs9//Bw5giYVfjSr1NBjSBg775WdeBOSlqYF6bcrH7A93A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 05:56:26 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 05:56:26 +0000
Message-ID: <bb6583dd-7a30-4601-88b9-041ae3615860@nvidia.com>
Date: Thu, 9 Apr 2026 11:26:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 9/9] PCI: tegra194: Use aspm-l1-entry-delay-ns DT
 property for L1 entrance latency
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, Frank.Li@nxp.com,
 den@valinux.co.jp, hongxing.zhu@nxp.com, jingoohan1@gmail.com,
 vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com,
 linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260408223027.GA371101@bhelgaas>
Content-Language: en-US
X-Nvconfidentiality: nvpublic
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260408223027.GA371101@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::12) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 03529f44-38d8-4554-fd61-08de95fcbc9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xc2N1huBIKMzxIP6hc1mwOzPrbiOZ4vopenn9OrtFf+75KEWt5Wja5o5mhWNmrFNWEnn1sDQmG/rAyELLp7SIBH0//a9ZsBfgUT2c8/wJH773hKbJTm9F+eplUeoMl0WH4oCXfyivPHH7Vey17NE3QHL0KCU2h4XAsOvsQ2h4yqqWQBD0mTFATVacwYf6uiKDt2Pu7J7GZIgkq7ERyrOoS/qxztBpEONooUTw2BZ0qNNksBjqBBjZ3quVPAN7mUN7S8fW0UNMzoj306FyWBPHYbjfP8km4EOK+QSkvU/hMGU17Xi9up0SrgXwY/5TNbyNTtzn4Q34/xkQ1hzmeqya8ma+toVAV4NVbIBQKTtLTGEZFmKHYLZwCl/xZNbcHtR+mWSjo/RvxDFwfbk2UwK4akVlKHzbeCRHR3xCOJlAP0S5e+lXad6Qa18Q+5DAnhtLzHKdRzWwReVAtIwUjRdSTbbDVywKLAyZXRiqo7QpUsIDtPD4zmHRJFY4QBmmKC2Fp5Mx+EGrOH8+tNilOukE0A6xZvG4AuAEj8z8wRSgCokv0YvWxWlvNBxZjUONCao6UdzGnQhKDTjJ43REDDIL8DwYm2SXn9vwCrh87WlAv/ACrvFqYRha6YoVpoBfrDXhlscPwFz52pv9909Uf8UF61MlyWRoyUeqYdziMaf7BuMl2t2kMvjNa70c8YJPx9XJMVCkE32rOKcyx8j7gx6YZbtkGDh4DclnnWbutIA4SPKUZcpOY3DLdNcMO/SWRL4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azF6NTJZRERoZXVkaGdGKzZRU2FxN3BrZ1hPeW9PbUNKWkhqZlRxUDVSYkFO?=
 =?utf-8?B?VERkdDEwUVd0TVF4TUU5UisvK0tMUEdTcythY1I3RDVCbEVKS3JoRFNBSFVB?=
 =?utf-8?B?U1YycTEwdmY3Nm9tQjNPSHdtRFprU3VQODI2QzBaa3hkb25wVGdIQmU1UHph?=
 =?utf-8?B?d1dzSzhTNXg2QlFBeGFiM2M5WlZKdUJYN3NLNXVIZ0pTUzkvYmZiSXlyQkNa?=
 =?utf-8?B?aUJiNUYveEJqVlFWbGIvSVk1R3ZUM2lsb3FSaUtYc2FUVzBzOGEvMmdjQlZ4?=
 =?utf-8?B?ZE1obyszRndCMVJlSVNlYk1oa1NlUUgzMmZMRWJTNVNrRzVCdjQ4d2o3UXVz?=
 =?utf-8?B?Z3ZVUjFaTTc0UE1RMUt1d0czWWZ3a2FRTmxOczAyWlhrZXlCR1lvUFgwZyt1?=
 =?utf-8?B?L0tvMHpoajJheU04RVlkcUlkR1Zmd1lvaytJQ1VBallLbG1kMnFhNi9Zdmo5?=
 =?utf-8?B?MFhqMW02OVE4MUZScmxRNVh2ejJWRjBFUkdwcEN0VGdobm9hWk9nRndYZTc3?=
 =?utf-8?B?K1Z1Y214NlJ1dTV0WHYwNklaV1d2OUxzcG8zRXR5RHhxNDdXNVEyR3Z2dVpD?=
 =?utf-8?B?aGZORlZZQXFSWEtQNE8wRTh0Q283UCtjd0RHaXlVV1dTVGdtOUpsajVuNkZX?=
 =?utf-8?B?RGxPMXgydnRhSWtIb0hzZUphdG1PY3VkVGpUYzZNTW93WS94NFFlVHFzOEYx?=
 =?utf-8?B?SHBPc2JZU3hRY01Kc2xBdE9XSkt4NVdOam1WWmpRUUlJT3FlUmlpTUxDT0Nw?=
 =?utf-8?B?NUM2bXBneXBpZC9vZmlISUdOa0p4b282TlkvbGVMdjQ5c0NaVGdMSlpSbW5q?=
 =?utf-8?B?ek9hazhySklFUVdoOE1rNi9VYW1DUWVkMjBIMzVNaklnSzR6cWc3MVJBZmVq?=
 =?utf-8?B?U1NpQnNDNTNmWHFUZ1BzOGZncUJCMUs0UFVJMlRPbllLd3UyNnU5US9KUEV1?=
 =?utf-8?B?SGcrUFgxczBZcGF4Rk1TdHhsMGZnRy9pQUR4SHlDZzMzd2R1UWs0S2xJOXNv?=
 =?utf-8?B?Z01waStSdG1ONm9qTllKTFA5TTZ3UGF6aGZQbWJoNXZ5V0k5UFZic2tCajZZ?=
 =?utf-8?B?am9aUlNoSU1oblpLdStxenlrTzh1T3JZWmswTEN2anFFQzJKeTNaVmxCbTRz?=
 =?utf-8?B?YWxSemZYMVc5TFFqU00xdzk3WUxQZ1RoSzhMZ2h2dmp6c3FGaGVYRU9IRktV?=
 =?utf-8?B?OVpRMjVTeU1kM0crWXJSOVNmNmNiOTBUSG5jMzErdG9VYWQ2VmRydlU2cDA0?=
 =?utf-8?B?dU8wYWNqeGVicWdoVkhjbTZ0YkRtMGZUMFJOc250cVV5a3FveU5jbkVDNVY2?=
 =?utf-8?B?N3M4Q3FtT3FFTUVLM0ZqOERrODNzeHhxem9ETlU4ZE9PdVNRMHNXYlRTTjVZ?=
 =?utf-8?B?NXJYSmp3QUZrOXRjdmJzdXpXRU8zcmtSSHVtdnlyZG5ZcEkvNHRPUVZqMGkx?=
 =?utf-8?B?ZWg4YzFveitxbldFaHJmSHYrTUJqTWl4M0oveGVyNHJuV2lCUTJHZ2hmdGZm?=
 =?utf-8?B?MHpTak1LQnNzYUhmMWVrL1dyUjRvMHZidmFGYTJObTVOcVhhTlZLbjJXZ0F0?=
 =?utf-8?B?Y21YcXVwQXV0KzBHOUszbXFselFkVVNWK1c1dHFhWWpMWlZtOHBncEN6Y0VQ?=
 =?utf-8?B?SU93UDBoak9zczhqQnhIdVhoM3Qrc01IQmZlSEV5dTZ5TG9yc0YrRC9RcjhZ?=
 =?utf-8?B?TlZGaklSOVBEbCs0cGhTbStTdVVITXpmdGFYWUZ1endKZ3J4enUrcTFlMm5X?=
 =?utf-8?B?a0t4cmpDam15RTJ2elZjYTBPV0lIVVl1LytIbElLeWorZEdjc3lUQzZVdUND?=
 =?utf-8?B?QmtHZnBhV3hjRjU3SWp5NlZjejg4bkpqUFZ4aENHbzNNS05OT3AxZDB2Zmsx?=
 =?utf-8?B?TmpBNytyOXp2T2tpbTVSSVVaM1FsQ21lSkN3L3NIc2NSb2dQbkplamhMcWh5?=
 =?utf-8?B?ZXJWVmdsdDhrM3hiTXZKTzA2MEFPR0s2QW9mb1h6TnZHS2JDNkllRjdpSjRw?=
 =?utf-8?B?ZS92QnZCelUyb1ZqL1hkVVVKYmpGVmtYeFRaYXpuM09QZm9wbWxYSy9DZ0xQ?=
 =?utf-8?B?MzEwQnJUWStMVjRJMUg0Titla1phKzNqVFYwYzBuZU1rUVE3YmZWQ2JZNzVU?=
 =?utf-8?B?Z3M0d09EVXo2RGl0dWZLQU04R3pnRFVnelY2dXRtdWRuNTZDa1ZSSHRrYnJr?=
 =?utf-8?B?dGN1U0Jvc3ZMMEo4YzV6WlpVQlVGRnFxd3lkVmM4dDk5NitTK0toVVR0Y3pk?=
 =?utf-8?B?ekFJcmFwTGxpM2R5eklESXcxT2pXU3UrTDRxY0VZeGhhNW9sODBmMUthVis1?=
 =?utf-8?B?S2JEcHNsYXFYNkdvaFJxbktEQjlYOHZ1cjVrbU9NbFJyRVhtVmkrQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03529f44-38d8-4554-fd61-08de95fcbc9d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 05:56:26.3699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUZ5LzR7Gym3zxkM5QgDHsGU2wCE0oTFfy+7HzXVdYQMH4S5h+X3Dz4CzwuP733UjY8nsI15xSzIkE9BadsAbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845



On 09/04/26 4:00 am, Bjorn Helgaas wrote:
> On Wed, Mar 25, 2026 at 12:40:00AM +0530, Manikanta Maddireddy wrote:
>> Program ASPM L1 entrance latency from the optional aspm-l1-entry-delay-ns
>> device tree property instead of of_data. Convert the value from nanoseconds
>> to the hardware encoding (log2(us) + 1, 3-bit field). If the property is
>> absent, default to 7 (maximum latency).
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> Changes V8: Use aspm-l1-entry-delay-ns instead of of_data
>> Changes V1 -> V7: None
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 3278353b2c29..a856a48362df 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/iopoll.h>
>>   #include <linux/kernel.h>
>> +#include <linux/log2.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/of_pci.h>
>> @@ -272,6 +273,7 @@ struct tegra_pcie_dw {
>>   	u32 aspm_cmrt;
>>   	u32 aspm_pwr_on_t;
>>   	u32 aspm_l0s_enter_lat;
>> +	u32 aspm_l1_enter_lat;
>>   
>>   	struct regulator *pex_ctl_supply;
>>   	struct regulator *slot_ctl_3v3;
>> @@ -710,6 +712,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>>   	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
>>   	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
>>   	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
>> +	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
>> +	val |= (pcie->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
>>   	val |= PORT_AFR_ENTER_ASPM;
>>   	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
>>   }
>> @@ -1110,6 +1114,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>>   {
>>   	struct platform_device *pdev = to_platform_device(pcie->dev);
>>   	struct device_node *np = pcie->dev->of_node;
>> +	u32 val;
>>   	int ret;
>>   
>>   	pcie->dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
>> @@ -1136,6 +1141,15 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>>   		dev_info(pcie->dev,
>>   			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
>>   
>> +	/* Default to max latency of 7. */
>> +	pcie->aspm_l1_enter_lat = 7;
>> +	ret = of_property_read_u32(np, "aspm-l1-entry-delay-ns", &val);
>> +	if (!ret) {
>> +		u32 us = max(val / 1000, 1U);
>> +
>> +		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);
> 
> I haven't investigated yet, but I see this build error on
> pci/controller/dwc-tegra194:
> 
>      CC      drivers/pci/controller/dwc/pcie-tegra194.o
>    In file included from <command-line>:
>    In function ‘tegra_pcie_dw_parse_dt’,
>        inlined from ‘tegra_pcie_dw_probe’ at drivers/pci/controller/dwc/pcie-tegra194.c:2148:8:
>    ././include/linux/compiler_types.h:706:45: error: call to ‘__compiletime_assert_515’ declared with attribute error: min(( __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) : (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) signedness error
>      706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> 	|                                             ^
>    ././include/linux/compiler_types.h:687:25: note: in definition of macro ‘__compiletime_assert’
>      687 |                         prefix ## suffix();                             \
> 	|                         ^~~~~~
>    ././include/linux/compiler_types.h:706:9: note: in expansion of macro ‘_compiletime_assert’
>      706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> 	|         ^~~~~~~~~~~~~~~~~~~
>    ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> 	|                                     ^~~~~~~~~~~~~~~~~~
>    ./include/linux/minmax.h:93:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>       93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
> 	|         ^~~~~~~~~~~~~~~~
>    ./include/linux/minmax.h:98:9: note: in expansion of macro ‘__careful_cmp_once’
>       98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
> 	|         ^~~~~~~~~~~~~~~~~~
>    ./include/linux/minmax.h:105:25: note: in expansion of macro ‘__careful_cmp’
>      105 | #define min(x, y)       __careful_cmp(min, x, y)
> 	|                         ^~~~~~~~~~~~~
>    drivers/pci/controller/dwc/pcie-tegra194.c:1155:43: note: in expansion of macro ‘min’
>     1155 |                 pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);
> 	|                                           ^~~
> 

Hi Bjorn,

I don't see this error at my side, but kernel test robot reported this 
error at 
https://lore.kernel.org/oe-kbuild-all/202604051407.AODe3ddZ-lkp@intel.com/.

I published a patch 
https://patchwork.kernel.org/project/linux-pci/patch/20260407145749.130753-1-mmaddireddy@nvidia.com/ 
to fix this issue.


Could you provide me your build environmental details like which tool 
chain and make command are you using? I will incorporate these steps so 
that I can avoid mistakes like these in future.

Thanks,
Manikanta

-- 
nvpublic

